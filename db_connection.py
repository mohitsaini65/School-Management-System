import mysql.connector

def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Mohit@6565",
        database="school_mgmt"
    )
