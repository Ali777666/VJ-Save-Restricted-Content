FROM python:3.10.8-slim-buster

# Update system packages to fix security vulnerabilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends libtasn1-6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Create a non-root user with UID 10014 as required by choreo.dev
RUN adduser --disabled-password --gecos "" --uid 10014 choreouser

COPY . .

# Set the appropriate permissions
RUN chown -R 10014:10014 /app

# Switch to non-root user
USER 10014

CMD gunicorn app:app & python3 bot.py
