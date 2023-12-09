@app.route('/name_room/', methods=('GET', 'POST'))
def name_room():
    if request.method == 'POST':
        id = request.form['ID']
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT name FROM public.rooms WHERE id = %s;', (id))
        values = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('result_name_room.html', rooms=values)
    return render_template('name_room.html')