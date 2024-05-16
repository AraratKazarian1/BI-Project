Use ORDERS_DIMENSIONAL_DB;

-- DimCategories
CREATE TABLE dim_categories_scd1 (
    CategoryID_PK_SK INT IDENTITY(1,1) PRIMARY KEY, 
    CategoryID_NK INT,
    CategoryName VARCHAR(255) NOT NULL,
    Description VARCHAR(MAX)
);

-- DimCustomers
CREATE TABLE dim_customers_SCD3 (
    CustomerID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID_NK VARCHAR(50),
    CompanyName VARCHAR(255),
    ContactName VARCHAR(255),
	ContactName_Prev VARCHAR(255) DEFAULT NULL,
	ContactName_Prev_ValidTo char(8) NULL,
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
CREATE TABLE dim_employees_SCD2 (
    EmployeeID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID_NK INT,
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
    Notes VARCHAR(MAX),
    ReportsTo INT,
    PhotoPath VARCHAR(255),
	ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
);

-- DimProducts
CREATE TABLE dim_products_SCD1 (
    ProductID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
	ProductID_NK INT,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
	SupplierID_SK INT,
    CategoryID INT,
	CategoryID_SK INT,
    QuantityPerUnit VARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT
);

-- DimRegion
CREATE TABLE dim_region_SCD1 (
    RegionID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    RegionID_NK INT ,
    RegionDescription VARCHAR(255)
);

-- DimShippers
CREATE TABLE dim_shippers_SCD1 (
    ShipperID_PK_SK INT IDENTITY(1, 1) PRIMARY KEY,
    ShipperID_NK INT,
    CompanyName VARCHAR(255),
    Phone VARCHAR(255)
);

-- DimSuppliers SCD1
CREATE TABLE dim_suppliers_SCD1 (
    SupplierID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID_NK INT,
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
    HomePage VARCHAR(MAX),
	ValidFrom datetime NULL
);

-- DimSuppliers SCD4
CREATE TABLE dim_suppliers_SCD4_history (
    SupplierID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID_NK INT,
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
    HomePage VARCHAR(MAX),
	ValidFrom datetime NULL,
	ValidTo datetime NULL
);


-- DimTerritories
CREATE TABLE dim_territories_SCD2 (
    TerritoryID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
	TerritoryID_NK INT,
    TerritoryDescription VARCHAR(255),
    RegionID INT,
	ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
);

-- FactOrders
CREATE TABLE fact_orders (
    Order_Product_SK_PK INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID_NK INT,
    ProductID_NK INT,
    ProductID_SK INT,
    UnitPrice DECIMAL(20, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(20,10 ) DEFAULT 0.0,
    CustomerID VARCHAR(5),
    CustomerID_SK INT,
    EmployeeID INT,
    EmployeeID_SK INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    ShipVia_SK INT,
    Freight DECIMAL(10, 2),
    ShipName VARCHAR(255),
    ShipAddress VARCHAR(255),
    ShipCity VARCHAR(255),
    ShipRegion VARCHAR(255),
    ShipPostalCode VARCHAR(20),
    ShipCountry VARCHAR(255),
    TerritoryID INT, 
    TerritoryID_SK INT
);
