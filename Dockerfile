# Base image (Python 3.11 is safer for tgcrypto & aiohttp)
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for building Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ make libffi-dev libssl-dev ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy project files into container
COPY . /app

# Upgrade pip and install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Run your bot
CMD ["python", "main.py"]

