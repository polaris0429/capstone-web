from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

# JSON 데이터 로드
def load_data():
    with open('data.json', 'r', encoding='utf-8') as f:
        return json.load(f)

@app.route('/')
@app.route('/main')
def main():
    data = load_data()
    return render_template('main.html', data=data)

@app.route('/subject')
def subject():
    data = load_data()
    return render_template('subject.html', data=data['subject'])

@app.route('/rationale')
def rationale():
    data = load_data()
    return render_template('rationale.html', data=data['rationale'])

@app.route('/features')
def features():
    data = load_data()
    return render_template('features.html', data=data['features'])

@app.route('/environment')
def environment():
    data = load_data()
    return render_template('environment.html', data=data['environment'])

@app.route('/team')
def team():
    data = load_data()
    return render_template('team.html', data=data['team'])

# API 엔드포인트
@app.route('/api/subject')
def api_subject():
    data = load_data()
    return jsonify(data['subject'])

@app.route('/api/rationale')
def api_rationale():
    data = load_data()
    return jsonify(data['rationale'])

@app.route('/api/features')
def api_features():
    data = load_data()
    return jsonify(data['features'])

@app.route('/api/environment')
def api_environment():
    data = load_data()
    return jsonify(data['environment'])

@app.route('/api/team')
def api_team():
    data = load_data()
    return jsonify(data['team'])

@app.route('/api/all')
def api_all():
    data = load_data()
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
