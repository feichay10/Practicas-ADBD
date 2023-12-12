import psycopg2
from flask import Flask, render_template, request, url_for, redirect
from werkzeug.exceptions import BadRequest, InternalServerError, NotFound

app = Flask(__name__)


# Manejo de error 404 - Página no encontrada
@app.errorhandler(404)
def page_not_found(error):
    return render_template("404.html"), 404


# Manejo de error 500 - Error interno del servidor
@app.errorhandler(500)
def internal_server_error(error):
    return render_template("500.html"), 500


# Ruta para generar un error 403 - Prohibido
@app.route("/forbidden")
def forbidden():
    abort(403)


def get_db_connection():
    conn = psycopg2.connect(host='localhost',
                            database="flask_db",
                            user="postgres",
                            password="clave")
    return conn


@app.route('/')
def index():
    try:
        conn = get_db_connection()
        if not conn:
            raise InternalServerError('No se pudo conectar a la base de datos')

        cur = conn.cursor()
        cur.execute('SELECT * FROM books;')
        books = cur.fetchall()
        cur.close()
        conn.close()

        if not books:
            raise NotFound('No hay libros registrados')

        return render_template('index.html', books=books)

    except psycopg2.Error as e:
        print(f"Error al ejecutar la consulta SQL: {str(e)}")
        raise InternalServerError(
            "Error interno del servidor al ejecutar la consulta SQL."
        )

    except NotFound as e:
        print(f"Error 404: {str(e)}")
        return render_template("404.html"), 404


@app.route('/create/', methods=('GET', 'POST'))
def create():
    try:
        if request.method == 'POST':
            title = request.form['title']
            author = request.form['author']
            pages_num = int(request.form['pages_num'])
            review = request.form['review']

            if pages_num <= 0:
                raise BadRequest('El número de páginas debe ser mayor a 0.')

            if not title or not author or not pages_num or not review:
                raise BadRequest("Todos los campos son obligatorios.")

            conn = get_db_connection()
            if not conn:
                raise InternalServerError(
                    'No se pudo conectar a la base de datos.'
                )

            cur = conn.cursor()
            cur.execute('INSERT INTO books (title, author, pages_num, review)'
                        'VALUES (%s, %s, %s, %s)',
                        (title, author, pages_num, review))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('index'))

        return render_template('create.html')

    except BadRequest as e:
        print(f"Error 400: {str(e)}")
        return render_template("400.html", error=str(e)), 400

    except psycopg2.Error as e:
        print(f"Error al insertar un libro en la base de datos: {str(e)}")
        raise InternalServerError(
            "Error interno del servidor al intentar un nuevo libro."
        )


@app.route('/delete/', methods=['GET', 'POST'])
def delete():
    try:
        if request.method == 'POST':
            id = request.form['ID']

            if not id:
                raise BadRequest('Tiene que ingresar un ID.')

            conn = get_db_connection()
            if not conn:
                raise InternalServerError(
                    'No se pudo conectar a la base de datos.'
                )
            cur = conn.cursor()
            cur.execute('DELETE FROM books WHERE id = %s',
                        (id))

            if cur.rowcount == 0:
                raise NotFound(
                    'El ID ingresado no existe en la base de datos.')

            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('index'))

        return render_template('delete.html')

    except BadRequest as e:
        print(f"Error 400: {str(e)}")
        return render_template("400.html", error=str(e)), 400

    except psycopg2.Error as e:
        print(f"Error al eliminar un libro en la base de datos: {str(e)}")
        raise InternalServerError(
            "Error interno del servidor al eliminar un nuevo libro."
        )

    except NotFound as e:
        print(f"Error 404: {str(e)}")
        return render_template("404.html", error=e), 404


@app.route('/update/', methods=['GET', 'POST'])
def update():
    try:
        if request.method == 'POST':
            id = request.form['ID']
            title = request.form['title']
            author = request.form['author']
            pages_num = int(request.form['pages_num'])
            review = request.form['review']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('UPDATE books SET title = %s, author = %s, pages_num = %s, review = %s WHERE id = %s',
                        (title, author, pages_num, review, id))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('index'))

        return render_template('update.html')

    except BadRequest as e:
        print(f"Error 400: {str(e)}")
        return render_template("400.html", error=str(e)), 400

    except psycopg2.Error as e:
        print(f"Error al actualizar un libro en la base de datos: {str(e)}")
        raise InternalServerError(
            "Error interno del servidor al actualizar un nuevo libro."
        )


@app.route('/about/', methods=('GET', 'POST'))
def about():
    return render_template('about.html')


if __name__ == '_main_':
    app.run(host='0.0.0.0', port=8080, debug=True)
