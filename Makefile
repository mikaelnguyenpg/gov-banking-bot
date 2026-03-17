.PHONY: dev run shell clean test help

# Biến số
PYTHON_MODULE = gov_banking_bot.main
APP_PATH = src/gov_banking_bot/main.py

help: ## Hiển thị các lệnh hiện có
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

shell: ## Vào môi trường phát triển (Nix)
	nix develop

dev: ## Chạy FastAPI ở chế độ Development (Hot-reload)
	fastapi dev $(APP_PATH)

debug: ## Chạy App theo dạng Module để Debug
	python -m $(PYTHON_MODULE)

run: ## Chạy App theo dạng Production (Production-like)
	PYTHONPATH=src uvicorn $(PYTHON_MODULE):app --host 0.0.0.0 --port 8000

test: ## Chạy Unit Test
	PYTHONPATH=src pytest tests/

health: ## Check health
	curl http://localhost:8000/health

clean: ## Dọn dẹp cache và các file rác
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".venv" -exec rm -rf {} +
	rm -f .python-version
