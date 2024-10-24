FROM python:3.9-alpine

WORKDIR /app

COPY requirement.txt .

RUN apk add --no-cache gcc musl-dev \
    && pip install -r requirement.txt \
    && apk del gcc musl-dev

COPY app.py .
COPY templates/ ./templates/

EXPOSE 5000

CMD ["python", "app.py"]
