ALTER DATABASE `sql3684435` SET ANSI_NULL_DEFAULT OFF 
;
ALTER DATABASE `sql3684435` SET ANSI_WARNINGS OFF 
;
ALTER DATABASE `sql3684435` SET ARITHABORT OFF 
;
ALTER DATABASE `sql3684435` SET AUTO_CLOSE OFF 
;
ALTER DATABASE `sql3684435` SET AUTO_SHRINK OFF 
;
ALTER DATABASE `sql3684435` SET AUTO_UPDATE_STATISTICS ON 
;
ALTER DATABASE `sql3684435` SET CURSOR_CLOSE_ON_COMMIT OFF 
;
ALTER DATABASE `sql3684435` SET CURSOR_DEFAULT  GLOBAL 
;
ALTER DATABASE `sql3684435` SET CONCAT_NULL_YIELDS_NULL OFF 
;
ALTER DATABASE `sql3684435` SET NUMERIC_ROUNDABORT OFF 
;
ALTER DATABASE `sql3684435` SET RECURSIVE_TRIGGERS OFF 
;
ALTER DATABASE `sql3684435` SET  DISABLE_BROKER 
;
ALTER DATABASE `sql3684435` SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
;
ALTER DATABASE `sql3684435` SET DATE_CORRELATION_OPTIMIZATION OFF 
;
ALTER DATABASE `sql3684435` SET TRUSTWORTHY OFF 
;
ALTER DATABASE `sql3684435` SET ALLOW_SNAPSHOT_ISOLATION OFF 
;
ALTER DATABASE `sql3684435` SET PARAMETERIZATION SIMPLE 
;
ALTER DATABASE `sql3684435` SET READ_COMMITTED_SNAPSHOT OFF 
;
ALTER DATABASE `sql3684435` SET HONOR_BROKER_PRIORITY OFF 
;
ALTER DATABASE `sql3684435` SET RECOVERY SIMPLE 
;
ALTER DATABASE `sql3684435` SET  MULTI_USER 
;
ALTER DATABASE `sql3684435` SET PAGE_VERIFY CHECKSUM  
;
ALTER DATABASE `sql3684435` SET DB_CHAINING OFF 
;
ALTER DATABASE `sql3684435` SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
;
ALTER DATABASE `sql3684435` SET TARGET_RECOVERY_TIME = 0 SECONDS 
;
ALTER DATABASE `sql3684435` SET DELAYED_DURABILITY = DISABLED 
;
ALTER DATABASE `sql3684435` SET ACCELERATED_DATABASE_RECOVERY = OFF  
;
ALTER DATABASE `sql3684435` SET QUERY_STORE = OFF
;
USE `sql3684435`
;
CREATE TABLE `PaymentsTrackingHistory`(
	`PaymentId` `bigint` NOT NULL,
	`DismissedAt` `datetime2`(0) NULL,
	`ErrorReason` varchar(200) NULL,
	`AttemptedAt` `datetime2`(7) NOT NULL,
	`RetiredAt` `datetime2`(7) NOT NULL
)
;
CREATE INDEX `ix_PaymentsTrackingHistory` ON `PaymentsTrackingHistory`
(
	`RetiredAt` ASC,
	`AttemptedAt` ASC
)
;

CREATE TABLE `PaymentsTracking`(
	`PaymentId` `bigint` NOT NULL,
	`DismissedAt` `datetime2`(0) NULL,
	`ErrorReason` varchar(200) NULL,
	`AttemptedAt` `datetime2`(7) GENERATED ALWAYS AS ROW START NOT NULL,
	`RetiredAt` `datetime2`(7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT `PK_Payments_PaymentId` PRIMARY KEY 
(
	`PaymentId` ASC
),
	PERIOD FOR SYSTEM_TIME (`AttemptedAt`, `RetiredAt`)
)
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = `PaymentsTrackingHistory` )
)
;
CREATE TABLE `Addresses`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`AddressLine1` varchar(61) NOT NULL,
	`AddressLine2` varchar(61) NULL,
	`AddressLine3` varchar(61) NULL,
	`City` varchar(35) NOT NULL,
	`StateProvince` varchar(29) NOT NULL,
	`PostalCode` varchar(11) NOT NULL,
	`Country` varchar(60) NOT NULL,
 CONSTRAINT `PK_Address` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `AppParams`(
	`Name` varchar(100) NOT NULL,
	`Value` varchar(4000) NULL,
	`ProcessJobIds` varchar(25) NULL,
	`Cate;ry` varchar(50) NULL,
	`SubCate;ry` varchar(50) NULL,
	`ValueTypeId` int NOT NULL,
	`Notes` varchar(200) NULL,
	`EnabledDate` `datetime2`(0) NULL,
	`CreatedAt` `datetime2`(2) NOT NULL,
	`CreatedBy` varchar(25) NOT NULL,
	`ModifiedAt` `datetime2`(3) NULL,
	`ModifiedBy` varchar(25) NULL,
 CONSTRAINT `PK_AppParams` PRIMARY KEY 
(
	`Name` ASC
)
)
;
CREATE TABLE `AppParamValueTypes`(
	`Id` int NOT NULL,
	`Type` varchar(20) NOT NULL,
 CONSTRAINT `PK_ParamValueTypes` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `CanadaFileTracking`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`At` `datetime2`(7) NOT NULL,
	`Filename` varchar(50) NOT NULL,
 CONSTRAINT `PK_CanadaFileTracking` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ChangeLog`(
	`Id` int AUTO_INCREMENT NOT NULL,
	`TableName` varchar(50) NOT NULL,
	`ColumnName` varchar(50) NOT NULL,
	`UserId` int NOT NULL,
	`PrevValue` varchar(max) NULL,
	`NewValue` varchar(max) NULL,
	`ValueType` int NOT NULL,
	datetime datetime NOT NULL,
 CONSTRAINT `PK_ChangeLog` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Customers`(
	`CustomerNumber` varchar(15) NOT NULL,
	`CustomerName` varchar(65) NULL,
	`ContactName` varchar(61) NULL,
	`CompanyName` varchar(35) NULL,
	`Phone1` varchar(21) NULL,
	`Phone2` varchar(21) NULL,
	`Phone3` varchar(21) NULL,
	`EmailAddress` varchar(80) NULL,
	`EnteredDate` `datetime2`(0) NULL,
	`BillAddressId` `bigint` NULL,
	`ShipAddressId` `bigint` NULL,
	`ImportedDate` `datetime2`(2) NULL,
	`TaxId` varchar(30) NULL,
	`TaxIdType` varchar(50) NULL,
 CONSTRAINT `PK_Customer` PRIMARY KEY 
(
	`CustomerNumber` ASC
)
)
;
CREATE TABLE `DashboardPages`(
	`Id` `tinyint` AUTO_INCREMENT NOT NULL,
	`Page` varchar(50) NOT NULL,
	`Actions` varchar(max) NULL,
 CONSTRAINT `PK_DashboardPages` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ErpReturnOrderLines`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`ErpId` varchar(40) NULL,
	`ErpHeaderId` varchar(40) NOT NULL,
	`OrderNumber` varchar(20) NOT NULL,
	`ParentLineNumber` int NULL,
	`LineNumber` int NOT NULL,
	`Sku` varchar(20) NOT NULL,
	`Description` varchar(50) NULL,
	`Quantity` int NOT NULL,
	`UnitPrice` decimal(18, 2) NOT NULL,
	`UnitTax` decimal(18, 2) NULL,
	`Warehouse` varchar(20) NULL,
 CONSTRAINT `PK_ErpReturnOrderLines` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ErpReturnOrders`(
	`ErpId` varchar(40) NOT NULL,
	`OrderNumber` varchar(20) NOT NULL,
	`CustomerNumber` varchar(15) NOT NULL,
	`CreatedDate` `datetime2`(7) NOT NULL,
	`OrderDate` `datetime2`(0) NOT NULL,
	`ShipDate` `datetime2`(0) NOT NULL,
	`CustomerName` varchar(35) NULL,
	`Address` varchar(35) NULL,
	`Address2` varchar(35) NULL,
	`City` varchar(35) NULL,
	`State` varchar(25) NULL,
	`Country` varchar(3) NULL,
	`PostalCode` varchar(10) NULL,
	`Phone` varchar(20) NULL,
	`Email` varchar(50) NULL,
	`Warehouse` varchar(25) NOT NULL,
	`OriginalOrderNumber` int NOT NULL,
	`ImportedAt` `datetime2`(2) NOT NULL,
	`SentToCrmAt` `datetime2`(2) NULL,
	`CrmOrderId` int NULL,
 CONSTRAINT `PK_ReturnOrders_ErpId` PRIMARY KEY 
(
	`ErpId` ASC
)
)
;
CREATE TABLE `ErpShipmentTracking`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`ErpPostedPackageId` varchar(40) NOT NULL,
	`ErpOrderNumber` varchar(25) NOT NULL,
	`When` `datetime2`(7) NOT NULL,
 CONSTRAINT `unique_ErpPostedPkgId` UNIQUE NONCLUSTERED 
(
	`ErpPostedPackageId` ASC
)
)
;
CREATE TABLE `Logging`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`Level` varchar(max) NULL,
	`TimeStamp` datetime NULL,
	`Message` varchar(max) NULL,
	`Exception` varchar(max) NULL,
	`Properties` varchar(max) NULL,
	`JobName` varchar(30) NOT NULL,
	`MessageTemplate` varchar(max) NULL,
 CONSTRAINT `PK_Logging` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Maps`(
	`Id` int AUTO_INCREMENT NOT NULL,
	`IsoCountryCode` varchar(3) NOT NULL,
	`ErpCompanyId` varchar(50) NOT NULL,
	`IsoCurrencyCode` varchar(3) NOT NULL,
	`ErpCurrencyCode` varchar(10) NOT NULL,
	`SourceWarehouse` varchar(11) NOT NULL,
	`SourceShipMethod` varchar(100) NULL,
	`DestinationWarehouse` varchar(25) NULL,
	`ReturnsWarehouse` varchar(25) NULL,
	`IsVAT` tinyint NULL,
	`UseForErpPull` tinyint NULL,
	`ProcessingSequence` int NULL,
	`ActivatedAt` `datetime2`(0) NULL,
	`DeactivatedAt` `datetime2`(0) NULL,
	`CreatedAt` `datetime2`(3) NOT NULL,
	`CreatedBy` varchar(25) NOT NULL,
	`ModifiedAt` `datetime2`(3) NULL,
	`ModifiedBy` varchar(25) NULL,
 CONSTRAINT `PK_Maps` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `OrderBatch`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`DailyBatchNumber` int NOT NULL,
	`BatchDate` `datetime2`(0) NOT NULL,
	`Market` varchar(10) NOT NULL,
	`SelectedOrderCount` int NOT NULL,
	`ProcessedOrderCount` int NULL,
	`CreatedAt` `datetime2`(3) NOT NULL,
	`BatchMonth` int NULL,
	`OrderBatchSize` int NULL,
 CONSTRAINT `PK_OrderBatch_OrderBatchId` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `OrderBatchDetail`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`OrderBatchId` `bigint` NOT NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`ErrorCode` varchar(50) NULL,
	`ErrorMessage` varchar(2000) NULL,
 CONSTRAINT `PK_OrderBatchDetail_Id` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Orderlines`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`LineNumber` int NULL,
	`Sku` varchar(31) NOT NULL,
	`Quantity` decimal(18, 2) NOT NULL,
	`UnitPrice` decimal(18, 2) NOT NULL,
	`TaxRate` decimal(18, 2) NOT NULL,
	`UnitTaxAmount` decimal(18, 2) NULL,
	`ExtTaxAmount` decimal(18, 2) NULL,
	`Warehouse` varchar(11) NULL,
	`Description` varchar(200) NULL,
	`ParentSku` varchar(31) NULL,
	`ComponentPrice` decimal(18, 2) NULL,
	`UnitCost` decimal(18, 2) NULL,
	`ItemType` int NOT NULL,
	`IsVirtual` tinyint NOT NULL,
	`Weight` decimal(9, 2) NULL,
	`CVolume` decimal(18, 2) NULL,
 CONSTRAINT `PK_orderline_Clustered` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Orders`(
	`OrderNumber` varchar(21) NOT NULL,
	`CustomerNumber` varchar(15) NOT NULL,
	`Market` varchar(10) NOT NULL,
	`CurrencyCode` varchar(10) NOT NULL,
	`CreatedDate` `datetime2`(7) NOT NULL,
	`OrderDate` `datetime2`(0) NOT NULL,
	`Warehouse` varchar(25) NULL,
	`PushStatusId` int NULL,
	`ShipToName` varchar(65) NULL,
	`ShipDate` datetime NULL,
	`ShipMethod` varchar(50) NULL,
	`TrackingNumber` varchar(41) NULL,
	`OrderTotalAmount` decimal(18, 2) NOT NULL,
	`FreightAmount` decimal(18, 2) NOT NULL,
	`FreightTaxAmount` decimal(18, 2) NOT NULL,
	`TaxAmount` decimal(18, 2) NOT NULL,
	`DiscountAmount` decimal(18, 2) NULL,
	`OrderNotes` varchar(500) NULL,
	`Phone1` varchar(21) NULL,
	`Phone2` varchar(21) NULL,
	`Phone3` varchar(21) NULL,
	`BillAddressId` `bigint` NULL,
	`ShipAddressId` `bigint` NULL,
	`StagingImportDate` `datetime2`(4) NOT NULL,
	`PickupName` varchar(100) NULL,
	`OrderTypeDescription` varchar(20) NULL,
	`ReferenceOrderNumber` varchar(21) NULL,
	`ErpOrderNumber` varchar(25) NULL,
	`ErpId` varchar(40) NULL,
	`SentToErp` `datetime2`(2) NULL,
	`SentTo3PL` `datetime2`(2) NULL,
 CONSTRAINT `PK_orders_OrderNumber` PRIMARY KEY 
(
	`OrderNumber` ASC
)
)
;
CREATE TABLE `OrderStagingErrors`(
	`Id` int AUTO_INCREMENT NOT NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`OrderDate` `datetime2`(0) NOT NULL,
	`OrderTotal` decimal(18, 2) NOT NULL,
	`CurrencyCode` varchar(3) NOT NULL,
	`Message` varchar(300) NOT NULL,
	`At` `datetime2`(3) NOT NULL,
	`IgnoredAt` `datetime2`(3) NULL,
	`Exception` varchar(max) NULL,
 CONSTRAINT `PK_OrderStagingErrors` PRIMARY KEY 
(
	`Id` ASC
),
 CONSTRAINT `unique_ordnum` UNIQUE NONCLUSTERED 
(
	`OrderNumber` ASC
)
)
;
CREATE TABLE `Payments`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`SourcePaymentId` varchar(20) NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`PaymentType` varchar(30) NULL,
	`PaymentAmount` decimal(18, 2) NOT NULL,
	`PaymentDate` `datetime2`(0) NOT NULL,
	`CardNumber` varchar(25) NULL,
	`AuthCode` varchar(25) NULL,
	`SentToErp` `datetime2`(2) NULL,
PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ProcessedTransactions`(
	`Id` `bigint` NOT NULL,
	`OrderDate` `datetime2`(0) NULL,
	`EntryReceiedDate` `datetime2`(5) NOT NULL,
	`CustomerID` int NOT NULL,
	`LoginName` varchar(30) NULL,
	`OrderID` int NOT NULL,
	`AffiliateOrderID` varchar(10) NULL,
	`FirstName` varchar(25) NULL,
	`LastName` varchar(25) NULL,
	`Phone` varchar(12) NULL,
	`Email` varchar(40) NULL,
	`City` varchar(40) NULL,
	`State` varchar(2) NULL,
	`PostalCode` varchar(10) NULL,
	`Country` varchar(10) NULL,
	`FileOrigin` varchar(45) NOT NULL,
	`Affiliate` varchar(10) NULL,
	`SuccessStatus` tinyint NOT NULL,
	`FailReason` varchar(200) NULL,
	`Emailed` tinyint NULL,
PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ProcessingErrors`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`ProcessJobId` int NOT NULL,
	`Cate;ry` varchar(20) NULL,
	`OrderNumber` varchar(21) NOT NULL,
	`LineNumber` int NULL,
	`AltId` varchar(12) NULL,
	`Message` varchar(300) NOT NULL,
	`AdditionalData` varchar(300) NULL,
	`At` `datetime2`(2) NOT NULL,
	`DismissedAt` `datetime2`(2) NULL,
	`DismissedBy` varchar(20) NULL,
	`Exception` varchar(max) NULL,
 CONSTRAINT `PK_ProcessingErrors_Id` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ProcessJobs`(
	`Id` int NOT NULL,
	`Name` varchar(50) NOT NULL,
	`ExternalSystem` varchar(15) NOT NULL,
	`DataDirection` varchar(3) NOT NULL,
 CONSTRAINT `PK_ProcessJobs_Id` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `PurgeRunDetails`(
	`PurgeRunDetailId` int AUTO_INCREMENT NOT NULL,
	`PurgeRunId` int NOT NULL,
	`TableName` varchar(20) NOT NULL,
	`PurgeCount` int NOT NULL,
 CONSTRAINT `PK_PurgeRunDetails` PRIMARY KEY 
(
	`PurgeRunDetailId` ASC
)
)
;
CREATE TABLE `PurgeRuns`(
	`PurgeRunId` int AUTO_INCREMENT NOT NULL,
	`RunDate` `datetime2`(2) NOT NULL,
	`MonthsKept` int NOT NULL,
 CONSTRAINT `PK_PurgeRuns` PRIMARY KEY 
(
	`PurgeRunId` ASC
)
)
;
CREATE TABLE `PushStatuses`(
	`Id` int AUTO_INCREMENT NOT NULL,
	`Name` varchar(20) NOT NULL,
PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Roles`(
	`Id` `tinyint` NOT NULL,
	`Role` varchar(50) NOT NULL,
	`RestrictedPages` varchar(max) NOT NULL,
	`RestrictedActions` varchar(max) NOT NULL,
 CONSTRAINT `PK_Roles` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ShippedOrderlines`(
	`Id` `bigint` AUTO_INCREMENT NOT NULL,
	`OrderlineId` `bigint` NOT NULL,
	`ShippedAt` `datetime2`(3) NOT NULL,
	`ShippedQuantity` int NOT NULL,
	`Carrier` varchar(50) NULL,
	`ShipMethod` varchar(50) NULL,
	`TrackingNumber` varchar(50) NULL,
	`LotNumber` varchar(25) NOT NULL,
	`ShippedOrderSourceId` int NOT NULL,
	`SourceDocument` varchar(50) NULL,
	`CrmNotifiedAt` `datetime2`(0) NULL,
	`ErpNotifiedAt` `datetime2`(0) NULL,
	`CreatedAt` `datetime2`(3) NOT NULL,
	`CreatedBy` varchar(25) NOT NULL,
 CONSTRAINT ``PK_ShippedOrderLines_Id`` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `ShippedOrderSources`(
	`Id` int NOT NULL,
	`Name` varchar(30) NULL,
PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE TABLE `Users`(
	`Id` int AUTO_INCREMENT NOT NULL,
	`Email` varchar(100) NOT NULL,
	`Name` varchar(100) NOT NULL,
	`Hash` varchar(max) NOT NULL,
	`Role` `tinyint` NOT NULL,
	`DateRegistered` `datetime2`(2) NOT NULL,
	`LastLogin` `datetime2`(2) NULL,
	`LoggedIn` tinyint NULL,
	`FailedAttempts` `tinyint` NULL,
	`Active` tinyint NULL,
 CONSTRAINT `PK_Users` PRIMARY KEY 
(
	`Id` ASC
)
)
;
CREATE NONCLUSTERED INDEX `IX_OBD_OrdNbr` ON `OrderBatchDetail`
(
	`OrderNumber` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_Ol_OrdNbr` ON `Orderlines`
(
	`OrderNumber` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_Orders_MktPushStErpOrdNbr` ON `Orders`
(
	`Market` ASC,
	`PushStatusId` ASC,
	`ErpOrderNumber` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_Pmt_OrdNbr` ON `Payments`
(
	`OrderNumber` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_Pmts_OrdNbr` ON `Payments`
(
	`SentToErp` ASC,
	`PaymentDate` ASC
)
;
CREATE NONCLUSTERED INDEX `ix_OrderNumber` ON `ProcessingErrors`
(
	`OrderNumber` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_ShippedOrderlines_SourceDocument` ON `ShippedOrderlines`
(
	`SourceDocument` ASC
)
;
CREATE NONCLUSTERED INDEX `IX_SOL_OrdLnId` ON `ShippedOrderlines`
(
	`OrderlineId` ASC
)
;
ALTER TABLE `AppParams`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ValueTypeId`)
REFERENCES `AppParamValueTypes` (`Id`)
;
ALTER TABLE `AppParams` CHECK CONSTRAINT `FK_AppParams_ParamValueTypes`
;
ALTER TABLE `CanadaFileTracking`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`OrderNumber`)
REFERENCES `Orders` (`OrderNumber`)
ON DELETE CASCADE
;
ALTER TABLE `CanadaFileTracking` CHECK CONSTRAINT `FK_CanadaFileTracking_Orders`
;
ALTER TABLE `ChangeLog`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ValueType`)
REFERENCES `AppParamValueTypes` (`Id`)
;
ALTER TABLE `ChangeLog` CHECK CONSTRAINT `FK_ChangeLog_AppParamValueTypes`
;
ALTER TABLE `ChangeLog`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`UserId`)
REFERENCES `Users` (`Id`)
;
ALTER TABLE `ChangeLog` CHECK CONSTRAINT `FK_ChangeLog_Users`
;
ALTER TABLE `Customers`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ShipAddressId`)
REFERENCES `Addresses` (`Id`)
;
ALTER TABLE `Customers` CHECK CONSTRAINT `FK_Customers_Addresses`
;
ALTER TABLE `Customers`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`BillAddressId`)
REFERENCES `Addresses` (`Id`)
;
ALTER TABLE `Customers` CHECK CONSTRAINT `FK_Customers_Addresses1`
;
ALTER TABLE `ErpReturnOrderLines`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ErpHeaderId`)
REFERENCES `ErpReturnOrders` (`ErpId`)
ON DELETE CASCADE
;
ALTER TABLE `ErpReturnOrderLines` CHECK CONSTRAINT `FK_ReturnOrderLines_ROs`
;
ALTER TABLE `ErpReturnOrders`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`CustomerNumber`)
REFERENCES `Customers` (`CustomerNumber`)
;
ALTER TABLE `ErpReturnOrders` CHECK CONSTRAINT `FK_ErpReturnOrders_Customers`
;
ALTER TABLE `OrderBatchDetail`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`OrderBatchId`)
REFERENCES `OrderBatch` (`Id`)
ON DELETE CASCADE
;
ALTER TABLE `OrderBatchDetail` CHECK CONSTRAINT `FK_OrderBatch_OrderBatchDetail_Cascade`
;
ALTER TABLE `Orderlines`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`OrderNumber`)
REFERENCES `Orders` (`OrderNumber`)
ON DELETE CASCADE
;
ALTER TABLE `Orderlines` CHECK CONSTRAINT `FK_Orderlines_Orders`
;
ALTER TABLE `Orders`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`BillAddressId`)
REFERENCES `Addresses` (`Id`)
ON DELETE CASCADE
;
ALTER TABLE `Orders` CHECK CONSTRAINT `FK_Orders_Bill_Addresses`
;
ALTER TABLE `Orders`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`CustomerNumber`)
REFERENCES `Customers` (`CustomerNumber`)
;
ALTER TABLE `Orders` CHECK CONSTRAINT `FK_Orders_Customers`
;
ALTER TABLE `Orders`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`PushStatusId`)
REFERENCES `PushStatuses` (`Id`)
;
ALTER TABLE `Orders` CHECK CONSTRAINT `FK_Orders_PushStatuses`
;
ALTER TABLE `Orders`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ShipAddressId`)
REFERENCES `Addresses` (`Id`)
;
ALTER TABLE `Orders` CHECK CONSTRAINT `FK_Orders_Ship_Addresses`
;
ALTER TABLE `Payments`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`OrderNumber`)
REFERENCES `Orders` (`OrderNumber`)
ON DELETE CASCADE
;
ALTER TABLE `Payments` CHECK CONSTRAINT `FK_Payments_Orders`
;
ALTER TABLE `PaymentsTracking`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`PaymentId`)
REFERENCES `Payments` (`Id`)
ON DELETE CASCADE
;
ALTER TABLE `PaymentsTracking` CHECK CONSTRAINT `FK_PaymentsTracking_Payments`
;
ALTER TABLE `ProcessingErrors`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ProcessJobId`)
REFERENCES `ProcessJobs` (`Id`)
;
ALTER TABLE `ProcessingErrors` CHECK CONSTRAINT `FK_ProcessJobs_Id`
;
ALTER TABLE `PurgeRunDetails`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`PurgeRunId`)
REFERENCES `PurgeRuns` (`PurgeRunId`)
;
ALTER TABLE `PurgeRunDetails` CHECK CONSTRAINT `FK_PurgeRunDetails_PurgeRuns`
;
ALTER TABLE `ShippedOrderlines`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`OrderlineId`)
REFERENCES `Orderlines` (`Id`)
ON DELETE CASCADE
;
ALTER TABLE `ShippedOrderlines` CHECK CONSTRAINT `FK_Orders_OrderlineId`
;
ALTER TABLE `ShippedOrderlines`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`ShippedOrderSourceId`)
REFERENCES `ShippedOrderSources` (`Id`)
;
ALTER TABLE `ShippedOrderlines` CHECK CONSTRAINT `FK_Orders_SourceId`
;
ALTER TABLE `Users`  WITH CHECK ADD  CONSTRAINT FOREIGN KEY (`Role`)
REFERENCES `Roles` (`Id`)
;
ALTER TABLE `Users` CHECK CONSTRAINT `FK_Users_Roles`
;
CREATE TRIGGER `trg_DismissPaymentTrackingWhenProcessingErrorsDismissed`
ON `ProcessingErrors`
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
ALTER TABLE `ProcessingErrors` ENABLE TRIGGER `trg_DismissPaymentTrackingWhenProcessingErrorsDismissed`
;
USE `master`
;
ALTER DATABASE `sql3684435` SET  READ_WRITE 
;
