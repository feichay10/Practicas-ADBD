@app.route('/delete/', methods=['GET', 'POST'])
def delete():
    try:
        if request.method == 'POST':
            
            #...codigo
            
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