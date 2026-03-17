# main.py
# Cách A: Chạy thông qua file main.py
# * run: `python -m gov_banking_bot.main`
# Cách B.1: Dùng uvicorn
# * run: `uvicorn gov_banking_bot.main:app --reload`
# Cách B.2: Dùng lệnh mới của FastAPI (nếu đã cài fastapi)
# * run: `fastapi dev src/gov_banking_bot/main.py`
# * test: `curl http://localhost:8000/health`
from fastapi import FastAPI
import uvicorn

app = FastAPI(title="SG Banking Bot")


@app.get("/health")
def health_check():
    return {"status": "healthy"}


if __name__ == "__main__":
    uvicorn.run("gov_banking_bot.main:app", host="0.0.0.0", port=8000, reload=True)
