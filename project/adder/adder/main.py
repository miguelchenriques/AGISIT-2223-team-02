from fastapi import FastAPI
import pymongo
from fastapi.middleware.cors import CORSMiddleware

def get_connection_string():
    con_string = "mongodb://{}/?replicaSet=rs0"
    with open('database_ips', 'r') as f:
        ips = [ip for ip in f.read().split('\n') if ip]
        return con_string.format(",".join(ips))
        

client = pymongo.MongoClient(get_connection_string())
history = client.calculator.history

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def add_document(a: float, b: float, operator: str, result: float):
    document = {
        "num1": a,
        "num2": b,
        "operation": operator,
        "result": result
    }
    history.insert_one(document)

def get_documents():
    results = history.find({}, {'_id': 0})
    return [result for result in results]

@app.get('/health')
async def health_check():
    return {"status": "OK"}

@app.get('/sum')
async def sum(a: float, b: float) -> float:
    result = round(a + b, 2)
    add_document(a, b, "+", result)
    return result

@app.get('/sub')
async def subtraction(a: float, b: float) -> float:
    result = round(a - b, 2)
    add_document(a, b, "-", result)
    return result

@app.get('/history')
async def get_history():
    return get_documents()