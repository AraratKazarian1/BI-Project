-- Create Table: Suppliers
CREATE TABLE {db}.{schema}.Suppliers (
    SupplierID INT PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    [Address] VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255),
    Phone VARCHAR(20),
    Fax VARCHAR(20),
    HomePage VARCHAR(255)
);
