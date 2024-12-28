FROM python:3.10.8-slim-buster
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Create a non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY . .

# Set the appropriate permissions
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

CMD gunicorn app:app & python3 bot.py

