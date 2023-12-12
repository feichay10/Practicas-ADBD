# Ruta para generar un error 403 - Prohibido
@app.route("/forbidden")
def forbidden():
    abort(403)