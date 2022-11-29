# syntax=docker/dockerfile:1

FROM python:3.7-slim-buster

WORKDIR /app

COPY . .

CMD ["python3", "main.py"]