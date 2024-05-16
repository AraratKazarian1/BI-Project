MERGE {db_dim}.{schema_dim}.{table_dim} AS DST -- destination
USING {db_rel}.{schema_rel}.{table_rel} AS SRC -- source
ON ( SRC.CategoryID = DST.CategoryID_NK )
WHEN NOT MATCHED THEN
  INSERT (CategoryID_NK,
          CategoryName,
          Description)
  VALUES (SRC.CategoryID,
          SRC.CategoryName,
          SRC.Description)
WHEN MATCHED AND  (
  Isnull(DST.CategoryName, '') <> Isnull(SRC.CategoryName, '')  OR
  Isnull(DST.Description, '') <> Isnull(SRC.Description, ''))
	THEN
		UPDATE SET DST.CategoryName = SRC.CategoryName,
             DST.Description = SRC.Description
             
OUTPUT $action, 
DELETED.CategoryID_NK AS TargetCategoryID, 
DELETED.CategoryName AS TargetCategoryName, 
DELETED.Description AS TargetDescription, 
INSERTED.CategoryID_NK AS SourceCategoryID, 
INSERTED.CategoryName AS SourceCategoryName, 
INSERTED.Description AS SourceDescription; 