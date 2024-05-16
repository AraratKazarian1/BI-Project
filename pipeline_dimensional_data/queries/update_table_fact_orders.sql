INSERT INTO {db_dim}.{schema_dim}.{table_dim} (
    OrderID_NK,
    ProductID_NK,
    ProductID_SK,
    UnitPrice,
    Quantity,
    Discount,
    CustomerID,
    CustomerID_SK,
    EmployeeID,
    EmployeeID_SK,
    OrderDate,
    RequiredDate,
    ShippedDate,
    ShipVia,
    ShipVia_SK,
    Freight,
    ShipName,
    ShipAddress,
    ShipCity,
    ShipRegion,
    ShipPostalCode,
    ShipCountry,
    TerritoryID,
    TerritoryID_SK
)
OUTPUT  
inserted.OrderID_NK,
inserted.ProductID_NK,
inserted.ProductID_SK,
inserted.UnitPrice,
inserted.Quantity,
inserted.Discount,
inserted.CustomerID,
inserted.CustomerID_SK,
inserted.EmployeeID,
inserted.EmployeeID_SK,
inserted.OrderDate,
inserted.RequiredDate,
inserted.ShippedDate,
inserted.ShipVia,
inserted.ShipVia_SK,
inserted.Freight,
inserted.ShipName,
inserted.ShipAddress,
inserted.ShipCity,
inserted.ShipRegion,
inserted.ShipPostalCode,
inserted.ShipCountry,
inserted.TerritoryID,
inserted.TerritoryID_SK

SELECT
    o.OrderID AS OrderID_NK,
    od.ProductID AS ProductID_NK,
    p.ProductID_PK_SK AS ProductID_SK,
    od.UnitPrice,
    od.Quantity,
    od.Discount,
    o.CustomerID,
    c.CustomerID_PK_SK AS CustomerID_SK,
    o.EmployeeID,
    e.EmployeeID_PK_SK AS EmployeeID_SK,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,
    o.ShipVia,
    s.ShipperID_PK_SK AS ShipVia_SK,
    o.Freight,
    o.ShipName,
    o.ShipAddress,
    o.ShipCity,
    o.ShipRegion,
    o.ShipPostalCode,
    o.ShipCountry,
    o.TerritoryID,
    t.TerritoryID_PK_SK AS TerritoryID_SK
FROM
    {db_rel}.{schema_rel}.{table_rel} o
JOIN
    {db_rel}.{schema_rel}.OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN {db_dim}.{schema_dim}.Dim_Products_SCD1 p ON od.ProductID = p.ProductID_NK
LEFT JOIN {db_dim}.{schema_dim}.Dim_Customers_SCD3 c ON o.CustomerID = c.CustomerID_NK
LEFT JOIN {db_dim}.{schema_dim}.Dim_Employees_SCD2 e ON o.EmployeeID = EmployeeID_NK
LEFT JOIN {db_dim}.{schema_dim}.Dim_Shippers_SCD1 s ON o.ShipVia = s.ShipperID_NK
LEFT JOIN {db_dim}.{schema_dim}.Dim_Territories_SCD2 t ON o.TerritoryID = TerritoryID_NK
WHERE e.IsCurrent = 1 and t.IsCurrent = 1;