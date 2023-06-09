from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

# Connection to the Azure MySQL database
host = 'newdb.mysql.database.azure.com'
database = 'studinfo'
user = 'newdb1'
password = 'Jagruthi35'

conn = mysql.connector.connect(
    host=host,
    database=database,
    user=user,
    password=password
)

@app.route('/')
def student_form():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/submit', methods=['POST'])
def submit():
    # Retrieve form data
    name = request.form['name']
    email = request.form['email']
    major = request.form['major']
    phone = request.form['phone']

    # Store the student details in the database
    cursor = conn.cursor()
    insert_query = "INSERT INTO studinfo (name, email, major, phone) VALUES (%s, %s, %s, %s)"
    cursor.execute(insert_query, (name, email, major, phone))
    conn.commit()

    # Redirect to the about page
    return redirect('/about')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80,debug=True)
