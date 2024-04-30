from flask import (
    Flask,
    # redirect,
    request,
    render_template,
    # url_for
)

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/page/<filename>')
def page(filename):
    try:
        return render_template('page.html', filename=filename)
    except ValueError:
        # Тут будет шаблон с предложением создать файл
        # return redirect(url_for('new_route'))
        return render_template('404.html'), 404

@app.route('/search')
def search():
    query = request.args.get('query', '')
    return f"Вы искали: {query}"

# @app.route('/login', methods=['GET', 'POST'])
# def login():
#     if request.method == 'POST':
#         username = request.form['username']
#         password = request.form['password']
#         # Обработка данных формы
#     else:
#         # Возвращение формы
#         pass

@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
