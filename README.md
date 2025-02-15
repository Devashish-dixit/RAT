# RAT (Research Analysis Tool)

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1ODMONDhrKzaGUZcDuedUXy6yZ2rnF4uL?usp=sharing)  
[![Open App](https://img.shields.io/badge/Open%20App-Live-blue?style=for-the-badge)](https://rat-r0u0.onrender.com)


![RAT](https://github.com/Devashish-dixit/RAT/blob/main/images/RATforRender.png)
## Overview
The Research Analysis Tool (RAT) is a cutting-edge Python application designed to streamline the academic research process. By automating paper discovery, summarization, and in-depth analysis, RAT empowers researchers to make data-driven decisions efficiently and effectively.

## Workflow

1. **Query Input & arXiv Link Generation**  
   Users begin by entering a research query. RAT converts this query into an arXiv search URL, setting the stage for data collection.

2. **Web Scraping**  
   Using the `requests` library along with `BeautifulSoup`, RAT scrapes research papers from arXiv. The extracted information—comprising the title, author(s), abstract, and PDF link—is organized into a structured DataFrame.

3. **AI-Powered Summarization**  
   The tool then passes the DataFrame to the Groq summarizer. Here, an AI model (e.g., `llama-3-8b-instant` from Groq) iteratively generates concise summaries of each paper’s abstract, distilling key insights.

4. **Global Research Analysis**  
   Leveraging the AI-generated summaries, along with the paper titles and PDF links, RAT performs a comprehensive analysis to:
   - Identify emerging trends and subfields.
   - Detect research gaps and underexplored opportunities.
   - Highlight critical research questions for future studies.  
   For this step, users can select from multiple LLMs via OpenRouter—including DeepSeek, Google Gemini 2.0 Experimental, LLaMA, Mistral, and Qwen.

5. **Citation & Export**  
   Finally, RAT ensures that every reference is properly cited using the provided PDF links, and a complete research report is generated, ready for download as a PDF.

<!-- Placeholder for workflow visualization image -->
![Workflow Diagram]([https://dummyimage.com/workflow](https://github.com/Devashish-dixit/RAT/blob/main/images/RATworkflow.png))

## API Keys & Setup Instructions

To use RAT, you'll need API keys for both Groq and OpenRouter. Follow these steps to get set up:

1. **Groq API Key**  
   Register on the [Groq site](https://console.groq.com/) and follow their instructions to obtain your API key.  
   <!-- Placeholder for Groq API key setup image -->
   ![Groq API Key Setup](https://github.com/Devashish-dixit/RAT/blob/main/images/groqapikey.png)

2. **OpenRouter API Key**  
   Register on the [OpenRouter platform](https://openrouter.ai/) and secure your API key by following their detailed guidelines.  
   <!-- Placeholder for OpenRouter API key setup image -->
   ![OpenRouter API Key Setup]([https://dummyimage.com/openrouter-api](https://github.com/Devashish-dixit/RAT/blob/main/images/Openrouterapikey.png))

## Getting Started

To run RAT web app locally:

1. **Clone the Repository**
  ```bash
   git clone https://github.com/Devashish-dixit/RAT
   cd research-analysis-tool
```
2. **Install Dependencies**

```bash
pip install -r requirements.txt
```
3. **Run the Application**

```bash
streamlit run app.py

```
Or you can download and use the interactive python notebook locally.

For a quick start though, simply click the Colab badge or the web app at the top to open the project in Google Colab.

Happy Researching!
