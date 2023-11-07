from flask import Flask, request, jsonify
from subprocess import check_output
import sqlite3
import os

app = Flask(__name__)

@app.route('/improper-validation', methods=['POST'])
def improper_input_validation():
    try:
        data = request.json
        command = data['command']
        multiplier = data['multiplier']

        # Command Execution without validation
        result = check_output(command, shell=True).decode('utf-8')

        # Mathematical operation without proper validation
        product = int(multiplier) * 10

        response = {
            'command_output': result,
            'product': product
        }
        return jsonify(response)
    except Exception as e:
        return str(e)


@app.route('/command', methods=['POST'])
def command_injection():
    command = request.form['command']
    try:
        result = check_output(command, shell=True).decode('utf-8')
        return f'Command executed! Result: {result}'
    except Exception as e:
        return str(e)

@app.route('/sql', methods=['GET'])
def sql_injection():
    query = request.args.get('query')
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    try:
        c.execute(query)
        result = c.fetchall()
        return f'Query executed! Result: {result}'
    except sqlite3.Error as e:
        return str(e)




@app.route('/path', methods=['GET'])
def path_traversal():
    file_path = request.args.get('file')
    return open(file_path, 'r').read()

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    file.save('uploads/' + file.filename)
    return 'File uploaded!'

@app.route('/execute', methods=['POST'])
def execute_payload():
    file_name = request.form['file']
    os.system(f'uploads/{file_name}')
    return 'File executed!'

if __name__ == '__main__':
    app.run(
        host="0.0.0.0", 
        port=5000, 
        debug=True
    )
