from flask import Flask, render_template

app = Flask(__name__)

employees = [
    {"id": 1, "name": "Ravi", "role": "DevOps Engineer"},
    {"id": 2, "name": "Anu", "role": "Cloud Engineer"},
    {"id": 3, "name": "Kumar", "role": "Software Developer"}
]

@app.route("/")
def home():
    return render_template("index.html", employees=employees)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

