Use ORDERS_RELATIONAL_DB;

-- Categories table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
    CREATE TABLE Categories (
        CategoryID INT NOT NULL,
        CategoryName VARCHAR(255) NOT NULL,
        Description VARCHAR(255) NOT NULL
    );
END

-- Customers table 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customers]') AND type in (N'U'))
BEGIN
    CREATE TABLE Customers (
        CustomerID VARCHAR(255) NOT NULL,
        CompanyName VARCHAR(255) NOT NULL,
        ContactName VARCHAR(255) NOT NULL,
        ContactTitle VARCHAR(255) NOT NULL,
        Address VARCHAR(255) NOT NULL,
        City VARCHAR(255) NOT NULL,
        Region VARCHAR(255) NULL,
        PostalCode VARCHAR(255) NULL,
        Country VARCHAR(255) NOT NULL,
        Phone VARCHAR(255) NOT NULL,
        Fax VARCHAR(255) NULL
    );
END

-- Employees table 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
BEGIN
    CREATE TABLE Employees (
        EmployeeID INT NOT NULL,
        LastName VARCHAR(255) NOT NULL,
        FirstName VARCHAR(255) NOT NULL,
        Title VARCHAR(255) NOT NULL,
        TitleOfCourtesy VARCHAR(255) NOT NULL,
        BirthDate DATETIME NOT NULL,
        HireDate DATETIME NOT NULL,
        Address VARCHAR(255) NOT NULL,
        City VARCHAR(255) NOT NULL,
        Region VARCHAR(255) NULL,
        PostalCode VARCHAR(255) NOT NULL,
        Country VARCHAR(255) NOT NULL,
        HomePhone VARCHAR(255) NOT NULL,
        Extension INT NOT NULL,
        Notes VARCHAR(500) NOT NULL,
        ReportsTo INT NULL,
        PhotoPath VARCHAR(255) NOT NULL
    );
END

-- OrderDetails table 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetails]') AND type in (N'U'))
BEGIN
    CREATE TABLE OrderDetails (
        OrderID INT NOT NULL,
        ProductID INT NOT NULL,
        UnitPrice INT NOT NULL,
        Quantity INT NOT NULL,
        Discount INT NOT NULL
    );
END

-- Orders table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
    CREATE TABLE Orders (
        OrderID INT NOT NULL,
        CustomerID VARCHAR(255) NOT NULL,
        EmployeeID INT NOT NULL,
        OrderDate DATETIME NOT NULL,
        RequiredDate DATETIME NOT NULL,
        ShippedDate DATETIME NULL,
        ShipVia INT NOT NULL,
        Freight FLOAT NOT NULL,
        ShipName VARCHAR(255) NOT NULL,
        ShipAddress VARCHAR(255) NOT NULL,
        ShipCity VARCHAR(255) NOT NULL,
        ShipRegion VARCHAR(255) NULL,
        ShipPostalCode VARCHAR(255) NULL,
        ShipCountry VARCHAR(255) NOT NULL,
        TerritoryID INT NOT NULL
    );
END

-- Products table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
BEGIN
    CREATE TABLE Products (
        ProductID INT NOT NULL,
        ProductName VARCHAR(255) NOT NULL,
        SupplierID INT NOT NULL,
        CategoryID INT NOT NULL,
        QuantityPerUnit VARCHAR(255) NOT NULL,
        UnitPrice FLOAT NOT NULL,
        UnitsInStock INT NOT NULL,
        UnitsOnOrder INT NOT NULL,
        ReorderLevel INT NOT NULL,
        Discontinued VARCHAR(255) NOT NULL
    );
END

-- Region table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
BEGIN
    CREATE TABLE Region (
        RegionID INT NOT NULL,
        RegionDescription VARCHAR(255) NOT NULL
    );
END

-- Shippers table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shippers]') AND type in (N'U'))
BEGIN
    CREATE TABLE Shippers (
        ShipperID INT NOT NULL,
        CompanyName VARCHAR(255) NOT NULL,
        Phone VARCHAR(255) NOT NULL
    );
END

-- Suppliers table 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Suppliers]') AND type in (N'U'))
BEGIN
    CREATE TABLE Suppliers (
        SupplierID INT NOT NULL,
        CompanyName VARCHAR(255) NOT NULL,
        ContactName VARCHAR(255) NOT NULL,
        ContactTitle VARCHAR(255) NOT NULL,
        Address VARCHAR(255) NOT NULL,
        City VARCHAR(255) NOT NULL,
        Region VARCHAR(255) NULL,
        PostalCode VARCHAR(255) NOT NULL,
        Country VARCHAR(255) NOT NULL,
        Phone VARCHAR(255) NOT NULL,
        Fax VARCHAR(255) NULL,
        HomePage VARCHAR(255) NULL
    );
END

-- Territories table 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Territories]') AND type in (N'U'))
BEGIN
    CREATE TABLE Territories (
        TerritoryID INT NOT NULL,
        TerritoryDescription VARCHAR(255) NOT NULL,
        RegionID INT NOT NULL
    );
END


use ORDERS_RELATIONAL_DB;
select * from Categories