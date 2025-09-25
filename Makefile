.PHONY: setup-env help

help:
	@echo "Available targets:"
	@echo "  setup-env    - Create .env from .env.example with generated secrets"
	@echo "  help         - Show this help message"

setup-env:
	@if [ -f .env ] || [ -f litellm_config.yml ]; then \
		echo "❌ Configuration files already exist. Skipping setup to avoid overwriting."; \
		if [ -f .env ]; then echo "   - .env exists"; fi; \
		if [ -f litellm_config.yml ]; then echo "   - litellm_config.yml exists"; fi; \
		echo "   Delete existing files first if you want to regenerate them."; \
		exit 1; \
	fi
	@echo "🔧 Creating .env from .env.example..."
	@cp .env.example .env
	@echo "🔧 Creating litellm_config.yml from litellm_config.yml.example..."
	@if [ -f litellm_config.yml.example ]; then \
		cp litellm_config.yml.example litellm_config.yml; \
	else \
		echo "⚠️  litellm_config.yml.example not found, skipping config copy"; \
	fi
	@echo "🔑 Generating secrets..."
	@LITELLM_KEY=$$(openssl rand -hex 32); \
	sed -i '' "s/OPEN_WEBUI_SECRET_KEY=/OPEN_WEBUI_SECRET_KEY=$$(openssl rand -hex 32)/" .env; \
	sed -i '' "s/POSTGRES_PASSWORD=/POSTGRES_PASSWORD=$$(openssl rand -hex 16)/" .env; \
	sed -i '' "s/LITELLM_MASTER_KEY=/LITELLM_MASTER_KEY=$$LITELLM_KEY/" .env; \
	sed -i '' "s/OPEN_WEBUI_OPENAI_API_KEY=/OPEN_WEBUI_OPENAI_API_KEY=$$LITELLM_KEY/" .env
	@echo "✅ .env file created successfully!"
	@echo ""
	@echo "⚠️  IMPORTANT: You still need to set the following manually:"
	@echo ""
	@echo "   API Keys:"
	@echo "   - LITELLM_OPENAI_API_KEY"
	@echo "   - LITELLM_ANTHROPIC_API_KEY"
	@echo "   - LITELLM_GEMINI_API_KEY"
	@echo "   - LITELLM_PERPLEXITY_API_KEY"
	@echo ""
	@echo "   Base URLs:"
	@echo "   - LITELLM_OPENAI_API_BASE"
	@echo "   - LITELLM_ANTHROPIC_API_BASE"
	@echo "   - LITELLM_GEMINI_API_BASE"
	@echo "   - LITELLM_PERPLEXITY_API_BASE"
	@echo ""
	@echo "   These require access to your internal proxy endpoints."