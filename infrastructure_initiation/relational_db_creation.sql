CREATE DATABASE ORDERS_RELATIONAL_DB 
    ON ( NAME = 'ORDERS_RELATIONAL_DB', 
         FILENAME = 'C:\Users\arara\OneDrive\Desktop\DS-206-GROUP-PROJECT-2\BI-Project\ORDERS_RELATIONAL_DB.mdf' , 
         SIZE = 10MB , 
         MAXSIZE = UNLIMITED, 
         FILEGROWTH = 10% )
    LOG ON ( NAME = 'ORDERS_RELATIONAL_DB_log', 
             FILENAME = 'C:\Users\arara\OneDrive\Desktop\DS-206-GROUP-PROJECT-2\BI-Project\ORDERS_RELATIONAL_DB.ldf' , 
             SIZE = 2MB , 
             MAXSIZE = 15MB , 
             FILEGROWTH = 500KB )