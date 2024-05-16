MERGE {db_dim}.{schema_dim}.{table_dim} AS DST -- destination
USING {db_rel}.{schema_rel}.{table_rel} AS SRC -- source
ON ( SRC.RegionID = DST.RegionID_NK )
WHEN NOT MATCHED THEN -- there are IDs in the source table that are not in the destination table
  INSERT (RegionID_NK,
          RegionDescription)
  VALUES (SRC.RegionID,
          SRC.RegionDescription)
WHEN MATCHED AND  (
  Isnull(DST.RegionDescription, '') <> Isnull(SRC.RegionDescription, ''))
	THEN
		UPDATE SET DST.RegionDescription = SRC.RegionDescription
             
OUTPUT $action, 
DELETED.RegionID_NK AS TargetRegionID, 
DELETED.RegionDescription AS TargetRegionDescription, 
INSERTED.RegionID_NK AS SourceRegionID, 
INSERTED.RegionDescription AS SourceRegionDescription; 