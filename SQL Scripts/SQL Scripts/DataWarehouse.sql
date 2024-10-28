
Create Database AWN_DW
Use AWN_DW
GO





CREATE TABLE [dbo].[DimReseller] (           
    ResellerSurrogateKey INT IDENTITY(1,1) ,    -- Surrogate key
    ResellerID INT UNIQUE NOT NULL,
	SalesPersonID INT,
	CustomerKey Int, 
    ResellerName NVARCHAR(100),
	ModifiedDate datetime
 CONSTRAINT [PK_DimReseller_ResellerKey] PRIMARY KEY CLUSTERED 
(
	ResellerSurrogateKey ASC,
	ResellerID ASC
)
);
GO






CREATE TABLE [dbo].[DimCustomer](
	[CustomerSurrogateKey] [int] identity(1,1),
	[CustomerID] [int]  UNIQUE NOT NULL,
	[PersonID] [int] NULL,
	[ResellerID] [int] NULL,
	[TerritoryID] [int] NULL,
	[rowguid] [uniqueidentifier]   NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[CustomerSurrogateKey] ASC,
	[CustomerID] ASC
)
);
GO






CREATE TABLE [dbo].[DimOnlineCustomer](
	[OnlineCustomerSurrogateKey] [int] IDENTITY(1,1) NOT NULL,
	[OnlineCustomerID] INT UNIQUE NOT NULL,
	[CustomerID] [int] ,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[EmailPromotion] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](120) NULL,
	[City] [nvarchar] (50) Null,
	PersonModifiedDate datetime,
	AddressModifiedDate datetime
 CONSTRAINT [PK_DimOnlineCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[OnlineCustomerSurrogateKey] ASC,
	[OnlineCustomerID] ASC
)
);
GO







CREATE TABLE [dbo].[DimSalesTerritory](
	[SalesTerritorySurrogateKey] [int] IDENTITY(1,1) NOT NULL,
	[SalesTerritoryID] [int] UNIQUE NOT NULL,
	[SalesTerritoryCountry] [nvarchar](50) NOT NULL,
	[SalesTerritoryGroup] [nvarchar](50),
	[Name] nvarchar(50),
	SalesYTD Money,
	SalesLastYear money,
	CostYTD money,
	CostLastYear money,
	ModifiedDate datetime
 CONSTRAINT [PK_DimSalesTerritory_SalesTerritoryKey] PRIMARY KEY CLUSTERED 
(
	[SalesTerritorySurrogateKey] ASC,
	[SalesTerritoryID] ASC
)
);
GO






CREATE TABLE [dbo].[DimSalesPerson] (
	[SalesPersonSurrogateKey] int identity(1,1),
    [SalesPersonID] INT UNIQUE NOT NULL,                            
    [TerritoryID] INT NULL,                          
    [SalesQuota] MONEY NULL,                         
    [Bonus] MONEY NULL,                              
    [CommissionPct] smallmoney NULL,              
    [SalesYTD] MONEY NULL,                           
    [SalesLastYear] MONEY NULL,                 
    [ModifiedDate] DATETIME NULL,                    
    CONSTRAINT [PK_DimSalesPerson_SalesPersonKey] PRIMARY KEY CLUSTERED
    (
        [SalesPersonSurrogateKey] ASC,
		SalesPersonID ASC
    ) 
	);
GO









CREATE TABLE [dbo].[DimProduct](
	[ProductSurrogateKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] INT UNIQUE NOT NULL,
	ProductNumber nvarchar(25) null,
	[ProductName] [nvarchar](50) NOT NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NUlL,
	ProductLine nchar(2),
	SafetyStockLevel smallint,
	[ProductSubcategoryName] [nvarchar](50) NULL,
	[ProductcategoryName] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_DimProduct_ProductKey] PRIMARY KEY CLUSTERED 
(
	[ProductSurrogateKey] ASC,
	[ProductID] ASC
)
);
GO







CREATE TABLE [dbo].[DimWorkOrder] (
	[WorkOrderSurrogateKey] INT IDENTITY(1,1) Not null,
    [WorkOrderID] INT UNIQUE NOT NULL,
    [ProductID] INT NOT NULL,
    [OrderQty] INT NOT NULL,
	[ScrappedQty] smallint Null,
	[StockedQty] int NULL,
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME NULL,
    [DueDate] DATETIME NOT NULL,
    [ModifiedDate] DATETIME NOT NULL ,
    CONSTRAINT [PK_DimWorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED 
    (
        [WorkOrderSurrogateKey] ASC,
		WorkOrderID ASC
    ) 
);
GO






CREATE TABLE [dbo].[DimVendor] (
    [VendorSurrogateKey] INT IDENTITY(1,1) NOT NULL,           
    [VendorID] INT UNIQUE NOT NULL,                      
    [AccountNumber] NVARCHAR(50) NULL,               
    [VendorName] NVARCHAR(100) NULL,                  
    [CreditRating] TINYINT NULL,                      
    [PreferredVendorStatus] BIT NULL,                 -- Indicates if the vendor is preferred (1 = Yes, 0 = No)
    [ActiveFlag] BIT NULL,                            -- Indicates if the vendor is active (1 = Active, 0 = Inactive)     
    [ModifiedDate] DATETIME NULL,                     
    CONSTRAINT [PK_DimVendor_VendorKey] PRIMARY KEY CLUSTERED 
    (
        [VendorSurrogateKey] ASC,
		[VendorID] ASC
    ) 
);
GO







CREATE TABLE [dbo].[FactResellerSales](
	[ProductKey] [int],
	[OrderDateKey_Reseller] [int],
	[CustomerID] [int],
	[ResellerKey] [int],
	[SalesTerritoryKey] [int],
	[SalesOrderNumber] [nvarchar](20) NOT NULL, --SALESORDERID
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	LineTotal int,
	[OrderQuantity] [smallint] NULL,
	[UnitPrice] [money] NOT NULL,
	UnitPriceDiscount money,
	SubTotal money,
	TaxAmt money,
	Freight money,
	TotalDue money,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ShipDate] [datetime] NULL,
	ModifiedDate datetime
 CONSTRAINT [PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)
);
GO



CREATE TABLE [dbo].[FactInternetSales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey_Internet] [int],
	OnlineCustomerID int,
	[CustomerID] [int] , 
	[SalesTerritoryKey] [int] ,
	[SalesOrderNumber] [nvarchar](20) NOT NULL, --SALESORDERID
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	LineTotal money,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	UnitPriceDiscount money,
	SubTotal money,
	TaxAmt money,
	Freight money,
	TotalDue money,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ShipDate] [datetime] NULL,
	ModifiedDate datetime 
 CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)
);
GO




CREATE TABLE [dbo].[FactPurchaseOrder] (
    PurchaseOrderID INT NOT NULL,                
    PurchaseOrderDetailID INT NOT NULL,             
    PurchaseLineNumber INT , 
	LineTotal INT,
    OrderDate DATE,    
	OrderDateKey_Purchase int,
    DueDate DATE,                        
    ProductID INT,                        
    UnitPrice MONEY,                      
    OrderQty INT,                         
    TaxAmt MONEY,
	Freight money,
	SubTotal money,
    ReceivedQty INT,                       
    RejectedQty INT,
	StockedQty INT,
    VendorID INT, 
	TotalDue money,
    PreferredVendorStatus BIT NOT NULL,             -- Vendor's preferred status
    ActiveFlag BIT NOT NULL,                        -- Vendor's active flag
	ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_FactPurchaseOrder_PurchaseOrderKey] PRIMARY KEY CLUSTERED 
    (
        PurchaseOrderID ASC,
		PurchaseOrderDetailID ASC
    )
);

