FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Cài Chromium + dependency cần thiết
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    fonts-liberation \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set Chromium path cho Selenium
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Tạo thư mục app
WORKDIR /app

# Copy & install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

# Chạy test Robot
CMD ["robot", "-d", "results", "test"]
