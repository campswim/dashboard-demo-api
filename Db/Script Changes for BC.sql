--Structure

ALTER TABLE gp.BatchDetail ALTER COLUMN ErrorCode varchar(50)

------------- CUSTOMERS
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Customers]') AND name = 'TaxId'
)
BEGIN
	ALTER TABLE dbo.Customers ADD TaxId VARCHAR(30) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Customers]') AND name = 'TaxIdType'
)
BEGIN
	ALTER TABLE dbo.Customers ADD TaxIdType VARCHAR(50) NULL
END

------------- ORDERS
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orders]') AND name = 'PickupName'
)
BEGIN
	ALTER TABLE dbo.Orders ADD PickupName VARCHAR(100) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orders]') AND name = 'OrderTypeCode'
)
BEGIN
	ALTER TABLE dbo.Orders ADD OrderTypeCode VARCHAR(20) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orders]') AND name = 'SeReferenceOrderNumberntTo3PL'
)
BEGIN
	ALTER TABLE dbo.Orders ADD ReferenceOrderNumber VARCHAR(21) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orders]') AND name = 'ErpOrderNumber'
)
BEGIN
	ALTER TABLE dbo.Orders ADD ErpOrderNumber varchar(25) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orders]') AND name = 'SentTo3PLAt'
)
BEGIN
    ALTER TABLE [dbo].[Orders] ADD [SentTo3PLAt] [datetime2](2) NULL
END

ALTER TABLE dbo.Orders ALTER column ShipMethod VARCHAR(50) NULL
ALTER TABLE dbo.Orders ALTER column Warehouse VARCHAR(25) NULL


------------- ORDERLINES
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orderlines]') AND name = '[Description]'
)
BEGIN
    ALTER TABLE dbo.OrderLines ADD [Description] VARCHAR(200) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orderlines]') AND name = 'ParentSku'
)
BEGIN
    ALTER TABLE dbo.OrderLines ADD ParentSku VARCHAR(31) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Orderlines]') AND name = 'ComponentPrice'
)
BEGIN
    ALTER TABLE dbo.OrderLines ADD ComponentPrice DECIMAL(18,2) NULL
END
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Payments]') AND name = 'PaymentType'
)
BEGIN
    ALTER TABLE dbo.Payments ALTER COLUMN PaymentType VARCHAR(30) NULL
END

------------ gp MAPS
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Maps]') AND name = 'ReturnsWarehouse'
)
BEGIN
    ALTER TABLE dbo.Maps ADD ReturnsWarehouse VARCHAR(25) NULL
END
EXECUTE SP_RENAME @objname = 'dbo.Maps.GpWarehouse', @newname = 'DestWarehouse', @objtype = 'COLUMN'
IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Maps]') AND name = 'IsVAT'
)
BEGIN
    ALTER TABLE dbo.Maps ADD IsVAT bit NULL
END

ALTER TABLE dbo.Maps ALTER column DestWarehouse VARCHAR(25) NULL



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PushStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT dbo.PushStatuses VALUES ('Sent')
INSERT dbo.PushStatuses VALUES ('Failed')
INSERT dbo.PushStatuses VALUES ('Ignored')
INSERT dbo.PushStatuses VALUES ('Placeholder')
GO
ALTER TABLE dbo.Orders
DROP CONSTRAINT FK_Orders_GpPushStatuses
GO
EXEC sp_rename 'dbo.Orders.GpPushStatusType', 'PushStatusId', 'COLUMN'
GO
ALTER TABLE dbo.Orders
	ADD CONSTRAINT FK_Orders_PushStatuses
	FOREIGN KEY (PushStatusId) REFERENCES PushStatuses(Id)
GO
DROP TABLE dbo.GpPushStatusTypes


CREATE TABLE dbo.ShippedOrderSources
(
	Id int primary key NOT NULL,
	[Name] varchar(30) NOT NULL
)

CREATE TABLE dbo.ShippedOrderlines
(
	Id bigint primary key identity(1,1),
	OrderlineId bigint NOT NULL,
	ShippedAt DATETIME2(0) NOT NULL,
	ShippedQuantity int NOT NULL,
	LotNumber varchar(25) NOT NULL,
	ShippedOrderSourceId int not NULL,
	SourceDocument varchar(50),
	BcNotifiedAt DATETIME2(0),
	ExigoNotifiedAt DATETIME2(0),
	CreatedAt DATETIME2(2) NOT NULL,
	CreatedBy varchar(25) NOT NULL
)
ALTER TABLE dbo.ShippedOrderlines
	ADD CONSTRAINT FK_Orders_SourceId
	FOREIGN KEY (ShippedOrderSourceId) REFERENCES dbo.ShippedOrderSources(Id)
GO
ALTER TABLE dbo.ShippedOrderlines
	ADD CONSTRAINT FK_Orders_OrderlineId
	FOREIGN KEY (OrderlineId) REFERENCES dbo.Orderlines(Id)
GO


CREATE TABLE dbo.PaymentsToErpSendFails
(
	Id bigint primary key identity(1,1),
	PaymentId bigint NOT NULL,
	AttemptedAt DATETIME2(2) NOT NULL,
	DismissedAt DATETIME2(2) NULL,
	ErrorMessage VARCHAR(200) NULL--?? DO I WANT THIS AS NULLable ??
)
ALTER TABLE dbo.PaymentsToErpSendFails
	ADD CONSTRAINT FK_PaymentFails_PaymentId
	FOREIGN KEY (PaymentId) REFERENCES dbo.Payments(Id)
GO


---------- APPPARAMS - Settings
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'BcEnvironment')
BEGIN  
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('BcEnvironment','Sandbox_YOLI_UAT_06012022',2,'Order','API',10,'D365 Business Central environment name','2022-5-13','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'BcClientId')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('BcClientId','13c767fd-b54b-4470-9ee9-acdcd9c8a0b1',2,'Order','API',10,'D365 Business Central ClientId','2022-5-13','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'BcClientSecret')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('BcClientSecret','nN17Q~HJn3ABQhcfnKQG7UNymH3-HRQl9-PVt',2,'Order','API',10,'D365 Business Central Client Secret','2022-5-13','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'BcAadTenantId')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('BcAadTenantId','39d40a19-5ff8-48fe-bdd9-5958ff0f8835',2,'Order','API',10,'D365 Business Central AADTenantId','2022-5-13','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoToBCPaymentTypes')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoToBCPaymentTypes','Cash|CASH,Check|CHECK,Credit Card|CARD,Credit Voucher|ACCOUNT,Point Redemption|ACCOUNT,Use Credit|ACCOUNT',2,'Order','API',10,'Payment type mapping from Exigo to BC','2022-5-20','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'PushCountriesForTaxId')
BEGIN
	INSERT dbo.AppParams ([Name], [Value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('PushCountriesForTaxId', 'PH,', 1, 'Customer', 'Tax', 10, 'County list for pulling customer TaxId', GETDATE(), 'CDL')
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'RemoveNegPosCancelOutLines')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('RemoveNegPosCancelOutLines','True',1,'Order','Line',1,'Remove matching negative and positive lines that cancel each other out','2022-8-7','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoPromoSKU')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoPromoSKU','Promo',2,'Order','Line',10,'Single Exigo promotional SKU','2022-8-9','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoPromoAltSKUs')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoPromoAltSKUs','Yoli+ Free Shipping Discount=PROMO-SHIPPING',2,'Order','Line',10,'dict key is Promo description and value is ALT SKU to use in ERP','2022-8-9','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoPromoCatchAll')
BEGIN
	INSERT dbo.AppParams ([Name], [Value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoPromoCatchAll', 'Promo,', 2, 'Order', 'Sku', 10, 'When Alt Skus do not match, use this one', GETDATE(), 'CDL')
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoToBCPaymentTypes')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoToBCPaymentTypes',
'Cash=S-CASH
Credit Card=S-CARD
Yoli Cash (USD)=S-YOLICASH
Yoli Cash (AU)(USD)=S-YOLICASH
Yoli Cash (CAN)=S-YOLICASH
Yoli Cash (PHL)=S-YOLICASH
Yoli Bonus (USD)=S-YBONUS
Yoli Bonus (CAN)=S-YBONUS
Yoli Bonus (PHL)=S-YBONUS
Yoli Rewards (AU/USA)=S-YREWARD
Yoli Rewards (CAN)=S-YREWARD
Yoli Rewards (PHL)=S-YREWARD'
	,2,'Payment','Mapping',10,'Mapping payment types from ExigoToBC','2022-8-1','CDL');
END
IF NOT EXISTS(SELECT 1 FROM [dbo].[AppParams] WHERE [Name] = 'ExigoToBCShippingAgentCodes')
BEGIN
	INSERT dbo.appparams ([name],[value], ModuleId, Category, SubCategory, ValueType, Notes, EnabledDate, CreatedBy)
	VALUES('ExigoToBCShippingAgentCodes',
'Pick-Up|WILL CALL~
Surepost|UPS~SUREPOST LESS THAN 1 LB
Surepost+|UPS~SUREPOST 1 LB OR GREATER
UPS 2nd Day|UPS~2ND DAY AIR
UPS Ground|UPS~GROUND
UPS Next Day|UPS~NEXT DAY AIR
USPS - Priority|USPS~STANDARD
USPS 1st Class|USPS~STANDARD
Canada Post Exp|CANPX~
Canada Post Sta|CANP~
LBC|LBC~
Philippines Off|WILL CALL~'
	,2,'Order','Shipping',10,'Mapping shipping agent codes from ExigoToBC','2022-8-10','CDL');
END

UPDATE dbo.appparams SET [Value] = 'false' WHERE [name] = 'StagingIgnoreAddresses'
UPDATE dbo.appparams SET [Value] = '7' WHERE [name] = 'OnlyImportOrderStatusCodes' AND ModuleId = 1
UPDATE dbo.AppParams SET [Value] = 'true' WHERE [Name] = 'ImportCrmOrderNegativePayments' AND ModuleId=1
UPDATE dbo.appparams SET [Value] = '50400000' WHERE [name] = 'OrderPullMinOrderNumber' AND [Value] = '50000000'
UPDATE dbo.AppParams 
	SET [Name] = 'ImportIgnoreOrderTypes', [Value]=null
	WHERE [Name] = 'ImportIgnoreOrderStatusTypes'

DELETE dbo.AppParams WHERE [Name] = 'CashPaymentTypeNames'   --only used for GP
DELETE dbo.AppParams WHERE [Name] = 'CreditPaymentTypeNames' --only used for GP

--UPDATE dbo.AppParams SET EnabledDate = null WHERE [Name] = 'UseLastPaymentDateForOrder'
--UPDATE dbo.AppParams SET EnabledDate = null WHERE [Name] = 'UseOnlyShipDateInSelect'

/*
DISABLE ALL THESE
DOCDATE_UseOrderDateOrShipDate
OverrideOrderShipmethodWithDefault
SalesOrderShipMethod_Default
SalesOrderShipMethod_Override
CashPaymentTypeNames
*/


--Maps

UPDATE dbo.Maps
SET GpCompanyId = 'd88d601b-1c22-ec11-8f45-000d3a1bd9aa'
WHERE IsoCountryCode IN ('USA','AUS') AND ErpCompanyId IN ('TYOLI','YOLI');

UPDATE dbo.Maps
SET GpCompanyId = 'b242ba0f-ff51-ec11-9f08-000d3a14a707'
WHERE IsoCountryCode IN ('CAN') AND ErpCompanyId IN ('YOCAN', 'TCAN');

UPDATE dbo.Maps
SET GpCompanyId = '34195264-ff51-ec11-9f08-000d3a14a707'
WHERE IsoCountryCode IN ('PHL') AND ErpCompanyId IN ('YOPHL','TPHL');

UPDATE dbo.Maps
SET DestinationWarehouse = 'DC-PHL'
WHERE SourceWarehouse = '5' AND SourceShipMethod IS NULL

UPDATE dbo.Maps
SET DestinationWarehouse = 'DC-EVENTS'
WHERE SourceWarehouse = 6 AND DestinationWarehouse = 'DC-USAXXX'

UPDATE dbo.Maps
set DestinationWarehouse='DC-CA'
WHERE SourceWarehouse = 2 AND IsoCountryCode='CAN'

UPDATE dbo.Maps
SET ReturnsWarehouse = 'DC-RETURNS', ModifiedAt = GETDATE(), ModifiedBy = 'ChadL'
WHERE ReturnsWarehouse is null

UPDATE dbo.Maps SET isVat = 1 WHERE ISOCountryCode = 'PHL'

UPDATE dbo.Maps SET GpCurrencyCode = IsoCurrencyCode

--update dbo.Maps set DestWarehouse='DC-PHLWC' WHERE SourceShipMethod = 'Philippines Office Pickup'


--Customers


/*

--delete dbo.Orders
delete dbo.Customers
delete dbo.Addresses

*/
