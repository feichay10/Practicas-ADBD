@app.route('/update/', methods=['GET', 'POST'])
def update():
    if request.method == 'POST':
        id = request.form['ID']
        title = request.form['title']
        author = request.form['author']
        review = request.form['review']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('UPDATE books SET title = %s, author = %s, review = %s WHERE id = %s'
                    (title, author, review, id))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))

    return render_template('update.html')