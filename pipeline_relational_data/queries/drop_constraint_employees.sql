IF NOT EXISTS (
    SELECT 1
    FROM {db}.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
    INNER JOIN {db}.INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rc ON tc.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
    WHERE tc.TABLE_NAME = 'Employees' AND tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
)
BEGIN
    -- Add the foreign key constraint
    ALTER TABLE ORDERS_RELATIONAL_DB.DBO.EMPLOYEES  
    ADD CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID) REFERENCES ORDERS_RELATIONAL_DB.DBO.Departments (DepartmentID);
    
    PRINT 'Foreign key constraint has been added to table ORDERS_RELATIONAL_DB.DBO.EMPLOYEES';
END
ELSE
BEGIN
    PRINT 'Foreign key constraint already exists on the table ORDERS_RELATIONAL_DB.DBO.EMPLOYEES)';
END;
