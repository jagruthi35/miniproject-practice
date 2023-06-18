from flask import Flask, render_template, request, redirect
import pymssql
from azure.identity import DefaultAzureCredential

app = Flask(__name__)

# Connection to the Azure SQL database using managed identity
server = 'newdb1.database.windows.net'
database = 'studinfo'

credential = DefaultAzureCredential()
conn = pymssql.connect(server=server, database=database, auth=credential)

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
    cursor = conn.cursor(as_dict=True)
    insert_query = "INSERT INTO infodet(name, email, major, phone) VALUES (%(name)s, %(email)s, %(major)s, %(phone)s)"
    cursor.execute(insert_query, {'name': name, 'email': email, 'major': major, 'phone': phone})
    conn.commit()

    # Redirect to the about page
    return redirect('/about')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
