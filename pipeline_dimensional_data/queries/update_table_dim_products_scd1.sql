MERGE {db_dim}.{schema_dim}.{table_dim} AS DST -- destination
USING (SELECT p.*, b.SupplierID_PK_SK, c.CategoryID_PK_SK FROM
		 {db_rel}.{schema_rel}.{table_rel} p
		 LEFT JOIN {db_dim}.{schema_dim}.dim_suppliers_scd1 b ON p.SupplierID = b.SupplierID_NK
		 LEFT JOIN {db_dim}.{schema_dim}.dim_categories_scd1 c on p.CategoryID = c.CategoryID_NK
		 )AS SRC -- source
ON ( SRC.ProductID = DST.ProductID_NK)
WHEN NOT MATCHED THEN -- there are IDs in the source table that are not in the destination table
  INSERT (ProductID_NK,
          ProductName,
          SupplierID,
          SupplierID_SK,
          CategoryID,
          CategoryID_SK,
          QuantityPerUnit,
          UnitPrice,
          UnitsInStock,
          UnitsOnOrder,
          ReorderLevel,
          Discontinued)
  VALUES (SRC.ProductID,
          SRC.ProductName,
          SRC.SupplierID,
          SRC.SupplierID_PK_SK,
          SRC.CategoryID, 
          SRC.CategoryID_PK_SK,
          SRC.QuantityPerUnit,
          SRC.UnitPrice,
          SRC.UnitsInStock,
          SRC.UnitsOnOrder,
          SRC.ReorderLevel,
          SRC.Discontinued)
WHEN MATCHED AND  (
  Isnull(DST.ProductName, '') <> Isnull(SRC.ProductName, '')  OR
  Isnull(DST.SupplierID_SK, '') <> Isnull(SRC.SupplierID_PK_SK, '')  OR
  Isnull(DST.CategoryID_SK, '') <> Isnull(SRC.CategoryID_PK_SK, '')  OR
  Isnull(DST.SupplierID, '') <> Isnull(SRC.SupplierID, '')  OR
  Isnull(DST.CategoryID, '') <> Isnull(SRC.CategoryID, '')  OR
  Isnull(DST.QuantityPerUnit, '') <> Isnull(SRC.QuantityPerUnit, '')  OR
  Isnull(DST.UnitPrice, '') <> Isnull(SRC.UnitPrice, '')  OR
  Isnull(DST.UnitsInStock, '') <> Isnull(SRC.UnitsInStock, '')  OR
  Isnull(DST.UnitsOnOrder, '') <> Isnull(SRC.UnitsOnOrder, '')  OR
  Isnull(DST.ReorderLevel, '') <> Isnull(SRC.ReorderLevel, '')  OR
  Isnull(DST.Discontinued, '') <> Isnull(SRC.Discontinued, ''))
	THEN
		UPDATE SET DST.ProductName = SRC.ProductName,
             DST.SupplierID_SK = SRC.SupplierID_PK_SK,
             DST.CategoryID_SK = SRC.CategoryID_PK_SK,
             DST.SupplierID = SRC.SupplierID,
             DST.CategoryID = SRC.CategoryID,
             DST.QuantityPerUnit = SRC.QuantityPerUnit,
             DST.UnitPrice = SRC.UnitPrice,
             DST.UnitsInStock = SRC.UnitsInStock,
             DST.UnitsOnOrder = SRC.UnitsOnOrder,
             DST.ReorderLevel = SRC.ReorderLevel,
             DST.Discontinued = SRC.Discontinued

OUTPUT $action, 
DELETED.ProductID_NK AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.SupplierID AS TargetSupplierID, 
DELETED.SupplierID_SK AS TargetSupplierID_SK, 
DELETED.CategoryID AS TargetCategoryID,
DELETED.CategoryID_SK AS TargetCategoryID_SK,  
DELETED.QuantityPerUnit AS TargetQuantityPerUnit, 
DELETED.UnitPrice AS TargetUnitPrice, 
DELETED.UnitsInStock AS TargetUnitsInStock, 
DELETED.UnitsOnOrder AS TargetUnitsOnOrder,
DELETED.ReorderLevel AS TargetReorderLevel, 
DELETED.Discontinued AS TargetDiscontinued,
INSERTED.ProductID_NK AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.SupplierID AS SourceSupplierID, 
INSERTED.SupplierID_SK AS SourceSupplierID_SK, 
INSERTED.CategoryID AS SourceCategoryID,
INSERTED.CategoryID_SK AS SourceCategoryID_SK, 
INSERTED.QuantityPerUnit AS SourceQuantityPerUnit, 
INSERTED.UnitPrice AS SourceUnitPrice, 
INSERTED.UnitsInStock AS SourceUnitsInStock, 
INSERTED.UnitsOnOrder AS SourceUnitsOnOrder,
INSERTED.ReorderLevel AS SourceReorderLevel, 
INSERTED.Discontinued AS TargetDiscontinued; 