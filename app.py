from flask import Flask, jsonify, render_template

app = Flask(__name__)

@app.route('/')
def index():
    # Renders an HTML template when accessed from a browser
    return render_template('index.html')

@app.route('/health', methods=['GET'])
def health():
    # Returns a JSON response with a 200 status
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
