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
DECLARE  @Territories_SCD2 TABLE
(
    TerritoryID INT,
    TerritoryDescription VARCHAR(50), 
    RegionID INT, 
    ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL

) 
-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.TerritoryID = DST.TerritoryID_NK) 

-- New records inserted
WHEN NOT MATCHED THEN
    INSERT (TerritoryID_NK, TerritoryDescription, RegionID, ValidFrom, IsCurrent) 
    VALUES (SRC.TerritoryID, SRC.TerritoryDescription, SRC.RegionID, @Today, 1)
    
-- Existing records updated if data changes
WHEN MATCHED AND IsCurrent = 1 AND
    (
        ISNULL(DST.TerritoryDescription, '') <> ISNULL(SRC.TerritoryDescription, '') OR
        ISNULL(DST.RegionID, '') <> ISNULL(SRC.RegionID, '')
    )
THEN
    UPDATE
    SET DST.IsCurrent = 0, DST.ValidTo = @Yesterday 
OUTPUT $Action AS MergeAction, DELETED.TerritoryID_NK, DELETED.TerritoryDescription, DELETED.RegionID,
INSERTED.TerritoryID_NK, INSERTED.TerritoryDescription, INSERTED.RegionID;

-- Insert into the SCD2 table
INSERT INTO {db_dim}.{schema_dim}.{table_dim} (TerritoryID_NK, TerritoryDescription, RegionID, ValidFrom, ValidTo, IsCurrent)
SELECT TerritoryID, TerritoryDescription, RegionID, ValidFrom, ValidTo, IsCurrent
FROM @Territories_SCD2;