@app.route('/delete/', methods=['GET', 'POST'])
def delete():
    if request.method == 'POST':
        id = request.form['ID']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('DELETE FROM books WHERE id = %s',
                    (id))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))

    return render_template('delete.html')
