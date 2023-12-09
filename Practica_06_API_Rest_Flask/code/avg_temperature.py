@app.route('/average/', methods=('GET', 'POST'))
def average():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT AVG(temperature)'
                'FROM public.temperatures;')
    values = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('average.html', rooms = values)