# Manejo de error 500 - Error interno del servidor
@app.errorhandler(500)
def internal_server_error(error):
    return render_template("500.html"), 500