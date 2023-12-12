import os
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="flask_db",
    user='postgres',
    password='clave')

# Open a cursor to perform database operations
cur = conn.cursor()

# Execute a command: this creates a new table
cur.execute('DROP TABLE IF EXISTS books;')
cur.execute('CREATE TABLE books (id serial PRIMARY KEY,'
            'title varchar (150) NOT NULL,'
            'author varchar (50) NOT NULL,'
            'pages_num integer NOT NULL,'
            'review text,'
            'date_added date DEFAULT CURRENT_TIMESTAMP);'
            )

# Insert data into the table
cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('A Tale of Two Cities',
             'Charles Dickens',
             489,
             'A great classic!')
            )


cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('Anna Karenina',
             'Leo Tolstoy',
             864,
             'Another great classic!')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('La Biblia',
             'Dios',
             1350,
             'El libro más vendido de todos los tiempos.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('Citas del Presidente Mao Tse-Tung',
             'Gobierno de la República Popular China',
             300,
             'El segundo libro más vendido de todos los tiempos.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('Harry Potter',
             'J. K. Rowling',
             3342,
             'Una gran obra de fantasía.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('El Señor de los Anillos',
             'J. R. R. Tolkien',
             1216,
             'Una gran obra de fantasía.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('El Principito',
             'Antoine de Saint-Exupéry',
             96,
             'Un gran libro para niños y adultos.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('El Alquimista',
             'Paulo Coelho',
             208,
             'Un gran libro de superación personal.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('El Código Da Vinci',
             'Dan Brown',
             592,
             'Un gran libro de misterio.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ("Yo, Robot",
             'Isaac Asimov',
             256,
             'Un gran libro de ciencia ficción.')
            )

cur.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('El Hobbit',
             'J. R. R. Tolkien',
             304,
             'Una gran obra de fantasía.')
            )


conn.commit()

cur.close()
conn.close()
