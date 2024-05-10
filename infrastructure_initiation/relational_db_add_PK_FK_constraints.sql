-- Ensure all changes are executed as a single transaction
BEGIN TRANSACTION;

-- Primary Key Constraints
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Categories') AND is_primary_key = 1)
    ALTER TABLE dbo.Categories ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Customers') AND is_primary_key = 1)
    ALTER TABLE dbo.Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Employees') AND is_primary_key = 1)
    ALTER TABLE dbo.Employees ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.OrderDetails') AND is_primary_key = 1)
    ALTER TABLE dbo.OrderDetails ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Orders') AND is_primary_key = 1)
    ALTER TABLE dbo.Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Products') AND is_primary_key = 1)
    ALTER TABLE dbo.Products ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Region') AND is_primary_key = 1)
    ALTER TABLE dbo.Region ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Shippers') AND is_primary_key = 1)
    ALTER TABLE dbo.Shippers ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Suppliers') AND is_primary_key = 1)
    ALTER TABLE dbo.Suppliers ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Territories') AND is_primary_key = 1)
    ALTER TABLE dbo.Territories ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID);

-- Foreign Key Constraints
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Employees_ReportsTo'))
    ALTER TABLE dbo.Employees ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES dbo.Employees (EmployeeID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_OrderDetails_OrderID'))
    ALTER TABLE dbo.OrderDetails ADD CONSTRAINT FK_OrderDetails_OrderID FOREIGN KEY (OrderID) REFERENCES dbo.Orders (OrderID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_OrderDetails_ProductID'))
    ALTER TABLE dbo.OrderDetails ADD CONSTRAINT FK_OrderDetails_ProductID FOREIGN KEY (ProductID) REFERENCES dbo.Products (ProductID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Orders_CustomerID'))
    ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES dbo.Customers (CustomerID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Orders_EmployeeID'))
    ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES dbo.Employees (EmployeeID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Orders_ShipVia'))
    ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_ShipVia FOREIGN KEY (ShipVia) REFERENCES dbo.Shippers (ShipperID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Orders_TerritoryID'))
    ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES dbo.Territories (TerritoryID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Products_CategoryID'))
    ALTER TABLE dbo.Products ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID) REFERENCES dbo.Categories (CategoryID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Products_SupplierID'))
    ALTER TABLE dbo.Products ADD CONSTRAINT FK_Products_SupplierID FOREIGN KEY (SupplierID) REFERENCES dbo.Suppliers (SupplierID);

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_Territories_RegionID'))
    ALTER TABLE dbo.Territories ADD CONSTRAINT FK_Territories_RegionID FOREIGN KEY (RegionID) REFERENCES dbo.Region (RegionID);

-- Commit the transaction if all commands execute successfully
COMMIT TRANSACTION;
