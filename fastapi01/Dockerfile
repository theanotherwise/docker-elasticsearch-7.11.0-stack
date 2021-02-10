FROM python:3.9.1-alpine

RUN pip3 install fastapi uvicorn elastic-apm

RUN mkdir -p /opt/app && \
    chown root:root /opt/app && \
    chmod 755 /opt/app

WORKDIR /opt/app

COPY ./files/main.py .

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "8080", "main:app"]
