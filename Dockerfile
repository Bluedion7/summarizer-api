FROM python:3.10-slim

# Ensure OpenSSL is recent enough
RUN apt-get update && apt-get install -y build-essential libssl-dev \
    && apt-get clean

# Create app directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose port and run
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
