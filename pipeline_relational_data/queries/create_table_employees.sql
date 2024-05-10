-- Create Table: Employees
CREATE TABLE {db}.{schema}.Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    Title VARCHAR(255),
    TitleOfCourtesy VARCHAR(255),
    BirthDate DATE,
    HireDate DATE,
    [Address] VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(20),
    Country VARCHAR(255),
    HomePhone VARCHAR(20),
    Extension INT,
    Notes VARCHAR(MAX),
    ReportsTo INT, 
    PhotoPath VARCHAR(MAX)
);
