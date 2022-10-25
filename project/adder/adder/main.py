from fastapi import FastAPI

app = FastAPI()

@app.get('/health')
async def health_check():
    return {"status": "OK"}

@app.get('/sum')
async def sum(a: int, b: int) -> int:
    return a + b

@app.get('/subtraction')
async def subtraction(a: int, b: int) -> int:
    return a - b