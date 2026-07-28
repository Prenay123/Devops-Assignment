# Stage 1 - Builder
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /build

COPY app/requirements.txt .

RUN pip install \
    --no-cache-dir \
    --prefix=/install \
    -r requirements.txt

# Stage 2 - Runtime

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user
RUN groupadd -r appgroup && \
    useradd -r -g appgroup appuser
    

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy application with correct ownership
COPY --chown=appuser:appgroup app/main.py .

USER appuser

EXPOSE 8000

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000" ]