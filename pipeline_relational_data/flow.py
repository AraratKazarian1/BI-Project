from pipeline_relational_data import tasks 
import utils
from pipeline_relational_data import config
from logger import CustomFormatter
import logging

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
        
        #Deleting tables if they exist
        tasks.drop_table(conn_ER, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_constraint(conn_ER,  'employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'products', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'region', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.drop_table(conn_ER, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo') 
        
        # Creating all the tables 
        tasks.create_table(conn_ER, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'products', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'region', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo')
        tasks.create_table(conn_ER, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo')
        
        #Inserting Data
        tasks.insert_into_table(conn_ER, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Categories')
        tasks.insert_into_table(conn_ER, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Suppliers')
        tasks.insert_into_table(conn_ER, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Shippers')
        tasks.insert_into_table(conn_ER, 'region', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Region')
        tasks.insert_into_table(conn_ER, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Territories')
        tasks.insert_into_table(conn_ER, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Customers')
        tasks.insert_into_table(conn_ER, 'products', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Products')
        tasks.insert_into_table(conn_ER, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Employees')
        tasks.insert_into_table(conn_ER, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Orders')
        tasks.insert_into_table(conn_ER, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'OrderDetails')

        # Adding referential integrity
        tasks.establish_referential_integrity(conn_ER,'ORDERS_RELATIONAL_DB', 'dbo')
        
        conn_ER.close()
        logger.info("Relational Flow Completed Successfully")