FROM python:3.10-slim

# Cài tool cần thiết
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Cài Robot Framework libs
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
WORKDIR /app
COPY . .

# Chạy test
CMD ["robot", "test"]
