# Use the Alpine version of Python
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy only the requirements file first
COPY requirement.txt .

# Install dependencies
RUN apk add --no-cache gcc musl-dev \
    && pip install -r requirement.txt \
    && apk del gcc musl-dev

# Copy the application code and templates
COPY app.py .
COPY templates/ ./templates/

# Expose port 5000
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
