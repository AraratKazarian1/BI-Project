import os
import pandas as pd
import pyodbc
import utils
from pipeline_dimensional_data import config
from logger import CustomFormatter
import logging

#setting up logging
log_file_path=config.log_loc
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create a FileHandler and set the level to DEBUG
file_handler = logging.FileHandler(log_file_path)
file_handler.setLevel(logging.DEBUG)

# Set the formatter for the FileHandler
file_handler.setFormatter(CustomFormatter())
# Add the FileHandler to the logger
logger.addHandler(file_handler)


def connect_db_create_cursor(database_conf_name):
    # Call to read the configuration file
    db_conf = utils.get_sql_config(config.sql_server_config, database_conf_name)
    # Create a connection string for SQL Server
    db_conn_str = 'Driver={};Server={};Database={};Trusted_Connection={};'.format(*db_conf)
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    return db_cursor

def load_query(query_name):
    sql_script = ''
    for script in os.listdir(config.input_dir):
        if query_name in script:
            with open(config.input_dir + '\\' + script, 'r') as script_file:
                sql_script = script_file.read()
            break

    #logger.info("Loaded SQL Script: %s", sql_script) 
    return sql_script


def drop_table(cursor, table_name, db, schema):
    drop_table_script = load_query('drop_table').format(db=db, schema=schema, table=table_name)
    cursor.execute(drop_table_script)
    cursor.commit()
    logger.info("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))

def create_table(cursor, table_name, db, schema):
    create_table_script = load_query('create_table_{}'.format(table_name)).format(db=db, schema=schema)
    cursor.execute(create_table_script)
    cursor.commit()
    logger.info("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                           table_name=table_name))
def establish_referential_integrity(cursor, db, schema):
    establish_referential_script = load_query('establish_referential_integrity').format(db=db, schema=schema)
    cursor.execute(establish_referential_script)
    cursor.commit()
    logger.info("Referential integrity constraints have been established.")

def insert_into_table(cursor, table_name, db, schema, source_data, sheet_name):
    # Read the Excel sheet
    df = pd.read_excel(source_data, sheet_name=sheet_name, header=0)

    insert_into_table_script = load_query('insert_into_{}'.format(table_name)).format(db=db, schema=schema)

    # Populate a table in SQL Server
    for index, row in df.iterrows():
        values = [row[col] if pd.notna(row[col]) else None for col in df.columns]
        cursor.execute(insert_into_table_script, *values)
        cursor.commit()

    logger.info(f"{len(df)} rows have been inserted into the {db}.{schema}.{table_name} table")

def drop_constraint(cursor,  table_name, db, schema):
    drop_constraint_script = load_query('drop_constraint_{}'.format(table_name)).format(db=db, schema=schema)
    cursor.execute(drop_constraint_script)
    cursor.commit()
    logger.info(f"Foreign Key Constraint dropped from {schema}.{table_name} ")

def update_dim_table(cursor, table_dst, db_dst, schema_dst, table_src, db_src, schema_src):

    update_table_script = load_query('update_table_{}'.format(table_dst)).format(
        db_dim=db_dst, schema_dim=schema_dst, table_dim=table_dst,
        db_rel=db_src, schema_rel=schema_src, table_rel=table_src)
    # Execute the query
    cursor.execute(update_table_script)

    # Fetch the results (both deleted and inserted rows)
    result = cursor.fetchall()

    # Log the results
    for row in result:
        logger.info("Changed Row: %s", row)
    
    cursor.commit()

    logger.info(f"The dimension table {table_dst} has been updated.")

def update_dim_table_scd4(cursor, table_dst, table_hist, db_dst, schema_dst, table_src, db_src, schema_src):
    table_dim_scd4 = table_dst[:-1] + '4'
    
    update_table_script = load_query('update_table_{}'.format(table_dim_scd4)).format(
        db_dim=db_dst, schema_dim=schema_dst, table_dim=table_dst, table_hist = table_hist,
        db_rel=db_src, schema_rel=schema_src, table_rel=table_src)
    # Execute the query
    cursor.execute(update_table_script)

    # Fetch the results (both deleted and inserted rows)
    result = cursor.fetchall()

    # Log the results
    for row in result:
        logger.info("Changed Row: %s", row)
    
    cursor.commit()
    logger.info(f"The dimension tables {table_dst} and {table_hist}  have been updated.")