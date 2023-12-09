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


@app.route('/name_room/', methods=('GET', 'POST'))
def name_room():
    if request.method == 'POST':
        id = request.form['ID']
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT name FROM public.rooms WHERE id = ' + id + ';')
        values = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('result_name_room.html', rooms=values)
    return render_template('name_room.html')


@app.route('/room_avg_temperature/', methods=('GET', 'POST'))
def room_avg_temperature():
    if request.method == 'POST':
        id = request.form['ID']
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            'SELECT AVG(temperature) FROM temperatures WHERE room_id = ' + id + ';')
        values = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('result_room_avg_temperature.html', rooms=values)
    return render_template('room_avg_temperature.html')


@app.route('/room_min_temperature/', methods=('GET', 'POST'))
def room_min_temperature():
    if request.method == 'POST':
        id = request.form['ID']
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT MIN(temperature), r.name '
                    'FROM public.rooms r '
                    'JOIN public.temperatures t ON r.id = t.room_id '
                    'WHERE room_id = ' + id + 'GROUP BY(room_id, name)')
        values = cur.fetchone()
        cur.close()
        conn.close()

        result = {
            'room_name': values[0],
            'min_temperature': values[1]
        }

        return render_template('result_room_min_temperature.html', room=result)
    return render_template('room_min_temperature.html')


@app.route('/about/', methods=('GET', 'POST'))
def about():
    return render_template('about.html')


if __name__ == '_main_':
    app.run(host='0.0.0.0', port=8080, debug=True)
