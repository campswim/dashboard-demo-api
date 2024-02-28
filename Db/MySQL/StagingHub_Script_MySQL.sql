USE campswim_StagingHub
;

CREATE TABLE PaymentsTracking(
	PaymentId BIGINT NOT NULL,
	DismissedAt DATETIME NULL,
	ErrorReason VARCHAR(200) NULL,
	AttemptedAt DATETIME NOT NULL,
	RetiredAt DATETIME NOT NULL,
	CONSTRAINT PK_PaymentId PRIMARY KEY(PaymentId ASC)
);

CREATE TABLE Addresses(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	AddressLine1 VARCHAR(61) NOT NULL,
	AddressLine2 VARCHAR(61) NULL,
	AddressLine3 VARCHAR(61) NULL,
	City VARCHAR(35) NOT NULL,
	StateProvince VARCHAR(29) NOT NULL,
	PostalCode VARCHAR(11) NOT NULL,
	Country VARCHAR(60) NOT NULL,
	CONSTRAINT PK_Address PRIMARY KEY(Id ASC)
);

CREATE TABLE AppParams(
	Name VARCHAR(100) NOT NULL,
	Value VARCHAR(4000) NULL,
	ProcessJobIds VARCHAR(25) NULL,
	Category VARCHAR(50) NULL,
	SubCategory VARCHAR(50) NULL,
	ValueTypeId INT NOT NULL,
	Notes VARCHAR(200) NULL,
	EnabledDate DATETIME NULL,
	CreatedAt DATETIME NOT NULL,
	CreatedBy VARCHAR(25) NOT NULL,
	ModifiedAt DATETIME NULL,
	ModifiedBy VARCHAR(25) NULL,
	CONSTRAINT PK_AppParams PRIMARY KEY(`Name` ASC)
);

CREATE TABLE AppParamValueTypes(
	Id INT AUTO_INCREMENT NOT NULL,
	Type VARCHAR(20) NOT NULL,
	CONSTRAINT PK_ParamValueTypes PRIMARY KEY(Id ASC)
);

CREATE TABLE CanadaFileTracking(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	At DATETIME NOT NULL,
	Filename VARCHAR(50) NOT NULL,
	CONSTRAINT PK_CanadaFileTracking PRIMARY KEY(Id ASC)
);

CREATE TABLE ChangeLog(
	Id INT AUTO_INCREMENT NOT NULL,
	TableName VARCHAR(50) NOT NULL,
	ColumnName VARCHAR(50) NOT NULL,
	UserId INT NOT NULL,
	PrevValue VARCHAR(8000) NULL,
	NewValue VARCHAR(8000) NULL,
	ValueType INT NOT NULL,
	DATETIME DATETIME NOT NULL,
	CONSTRAINT PK_ChangeLog PRIMARY KEY(Id ASC)
);

CREATE TABLE Customers(
	CustomerNumber VARCHAR(15) NOT NULL,
	CustomerName VARCHAR(65) NULL,
	ContactName VARCHAR(61) NULL,
	CompanyName VARCHAR(35) NULL,
	Phone1 VARCHAR(21) NULL,
	Phone2 VARCHAR(21) NULL,
	Phone3 VARCHAR(21) NULL,
	EmailAddress VARCHAR(80) NULL,
	EnteredDate DATETIME NULL,
	BillAddressId BIGINT NULL,
	ShipAddressId BIGINT NULL,
	ImportedDate DATETIME NULL,
	TaxId VARCHAR(30) NULL,
	TaxIdType VARCHAR(50) NULL,
	CONSTRAINT PK_Customer PRIMARY KEY(CustomerNumber ASC)
);

CREATE TABLE DashboardPages(
	Id tinyint AUTO_INCREMENT NOT NULL,
	Page VARCHAR(50) NOT NULL,
	Actions VARCHAR(8000) NULL,
	CONSTRAINT PK_DashboardPages PRIMARY KEY(Id ASC)
);

CREATE TABLE ErpReturnOrderLines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ErpId VARCHAR(40) NULL,
	ErpHeaderId VARCHAR(40) NOT NULL,
	OrderNumber VARCHAR(20) NOT NULL,
	ParentLineNumber INT NULL,
	LineNumber INT NOT NULL,
	Sku VARCHAR(20) NOT NULL,
	Description VARCHAR(50) NULL,
	Quantity INT NOT NULL,
	UnitPrice decimal(18, 2) NOT NULL,
	UnitTax decimal(18, 2) NULL,
	Warehouse VARCHAR(20) NULL,
	CONSTRAINT PK_ErpReturnOrderLines PRIMARY KEY(Id ASC)
);

CREATE TABLE ErpReturnOrders(
	ErpId VARCHAR(40) NOT NULL,
	OrderNumber VARCHAR(20) NOT NULL,
	CustomerNumber VARCHAR(15) NOT NULL,
	CreatedDate DATETIME NOT NULL,
	OrderDate DATETIME NOT NULL,
	ShipDate DATETIME NOT NULL,
	CustomerName VARCHAR(35) NULL,
	Address VARCHAR(35) NULL,
	Address2 VARCHAR(35) NULL,
	City VARCHAR(35) NULL,
	State VARCHAR(25) NULL,
	Country VARCHAR(3) NULL,
	PostalCode VARCHAR(10) NULL,
	Phone VARCHAR(20) NULL,
	Email VARCHAR(50) NULL,
	Warehouse VARCHAR(25) NOT NULL,
	OriginalOrderNumber INT NOT NULL,
	ImportedAt DATETIME NOT NULL,
	SentToCrmAt DATETIME NULL,
	CrmOrderId INT NULL,
	CONSTRAINT PK_ReturnOrders_ErpId PRIMARY KEY(ErpId ASC)
);

CREATE TABLE ErpShipmentTracking(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ErpPostedPackageId VARCHAR(40) NOT NULL,
	ErpOrderNumber VARCHAR(25) NOT NULL,
	At DATETIME NOT NULL,
	CONSTRAINT PK_Id PRIMARY KEY(Id ASC)
);

CREATE TABLE Logging(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	Level VARCHAR(256) NULL,
	TimeStamp DATETIME NULL,
	Message VARCHAR(1000) NULL,
	Exception VARCHAR(1000) NULL,
	Properties VARCHAR(1000) NULL,
	JobName VARCHAR(30) NOT NULL,
	MessageTemplate VARCHAR(1000) NULL,
	CONSTRAINT PK_Logging PRIMARY KEY(Id ASC)
);

CREATE TABLE Maps(
	Id INT AUTO_INCREMENT NOT NULL,
	IsoCountryCode VARCHAR(3) NOT NULL,
	ErpCompanyId VARCHAR(50) NOT NULL,
	IsoCurrencyCode VARCHAR(3) NOT NULL,
	ErpCurrencyCode VARCHAR(10) NOT NULL,
	SourceWarehouse VARCHAR(11) NOT NULL,
	SourceShipMethod VARCHAR(100) NULL,
	DestinationWarehouse VARCHAR(25) NULL,
	ReturnsWarehouse VARCHAR(25) NULL,
	IsVAT tinyint NULL,
	UseForErpPull tinyint NULL,
	ProcessingSequence INT NULL,
	ActivatedAt DATETIME NULL,
	DeactivatedAt DATETIME NULL,
	CreatedAt DATETIME NOT NULL,
	CreatedBy VARCHAR(25) NOT NULL,
	ModifiedAt DATETIME NULL,
	ModifiedBy VARCHAR(25) NULL,
	CONSTRAINT PK_Maps PRIMARY KEY(Id ASC)
);

CREATE TABLE OrderBatch(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	DailyBatchNumber INT NOT NULL,
	BatchDate DATETIME NOT NULL,
	Market VARCHAR(10) NOT NULL,
	SelectedOrderCount INT NOT NULL,
	ProcessedOrderCount INT NULL,
	CreatedAt DATETIME NOT NULL,
	BatchMonth INT NULL,
	OrderBatchSize INT NULL,
	CONSTRAINT PK_OrderBatch_OrderBatchId PRIMARY KEY(Id ASC)
);

CREATE TABLE OrderBatchDetail(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderBatchId BIGINT NOT NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	ErrorCode VARCHAR(50) NULL,
	ErrorMessage VARCHAR(2000) NULL,
	CONSTRAINT PK_OrderBatchDetail_Id PRIMARY KEY(Id ASC)
);

CREATE TABLE Orderlines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	LineNumber INT NULL,
	Sku VARCHAR(31) NOT NULL,
	Quantity decimal(18, 2) NOT NULL,
	UnitPrice decimal(18, 2) NOT NULL,
	TaxRate decimal(18, 2) NOT NULL,
	UnitTaxAmount decimal(18, 2) NULL,
	ExtTaxAmount decimal(18, 2) NULL,
	Warehouse VARCHAR(11) NULL,
	Description VARCHAR(200) NULL,
	ParentSku VARCHAR(31) NULL,
	ComponentPrice decimal(18, 2) NULL,
	UnitCost decimal(18, 2) NULL,
	ItemType INT NOT NULL,
	IsVirtual tinyint NOT NULL,
	Weight decimal(9, 2) NULL,
	CVolume decimal(18, 2) NULL,
	CONSTRAINT PK_orderline_Clustered PRIMARY KEY(Id ASC)
);

CREATE TABLE Orders(
	OrderNumber VARCHAR(21) NOT NULL,
	CustomerNumber VARCHAR(15) NOT NULL,
	Market VARCHAR(10) NOT NULL,
	CurrencyCode VARCHAR(10) NOT NULL,
	CreatedDate DATETIME NOT NULL,
	OrderDate DATETIME NOT NULL,
	Warehouse VARCHAR(25) NULL,
	PushStatusId INT NULL,
	ShipToName VARCHAR(65) NULL,
	ShipDate DATETIME NULL,
	ShipMethod VARCHAR(50) NULL,
	TrackingNumber VARCHAR(41) NULL,
	OrderTotalAmount decimal(18, 2) NOT NULL,
	FreightAmount decimal(18, 2) NOT NULL,
	FreightTaxAmount decimal(18, 2) NOT NULL,
	TaxAmount decimal(18, 2) NOT NULL,
	DiscountAmount decimal(18, 2) NULL,
	OrderNotes VARCHAR(500) NULL,
	Phone1 VARCHAR(21) NULL,
	Phone2 VARCHAR(21) NULL,
	Phone3 VARCHAR(21) NULL,
	BillAddressId BIGINT NULL,
	ShipAddressId BIGINT NULL,
	StagingImportDate DATETIME NOT NULL,
	PickupName VARCHAR(100) NULL,
	OrderTypeDescription VARCHAR(20) NULL,
	ReferenceOrderNumber VARCHAR(21) NULL,
	ErpOrderNumber VARCHAR(25) NULL,
	ErpId VARCHAR(40) NULL,
	SentToErp DATETIME NULL,
	SentTo3PL DATETIME NULL,
	CONSTRAINT PK_orders_OrderNumber PRIMARY KEY(OrderNumber ASC)
);

CREATE TABLE OrderStagingErrors(
	Id INT AUTO_INCREMENT NOT NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	OrderDate DATETIME NOT NULL,
	OrderTotal decimal(18, 2) NOT NULL,
	CurrencyCode VARCHAR(3) NOT NULL,
	Message VARCHAR(300) NOT NULL,
	At DATETIME NOT NULL,
	IgnoredAt DATETIME NULL,
	Exception VARCHAR(8000) NULL,
	CONSTRAINT PK_OrderStagingErrors PRIMARY KEY(Id ASC),
	CONSTRAINT unique_ordnum UNIQUE NONCLUSTERED(OrderNumber ASC)
);

CREATE TABLE Payments(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	SourcePaymentId VARCHAR(20) NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	PaymentType VARCHAR(30) NULL,
	PaymentAmount decimal(18, 2) NOT NULL,
	PaymentDate DATETIME NOT NULL,
	CardNumber VARCHAR(25) NULL,
	AuthCode VARCHAR(25) NULL,
	SentToErp DATETIME NULL,
	PRIMARY KEY(Id ASC)
);

CREATE TABLE ProcessedTransactions(
	Id BIGINT NOT NULL,
	OrderDate DATETIME NULL,
	EntryReceiedDate DATETIME NOT NULL,
	CustomerID INT NOT NULL,
	LoginName VARCHAR(30) NULL,
	OrderID INT NOT NULL,
	AffiliateOrderID VARCHAR(10) NULL,
	FirstName VARCHAR(25) NULL,
	LastName VARCHAR(25) NULL,
	Phone VARCHAR(12) NULL,
	Email VARCHAR(40) NULL,
	City VARCHAR(40) NULL,
	State VARCHAR(2) NULL,
	PostalCode VARCHAR(10) NULL,
	Country VARCHAR(10) NULL,
	FileOrigin VARCHAR(45) NOT NULL,
	Affiliate VARCHAR(10) NULL,
	SuccessStatus tinyint NOT NULL,
	FailReason VARCHAR(200) NULL,
	Emailed tinyint NULL,
	PRIMARY KEY(Id ASC)
);

CREATE TABLE ProcessingErrors(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ProcessJobId INT NOT NULL,
	Category VARCHAR(20) NULL,
	OrderNumber VARCHAR(21) NOT NULL,
	LineNumber INT NULL,
	AltId VARCHAR(12) NULL,
	`Message` VARCHAR(300) NOT NULL,
	AdditionalData VARCHAR(300) NULL,
	`At` DATETIME NOT NULL,
	DismissedAt DATETIME NULL,
	DismissedBy VARCHAR(20) NULL,
	Exception VARCHAR(8000) NULL,
	CONSTRAINT PK_ProcessingErrors_Id PRIMARY KEY(Id ASC)
);

CREATE TABLE ProcessJobs(
	Id INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	ExternalSystem VARCHAR(15) NOT NULL,
	DataDirection VARCHAR(3) NOT NULL,
	CONSTRAINT PK_ProcessJobs_Id PRIMARY KEY(Id ASC)
);

CREATE TABLE PurgeRunDetails(
	PurgeRunDetailId INT AUTO_INCREMENT NOT NULL,
	PurgeRunId INT NOT NULL,
	TableName VARCHAR(20) NOT NULL,
	PurgeCount INT NOT NULL,
	CONSTRAINT PK_PurgeRunDetails PRIMARY KEY(PurgeRunDetailId ASC)
);

CREATE TABLE PurgeRuns(
	PurgeRunId INT AUTO_INCREMENT NOT NULL,
	RunDate DATETIME NOT NULL,
	MonthsKept INT NOT NULL,
	CONSTRAINT PK_PurgeRuns PRIMARY KEY(PurgeRunId ASC)
);

CREATE TABLE PushStatuses(
	Id INT AUTO_INCREMENT NOT NULL,
	Name VARCHAR(20) NOT NULL,
	PRIMARY KEY(Id ASC)
);

CREATE TABLE Roles(
	Id tinyint NOT NULL,
	Role VARCHAR(50) NOT NULL,
	RestrictedPages VARCHAR(8000) NOT NULL,
	RestrictedActions VARCHAR(8000) NOT NULL,
	CONSTRAINT PK_Roles PRIMARY KEY(Id ASC)
);

CREATE TABLE ShippedOrderlines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderlineId BIGINT NOT NULL,
	ShippedAt DATETIME NOT NULL,
	ShippedQuantity INT NOT NULL,
	Carrier VARCHAR(50) NULL,
	ShipMethod VARCHAR(50) NULL,
	TrackingNumber VARCHAR(50) NULL,
	LotNumber VARCHAR(25) NOT NULL,
	ShippedOrderSourceId INT NOT NULL,
	SourceDocument VARCHAR(50) NULL,
	CrmNotifiedAt DATETIME NULL,
	ErpNotifiedAt DATETIME NULL,
	CreatedAt DATETIME NOT NULL,
	CreatedBy VARCHAR(25) NOT NULL,
	CONSTRAINT PK_ShippedOrderLines_Id PRIMARY KEY(Id ASC)
);

CREATE TABLE ShippedOrderSources(
	Id INT AUTO_INCREMENT NOT NULL,
	Name VARCHAR(30) NULL,
	PRIMARY KEY(Id ASC)
);

CREATE TABLE Users(
	Id INT AUTO_INCREMENT NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Hash VARCHAR(8000) NOT NULL,
	Role tinyint NOT NULL,
	DateRegistered DATETIME NOT NULL,
	LastLogin DATETIME NULL,
	LoggedIn tinyint NULL,
	FailedAttempts tinyint NULL,
	Active tinyint NULL,
 	CONSTRAINT PK_Users PRIMARY KEY(Id ASC)
);

ALTER TABLE AppParams ADD CONSTRAINT FOREIGN KEY FK_AppParams_ParamValueTypes (ValueTypeId)
REFERENCES AppParamValueTypes (Id)
;
ALTER TABLE CanadaFileTracking Add CONSTRAINT FOREIGN KEY FK_CanadaFileTracking_Orders (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE ChangeLog Add CONSTRAINT FOREIGN KEY FK_ChangeLog_AppParamValueTypes (ValueType)
REFERENCES AppParamValueTypes (Id)
;
ALTER TABLE ChangeLog Add CONSTRAINT FOREIGN KEY FK_ChangeLog_Users (UserId)
REFERENCES Users (Id)
;
ALTER TABLE Customers Add CONSTRAINT FOREIGN KEY FK_Customers_Addresses (ShipAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE Customers Add CONSTRAINT FOREIGN KEY FK_Customers_Addresses1 (BillAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE ErpReturnOrderLines Add CONSTRAINT FOREIGN KEY FK_ReturnOrderLines_ROs (ErpHeaderId)
REFERENCES ErpReturnOrders (ErpId)
ON DELETE CASCADE
;
ALTER TABLE ErpReturnOrders Add CONSTRAINT FOREIGN KEY FK_ErpReturnOrders_Customers (CustomerNumber)
REFERENCES Customers (CustomerNumber)
;
ALTER TABLE OrderBatchDetail Add CONSTRAINT FOREIGN KEY FK_OrderBatch_OrderBatchDetail_Cascade (OrderBatchId)
REFERENCES OrderBatch (Id)
ON DELETE CASCADE
;
ALTER TABLE Orderlines Add CONSTRAINT FOREIGN KEY FK_Orderlines_Orders (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE Orders Add CONSTRAINT FOREIGN KEY FK_Orders_Bill_Addresses (BillAddressId)
REFERENCES Addresses (Id)
ON DELETE CASCADE
;
ALTER TABLE Orders Add CONSTRAINT FOREIGN KEY FK_Orders_Customers (CustomerNumber)
REFERENCES Customers (CustomerNumber)
;
ALTER TABLE Orders Add CONSTRAINT FOREIGN KEY FK_Orders_PushStatuses (PushStatusId)
REFERENCES PushStatuses (Id)
;
ALTER TABLE Orders Add CONSTRAINT FOREIGN KEY FK_Orders_Ship_Addresses (ShipAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE Payments Add CONSTRAINT FOREIGN KEY FK_Payments_Orders (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE PaymentsTracking Add CONSTRAINT FOREIGN KEY FK_PaymentsTracking_Payments (PaymentId)
REFERENCES Payments (Id)
ON DELETE CASCADE
;
ALTER TABLE ProcessingErrors Add CONSTRAINT FOREIGN KEY FK_ProcessJobs_Id (ProcessJobId)
REFERENCES ProcessJobs (Id)
;
ALTER TABLE PurgeRunDetails Add CONSTRAINT FOREIGN KEY FK_PurgeRunDetails_PurgeRuns (PurgeRunId)
REFERENCES PurgeRuns (PurgeRunId)
;
ALTER TABLE ShippedOrderlines Add CONSTRAINT FOREIGN KEY FK_Orders_OrderlineId (OrderlineId)
REFERENCES Orderlines (Id)
ON DELETE CASCADE
;
ALTER TABLE ShippedOrderlines Add CONSTRAINT FOREIGN KEY FK_Orders_SourceId (ShippedOrderSourceId)
REFERENCES ShippedOrderSources (Id)
;
ALTER TABLE Users Add CONSTRAINT FOREIGN KEY FK_Users_Roles (Role)
REFERENCES Roles (Id)
;

/*
CREATE TRIGGER trg_DismissPaymentTrackingWhenProcessingErrorsDismissed
AFTER UPDATE
ON ProcessingErrors
FOR EACH ROW
BEGIN
 declare @pjId INT;
 declare @altId VARCHAR(12);
 SELECT TOP 1 @pjId = ProcessJobId from INSERTED
 SELECT TOP 1 @altId = AltId from INSERTED
 UPDATE dbo.PaymentsTracking
 SET DismissedAt = NOW()
 WHERE @pjId = 211
 AND PaymentId = CAST(@altId as BIGINT)
END ;
;
ALTER DATABASE campswim_StagingHub SET READ_WRITE 
;
*/