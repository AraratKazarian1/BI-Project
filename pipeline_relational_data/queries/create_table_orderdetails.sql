-- Create Table: OrderDetails
CREATE TABLE {db}.{schema}.OrderDetails (
    OrderID INT ,
    ProductID INT ,
    UnitPrice DECIMAL(20, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(20,10 ) DEFAULT 0.0, 
    PRIMARY KEY (OrderID, ProductID)
);
