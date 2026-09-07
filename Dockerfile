FROM python:3.10-slim

# Install system libraries MediaPipe/OpenCV need on a headless Linux server
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgles2-mesa \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 10000

CMD ["uvicorn", "src.api.server:app", "--host", "0.0.0.0", "--port", "10000"]
