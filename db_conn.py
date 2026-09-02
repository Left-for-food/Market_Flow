# Connecting to the Postgres Server

import psycopg2
import sqlalchemy
import dotenv
import os

dotenv.load_dotenv()

username_db = (os.getenv('DB_USER'))
host_db = (os.getenv('DB_HOST'))
password_db = (os.getenv('DB_PASSWORD'))


engine = sqlalchemy.create_engine(f'postgresql+psycopg2://{username_db}:{password_db}@{host_db}/postgres')