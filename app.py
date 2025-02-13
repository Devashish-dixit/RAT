import streamlit as st
import pandas as pd
import asyncio
import os
import json
import re
import urllib.parse
import requests
from io import BytesIO
from bs4 import BeautifulSoup
import nest_asyncio
from groq import Groq
from openai import OpenAI

def clean_text(text):
    return re.sub(r'^(Authors:|Abstract:)\s*', '', re.sub(r'\s+', ' ', str(text)).strip()) if text else ''

def parse_arxiv_results(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    papers = []
    for container in soup.find_all('li', class_='arxiv-result'):
        try:
            papers.append({
                'title': clean_text(container.find('p', class_='title').text),
                'authors': clean_text(container.find('p', class_='authors').text),
                'abstract': clean_text(container.find('p', class_='abstract').text),
                'pdf_link': container.find('a', href=lambda href: href and '/pdf/' in href)['href']
            })
        except Exception as e:
            print(f"Parsing error: {e}")
    return papers

def generate_arxiv_search_url(query):
    base_url = "https://arxiv.org/search/?query="
    encoded_query = urllib.parse.quote(query)
    return f"{base_url}{encoded_query}&searchtype=all"

async def crawl_arxiv(base_url, max_pages):
    all_papers = []
    current_page = 0
    while current_page < max_pages:
        try:
            start = current_page * 50
            url = f"{base_url}&start={start}" if '?' in base_url else f"{base_url}?start={start}"
            response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
            response.raise_for_status()
            papers = parse_arxiv_results(response.text)
            if not papers:
                break
            all_papers.extend(papers)
            current_page += 1
        except Exception as e:
            print(f"Crawling error: {e}")
            break
    return pd.DataFrame(all_papers)

def run_arxiv_crawler(user_query, max_pages):
    search_url = generate_arxiv_search_url(user_query)
    return asyncio.run(crawl_arxiv(search_url, max_pages))

class GroqAbstractSummarizer:
    def __init__(self, api_key, model):
        self.client = Groq(api_key=api_key)
        self.model = model

    def generate_summary(self, abstract):
        prompt = f"Summarize this research paper abstract: {abstract}"
        try:
            response = self.client.chat.completions.create(
                messages=[{"role": "user", "content": prompt}],
                model=self.model,
                temperature=0.3,
            )
            return response.choices[0].message.content
        except Exception as e:
            return "Failed"

    def process_dataframe(self, df):
        df_out = df.copy()
        df_out['summary'] = df_out['abstract'].apply(lambda x: self.generate_summary(x) if pd.notna(x) else '')
        return df_out

class OpenRouterResearchAnalyzer:
    def __init__(self, api_key, model):
        self.client = OpenAI(base_url="https://openrouter.ai/api/v1", api_key=api_key)
        self.model = model

    def analyze_research_titles(self, df):
        research_data = [{'title': row['title'], 'summary': row['summary'], 'pdf_link': row['pdf_link']} for _, row in df.iterrows()]
        prompt = f"Analyze these research papers: {json.dumps(research_data)}"
        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[{"role": "user", "content": prompt}]
            )
            return response.choices[0].message.content
        except Exception as e:
            return "Analysis failed"

def convert_df_to_csv(df):
    return df.to_csv(index=False).encode('utf-8')

def main():
    st.image("https://i.ibb.co/twk5x4HD/RATfor-Render.png", use_column_width=True)
    st.title("Research Analysis Tool (RAT)")
    
    if 'groq_api_key' not in st.session_state:
        st.session_state['groq_api_key'] = ""
    if 'openrouter_api_key' not in st.session_state:
        st.session_state['openrouter_api_key'] = ""
    
    st.session_state['groq_api_key'] = st.text_input("Enter your Groq API Key:", type="password")
    st.session_state['openrouter_api_key'] = st.text_input("Enter your OpenRouter API Key:", type="password")
    
    groq_model = st.selectbox("Select Groq Model:", [
        "llama-3.1-8b-instant", "llama-3.3-70b-versatile", "llama-3.3-70b-specdec",
        "deepseek-r1-distill-llama-70b", "mixtral-8x7b-32768"
    ], index=3)
    
    openrouter_model = st.selectbox("Select OpenRouter Model:", [
        "deepseek/deepseek-r1-distill-llama-70b:free", "deepseek/deepseek-r1:free", "deepseek/deepseek-chat:free",
        "google/gemini-2.0-flash-lite-preview-02-05:free", "google/gemini-2.0-pro-exp-02-05:free",
        "qwen/qwen-vl-plus:free", "qwen/qwen2.5-vl-72b-instruct:free",
        "meta-llama/llama-3.3-70b-instruct:free", "mistralai/mistral-nemo:free"
    ], index=3)
    
    summarizer = GroqAbstractSummarizer(st.session_state['groq_api_key'], groq_model)
    analyzer = OpenRouterResearchAnalyzer(st.session_state['openrouter_api_key'], openrouter_model)
    
    user_query = st.text_input("Enter your research query:")
    max_pages = st.number_input("Max pages to crawl:", min_value=1, max_value=10, value=3)
    
    if st.button("Start Analysis"):
        df = run_arxiv_crawler(user_query, max_pages)
        if df.empty:
            st.error("No research papers found.")
            return
        
        st.dataframe(df)
        csv_data = convert_df_to_csv(df)
        st.download_button("Download Papers CSV", csv_data, "papers.csv", "text/csv")
        
        df_with_summaries = summarizer.process_dataframe(df)
        st.dataframe(df_with_summaries)
        csv_summaries = convert_df_to_csv(df_with_summaries)
        st.download_button("Download Summaries CSV", csv_summaries, "summaries.csv", "text/csv")
        
        insights = analyzer.analyze_research_titles(df_with_summaries)
        st.markdown(insights)

if __name__ == "__main__":
    main()
