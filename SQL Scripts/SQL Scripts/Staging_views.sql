USE STAGING;
GO

-- View for FactResellerSales
CREATE VIEW [dbo].[FactResellerSales] AS
SELECT 
    sod.SalesOrderID,
    sod.SalesOrderDetailID,
    ROW_NUMBER() OVER (PARTITION BY sod.SalesOrderID ORDER BY soh.ModifiedDate) AS saleLineNumber,
    CAST(soh.OrderDate AS DATE) AS OrderDate,
    CAST(soh.DueDate AS DATE) AS DueDate,
    CAST(soh.ShipDate AS DATE) AS ShipDate,
    sod.OrderQty,
    sod.ProductID,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    soh.CustomerID,
    c.StoreID AS ResellerID,
    soh.TerritoryID,
    soh.SubTotal,
    soh.TaxAmt,
	soh.Freight,
    soh.ModifiedDate,
    soh.OnlineOrderFlag
FROM 
    Sales.SalesOrderHeader AS soh
LEFT JOIN 
    Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
WHERE 
    c.StoreID IS NOT NULL;  -- Exclude online sales
GO




-- View for FactOnlineSales
CREATE VIEW [dbo].[FactOnlineSales] AS
SELECT 
	sod.SalesOrderID,
    sod.SalesOrderDetailID,
    ROW_NUMBER() OVER (PARTITION BY sod.SalesOrderID ORDER BY soh.ModifiedDate) AS saleLineNumber,
    CAST(soh.OrderDate AS DATE) AS OrderDate,
    CAST(soh.DueDate AS DATE) AS DueDate,
    CAST(soh.ShipDate AS DATE) AS ShipDate,
    sod.CarrierTrackingNumber,
    sod.OrderQty,
    sod.ProductID,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    soh.CustomerID,
    c.PersonID,
    soh.TerritoryID,
    soh.SubTotal,
    soh.TaxAmt,
	soh.Freight,
    soh.ModifiedDate
FROM 
    Sales.SalesOrderHeader AS soh
LEFT JOIN 
    Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN 
    Production.[Product] AS p ON sod.ProductID = p.ProductID
LEFT JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
WHERE 
    c.PersonID IS NOT NULL   -- Include only online sales
GO






-- View for FactPurchaseOrder
CREATE VIEW [dbo].[FactPurchaseOrder] AS
SELECT 
    po.PurchaseOrderID,
    pod.PurchaseOrderDetailID,
    ROW_NUMBER() OVER (PARTITION BY po.PurchaseOrderID ORDER BY po.ModifiedDate) AS PurchaseLineNumber,
    CAST(po.OrderDate AS DATE) AS OrderDate,
    CAST(pod.DueDate AS DATE) AS DueDate,
    pod.ProductID,
    pod.UnitPrice,
    pod.OrderQty,
    po.TaxAmt,
	po.Freight,
	po.SubTotal,
    pod.ReceivedQty,
    pod.RejectedQty,
    po.VendorID,
    po.ModifiedDate,
    Ve.PreferredVendorStatus,
    Ve.ActiveFlag
FROM 
    Purchasing.PurchaseOrderHeader AS po
LEFT JOIN 
    Purchasing.PurchaseOrderDetail AS pod ON po.PurchaseOrderID = pod.PurchaseOrderID
LEFT JOIN 
    Purchasing.Vendor AS Ve ON po.VendorID = Ve.BusinessEntityID;
GO





-- View for DimReseller
CREATE VIEW [dbo].[vw_DimReseller] AS
SELECT
    BusinessEntityID AS StoreID,
	c.CustomerID,
    s.[Name] AS ResellerName,
    SalesPersonID,
	Demographics,
	s.rowguid,
	s.ModifiedDate
FROM 
    Sales.Customer AS c
LEFT JOIN 
    Sales.Store AS s ON c.StoreID = s.BusinessEntityID
WHERE 
    c.PersonID IS NULL;  -- Exclude individual customers
GO





SELECT *
INTO vw_OnlineCustomer -- Name of the new table
FROM (
    SELECT 
        c.PersonID,
        c.CustomerID,
        p.NameStyle,
        p.Title,
        p.FirstName,
        p.MiddleName,
        p.LastName,
        p.EmailPromotion,
        p.Suffix,
        p.AdditionalContactInfo,
        p.Demographics,
        p.rowguid,
        p.ModifiedDate AS PersonModifiedDate,
        a.AddressLine1,
        a.AddressLine2,
        a.City,
        a.ModifiedDate AS AddressModifiedDate,
        ROW_NUMBER() OVER (PARTITION BY c.PersonID ORDER BY c.PersonID ASC) AS row_num
    FROM Sales.Customer AS c
    LEFT JOIN 
        Person.Person AS p ON c.PersonID = p.BusinessEntityID
    LEFT JOIN 
        Person.BusinessEntityAddress AS bea ON p.BusinessEntityID = bea.BusinessEntityID
    LEFT JOIN 
        Person.Address AS a ON bea.AddressID = a.AddressID
) AS RankedSales
WHERE row_num = 1 and PersonID IS NOT NULL
order by PersonID;





-- View for DimWorkOrder
CREATE VIEW [dbo].[vw_DimWorkOrder] AS
SELECT DISTINCT
    wo.WorkOrderID,
    wo.ProductID,
    wo.OrderQty,
    wo.ScrappedQty,
    wo.StartDate,
    wo.EndDate,
    CAST(wo.DueDate AS DATETIME) AS DueDate,
    wo.ScrapReasonID,
    wo.ModifiedDate
FROM 
    Production.WorkOrder AS wo;
GO




SELECT * 
INTO [dbo].[vw_Product]
FROM (
        SELECT  
            p.ProductID,
            p.ProductNumber,
            p.[Name],
            sc.[Name] AS ProductSubcategoryName,
            c.[Name] AS ProductCategoryName,
            p.MakeFlag,
            p.FinishedGoodsFlag,
            p.Color,
            p.SafetyStockLevel,
            p.ReorderPoint,
            p.StandardCost,
            p.ListPrice,
            p.Size,
            p.SizeUnitMeasureCode,
            p.[Weight],
            p.WeightUnitMeasureCode,
            p.DaysToManufacture,
            p.ProductLine,
            p.Class,
            p.Style,
            p.SellStartDate,
            p.SellEndDate,
            p.DiscontinuedDate,
            p.rowguid,
            p.ModifiedDate,
            ROW_NUMBER() OVER (PARTITION BY p.ProductID ORDER BY p.ProductID ASC) AS row_num
        FROM 
            Production.Product AS p
        LEFT JOIN 
            Production.ProductSubCategory AS sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
        LEFT JOIN 
            Production.ProductCategory AS c ON sc.ProductCategoryID = c.ProductCategoryID
    )AS RankedSales
WHERE row_num = 1 and ProductID IS NOT NULL
order by ProductID;
