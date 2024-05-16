MERGE {db_dim}.{schema_dim}.{table_dim} AS TARGET -- destination
USING {db_rel}.{schema_rel}.{table_rel} AS SOURCE -- source 
ON (TARGET.ShipperID_NK = SOURCE.ShipperID) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND TARGET.CompanyName <> SOURCE.CompanyName OR TARGET.Phone <> SOURCE.Phone
THEN UPDATE SET TARGET.CompanyName = SOURCE.CompanyName, TARGET.Phone = SOURCE.Phone
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT (ShipperID_NK, CompanyName, Phone) VALUES (SOURCE.ShipperID, SOURCE.CompanyName, SOURCE.Phone)
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.ShipperID_NK AS TargetShipperID, 
DELETED.CompanyName AS TargetCompanyName, 
DELETED.Phone AS TargetPhone, 
INSERTED.ShipperID_NK AS SourceShipperID, 
INSERTED.CompanyName AS SourceCompanyName, 
INSERTED.Phone AS SourcePhone; 
