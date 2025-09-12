'''
Database Connection
'''
import os

import psycopg2
from dotenv import load_dotenv

load_dotenv()


def get_db():
    '''
    Establishes connection to db
    :return: connection object
    '''
    try:
        conn = psycopg2.connect(
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT", 5432)
        )
        print("Connection established")
        return conn
    except (Exception, psycopg2.DatabaseError) as e:
        print(f'Error connecting to db: {e}')
        raise
