from flask import Flask, jsonify
from config import API_KEY

app = Flask(__name__)


@app.get("/")
def index():
    return jsonify(status="ok", key_loaded=bool(API_KEY))


@app.get("/health")
def health():
    return "healthy"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)