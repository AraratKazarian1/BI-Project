-- Define the dates used in validity - assume whole 24-hour cycles
DECLARE @Yesterday INT =  --20210412 = 2021 * 10000 + 4 * 100 + 12
(
   YEAR(DATEADD(dd, -1, GETDATE())) * 10000
)
+ (MONTH(DATEADD(dd, -1, GETDATE())) * 100) + DAY(DATEADD(dd, -1, GETDATE())) 
DECLARE @Today INT = --20210413 = 2021 * 10000 + 4 * 100 + 13
(
   YEAR(GETDATE()) * 10000
)
+ (MONTH(GETDATE()) * 100) + DAY(GETDATE()) 
-- Outer insert - the updated records are added to the SCD2 table
DECLARE @dim_employees_SCD2 TABLE (
	EmployeeID INT,
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
    PhotoPath VARCHAR(255),
	ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
)

-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.EmployeeID = DST.EmployeeID_NK) 

-- New records inserted
WHEN NOT MATCHED THEN
    INSERT (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, IsCurrent) 
    VALUES (SRC.EmployeeID, SRC.LastName, SRC.FirstName, SRC.Title, SRC.TitleOfCourtesy, SRC.BirthDate, SRC.HireDate, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.HomePhone, SRC.Extension, SRC.Notes, SRC.ReportsTo, SRC.PhotoPath, @Today, 1)
    
-- Existing records updated if data changes
WHEN MATCHED AND IsCurrent = 1 AND
    (
        ISNULL(DST.LastName, '') <> ISNULL(SRC.LastName, '') OR
        ISNULL(DST.FirstName, '') <> ISNULL(SRC.FirstName, '') OR
        ISNULL(DST.Title, '') <> ISNULL(SRC.Title, '') OR
        ISNULL(DST.TitleOfCourtesy, '') <> ISNULL(SRC.TitleOfCourtesy, '') OR
        ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
        ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
        ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
        ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
        ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
        ISNULL(DST.HomePhone, '') <> ISNULL(SRC.HomePhone, '')OR
        ISNULL(DST.Extension, '') <> ISNULL(SRC.Extension, '')OR
        ISNULL(DST.Notes, '') <> ISNULL(SRC.Notes, '')OR
        ISNULL(DST.PhotoPath, '') <> ISNULL(SRC.PhotoPath, '')
    )
THEN
    UPDATE
    SET DST.IsCurrent = 0, DST.ValidTo = @Yesterday 
OUTPUT $Action AS MergeAction, DELETED.EmployeeID_NK, DELETED.LastName, DELETED.FirstName, DELETED.Title, DELETED.TitleOfCourtesy, DELETED.BirthDate, DELETED.HireDate, DELETED.Address, DELETED.City, DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.HomePhone, DELETED.Extension, DELETED.Notes, DELETED.ReportsTo, DELETED.PhotoPath,
INSERTED.EmployeeID_NK, INSERTED.LastName, INSERTED.FirstName, INSERTED.Title, INSERTED.TitleOfCourtesy, INSERTED.BirthDate, INSERTED.HireDate, INSERTED.Address, INSERTED.City, INSERTED.Region, INSERTED.PostalCode, INSERTED.Country, INSERTED.HomePhone, INSERTED.Extension, INSERTED.Notes, INSERTED.ReportsTo, INSERTED.PhotoPath;

-- Insert into the SCD2 table
INSERT INTO {db_dim}.{schema_dim}.{table_dim} (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, ValidTo, IsCurrent)
SELECT EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, ValidTo, IsCurrent
FROM @dim_employees_SCD2;