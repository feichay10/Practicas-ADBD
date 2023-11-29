from flask import Flask
app = Flask(__name__)

# Suma de dos números

@app.route('/<int:number1>/<int:number2>/')
def addition(number1, number2):
    return "Addition of " + str(number1) + " and " + str(number2) + " is " + str(number1+number2)

@app.route('/<string:name>/')
def hello(name):
    return "Hello," + name

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)