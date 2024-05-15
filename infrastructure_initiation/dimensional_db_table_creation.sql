-- DimCategories
CREATE TABLE DimCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(255),
    Description TEXT
);

-- DimCustomers
CREATE TABLE DimCustomers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(255),
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    Phone VARCHAR(255),
    Fax VARCHAR(255)
);

-- DimEmployees
CREATE TABLE DimEmployees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    Title VARCHAR(255),
    TitleOfCourtesy VARCHAR(255),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    HomePhone VARCHAR(255),
    Extension VARCHAR(255),
    Notes TEXT,
    ReportsTo INT,
    PhotoPath VARCHAR(255)
);

-- DimProducts
CREATE TABLE DimProducts (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(255),
    UnitPrice MONEY,
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT
);

-- DimRegion
CREATE TABLE DimRegion (
    RegionID INT IDENTITY(1,1) PRIMARY KEY,
    RegionDescription VARCHAR(255)
);

-- DimShippers
CREATE TABLE DimShippers (
    ShipperID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(255),
    Phone VARCHAR(255)
);

-- DimSuppliers
CREATE TABLE DimSuppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(255),
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    Phone VARCHAR(255),
    Fax VARCHAR(255),
    HomePage TEXT
);

-- DimTerritories
CREATE TABLE DimTerritories (
    TerritoryID INT IDENTITY(1,1) PRIMARY KEY,
    TerritoryDescription VARCHAR(255),
    RegionID INT
);

-- FactOrders
CREATE TABLE FactOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    Freight MONEY,
    ShipName VARCHAR(255),
    ShipAddress VARCHAR(255),
    ShipCity VARCHAR(255),
    ShipRegion VARCHAR(255),
    ShipPostalCode VARCHAR(255),
    ShipCountry VARCHAR(255),
    TerritoryID INT
);
