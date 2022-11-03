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

def add_document(a: int, b: int, operator: str, result: int):
    document = {
        "num1": a,
        "num2": b,
        "operator": operator,
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
async def sum(a: int, b: int) -> int:
    result = a + b
    add_document(a, b, "+", result)
    return result

@app.get('/sub')
async def subtraction(a: int, b: int) -> int:
    result = a - b
    add_document(a, b, "-", result)
    return result

@app.get('/history')
async def get_history():
    return get_documents()