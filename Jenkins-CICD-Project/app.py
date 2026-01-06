from flask import Flask, jsonify, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/health")
def health():
    return jsonify(
        status="UP",
        service="Flask CI/CD App",
        message="Application is healthy"
    ), 200

@app.route("/about")
def about():
    return """
    <h1>About This Project</h1>
    <p>This is a Flask application deployed using a CI/CD pipeline.</p>
    <ul>
        <li>Jenkins for CI</li>
        <li>Docker for containerization</li>
        <li>AWS EC2 for deployment</li>
    </ul>
    """

@app.route("/api/info")
def api_info():
    return jsonify({
        "app": "Flask CI/CD Demo",
        "version": "1.0.0",
        "maintainer": "DevOps Engineer",
        "status": "Running"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

