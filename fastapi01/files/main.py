from fastapi import FastAPI
from elasticapm.contrib.starlette import make_apm_client, ElasticAPM

apm = make_apm_client({
    'SERVER_URL': 'http://apm01:8200',
    'SERVICE_NAME': 'fastapi01',
    'SERVER_TIMEOUT': '5s',
    'ENABLED': 'true',
    'LOG_LEVEL': 'trace',
    'LOG_FILE_SIZE': '100mb',
    'ENVIRONMENT': '1001'
})

app = FastAPI()
app.add_middleware(ElasticAPM, client=apm)

@app.get("/")
def read_root():
    return {"Hello": "World"}