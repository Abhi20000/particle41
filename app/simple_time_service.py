from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def get_time_and_ip():
    # Get current timestamp
    ip = request.headers.get("X-Forwarded-For", request.remote_addr)
    timestamp = datetime.now().isoformat() + "Z"

    return jsonify({
        "ip": ip,
        "timestamp": timestamp
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
