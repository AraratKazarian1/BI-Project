import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from pipeline_relational_data import tasks 
import utils
from pipeline_relational_data import config
from logger import CustomFormatter
import logging
import pandas as pd
import numpy as np

# Setting up logging
log_file_path=config.log_loc
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Creating a FileHandler and set the level to DEBUG
file_handler = logging.FileHandler(log_file_path)
file_handler.setLevel(logging.DEBUG)

# Setting the formatter for the FileHandler
file_handler.setFormatter(CustomFormatter())
# Adding the FileHandler to the logger
logger.addHandler(file_handler)

class RelationalDataFlow:
    def __init__(self):
        self.flow_id = utils.generate_unique_uuid()
        logger.info(f"RelationalDataFlow instance created with UUID: {self.flow_id}")

    def exec(self):
        # Initiating Connection
        conn_ER = tasks.connect_db_create_cursor("Database1")

        # Preprocess the Data
        # Function to replace NaN, inf, -inf with None in a DataFrame
        def replace_values(df):
            df.replace({np.nan: None, np.inf: None, -np.inf: None}, inplace=True)
        # Read the Excel file
        excel_data = pd.read_excel('raw_data_source.xlsx', sheet_name=None, engine='openpyxl', header=0)

        # Iterate through each sheet and replace values
        for _, df in excel_data.items():
            if _ == "Employees":
                df.sort_values(by='ReportsTo', ascending=True, na_position='first', inplace=True)
                df['ReportsTo'] = df['ReportsTo'].astype("Int64")
                replace_values(df)
            else:
                replace_values(df)

        # Inserting Data
        tasks.insert_into_table(conn_ER, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Categories')
        tasks.insert_into_table(conn_ER, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Suppliers')
        tasks.insert_into_table(conn_ER, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Shippers')
        tasks.insert_into_table(conn_ER, 'region', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Region')
        tasks.insert_into_table(conn_ER, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Territories')
        tasks.insert_into_table(conn_ER, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Customers')
        tasks.insert_into_table(conn_ER, 'products', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Products')
        tasks.insert_into_table(conn_ER, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Employees')
        tasks.insert_into_table(conn_ER, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'Orders')
        tasks.insert_into_table(conn_ER, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo', excel_data, 'OrderDetails')

        conn_ER.close()
        logger.info("Relational Flow Completed Successfully")