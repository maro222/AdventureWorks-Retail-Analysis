USE STAGING

CREATE TABLE dbo.TableTransferDetails (
    SourceConnection NVARCHAR(255),
    DestinationConnection NVARCHAR(255),
    SourceQuery NVARCHAR(MAX),
    DestinationTable NVARCHAR(255),
    PreExecuteQuery NVARCHAR(MAX) -- Optional for truncating, etc.
);
 

INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [BusinessEntityID],[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],[LastName],[Suffix],[EmailPromotion],CAST(AdditionalContactInfo AS NVARCHAR(MAX)) AS AdditionalContactInfo, CAST(Demographics AS NVARCHAR(MAX)) AS Demographics,[rowguid],[ModifiedDate] FROM [AdventureWorks].[Person].[Person]', 
 '[STAGING].[Person].[Person]', 
 'TRUNCATE TABLE [STAGING].[Person].[Person]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [AddressID],[AddressLine1],[AddressLine2],[City],[StateProvinceID],[PostalCode],CAST(SpatialLocation AS VARBINARY(MAX)) AS SpatialLocation,[rowguid],[ModifiedDate] FROM [AdventureWorks].[Person].[Address]', 
 '[STAGING].[Person].[Address]', 
 'TRUNCATE TABLE [STAGING].[Person].[Address]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Production].[Product]', 
 '[STAGING].[Production].[Product]', 
 'TRUNCATE TABLE [STAGING].[Production].[Product]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Production].[ProductCategory]', 
 '[STAGING].[Production].[ProductCategory]', 
 'TRUNCATE TABLE [STAGING].[Production].[ProductCategory]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Production].[ProductSubCategory]', 
 '[STAGING].[Production].[ProductSubCategory]', 
 'TRUNCATE TABLE [STAGING].[Production].[ProductSubCategory]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [WorkOrderID],[ProductID],[OrderQty],[ScrappedQty],[StartDate],[EndDate],[DueDate],[ScrapReasonID],[ModifiedDate] FROM [AdventureWorks].[Production].[WorkOrder]', 
 '[STAGING].[Production].[WorkOrder]', 
 'TRUNCATE TABLE [STAGING].[Production].[WorkOrder]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [PurchaseOrderID],[PurchaseOrderDetailID],[DueDate],[OrderQty],[ProductID],[UnitPrice],[ReceivedQty],[RejectedQty],[ModifiedDate] FROM [AdventureWorks].[Purchasing].[PurchaseOrderDetail]', 
 '[STAGING].[Purchasing].[PurchaseOrderDetail]', 
 'TRUNCATE TABLE [STAGING].[Purchasing].[PurchaseOrderDetail]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [PurchaseOrderID],[RevisionNumber],[Status],[EmployeeID],[VendorID],[ShipMethodID],[OrderDate],[ShipDate],[SubTotal],[TaxAmt],[Freight],[ModifiedDate] FROM [AdventureWorks].[Purchasing].[PurchaseOrderHeader]', 
 '[STAGING].[Purchasing].[PurchaseOrderHeader]', 
 'TRUNCATE TABLE [STAGING].[Purchasing].[PurchaseOrderHeader]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Purchasing].[Vendor]', 
 '[STAGING].[Purchasing].[Vendor]', 
 'TRUNCATE TABLE [STAGING].[Purchasing].[Vendor]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [CustomerID],[PersonID],[StoreID],[TerritoryID],[rowguid],[ModifiedDate] FROM [AdventureWorks].[Sales].[Customer]', 
 '[STAGING].[Sales].[Customer]', 
 'TRUNCATE TABLE [STAGING].[Sales].[Customer]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [SalesOrderID],[SalesOrderDetailID],[CarrierTrackingNumber],[OrderQty],[ProductID],[SpecialOfferID],[UnitPrice],[UnitPriceDiscount],[rowguid],[ModifiedDate] FROM [AdventureWorks].[Sales].[SalesOrderDetail]', 
 '[STAGING].[Sales].[SalesOrderDetail]', 
 'TRUNCATE TABLE [STAGING].[Sales].[SalesOrderDetail]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT [SalesOrderID],[RevisionNumber],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag],[PurchaseOrderNumber],[AccountNumber],[CustomerID],[SalesPersonID],[TerritoryID],[BillToAddressID],[ShipToAddressID],[ShipMethodID],[CreditCardID],[CreditCardApprovalCode],[CurrencyRateID],[SubTotal],[TaxAmt],[Freight],[Comment],[rowguid],[ModifiedDate] FROM [AdventureWorks].[Sales].[SalesOrderHeader]', 
 '[STAGING].[Sales].[SalesOrderHeader]', 
 'TRUNCATE TABLE [STAGING].[Sales].[SalesOrderHeader]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Sales].[SalesPerson]', 
 '[STAGING].[Sales].[SalesPerson]', 
 'TRUNCATE TABLE [STAGING].[Sales].[SalesPerson]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Sales].[SalesTerritory]', 
 '[STAGING].[Sales].[SalesTerritory]', 
 'TRUNCATE TABLE [STAGING].[Sales].[SalesTerritory]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Sales].[Store]', 
 '[STAGING].[Sales].[Store]', 
 'TRUNCATE TABLE [STAGING].[Sales].[Store]');



INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Person].[BusinessEntityAddress]', 
 '[STAGING].[Person].[BusinessEntityAddress]', 
 'TRUNCATE TABLE [STAGING].[Person].[BusinessEntityAddress]');


INSERT INTO dbo.TableTransferDetails 
(SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery)
VALUES 
(
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=AdventureWorks;Integrated Security=True',
 'Data Source=DESKTOP-1V4QN0F;Initial Catalog=STAGING;Integrated Security=True',
 'SELECT * FROM [AdventureWorks].[Person].[BusinessEntity]', 
 '[STAGING].[Person].[BusinessEntity]', 
 'TRUNCATE TABLE [STAGING].[Person].[BusinessEntity]');


 SELECT SourceConnection, DestinationConnection, SourceQuery, DestinationTable, PreExecuteQuery FROM dbo.TableTransferDetails;
