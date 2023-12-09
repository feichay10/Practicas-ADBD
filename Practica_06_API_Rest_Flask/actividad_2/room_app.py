import os
import psycopg2
import json
from flask import Flask, render_template, request, url_for, redirect

app = Flask(__name__)


def get_db_connection():
    conn = psycopg2.connect(host='localhost',
                            database="myhome",
                            # user=os.environ['DB_USERNAME'],
                            user="postgres",
                            # password=os.environ['DB_PASSWORD']
                            password="clave")
    return conn


@app.route('/')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM public.rooms;')
    rooms = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('index.html', rooms=rooms)


@app.route('/average/', methods=('GET', 'POST'))
def average():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT AVG(temperature)'
                'FROM temperatures;')
    values = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('average.html', rooms=values)


@app.route('/maximum/', methods=('GET', 'POST'))
def maximum():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT MAX(temperature)'
                'FROM temperatures;')
    values = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('maximum.html', rooms=values)


@app.route('/about/', methods=('GET', 'POST'))
def about():
    return render_template('about.html')


if __name__ == '_main_':
    app.run(host='0.0.0.0', port=8080, debug=True)
