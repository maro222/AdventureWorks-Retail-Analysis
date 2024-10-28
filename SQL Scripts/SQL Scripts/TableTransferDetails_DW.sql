Use AWN_DW 

CREATE TABLE dbo.DW_TableTransferDetails (
    SourceConnection NVARCHAR(255),
    SourceQuery NVARCHAR(MAX),
    DestinationTable NVARCHAR(255),
    PreExecuteQuery NVARCHAR(MAX) -- Optional for truncating, etc.
);





-- DimCustomer
INSERT INTO dbo.DW_TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AWN_DW;Integrated Security=True',
 'SELECT CustomerID, PersonID, StoreID, TerritoryID, ModifiedDate, rowguid
 FROM [STAGING].[Sales].[Customer]', 
 '[AWN_DW].[dbo].[DimCustomer]', 
 'TRUNCATE TABLE [AWN_DW].[dbo].[DimCustomer]');




-- DimSalesPerson
INSERT INTO dbo.DW_TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AWN_DW;Integrated Security=True',
 'SELECT SalesPersonKey,BusinessEntityID,TerritoryID,SalesQuota,Bonus,CommissionPct,SalesYTD,SalesLastYear,rowguid,ModifiedDate
  FROM [STAGING].[Sales].[SalesPerson]', 
 '[AWN_DW].[dbo].[DimSalesPerson]', 
 'TRUNCATE TABLE [AWN_DW].[dbo].[DimSalesPerson]');


-- DimVendor
INSERT INTO dbo.DW_TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AWN_DW;Integrated Security=True',
 'SELECT [VendorKey],BusinessEntityID,AccountNumber,Name,CreditRating,PreferredVendorStatus,ActiveFlag,PurchasingWebServiceURL,ModifiedDate
  FROM [STAGING].[Purchasing].[Vendor]', 
 '[AWN_DW].[dbo].[DimVendor]', 
 'TRUNCATE TABLE [AWN_DW].[dbo].[DimVendor]');


-- DimWorkOrder
INSERT INTO dbo.DW_TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AWN_DW;Integrated Security=True',
 'SELECT WorkOrderID,ProductID, OrderQty,ScrappedQty ,StartDate, EndDate, DueDate, ScrapReasonID, ModifiedDate
  FROM [STAGING].[Production].[WorkOrder]', 
 '[AWN_DW].[dbo].[DimWorkOrder]', 
 'TRUNCATE TABLE [AWN_DW].[dbo].[DimWorkOrder]');



 select * from dbo.DW_TableTransferDetails 