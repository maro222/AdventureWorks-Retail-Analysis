USE AWN_DW

-- FactInternetSales related to DimCustomer, DimProduct, DimSalesTerritory
ALTER TABLE [dbo].[FactInternetSales]  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimOnlineCustomer] FOREIGN KEY([OnlineCustomerID])
REFERENCES [dbo].[DimOnlineCustomer] ([OnlineCustomerID])
GO
ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimOnlineCustomer]
GO


ALTER TABLE [dbo].[FactInternetSales]  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[DimCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimCustomer]
GO


ALTER TABLE [dbo].[FactInternetSales]  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimProduct] FOREIGN KEY([ProductKey])
REFERENCES [dbo].[DimProduct] ([ProductID])
GO
ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimProduct]
GO


ALTER TABLE [dbo].[FactInternetSales]  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimSalesTerritory] FOREIGN KEY([SalesTerritoryKey])
REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryID])
GO
ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimSalesTerritory]
GO





-- FactResellerSales related to DimProduct, DimSalesTerritory, DimReseller
ALTER TABLE [dbo].[FactResellerSales]  WITH CHECK ADD  CONSTRAINT [FK_FactResellerSales_DimCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[DimCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimCustomer]
GO


ALTER TABLE [dbo].[FactResellerSales]  WITH CHECK ADD  CONSTRAINT [FK_FactResellerSales_DimProduct] FOREIGN KEY([ProductKey])
REFERENCES [dbo].[DimProduct] ([ProductID])
GO
ALTER TABLE [dbo].[FactResellerSales] CHECK CONSTRAINT [FK_FactResellerSales_DimProduct]
GO


ALTER TABLE [dbo].[FactResellerSales]  WITH CHECK ADD  CONSTRAINT [FK_FactResellerSales_DimSalesTerritory] FOREIGN KEY([SalesTerritoryKey])
REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryID])
GO
ALTER TABLE [dbo].[FactResellerSales] CHECK CONSTRAINT [FK_FactResellerSales_DimSalesTerritory]
GO


ALTER TABLE [dbo].[FactResellerSales]  WITH CHECK ADD  CONSTRAINT [FK_reseller] FOREIGN KEY([ResellerKey])
REFERENCES [dbo].[DimReseller] (ResellerID)
GO
ALTER TABLE [dbo].[FactResellerSales] CHECK CONSTRAINT [FK_reseller]
GO





-- FactPurchaseOrder related to DimVendor, DimShipMethod
ALTER TABLE [dbo].[FactPurchaseOrder] WITH CHECK ADD CONSTRAINT [FK_FactPurchaseOrder_DimVendor] FOREIGN KEY(VendorID)
REFERENCES [dbo].[DimVendor] ([VendorID])
GO
ALTER TABLE [dbo].[FactPurchaseOrder] CHECK CONSTRAINT [FK_FactPurchaseOrder_DimVendor]



ALTER TABLE [dbo].[FactPurchaseOrder] WITH CHECK ADD CONSTRAINT [FK_FactPurchaseOrder_DimProduct] FOREIGN KEY(ProductID)
REFERENCES [dbo].[DimProduct] ([ProductID])
GO
ALTER TABLE [dbo].[FactPurchaseOrder] CHECK CONSTRAINT [FK_FactPurchaseOrder_DimProduct]
GO




 -- DimReseller related to SalesPerson
ALTER TABLE [dbo].[DimReseller] ADD CONSTRAINT [FK_DimReseller_DimSalesPerson] FOREIGN KEY([SalesPersonID])
REFERENCES [dbo].[DimSalesPerson] ([SalesPersonID])
GO
ALTER TABLE [dbo].[DimReseller] CHECK CONSTRAINT [FK_DimReseller_DimSalesPerson]


--- DimProduct related to WorkOrder
ALTER TABLE [dbo].[DimWorkOrder] ADD CONSTRAINT [FK_DimWorkOrder_DimProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[DimProduct] ([ProductID])
GO

ALTER TABLE [dbo].[DimWorkOrder] CHECK CONSTRAINT [FK_DimWorkOrder_DimProduct]





--Dimdate linked to facts
-- Check if the foreign key constraint on FactInternetSales exists before adding
IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_FactInternetSales_DimDate'
)
BEGIN
    -- Add foreign key constraint on FactInternetSales
    ALTER TABLE [dbo].[FactInternetSales] WITH CHECK ADD CONSTRAINT [FK_FactInternetSales_DimDate]
    FOREIGN KEY (OrderDateKey_Internet) REFERENCES [dbo].[DimDate] (DateKey);
    
    -- Check the constraint to make sure it is enforced
    ALTER TABLE [dbo].[FactInternetSales] CHECK CONSTRAINT [FK_FactInternetSales_DimDate];
END;
GO

-- Check if the foreign key constraint on FactResellerSales exists before adding
IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_FactResellerSales_DimDate'
)
BEGIN
    -- Add foreign key constraint on FactResellerSales
    ALTER TABLE [dbo].[FactResellerSales] WITH CHECK ADD CONSTRAINT [FK_FactResellerSales_DimDate]
    FOREIGN KEY (OrderDateKey_Reseller) REFERENCES [dbo].[DimDate] (DateKey);
    
    -- Check the constraint to make sure it is enforced
    ALTER TABLE [dbo].[FactResellerSales] CHECK CONSTRAINT [FK_FactResellerSales_DimDate];
END;
GO


-- Check if foreign key constraint on FactPurchaseOrder exists before creating
IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_FactPurchaseOrder_DimDate'
    AND parent_object_id = OBJECT_ID('dbo.FactPurchaseOrder')
)
BEGIN
    -- Add foreign key constraint on FactPurchaseSales for OrderDateKey_Purchase
    ALTER TABLE [dbo].[FactPurchaseOrder] WITH CHECK ADD CONSTRAINT [FK_FactPurchaseOrder_DimDate]
    FOREIGN KEY(OrderDateKey_Purchase) REFERENCES [dbo].[DimDate] (DateKey);
    
    ALTER TABLE [dbo].[FactPurchaseOrder] CHECK CONSTRAINT [FK_FactPurchaseOrder_DimDate];
END;
GO


--- clusteredIndex on DimDate 
-- Check if the index on FactInternetSales for OrderDateKey_Internet exists before creating
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_FactInternetSales_OrderDateKey' 
    AND object_id = OBJECT_ID('dbo.FactInternetSales')
)
BEGIN
    -- Create index on FactInternetSales for OrderDateKey_Internet
    CREATE NONCLUSTERED INDEX [IX_FactInternetSales_OrderDateKey] ON [dbo].[FactInternetSales] (
        [OrderDateKey_Internet] ASC
    );
END;
GO

-- Check if the index on FactResellerSales for OrderDateKey_Reseller exists before creating
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_FactResellerSales_OrderDateKey' 
    AND object_id = OBJECT_ID('dbo.FactResellerSales')
)
BEGIN
    -- Create index on FactResellerSales for OrderDateKey_Reseller
    CREATE NONCLUSTERED INDEX [IX_FactResellerSales_OrderDateKey] ON [dbo].[FactResellerSales] (
        [OrderDateKey_Reseller] ASC
    );
END;
GO



-- Check if the index on FactPurchaseOrder for OrderDateKey_Purchase exists before creating
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_FactPurchaseOrder_OrderDateKey'
    AND object_id = OBJECT_ID('dbo.FactPurchaseOrder')
)
BEGIN
    -- Create index on FactPurchaseOrder for OrderDateKey_Purchase
    CREATE NONCLUSTERED INDEX [IX_FactPurchaseOrder_OrderDateKey] ON [dbo].[FactPurchaseOrder] (
        [OrderDateKey_Purchase] ASC
    );
END;
GO


---update fact with datekey
-- Update the OrderDateKey_Internet in FactInternetSales by looking up DimDate
UPDATE fis
SET fis.OrderDateKey_Internet = dd.DateKey
FROM [dbo].[FactInternetSales] fis
JOIN [dbo].[DimDate] dd
  ON fis.OrderDate = dd.FullDateAlternateKey;

-- Update the ShipDateKey in FactInternetSales by looking up DimDate
UPDATE frs
SET frs.OrderDateKey_Reseller = dd.DateKey
FROM [dbo].[FactResellerSales] frs
JOIN [dbo].[DimDate] dd
  ON frs.OrderDate = dd.FullDateAlternateKey;

UPDATE fps
SET fps.OrderDateKey_Purchase = dd.DateKey
FROM [dbo].[FactPurchaseOrder] fps
JOIN [dbo].[DimDate] dd
ON fps.OrderDate = dd.FullDateAlternateKey;
