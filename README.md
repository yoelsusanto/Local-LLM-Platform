# Local LLM Platform

A Docker Compose setup that combines [Open WebUI](https://github.com/open-webui/open-webui) with [LiteLLM](https://github.com/BerriAI/litellm) to provide a unified interface for multiple AI providers including OpenAI, Anthropic, Google Gemini, and Perplexity.

## Architecture

- **Open WebUI**: Web interface for chatting with AI models
- **LiteLLM**: Proxy server that provides a unified API for multiple AI providers
- **PostgreSQL**: Database backend for LiteLLM

## Quick Start

1. **Set up environment:**
   ```bash
   make setup-env
   ```

2. **Configure API keys and base URLs** in the generated `.env` file:

   **API Keys:**
   - `LITELLM_OPENAI_API_KEY`
   - `LITELLM_ANTHROPIC_API_KEY`
   - `LITELLM_GEMINI_API_KEY`
   - `LITELLM_PERPLEXITY_API_KEY`

   **Base URLs:**
   - `LITELLM_OPENAI_API_BASE`
   - `LITELLM_ANTHROPIC_API_BASE`
   - `LITELLM_GEMINI_API_BASE`
   - `LITELLM_PERPLEXITY_API_BASE`

3. **Start services:**
   ```bash
   docker compose up -d
   ```

4. **Access the interface:**
   - Open WebUI: http://localhost:30001
   - LiteLLM: http://localhost:30003

## Available Models

### OpenAI
- `openai/*` (all models)
- `openai/gpt-5-priority` (priority tier)

### Anthropic
- `anthropic/claude-sonnet-4-20250514` (with thinking support)
- `anthropic/*` (all models)

### Google Gemini
- `google/gemini-2.5-pro` (with Google Search)
- `google/gemini-2.5-flash` (with Google Search)
- `google/gemini-2.5-flash-lite` (with Google Search)

### Perplexity
- `perplexity/sonar-pro`

## Configuration

### Environment Variables
- **Ports**: Customize `OPEN_WEBUI_PORT` and `LITELLM_PORT`
- **Data paths**: Configure `OPEN_WEBUI_DATA_PATH` and `POSTGRES_DATA_PATH`
- **Model settings**: Set default task model with `OPEN_WEBUI_TASK_MODEL_EXTERNAL`

### Model Configuration
Edit `litellm_config.yml` to:
- Add new model providers
- Configure model aliases
- Set up custom routing rules

## (Optional) Preferred Interface Settings
- High Contrast Mode (Beta)
- Notification Sound
- Widescreen Mode
- Enter Key Behavior: Ctrl+Enter to Send
