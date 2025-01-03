from flask import Flask, jsonify
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)

@app.route('/')
def hello_world():
    try:
        return 'Hello from Koyeb world'
    except Exception as e:
        app.logger.error(f"Error: {e}")
        return jsonify(error=str(e)), 500

@app.route('/health')
def health_check():
    return jsonify(status="healthy"), 200

if __name__ == "__main__":
    app.run()
