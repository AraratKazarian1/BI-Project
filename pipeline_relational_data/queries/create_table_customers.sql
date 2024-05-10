-- Create Table: Customers
CREATE TABLE {db}.{schema}.Customers (
    CustomerID VARCHAR(5) PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    [Address] VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255),
    Phone VARCHAR(50),
    Fax VARCHAR(50)
);
