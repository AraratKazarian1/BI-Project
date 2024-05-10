-- Create Table: Categories
CREATE TABLE {db}.{schema}.Categories (
    CategoryID INT PRIMARY KEY ,
    CategoryName VARCHAR(255) NOT NULL,
    [Description] VARCHAR(MAX)
);
