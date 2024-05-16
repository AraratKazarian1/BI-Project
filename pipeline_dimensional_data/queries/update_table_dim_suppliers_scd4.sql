DECLARE  @Suppliers_SCD4 TABLE
(
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
	MergeAction varchar(10) NULL

) 
-- Merge statement
MERGE INTO {db_dim}.{schema_dim}.{table_dim}  AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON			(SRC.SupplierID = DST.SupplierID_NK)

WHEN NOT MATCHED THEN
INSERT (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom)
VALUES (SRC.SupplierID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, SRC.HomePage, GETDATE())

WHEN MATCHED 
AND		
	 ISNULL(DST.CompanyName,'') <> ISNULL(SRC.CompanyName,'')OR  
	 ISNULL(DST.ContactName,'') <> ISNULL(SRC.ContactName,'')OR  
	 ISNULL(DST.ContactTitle,'') <> ISNULL(SRC.ContactTitle,'')OR  
	 ISNULL(DST.Address,'') <> ISNULL(SRC.Address,'')OR  
	 ISNULL(DST.City,'') <> ISNULL(SRC.City,'')OR  
	 ISNULL(DST.Region,'') <> ISNULL(SRC.Region,'')OR  
	 ISNULL(DST.PostalCode,'') <> ISNULL(SRC.PostalCode,'')OR  
	 ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'')OR  
	 ISNULL(DST.Phone,'') <> ISNULL(SRC.Phone,'')OR  
	 ISNULL(DST.Fax,'') <> ISNULL(SRC.Fax,'')OR  
	 ISNULL(DST.HomePage,'') <> ISNULL(SRC.HomePage,'')
THEN UPDATE 
SET			 
	 DST.CompanyName = SRC.CompanyName
	 ,DST.ContactName = SRC.ContactName
	 ,DST.ContactTitle = SRC.ContactTitle
	 ,DST.Address = SRC.Address
	 ,DST.City = SRC.City
	 ,DST.Region = SRC.Region
	 ,DST.PostalCode = SRC.PostalCode
	 ,DST.Country = SRC.Country
	 ,DST.Phone = SRC.Phone
	 ,DST.Fax = SRC.Fax
	 ,DST.HomePage = SRC.HomePage
	 ,DST.ValidFrom = GETDATE()

OUTPUT DELETED.SupplierID_NK, DELETED.CompanyName, DELETED.ContactName, DELETED.ContactTitle, DELETED.Address, DELETED.City, DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.Phone, DELETED.Fax, DELETED.HomePage, DELETED.ValidFrom, $Action AS MergeAction
INTO @Suppliers_SCD4 (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, MergeAction)
OUTPUT $Action AS MergeAction, DELETED.SupplierID_NK, DELETED.CompanyName, DELETED.ContactName, DELETED.ContactTitle, DELETED.Address, DELETED.City, DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.Phone, DELETED.Fax, DELETED.HomePage, DELETED.ValidFrom, 
INSERTED.SupplierID_NK,INSERTED.CompanyName, INSERTED.ContactName, INSERTED.ContactTitle, INSERTED.Address, INSERTED.City, INSERTED.Region, INSERTED.PostalCode, INSERTED.Country, INSERTED.Phone, INSERTED.Fax, INSERTED.HomePage, INSERTED.ValidFrom
;

-- Update history table to set final date and current flag

UPDATE		TP4

SET			TP4.ValidTo = DATEADD(day, -1, GETDATE())

FROM		{db_dim}.{schema_dim}.{table_hist} TP4
			INNER JOIN @Suppliers_SCD4 TMP
			ON TP4.SupplierID_NK = TMP.SupplierID_NK

WHERE		TP4.ValidTo IS NULL


-- Add latest history records to history table
INSERT INTO {db_dim}.{schema_dim}.{table_hist} (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, ValidTo)
SELECT SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, DATEADD(DAY, -1, GETDATE())
FROM @Suppliers_SCD4
WHERE SupplierID_NK IS NOT NULL
;