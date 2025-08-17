FROM python:3.12-slim

# Install system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    gcc ffmpeg aria2 libffi-dev musl-dev mediainfo \
    python3-dev libssl-dev build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependency files first
COPY requirements.txt /app/requirements.txt
COPY Installer /app/Installer

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir -r Installer

# Copy project
COPY . /app

# Run bot
CMD ["python", "modules/main.py"]
