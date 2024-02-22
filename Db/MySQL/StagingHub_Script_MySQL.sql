USE sql3684435
;
CREATE TABLE PaymentsTrackingHistory(
	PaymentId BIGINT NOT NULL,
	DismissedAt datetime NULL,
	ErrorReason varchar(200) NULL,
	AttemptedAt datetime NOT NULL,
	RetiredAt datetime NOT NULL
)
;
CREATE INDEX ix_PaymentsTrackingHistory ON PaymentsTrackingHistory
(
	RetiredAt ASC,
	AttemptedAt ASC
)
;

CREATE TABLE PaymentsTracking(
	PaymentId BIGINT NOT NULL,
	DismissedAt datetime NULL,
	ErrorReason varchar(200) NULL,
	AttemptedAt datetime NOT NULL,
	RetiredAt datetime NOT NULL,
 CONSTRAINT PK_Payments_PaymentId PRIMARY KEY 
(
	PaymentId ASC
),
	PERIOD FOR SYSTEM_TIME (AttemptedAt, RetiredAt)
)
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = PaymentsTrackingHistory )
)
;
CREATE TABLE Addresses(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	AddressLine1 varchar(61) NOT NULL,
	AddressLine2 varchar(61) NULL,
	AddressLine3 varchar(61) NULL,
	City varchar(35) NOT NULL,
	StateProvince varchar(29) NOT NULL,
	PostalCode varchar(11) NOT NULL,
	Country varchar(60) NOT NULL,
 CONSTRAINT PK_Address PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE AppParams(
	Name varchar(100) NOT NULL,
	Value varchar(4000) NULL,
	ProcessJobIds varchar(25) NULL,
	Category varchar(50) NULL,
	SubCategory varchar(50) NULL,
	ValueTypeId int NOT NULL,
	Notes varchar(200) NULL,
	EnabledDate datetime NULL,
	CreatedAt datetime NOT NULL,
	CreatedBy varchar(25) NOT NULL,
	ModifiedAt datetime NULL,
	ModifiedBy varchar(25) NULL,
 CONSTRAINT PK_AppParams PRIMARY KEY 
(
	Name ASC
)
)
;
CREATE TABLE AppParamValueTypes(
	Id int NOT NULL,
	Type varchar(20) NOT NULL,
 CONSTRAINT PK_ParamValueTypes PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE CanadaFileTracking(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderNumber varchar(21) NOT NULL,
	At datetime NOT NULL,
	Filename varchar(50) NOT NULL,
 CONSTRAINT PK_CanadaFileTracking PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ChangeLog(
	Id int AUTO_INCREMENT NOT NULL,
	TableName varchar(50) NOT NULL,
	ColumnName varchar(50) NOT NULL,
	UserId int NOT NULL,
	PrevValue varchar(max) NULL,
	NewValue varchar(max) NULL,
	ValueType int NOT NULL,
	datetime datetime NOT NULL,
 CONSTRAINT PK_ChangeLog PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Customers(
	CustomerNumber varchar(15) NOT NULL,
	CustomerName varchar(65) NULL,
	ContactName varchar(61) NULL,
	CompanyName varchar(35) NULL,
	Phone1 varchar(21) NULL,
	Phone2 varchar(21) NULL,
	Phone3 varchar(21) NULL,
	EmailAddress varchar(80) NULL,
	EnteredDate datetime NULL,
	BillAddressId BIGINT NULL,
	ShipAddressId BIGINT NULL,
	ImportedDate datetime NULL,
	TaxId varchar(30) NULL,
	TaxIdType varchar(50) NULL,
 CONSTRAINT PK_Customer PRIMARY KEY 
(
	CustomerNumber ASC
)
)
;
CREATE TABLE DashboardPages(
	Id tinyint AUTO_INCREMENT NOT NULL,
	Page varchar(50) NOT NULL,
	Actions varchar(max) NULL,
 CONSTRAINT PK_DashboardPages PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ErpReturnOrderLines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ErpId varchar(40) NULL,
	ErpHeaderId varchar(40) NOT NULL,
	OrderNumber varchar(20) NOT NULL,
	ParentLineNumber int NULL,
	LineNumber int NOT NULL,
	Sku varchar(20) NOT NULL,
	Description varchar(50) NULL,
	Quantity int NOT NULL,
	UnitPrice decimal(18, 2) NOT NULL,
	UnitTax decimal(18, 2) NULL,
	Warehouse varchar(20) NULL,
 CONSTRAINT PK_ErpReturnOrderLines PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ErpReturnOrders(
	ErpId varchar(40) NOT NULL,
	OrderNumber varchar(20) NOT NULL,
	CustomerNumber varchar(15) NOT NULL,
	CreatedDate datetime NOT NULL,
	OrderDate datetime NOT NULL,
	ShipDate datetime NOT NULL,
	CustomerName varchar(35) NULL,
	Address varchar(35) NULL,
	Address2 varchar(35) NULL,
	City varchar(35) NULL,
	State varchar(25) NULL,
	Country varchar(3) NULL,
	PostalCode varchar(10) NULL,
	Phone varchar(20) NULL,
	Email varchar(50) NULL,
	Warehouse varchar(25) NOT NULL,
	OriginalOrderNumber int NOT NULL,
	ImportedAt datetime NOT NULL,
	SentToCrmAt datetime NULL,
	CrmOrderId int NULL,
 CONSTRAINT PK_ReturnOrders_ErpId PRIMARY KEY 
(
	ErpId ASC
)
)
;
CREATE TABLE ErpShipmentTracking(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ErpPostedPackageId varchar(40) NOT NULL,
	ErpOrderNumber varchar(25) NOT NULL,
	When datetime NOT NULL,
 CONSTRAINT unique_ErpPostedPkgId UNIQUE NONCLUSTERED 
(
	ErpPostedPackageId ASC
)
)
;
CREATE TABLE Logging(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	Level varchar(max) NULL,
	TimeStamp datetime NULL,
	Message varchar(max) NULL,
	Exception varchar(max) NULL,
	Properties varchar(max) NULL,
	JobName varchar(30) NOT NULL,
	MessageTemplate varchar(max) NULL,
 CONSTRAINT PK_Logging PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Maps(
	Id int AUTO_INCREMENT NOT NULL,
	IsoCountryCode varchar(3) NOT NULL,
	ErpCompanyId varchar(50) NOT NULL,
	IsoCurrencyCode varchar(3) NOT NULL,
	ErpCurrencyCode varchar(10) NOT NULL,
	SourceWarehouse varchar(11) NOT NULL,
	SourceShipMethod varchar(100) NULL,
	DestinationWarehouse varchar(25) NULL,
	ReturnsWarehouse varchar(25) NULL,
	IsVAT tinyint NULL,
	UseForErpPull tinyint NULL,
	ProcessingSequence int NULL,
	ActivatedAt datetime NULL,
	DeactivatedAt datetime NULL,
	CreatedAt datetime NOT NULL,
	CreatedBy varchar(25) NOT NULL,
	ModifiedAt datetime NULL,
	ModifiedBy varchar(25) NULL,
 CONSTRAINT PK_Maps PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE OrderBatch(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	DailyBatchNumber int NOT NULL,
	BatchDate datetime NOT NULL,
	Market varchar(10) NOT NULL,
	SelectedOrderCount int NOT NULL,
	ProcessedOrderCount int NULL,
	CreatedAt datetime NOT NULL,
	BatchMonth int NULL,
	OrderBatchSize int NULL,
 CONSTRAINT PK_OrderBatch_OrderBatchId PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE OrderBatchDetail(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderBatchId BIGINT NOT NULL,
	OrderNumber varchar(21) NOT NULL,
	ErrorCode varchar(50) NULL,
	ErrorMessage varchar(2000) NULL,
 CONSTRAINT PK_OrderBatchDetail_Id PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Orderlines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderNumber varchar(21) NOT NULL,
	LineNumber int NULL,
	Sku varchar(31) NOT NULL,
	Quantity decimal(18, 2) NOT NULL,
	UnitPrice decimal(18, 2) NOT NULL,
	TaxRate decimal(18, 2) NOT NULL,
	UnitTaxAmount decimal(18, 2) NULL,
	ExtTaxAmount decimal(18, 2) NULL,
	Warehouse varchar(11) NULL,
	Description varchar(200) NULL,
	ParentSku varchar(31) NULL,
	ComponentPrice decimal(18, 2) NULL,
	UnitCost decimal(18, 2) NULL,
	ItemType int NOT NULL,
	IsVirtual tinyint NOT NULL,
	Weight decimal(9, 2) NULL,
	CVolume decimal(18, 2) NULL,
 CONSTRAINT PK_orderline_Clustered PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Orders(
	OrderNumber varchar(21) NOT NULL,
	CustomerNumber varchar(15) NOT NULL,
	Market varchar(10) NOT NULL,
	CurrencyCode varchar(10) NOT NULL,
	CreatedDate datetime NOT NULL,
	OrderDate datetime NOT NULL,
	Warehouse varchar(25) NULL,
	PushStatusId int NULL,
	ShipToName varchar(65) NULL,
	ShipDate datetime NULL,
	ShipMethod varchar(50) NULL,
	TrackingNumber varchar(41) NULL,
	OrderTotalAmount decimal(18, 2) NOT NULL,
	FreightAmount decimal(18, 2) NOT NULL,
	FreightTaxAmount decimal(18, 2) NOT NULL,
	TaxAmount decimal(18, 2) NOT NULL,
	DiscountAmount decimal(18, 2) NULL,
	OrderNotes varchar(500) NULL,
	Phone1 varchar(21) NULL,
	Phone2 varchar(21) NULL,
	Phone3 varchar(21) NULL,
	BillAddressId BIGINT NULL,
	ShipAddressId BIGINT NULL,
	StagingImportDate datetime NOT NULL,
	PickupName varchar(100) NULL,
	OrderTypeDescription varchar(20) NULL,
	ReferenceOrderNumber varchar(21) NULL,
	ErpOrderNumber varchar(25) NULL,
	ErpId varchar(40) NULL,
	SentToErp datetime NULL,
	SentTo3PL datetime NULL,
 CONSTRAINT PK_orders_OrderNumber PRIMARY KEY 
(
	OrderNumber ASC
)
)
;
CREATE TABLE OrderStagingErrors(
	Id int AUTO_INCREMENT NOT NULL,
	OrderNumber varchar(21) NOT NULL,
	OrderDate datetime NOT NULL,
	OrderTotal decimal(18, 2) NOT NULL,
	CurrencyCode varchar(3) NOT NULL,
	Message varchar(300) NOT NULL,
	At datetime NOT NULL,
	IgnoredAt datetime NULL,
	Exception varchar(max) NULL,
 CONSTRAINT PK_OrderStagingErrors PRIMARY KEY 
(
	Id ASC
),
 CONSTRAINT unique_ordnum UNIQUE NONCLUSTERED 
(
	OrderNumber ASC
)
)
;
CREATE TABLE Payments(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	SourcePaymentId varchar(20) NULL,
	OrderNumber varchar(21) NOT NULL,
	PaymentType varchar(30) NULL,
	PaymentAmount decimal(18, 2) NOT NULL,
	PaymentDate datetime NOT NULL,
	CardNumber varchar(25) NULL,
	AuthCode varchar(25) NULL,
	SentToErp datetime NULL,
PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ProcessedTransactions(
	Id BIGINT NOT NULL,
	OrderDate datetime NULL,
	EntryReceiedDate datetime NOT NULL,
	CustomerID int NOT NULL,
	LoginName varchar(30) NULL,
	OrderID int NOT NULL,
	AffiliateOrderID varchar(10) NULL,
	FirstName varchar(25) NULL,
	LastName varchar(25) NULL,
	Phone varchar(12) NULL,
	Email varchar(40) NULL,
	City varchar(40) NULL,
	State varchar(2) NULL,
	PostalCode varchar(10) NULL,
	Country varchar(10) NULL,
	FileOrigin varchar(45) NOT NULL,
	Affiliate varchar(10) NULL,
	SuccessStatus tinyint NOT NULL,
	FailReason varchar(200) NULL,
	Emailed tinyint NULL,
PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ProcessingErrors(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	ProcessJobId int NOT NULL,
	Category varchar(20) NULL,
	OrderNumber varchar(21) NOT NULL,
	LineNumber int NULL,
	AltId varchar(12) NULL,
	Message varchar(300) NOT NULL,
	AdditionalData varchar(300) NULL,
	At datetime NOT NULL,
	DismissedAt datetime NULL,
	DismissedBy varchar(20) NULL,
	Exception varchar(max) NULL,
 CONSTRAINT PK_ProcessingErrors_Id PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ProcessJobs(
	Id int NOT NULL,
	Name varchar(50) NOT NULL,
	ExternalSystem varchar(15) NOT NULL,
	DataDirection varchar(3) NOT NULL,
 CONSTRAINT PK_ProcessJobs_Id PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE PurgeRunDetails(
	PurgeRunDetailId int AUTO_INCREMENT NOT NULL,
	PurgeRunId int NOT NULL,
	TableName varchar(20) NOT NULL,
	PurgeCount int NOT NULL,
 CONSTRAINT PK_PurgeRunDetails PRIMARY KEY 
(
	PurgeRunDetailId ASC
)
)
;
CREATE TABLE PurgeRuns(
	PurgeRunId int AUTO_INCREMENT NOT NULL,
	RunDate datetime NOT NULL,
	MonthsKept int NOT NULL,
 CONSTRAINT PK_PurgeRuns PRIMARY KEY 
(
	PurgeRunId ASC
)
)
;
CREATE TABLE PushStatuses(
	Id int AUTO_INCREMENT NOT NULL,
	Name varchar(20) NOT NULL,
PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Roles(
	Id tinyint NOT NULL,
	Role varchar(50) NOT NULL,
	RestrictedPages varchar(max) NOT NULL,
	RestrictedActions varchar(max) NOT NULL,
 CONSTRAINT PK_Roles PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ShippedOrderlines(
	Id BIGINT AUTO_INCREMENT NOT NULL,
	OrderlineId BIGINT NOT NULL,
	ShippedAt datetime NOT NULL,
	ShippedQuantity int NOT NULL,
	Carrier varchar(50) NULL,
	ShipMethod varchar(50) NULL,
	TrackingNumber varchar(50) NULL,
	LotNumber varchar(25) NOT NULL,
	ShippedOrderSourceId int NOT NULL,
	SourceDocument varchar(50) NULL,
	CrmNotifiedAt datetime NULL,
	ErpNotifiedAt datetime NULL,
	CreatedAt datetime NOT NULL,
	CreatedBy varchar(25) NOT NULL,
 CONSTRAINT PK_ShippedOrderLines_Id PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE ShippedOrderSources(
	Id int NOT NULL,
	Name varchar(30) NULL,
PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE TABLE Users(
	Id int AUTO_INCREMENT NOT NULL,
	Email varchar(100) NOT NULL,
	Name varchar(100) NOT NULL,
	Hash varchar(max) NOT NULL,
	Role tinyint NOT NULL,
	DateRegistered datetime NOT NULL,
	LastLogin datetime NULL,
	LoggedIn tinyint NULL,
	FailedAttempts tinyint NULL,
	Active tinyint NULL,
 CONSTRAINT PK_Users PRIMARY KEY 
(
	Id ASC
)
)
;
CREATE NONCLUSTERED INDEX IX_OBD_OrdNbr ON OrderBatchDetail
(
	OrderNumber ASC
)
;
CREATE NONCLUSTERED INDEX IX_Ol_OrdNbr ON Orderlines
(
	OrderNumber ASC
)
;
CREATE NONCLUSTERED INDEX IX_Orders_MktPushStErpOrdNbr ON Orders
(
	Market ASC,
	PushStatusId ASC,
	ErpOrderNumber ASC
)
;
CREATE NONCLUSTERED INDEX IX_Pmt_OrdNbr ON Payments
(
	OrderNumber ASC
)
;
CREATE NONCLUSTERED INDEX IX_Pmts_OrdNbr ON Payments
(
	SentToErp ASC,
	PaymentDate ASC
)
;
CREATE NONCLUSTERED INDEX ix_OrderNumber ON ProcessingErrors
(
	OrderNumber ASC
)
;
CREATE NONCLUSTERED INDEX IX_ShippedOrderlines_SourceDocument ON ShippedOrderlines
(
	SourceDocument ASC
)
;
CREATE NONCLUSTERED INDEX IX_SOL_OrdLnId ON ShippedOrderlines
(
	OrderlineId ASC
)
;
ALTER TABLE AppParams  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ValueTypeId)
REFERENCES AppParamValueTypes (Id)
;
ALTER TABLE AppParams CHECK CONSTRAINT FK_AppParams_ParamValueTypes
;
ALTER TABLE CanadaFileTracking  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE CanadaFileTracking CHECK CONSTRAINT FK_CanadaFileTracking_Orders
;
ALTER TABLE ChangeLog  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ValueType)
REFERENCES AppParamValueTypes (Id)
;
ALTER TABLE ChangeLog CHECK CONSTRAINT FK_ChangeLog_AppParamValueTypes
;
ALTER TABLE ChangeLog  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (UserId)
REFERENCES Users (Id)
;
ALTER TABLE ChangeLog CHECK CONSTRAINT FK_ChangeLog_Users
;
ALTER TABLE Customers  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ShipAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE Customers CHECK CONSTRAINT FK_Customers_Addresses
;
ALTER TABLE Customers  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (BillAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE Customers CHECK CONSTRAINT FK_Customers_Addresses1
;
ALTER TABLE ErpReturnOrderLines  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ErpHeaderId)
REFERENCES ErpReturnOrders (ErpId)
ON DELETE CASCADE
;
ALTER TABLE ErpReturnOrderLines CHECK CONSTRAINT FK_ReturnOrderLines_ROs
;
ALTER TABLE ErpReturnOrders  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (CustomerNumber)
REFERENCES Customers (CustomerNumber)
;
ALTER TABLE ErpReturnOrders CHECK CONSTRAINT FK_ErpReturnOrders_Customers
;
ALTER TABLE OrderBatchDetail  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (OrderBatchId)
REFERENCES OrderBatch (Id)
ON DELETE CASCADE
;
ALTER TABLE OrderBatchDetail CHECK CONSTRAINT FK_OrderBatch_OrderBatchDetail_Cascade
;
ALTER TABLE Orderlines  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE Orderlines CHECK CONSTRAINT FK_Orderlines_Orders
;
ALTER TABLE Orders  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (BillAddressId)
REFERENCES Addresses (Id)
ON DELETE CASCADE
;
ALTER TABLE Orders CHECK CONSTRAINT FK_Orders_Bill_Addresses
;
ALTER TABLE Orders  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (CustomerNumber)
REFERENCES Customers (CustomerNumber)
;
ALTER TABLE Orders CHECK CONSTRAINT FK_Orders_Customers
;
ALTER TABLE Orders  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (PushStatusId)
REFERENCES PushStatuses (Id)
;
ALTER TABLE Orders CHECK CONSTRAINT FK_Orders_PushStatuses
;
ALTER TABLE Orders  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ShipAddressId)
REFERENCES Addresses (Id)
;
ALTER TABLE Orders CHECK CONSTRAINT FK_Orders_Ship_Addresses
;
ALTER TABLE Payments  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (OrderNumber)
REFERENCES Orders (OrderNumber)
ON DELETE CASCADE
;
ALTER TABLE Payments CHECK CONSTRAINT FK_Payments_Orders
;
ALTER TABLE PaymentsTracking  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (PaymentId)
REFERENCES Payments (Id)
ON DELETE CASCADE
;
ALTER TABLE PaymentsTracking CHECK CONSTRAINT FK_PaymentsTracking_Payments
;
ALTER TABLE ProcessingErrors  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ProcessJobId)
REFERENCES ProcessJobs (Id)
;
ALTER TABLE ProcessingErrors CHECK CONSTRAINT FK_ProcessJobs_Id
;
ALTER TABLE PurgeRunDetails  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (PurgeRunId)
REFERENCES PurgeRuns (PurgeRunId)
;
ALTER TABLE PurgeRunDetails CHECK CONSTRAINT FK_PurgeRunDetails_PurgeRuns
;
ALTER TABLE ShippedOrderlines  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (OrderlineId)
REFERENCES Orderlines (Id)
ON DELETE CASCADE
;
ALTER TABLE ShippedOrderlines CHECK CONSTRAINT FK_Orders_OrderlineId
;
ALTER TABLE ShippedOrderlines  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (ShippedOrderSourceId)
REFERENCES ShippedOrderSources (Id)
;
ALTER TABLE ShippedOrderlines CHECK CONSTRAINT FK_Orders_SourceId
;
ALTER TABLE Users  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (Role)
REFERENCES Roles (Id)
;
ALTER TABLE Users CHECK CONSTRAINT FK_Users_Roles
;
CREATE TRIGGER trg_DismissPaymentTrackingWhenProcessingErrorsDismissed
ON ProcessingErrors
AFTER UPDATE
NOT FOR REPLICATION
AS
BEGIN
  declare @pjId int;
  declare @altId varchar(12);
  SELECT TOP 1 @pjId = ProcessJobId from INSERTED
  SELECT TOP 1 @altId =AltId from INSERTED
  UPDATE dbo.PaymentsTracking
  SET DismissedAt = GETDATE()
  WHERE @pjId = 211
  AND PaymentId = CAST(@altId as BIGINT)
END ;
;
ALTER TABLE ProcessingErrors ENABLE TRIGGER trg_DismissPaymentTrackingWhenProcessingErrorsDismissed
;
USE master
;
ALTER DATABASE sql3684435 SET  READ_WRITE 
;
