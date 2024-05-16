DECLARE @Yesterday VARCHAR(8) = CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4)) + RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) + RIGHT('0' + CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2)
 --20210413: string/text/char
MERGE {db_dim}.{schema_dim}.{table_dim} AS DST 
USING {db_rel}.{schema_rel}.{table_rel} AS SRC
ON (SRC.CustomerID = DST.CustomerID_NK)
WHEN NOT MATCHED THEN
INSERT (CustomerID_NK, CompanyName, ContactName, ContactTitle, [Address], City, Region, PostalCode, Country, Phone, Fax)
VALUES (SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.[Address], SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax)
WHEN MATCHED  -- there can be only one matched case
AND 
	(
	ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') 
	OR ISNULL(DST.ContactName, '') <> ISNULL(SRC.ContactName, '') 
	OR ISNULL(DST.ContactTitle, '') <> ISNULL(SRC.ContactTitle, '')
	OR ISNULL(DST.[Address], '') <> ISNULL(SRC.[Address], '')
	OR ISNULL(DST.City, '') <> ISNULL(SRC.City, '')
	OR ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '')
	OR ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '')
	OR ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '')
	OR ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '')
	OR ISNULL(DST.Fax, '') <> ISNULL(SRC.Fax, '')
)
THEN 
	UPDATE 
	SET  
	DST.CompanyName = SRC.CompanyName -- simple overwrite
	,DST.ContactName = SRC.ContactName -- simple overwrite
	,DST.ContactName_Prev = (CASE WHEN DST.ContactName <> SRC.ContactName THEN DST.ContactName ELSE DST.ContactName_Prev END)
	,DST.ContactName_Prev_ValidTo = (CASE WHEN DST.ContactName<> SRC.ContactName THEN @Yesterday ELSE DST.ContactName_Prev_ValidTo END)
	,DST.ContactTitle = SRC.ContactTitle -- simple overwrite
	,DST.[Address] = SRC.[Address] -- simple overwrite
	,DST.City = SRC.City -- simple overwrite
	,DST.Region = SRC.Region -- simple overwrite
	,DST.PostalCode = SRC.PostalCode -- simple overwrite
	,DST.Country = SRC.Country -- simple overwrite
	,DST.Phone = SRC.Phone -- simple overwrite
	,DST.Fax = SRC.Fax -- simple overwrite

OUTPUT
  $action,
  DELETED.CustomerID_NK AS TargetCustomerID,
  DELETED.CompanyName AS TargetCompanyName,
  DELETED.ContactName AS TargetContactName,
  DELETED.ContactTitle AS TargetContactTitle,
  DELETED.ContactName_Prev AS TargetContactName_Prev,
  DELETED.ContactName_Prev_ValidTo AS TargetContactName_Prev_ValidTo,
  DELETED.[Address] AS TargetAddress,
  DELETED.City AS TargetCity,
  DELETED.Region AS TargetRegion,
  DELETED.PostalCode AS TargetPostalCode,
  DELETED.Country AS TargetCountry,
  DELETED.Phone AS TargetPhone,
  DELETED.Fax AS TargetFax,
  INSERTED.CustomerID_NK AS SourceCustomerID,
  INSERTED.CompanyName AS SourceCompanyName,
  INSERTED.ContactName AS SourceContactName,
  INSERTED.ContactTitle AS SourceContactTitle,
  INSERTED.ContactName_Prev AS SourceContactName_Prev,
  INSERTED.ContactName_Prev_ValidTo AS SourceContactName_Prev_ValidTo,
  INSERTED.[Address] AS SourceAddress,
  INSERTED.City AS SourceCity,
  INSERTED.Region AS SourceRegion,
  INSERTED.PostalCode AS SourcePostalCode,
  INSERTED.Country AS SourceCountry,
  INSERTED.Phone AS SourcePhone,
  INSERTED.Fax AS SourceFax;