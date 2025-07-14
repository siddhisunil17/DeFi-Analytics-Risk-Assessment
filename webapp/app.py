# app.py

from flask import Flask, render_template, request
import psycopg2

app = Flask(__name__)

# Database connection settings
DB_HOST = "localhost"
DB_PORT = 5432
DB_NAME = "defi_analysis"   # ← your actual DB name
DB_USER = "postgres"
DB_PASS = "Khushbu@150102"
                # you can also make this a constant

def run_query(sql_query):
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,      # ← use the constant here
            user=DB_USER,
            password=DB_PASS
        )
        cur = conn.cursor()
        cur.execute(sql_query)

        if sql_query.strip().lower().startswith("select"):
            result = cur.fetchall()
            column_names = [desc[0] for desc in cur.description]
        else:
            conn.commit()
            result = "Query executed successfully."
            column_names = []

        cur.close()
        conn.close()
        return result, column_names

    except Exception as e:
        # return the error message so the UI can show it
        return f"Error: {str(e)}", []

@app.route('/', methods=['GET', 'POST'])
def index():
    result = None
    columns = []
    if request.method == 'POST':
        sql_query = request.form['sql_query']
        result, columns = run_query(sql_query)
    return render_template('index.html', result=result, columns=columns)

if __name__ == '__main__':
    app.run(debug=True)
