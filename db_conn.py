# Connecting to the Postgres Server

import sqlalchemy
from sqlalchemy import text
import dotenv
import os

def create_engine_custom(DB_custom_name = 'postgres'):
    dotenv.load_dotenv()

    username_db = (os.getenv('DB_USER'))
    host_db = (os.getenv('DB_HOST'))
    password_db = (os.getenv('DB_PASSWORD'))


    engine = sqlalchemy.create_engine(f'postgresql+psycopg2://{username_db}:{password_db}@{host_db}/postgres', isolation_level="AUTOCOMMIT")

    # Creating a custom Market_Flow DB if it doesn't exist yet
    with engine.begin() as conn:
        query = text("""
            SELECT 1
            FROM pg_database
            WHERE datname = :DB_custom_name
        """)

        result = conn.execute(query, parameters={'DB_custom_name' : DB_custom_name}).scalar()

        if result:
            print(f'{DB_custom_name} DB exists already')
        else:
            conn.execute(text(f'CREATE DATABASE {DB_custom_name}'))
            print(f'{DB_custom_name} DB is created successfully')

        flag = 1

        return sqlalchemy.create_engine(f'postgresql+psycopg2://{username_db}:{password_db}@{host_db}/{DB_custom_name}'), flag

def delete_tables(engine: sqlalchemy.Engine):
    with engine.begin() as conn:
        conn.execute(text("""
            DROP SCHEMA public CASCADE;
            CREATE SCHEMA public;
            GRANT ALL ON SCHEMA public TO postgres;
            GRANT ALL ON SCHEMA public TO public;
            COMMENT ON SCHEMA public IS 'standard public schema';
        """))