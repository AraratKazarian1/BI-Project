-- Categories
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Categories') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameCategories NVARCHAR(256);
    SELECT @pkNameCategories = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Categories');
    IF @pkNameCategories IS NOT NULL EXEC('ALTER TABLE dbo.Categories DROP CONSTRAINT ' + @pkNameCategories);
END
ALTER TABLE dbo.Categories ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);

-- Customers
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Customers') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameCustomers NVARCHAR(256);
    SELECT @pkNameCustomers = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Customers');
    IF @pkNameCustomers IS NOT NULL EXEC('ALTER TABLE dbo.Customers DROP CONSTRAINT ' + @pkNameCustomers);
END
ALTER TABLE dbo.Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);

-- Employees
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Employees') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameEmployees NVARCHAR(256);
    SELECT @pkNameEmployees = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Employees');
    IF @pkNameEmployees IS NOT NULL EXEC('ALTER TABLE dbo.Employees DROP CONSTRAINT ' + @pkNameEmployees);
END
ALTER TABLE dbo.Employees ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);

-- Order Details
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.OrderDetails') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameOrderDetails NVARCHAR(256);
    SELECT @pkNameOrderDetails = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.OrderDetails');
    IF @pkNameOrderDetails IS NOT NULL EXEC('ALTER TABLE dbo.OrderDetails DROP CONSTRAINT ' + @pkNameOrderDetails);
END
ALTER TABLE dbo.OrderDetails ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID);

-- Orders
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Orders') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameOrders NVARCHAR(256);
    SELECT @pkNameOrders = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Orders');
    IF @pkNameOrders IS NOT NULL EXEC('ALTER TABLE dbo.Orders DROP CONSTRAINT ' + @pkNameOrders);
END
ALTER TABLE dbo.Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);

-- Products
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Products') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameProducts NVARCHAR(256);
    SELECT @pkNameProducts = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Products');
    IF @pkNameProducts IS NOT NULL EXEC('ALTER TABLE dbo.Products DROP CONSTRAINT ' + @pkNameProducts);
END
ALTER TABLE dbo.Products ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);

-- Region
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Region') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameRegion NVARCHAR(256);
    SELECT @pkNameRegion = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Region');
    IF @pkNameRegion IS NOT NULL EXEC('ALTER TABLE dbo.Region DROP CONSTRAINT ' + @pkNameRegion);
END
ALTER TABLE dbo.Region ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);

-- Shippers
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Shippers') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameShippers NVARCHAR(256);
    SELECT @pkNameShippers = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Shippers');
    IF @pkNameShippers IS NOT NULL EXEC('ALTER TABLE dbo.Shippers DROP CONSTRAINT ' + @pkNameShippers);
END
ALTER TABLE dbo.Shippers ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID);

-- Suppliers
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Suppliers') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameSuppliers NVARCHAR(256);
    SELECT @pkNameSuppliers = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Suppliers');
    IF @pkNameSuppliers IS NOT NULL EXEC('ALTER TABLE dbo.Suppliers DROP CONSTRAINT ' + @pkNameSuppliers);
END
ALTER TABLE dbo.Suppliers ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);

-- Territories
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Territories') AND is_primary_key = 1)
BEGIN
    DECLARE @pkNameTerritories NVARCHAR(256);
    SELECT @pkNameTerritories = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('dbo.Territories');
    IF @pkNameTerritories IS NOT NULL EXEC('ALTER TABLE dbo.Territories DROP CONSTRAINT ' + @pkNameTerritories);
END
ALTER TABLE dbo.Territories ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID);

-- Foreign Key Constraints
ALTER TABLE dbo.Employees ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES dbo.Employees (EmployeeID);
ALTER TABLE dbo.OrderDetails ADD CONSTRAINT FK_OrderDetails_OrderID FOREIGN KEY (OrderID) REFERENCES dbo.Orders (OrderID);
ALTER TABLE dbo.OrderDetails ADD CONSTRAINT FK_OrderDetails_ProductID FOREIGN KEY (ProductID) REFERENCES dbo.Products (ProductID);
ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES dbo.Customers (CustomerID);
ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES dbo.Employees (EmployeeID);
ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_ShipVia FOREIGN KEY (ShipVia) REFERENCES dbo.Shippers (ShipperID);
ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES dbo.Territories (TerritoryID);
ALTER TABLE dbo.Products ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID) REFERENCES dbo.Categories (CategoryID);
ALTER TABLE dbo.Products ADD CONSTRAINT FK_Products_SupplierID FOREIGN KEY (SupplierID) REFERENCES dbo.Suppliers (SupplierID);
ALTER TABLE dbo.Territories ADD CONSTRAINT FK_Territories_RegionID FOREIGN KEY (RegionID) REFERENCES dbo.Region (RegionID);
