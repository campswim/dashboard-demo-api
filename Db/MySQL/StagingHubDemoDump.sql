-- MySQL dump 10.13  Distrib 8.3.0, for macos14 (arm64)
--
-- Host: localhost    Database: campswim_dashboard_demo
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `campswim_dashboard_demo`
--

CREATE DATABASE IF NOT EXISTS `campswim_dashboard_demo`;

USE `campswim_dashboard_demo`;

--
-- Table structure for table `Addresses`
--

DROP TABLE IF EXISTS `Addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Addresses` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `AddressLine1` varchar(61) NOT NULL,
  `AddressLine2` varchar(61) DEFAULT NULL,
  `AddressLine3` varchar(61) DEFAULT NULL,
  `City` varchar(35) NOT NULL,
  `StateProvince` varchar(29) NOT NULL,
  `PostalCode` varchar(11) NOT NULL,
  `Country` varchar(60) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=67474 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Addresses`
--

LOCK TABLES `Addresses` WRITE;
INSERT INTO `Addresses` VALUES (67461,'1 Example St ','','','Example Town','WA','99999','US'),(67462,'2 Example St ','','','Example Town','WA','99999','US'),(67463,'3 Example St ','','','Example Town','WA','99999','US'),(67464,'4 Example St ','','','Example Town','WA','99999','US'),(67465,'5 Example St ','','','Example Town','ABR','9999','PH'),(67466,'6 Example St ','','','Example Town','ABR','9999','PH'),(67467,'7 Example St ','','','Example Town','ABR','9999','PH'),(67468,'8 Example St ','','','Example Town','BC','999 999','CA'),(67469,'9 Example St ','','','Example Town','BC','999 999','CA'),(67470,'10 Example St',NULL,NULL,'Example Town','BC','999 999','CA'),(67471,'11 Example St',NULL,NULL,'Example Town','VIC','9999','AUS'),(67472,'12 Example St',NULL,NULL,'Example Town','VIC','9999','AUS'),(67473,'13 Example St',NULL,NULL,'Example Town','VIC','9999','AUS');
UNLOCK TABLES;

--
-- Table structure for table `AppParams`
--

DROP TABLE IF EXISTS `AppParams`;
CREATE TABLE `AppParams` (
  `Name` varchar(100) NOT NULL,
  `Value` varchar(4000) DEFAULT NULL,
  `ProcessJobIds` varchar(25) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `SubCategory` varchar(50) DEFAULT NULL,
  `ValueTypeId` int NOT NULL,
  `Notes` varchar(200) DEFAULT NULL,
  `EnabledDate` datetime DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `CreatedBy` varchar(25) NOT NULL,
  `ModifiedAt` datetime DEFAULT NULL,
  `ModifiedBy` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `FK_AppParams_ParamValueTypes` (`ValueTypeId`),
  CONSTRAINT `appparams_ibfk_1` FOREIGN KEY (`ValueTypeId`) REFERENCES `AppParamValueTypes` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `AppParams`
--

LOCK TABLES `AppParams` WRITE;
INSERT INTO `AppParams` VALUES ('AccessToken','{\"iv\":\"SampleToken\",\"encryptedData\":\"SampleData\",\"key\":{\"type\":\"Buffer\",\"data\":140,151,11,2,7,78,211,19,18,96,11,88,119,221,199,21,84,183,240,118,102,57,213,92,25,74,116,27,217,173,122,31}}','200,201,210,211,212','Order','API',12,'1689359089208','2023-06-16 17:04:59','2023-06-16 11:04:59','1',NULL,NULL),('AfilliateWarehouseMap','SC-SHIPOFFRR=SHIPOFFERS','100','Order','Mapping',10,'Mapping company shipped orders for affiliates','2023-06-01 00:00:00','2023-03-27 21:49:40','1',NULL,NULL),('CAN3PLEnvironmentFlag','T','310','Ship','3PL CAN',10,'Environment variable \"P\"roduction or \"T\"est','2023-08-30 00:00:00','2023-08-30 00:00:00','1',NULL,NULL),('CAN3PLFolders','Incoming=WarehouseTrackingCAN;Processed=WarehouseTrackingCANCompleted;Failed=WarehouseTrackingCANFailed;Out;ing=companyFTPCAN','310,311','3PL','File',10,'file folder....','2023-04-04 00:00:00','2023-04-04 17:20:46','1',NULL,NULL),('CAN3PLIncomingFolder','CAN Samples/ToProcess','310','Ship','3PL CAN',10,'Incoming folder for CAN 3PL response file processing','2023-03-07 00:00:00','2023-03-07 14:56:28','1',NULL,NULL),('CAN3PLParseFileExt','*.txt','311','3PL','File extension',10,'Single File extension for CAN 3PL incoming shipping files to process','2023-08-28 00:00:00','2023-08-28 00:00:00','1',NULL,NULL),('CAN3PLShippingCodes','{\"Canada Post Standard\": \"10\", \"Canada Post Express\": \"11\"}','310','3PL','Shipping codes',12,'Out;ing 3PL shipping codes','2023-08-28 00:00:00','2023-08-28 00:00:00','1',NULL,NULL),('companyApi','{\"Url\": \"https://sandboxapi.company.com/3.0/companyApi.asmx\",\"Company\": \"CLIENT\",\"Username\": \"..testing123..\",\"Password\": \"....\"}','111','ReturnOrder','company Push',12,'company API params','2023-03-02 00:00:00','2023-03-23 00:00:00','1',NULL,NULL),('companyERPSkuMapping','CMPREVENUE=1016-UNV|1016-UNV-01|1024-UNV|1016-UNV-BLK,CONFERENCE TICKET=EVCON-UNIV-2023|EVVCON-UNIV-2023,MEMBERSHIPFEE=19819801|19819802|MemberShipFee-US|MembershipFee-CA|MemberShipFee-PH,REWARD TRIP=EVCRS-UNIV-24-01|77EVCRS-UNIV-24-02|EVCRS-UNIV-24-03,SHIPPING=1011-UNIV|10246-UNIV|BN-5022-US|BN-5022-CA|BN-5023-PH|REFUSALFEE-UNIV|INTERCEPTFEE-US|REROUTEFEE-US|REROUTEOOS-US','210','Order','Line',10,'list of key-value pairs where the values are separated by pipe (|) char. ERP Skus on the left (key) and company Skus on the right (value)','2023-09-26 00:00:00','2023-09-26 22:23:30','1',NULL,NULL),('companyPromoAltSKUs','CLIENT+ Free Shipping Discount=SHIPPING','210','Order','Line',10,'dict key is Promo description and value is ALT SKU to use in ERP','2022-08-09 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('companyPromoCatchAll','PROMO-PRODUCTS','210','Order','Sku',10,'When Alt Skus do not match, use this one','2023-05-02 14:11:05','2023-01-02 22:23:30','1',NULL,NULL),('companyPromoSKU','Promo','210','Order','Line',10,'Single company promotional SKU','2022-08-09 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('companyRoOrderStatusToSet','Pending','100','Order','companyApi',10,'OrderStatus to set the pulled unshipped order in company','2023-07-17 20:04:15','2023-07-17 20:04:15','1',NULL,NULL),('companySkusToSkipPush','VR','210','Order','Line',10,'List of delimited SKUs to skip on push of orderlines to ERP','2023-01-18 00:00:00','2023-01-18 15:52:09','1',NULL,NULL),('companyToERPPaymentTypes','Cash=S-CASH;Credit Card=S-CARD;CLIENT Cash (USD)=S-CLIENTCASH;CLIENT Cash (AU)(USD)=S-CLIENTCASH;CLIENT Cash (CAN)=S-CLIENTCASH;CLIENT Cash (PHL)=S-CLIENTCASH;CLIENT Bonus (USD)=S-BONUS;CLIENT Bonus (CAN)=S-BONUS;CLIENT Bonus (PHL)=S-BONUS;CLIENT Rewards (AU/USA)=S-REWARD;CLIENT Rewards (CAN)=S-REWARD;CLIENT Rewards (PHL)=S-REWARD;AmazonPay=S-Amazon;Wallet=S-Amazon','211','Order','API',10,'Payment type mapping from company to ERP','2022-05-20 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('companyToERPShippingAgentCodes','Pick-Up=WILL-CALL~;Surepost=UPS~SUREPOST LESS THAN 1 LB;Surepost+=UPS~SUREPOST 1 LB OR GREATER;UPS 2nd Day=UPS~2ND DAY AIR;UPS Ground=UPS~GROUND;UPS Next Day=UPS~NEXT DAY AIR;USPS - Priority=USPOSTAL~PRIORITY-PARCEL;USPS 1st Class=USPOSTAL~FIRST-PARCEL;USPS (Avg 30-45 day delivery)=USPOSTAL~PARCELSELECT-PARCEL;International 1st class (Avg 30-45 day delivery)=USPOSTAL~FIRST-PARCEL;Canada Post Express=CANP~CANP-EXPRESS;Canada Post Standard=CANP~CANP-STANDARD;LBC=LBC~;Philippines Office Pickup=WILL-CALL~','210','Order','Shipping',10,'Mapping shipping agent codes from companyToERP','2022-08-10 00:00:00','2023-01-02 22:31:34','1',NULL,NULL),('CrmPullPaymentThresholdVariance','1.01','100','Order','Validation',7,'Allowed variance','2021-01-01 00:00:00','2020-09-02 00:00:00','1',NULL,NULL),('ERPAadTenantId','SampleNumber','200,201,210,211,212','ERPAPI','API',10,'D365 ERP AADTenantId','2023-06-10 01:21:48','2023-01-02 22:23:30','1',NULL,NULL),('ERPClientId','SampleNumber','200,201,210,211,212','ERPAPI','API',10,'D365 ERP ClientId','2022-05-13 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('ERPClientSecret','SampleSecret','200,201,210,211,212','ERPAPI','API',10,'D365 ERP Client Secret','2022-05-13 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('ErpCmGlAccountNumbers','TAX=001;SHIPPING=002;other=003','210','Order','CreditMemo',10,'Gl Account nbrs to use for CM categories','2023-05-10 00:00:00','2023-05-10 20:34:50','1',NULL,NULL),('ERPEnvironment','SandBx_CLIENT_Sample_Numbers','200,201,210,211,212','ERPAPI','API',10,'D365 ERP environment `name`','2022-05-13 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('ERPMarketShipAgent','US=,PH=WILL CALL','210','Shipping Info','Mapping',10,'Mapping shipping agents by market','2022-03-27 00:00:00','2023-03-27 21:39:10','1',NULL,NULL),('ERPOrderLineSequenceInterval','10000','210','Order','Line',2,'16384 is the ERP default `value`','2023-04-21 00:18:23','2020-06-10 20:14:50','1',NULL,NULL),('ERPOrderShipAdvice','PH=PARTIAL;CA=PARTIAL','210','Order','ShippingAdvice',10,'Shipping advice override','2023-06-28 18:03:05','2023-06-28 18:03:05','1',NULL,NULL),('ERPOrderSummarySku','PRODUCT','210','Order','Lines',2,'Put the ERP SKU here if wanting to summarize all regular items into a single orderline in ERP','2023-09-14 00:00:00','2023-09-14 00:00:00','1',NULL,NULL),('ERPPaymentMethods','','211','Payment','Methods',12,'ERP Payment methods per company','2023-09-06 00:00:00','2023-09-06 00:00:00','1',NULL,NULL),('ERPPaymentMethodsFetchFrequency','604800','211','Payment','Methods',2,'Number of seconds before refetching payment methods from ERP','2023-09-06 00:00:00','2023-09-06 00:00:00','1',NULL,NULL),('ERPPmtJournalBatchName','company','211','Payment','Cash Receipt',10,'For  ','2023-01-03 00:00:00','2023-01-03 22:19:20','1',NULL,NULL),('ERPPmtJournalTemplateName','CASHRCPT','211','Payment','Cash Receipt',10,'For cashreceipts','2022-01-03 00:00:00','2023-01-03 22:19:20','1',NULL,NULL),('ErpPushOrdCalcThresholdVariance','0.05','210','Order','Validation',7,'Allowed variance','2021-01-01 00:00:00','2020-09-02 00:00:00','1',NULL,NULL),('ERPScope','https://api.samplesite.com/.default','200,201,210,211,212','Order','API',10,'D365 ERP auth scope','2023-06-15 19:13:24','2023-06-15 12:54:23','1',NULL,NULL),('ERPStatesToCountries','GU=GUM\nPR=PRI','210','Order','Mapping',10,'Mapping specific states to countries companyToERP','2022-03-25 00:00:00','2023-03-25 19:25:14','1',NULL,NULL),('FileShareRoot','/Users/User/Downloads/','310,311,320,321','Ship','3PL Proc',10,'FileShare root folder for 3PL response file processing','2023-03-07 00:00:00','2023-03-07 14:56:28','1',NULL,NULL),('ImportCrmOrderNegativePayments','true','100','Order','Payment',1,'Import ERP Order Payments with a negative amount','2020-12-20 00:00:00','2020-12-21 00:00:00','1',NULL,NULL),('ImportIgnoreOrderTypes','8','100','Order','Select',10,'Comma separated list of ordertypes to ignore','2021-11-10 00:00:00','2021-11-10 00:00:00','1',NULL,NULL),('LastTimeShippigInfoWasImportedFromERP','2023-07-17T17:03:55.20Z','200','Shipping','Shipped detail',8,'Fetch shipping info (posted packages) from ERP','2023-01-01 00:00:00','2023-01-30 00:00:00','1',NULL,NULL),('OnlyImportOrdersOverAmount','0.00','100','Order','Select',5,'Minimum amount of order to consider importing',NULL,'2020-06-10 20:14:50','1',NULL,NULL),('OnlyImportOrderStatusCodes','7','100','Order','Select',10,'comma separated codes-values: 2,3,4,5,7,8,13','2021-10-25 00:00:00','2020-06-10 20:14:50','1',NULL,NULL),('OrderPullAllowMoneyMismatch','true','100','Order','Header',1,'Whether we allow orders pulled where there is a mismatch in ordertotal vs sum of payment(s)','2023-06-07 20:52:34','2023-06-07 20:52:34','1',NULL,NULL),('OrderPullBatchsize','500','100,101','Order','Select',2,NULL,'2021-01-01 00:00:00','2020-06-10 20:14:50','1',NULL,NULL),('OrderPullDaysBack','4','100,101','Order','Select',2,NULL,NULL,'2020-09-22 00:00:00','1',NULL,NULL),('OrderPullHourDelay','2','100','Order','Header',2,'Number of hour delay for unshipped orders','2023-01-01 00:00:00','2023-01-01 00:00:00','1',NULL,NULL),('OrderPullLastDate','','100','Order','Select',8,'Last date of order pull from source system','2021-10-18 00:00:00','2020-06-10 20:14:50','1',NULL,NULL),('OrderPullMinOrderNumber','51800000','100,101,102','Order','Select',2,'Only pull order#s > than this value. Use 0 to turn this off','2021-10-15 00:00:00','2021-10-26 00:00:00','1',NULL,NULL),('OrderPullPickupShipMethodIds','8,18,23','100','Order','Selection',10,'Limit to these company pickup ship methods','2023-08-28 00:00:00','2023-08-28 21:49:40','1',NULL,NULL),('OrderPushBatchSize','200','210','Order','Select',2,NULL,'2021-10-15 00:00:00','2020-06-10 20:14:50','1',NULL,NULL),('OrdersPushFetchSize','165','210','Order','Batch',2,'Number of orders to fetch for building a batch','2021-01-01 00:00:00','2020-09-20 00:00:00','1',NULL,NULL),('OverrideOrderShipmethodWithDefault','false','210','Order','Header',1,NULL,'2021-01-01 00:00:00','2020-06-10 20:14:50','1',NULL,NULL),('PaymentsBatchFetchSize','60','211','Payment',NULL,2,'TOP x Payments to fetch for pushing to ERP','2023-01-14 10:36:51','2023-01-14 10:36:51','1',NULL,NULL),('PHL3PLFolders','Incoming=WarehouseTrackingPHI;Processed=WarehouseTrackingPHICompleted;Failed=WarehouseTrackingPHIFailed;Out;ing=companyFTPPHI','320,321','3PL','File',10,'file folder....','2023-04-04 00:00:00','2023-04-04 17:23:02','1',NULL,NULL),('PushCountriesForTaxId','PH','100','Customer','Tax',10,'County list for pulling customer TaxId','2023-01-02 22:23:30','2023-01-02 22:23:30','1',NULL,NULL),('RemoveNegPosCancelOutLines','True','100','Order','Line',1,'Remove matching negative and positive lines that cancel each other out','2022-08-07 00:00:00','2023-01-02 22:23:30','1',NULL,NULL),('StagingIgnoreAddresses','false','100,101','Order','Header',1,'Ignore addresses on pull','2020-10-20 00:00:00','2020-10-25 00:00:00','1',NULL,NULL),('UseLastPaymentDateForOrder','true',NULL,'Order','Header',1,'Use Last payment date for the order date. ;od for partial paid orders or stale orders that sat in shopping cart','2021-09-01 00:00:00','2021-09-01 00:00:00','1',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `AppParamValueTypes`
--

DROP TABLE IF EXISTS `AppParamValueTypes`;
CREATE TABLE `AppParamValueTypes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `AppParamValueTypes`
--

LOCK TABLES `AppParamValueTypes` WRITE;
INSERT INTO `AppParamValueTypes` VALUES (1,'bool'),(2,'int'),(3,'long'),(4,'byte'),(5,'float'),(6,'double'),(7,'decimal'),(8,'DateTime'),(9,'char'),(10,'string'),(11,'object'),(12,'JSON'),(13,'XML');
UNLOCK TABLES;

--
-- Table structure for table `CanadaFileTracking`
--

DROP TABLE IF EXISTS `CanadaFileTracking`;
CREATE TABLE `CanadaFileTracking` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(21) NOT NULL,
  `At` datetime NOT NULL,
  `Filename` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_CanadaFileTracking_Orders` (`OrderNumber`),
  CONSTRAINT `canadafiletracking_ibfk_1` FOREIGN KEY (`OrderNumber`) REFERENCES `Orders` (`OrderNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `CanadaFileTracking`
--

LOCK TABLES `CanadaFileTracking` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ChangeLog`
--

DROP TABLE IF EXISTS `ChangeLog`;
CREATE TABLE `ChangeLog` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `TableName` varchar(50) NOT NULL,
  `ColumnName` varchar(50) NOT NULL,
  `UserId` int NOT NULL,
  `PrevValue` varchar(8000) DEFAULT NULL,
  `NewValue` varchar(8000) DEFAULT NULL,
  `ValueType` int NOT NULL,
  `DATETIME` datetime NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ChangeLog_AppParamValueTypes` (`ValueType`),
  KEY `FK_ChangeLog_Users` (`UserId`),
  CONSTRAINT `changelog_ibfk_1` FOREIGN KEY (`ValueType`) REFERENCES `AppParamValueTypes` (`Id`),
  CONSTRAINT `changelog_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ChangeLog`
--

LOCK TABLES `ChangeLog` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `CustomerNumber` varchar(15) NOT NULL,
  `CustomerName` varchar(65) DEFAULT NULL,
  `ContactName` varchar(61) DEFAULT NULL,
  `CompanyName` varchar(35) DEFAULT NULL,
  `Phone1` varchar(21) DEFAULT NULL,
  `Phone2` varchar(21) DEFAULT NULL,
  `Phone3` varchar(21) DEFAULT NULL,
  `EmailAddress` varchar(80) DEFAULT NULL,
  `EnteredDate` datetime DEFAULT NULL,
  `BillAddressId` bigint DEFAULT NULL,
  `ShipAddressId` bigint DEFAULT NULL,
  `ImportedDate` datetime DEFAULT NULL,
  `TaxId` varchar(30) DEFAULT NULL,
  `TaxIdType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerNumber`),
  KEY `FK_Customers_Addresses` (`ShipAddressId`),
  KEY `FK_Customers_Addresses1` (`BillAddressId`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`ShipAddressId`) REFERENCES `Addresses` (`Id`),
  CONSTRAINT `customers_ibfk_2` FOREIGN KEY (`BillAddressId`) REFERENCES `Addresses` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
INSERT INTO `Customers` VALUES ('1000008','Cat Bruh','Cat Bruh','','999-999-9999',NULL,NULL,'cat.bruh@example.email.com','2009-08-31 10:00:00',67461,67461,'2023-10-03 15:44:22',NULL,NULL),('1000009','Elena DeWilt','Elena DeWilt',NULL,'999-999-9999',NULL,NULL,'e.dewilt@exampleemail.com','2009-08-31 10:00:00',67470,67470,'2023-10-03 15:44:22',NULL,NULL),('1000010','Belinda Bars','Belinda Bars','Example Enterprises LLC','999-999-9999',NULL,NULL,'b.bars@example.email.com','2009-08-31 10:00:00',67462,67462,'2023-10-03 15:44:30',NULL,NULL),('1000011','Jane Faustian','Jane Faustian',NULL,'999-999-9999',NULL,NULL,'jfaustian@exampleemail.com','2009-08-31 10:00:00',67471,67471,'2023-10-03 15:44:22',NULL,NULL),('1000012','Marla Hanogan','Marla Hanogan',NULL,'999-999-9999',NULL,NULL,'m.hanogan@example.email.com','2009-08-31 10:00:00',67472,67472,'2023-10-03 15:44:24',NULL,NULL),('1000013','Adrian Kay','Adrian Kay',NULL,'999-999-9999',NULL,NULL,'a.kay@example.email.com','2009-08-31 10:00:00',67473,67473,'2023-10-03 15:44:22',NULL,NULL),('1000040','Rob Murns','Rob Murns','Timeoutfreedom.co','999-999-9999','',NULL,'robmurns@exampleemail.com','2009-09-01 10:00:00',67463,67463,'2023-10-03 15:44:24',NULL,NULL),('1000117','Alice Queen','Alice Queen','Sample Solutions','999-999-9999',NULL,NULL,'a.queen@exampleemail.com','2009-09-01 10:00:00',67464,67464,'2023-06-22 11:50:07',NULL,NULL),('1000273','Maria Rowena','Maria Rowena','','999-999-9999','',NULL,'marwen@exampleemail.com','2009-09-02 10:00:00',67465,67465,'2023-06-22 11:50:45',NULL,NULL),('1001089','Ruby Song','Ruby Song','','999-999-9999','',NULL,'rubysong@exampleemail.com','2009-09-07 10:00:00',67466,67466,'2023-06-22 11:42:32',NULL,NULL),('1001093','Kate Kong','Kate Kong','','999-999-9999','',NULL,'kkong@exampleemail.com','2009-09-07 10:00:00',67467,67467,'2023-06-22 11:51:39',NULL,NULL),('1001176','M Trophy','M Trophy','','999-999-9999',NULL,NULL,'mtrophy@exmapleemail.com','2009-09-07 10:00:00',67468,67468,'2023-06-22 11:48:18',NULL,NULL),('1001195','Omam Badsign','Oman Badsign','','999-999-9999','','','badsign@exampleemail.com','2009-09-08 10:00:00',67469,67469,'2023-06-22 11:45:12',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `DashboardPages`
--

DROP TABLE IF EXISTS `DashboardPages`;
CREATE TABLE `DashboardPages` (
  `Id` tinyint NOT NULL AUTO_INCREMENT,
  `Page` varchar(50) NOT NULL,
  `Actions` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `DashboardPages`
--

LOCK TABLES `DashboardPages` WRITE;
INSERT INTO `DashboardPages` VALUES (1,'Dashboard',NULL),(2,'Failed Orders','Repull, Repush, Ignore, Unignore, Delete'),(3,'Failed Processes',NULL),(4,'Settings',NULL),(5,'Users','Add, Delete'),(6,'Sign Up, Sign In, Sign Out','Register, Sign In, Sign Out');
UNLOCK TABLES;

--
-- Table structure for table `ErpReturnOrderLines`
--

DROP TABLE IF EXISTS `ErpReturnOrderLines`;
CREATE TABLE `ErpReturnOrderLines` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `ErpId` varchar(40) DEFAULT NULL,
  `ErpHeaderId` varchar(40) NOT NULL,
  `OrderNumber` varchar(20) NOT NULL,
  `ParentLineNumber` int DEFAULT NULL,
  `LineNumber` int NOT NULL,
  `Sku` varchar(20) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(18,2) NOT NULL,
  `UnitTax` decimal(18,2) DEFAULT NULL,
  `Warehouse` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ReturnOrderLines_ROs` (`ErpHeaderId`),
  CONSTRAINT `erpreturnorderlines_ibfk_1` FOREIGN KEY (`ErpHeaderId`) REFERENCES `ErpReturnOrders` (`ErpId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ErpReturnOrderLines`
--

LOCK TABLES `ErpReturnOrderLines` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ErpReturnOrders`
--

DROP TABLE IF EXISTS `ErpReturnOrders`;
CREATE TABLE `ErpReturnOrders` (
  `ErpId` varchar(40) NOT NULL,
  `OrderNumber` varchar(20) NOT NULL,
  `CustomerNumber` varchar(15) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `OrderDate` datetime NOT NULL,
  `ShipDate` datetime NOT NULL,
  `CustomerName` varchar(35) DEFAULT NULL,
  `Address` varchar(35) DEFAULT NULL,
  `Address2` varchar(35) DEFAULT NULL,
  `City` varchar(35) DEFAULT NULL,
  `State` varchar(25) DEFAULT NULL,
  `Country` varchar(3) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Warehouse` varchar(25) NOT NULL,
  `OriginalOrderNumber` int NOT NULL,
  `ImportedAt` datetime NOT NULL,
  `SentToCrmAt` datetime DEFAULT NULL,
  `CrmOrderId` int DEFAULT NULL,
  PRIMARY KEY (`ErpId`),
  KEY `FK_ErpReturnOrders_Customers` (`CustomerNumber`),
  CONSTRAINT `erpreturnorders_ibfk_1` FOREIGN KEY (`CustomerNumber`) REFERENCES `Customers` (`CustomerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ErpReturnOrders`
--

LOCK TABLES `ErpReturnOrders` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ErpShipmentTracking`
--

DROP TABLE IF EXISTS `ErpShipmentTracking`;
CREATE TABLE `ErpShipmentTracking` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `ErpPostedPackageId` varchar(40) NOT NULL,
  `ErpOrderNumber` varchar(25) NOT NULL,
  `At` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ErpShipmentTracking`
--

LOCK TABLES `ErpShipmentTracking` WRITE;
INSERT INTO `ErpShipmentTracking` VALUES (1,'sample-package-id-1','S-ORD102648','2023-07-22 00:24:37'),(2,'sample-package-id-2','S-ORD102647','2023-07-22 00:24:53'),(3,'sample-package-id-3','S-ORD102645','2023-07-22 00:24:56'),(4,'sample-package-id-4','S-ORD102641','2023-07-29 11:01:10'),(5,'sample-package-id-5','S-ORD102606','2023-07-29 11:01:11'),(6,'sample-package-id-6','S-ORD102594','2023-07-29 11:01:12');
UNLOCK TABLES;

--
-- Table structure for table `IgnorePush`
--

DROP TABLE IF EXISTS `IgnorePush`;
CREATE TABLE `IgnorePush` (
  `OrderNumber` varchar(255) NOT NULL,
  `IgnoredBy` int DEFAULT NULL,
  `IgnoredAt` datetime DEFAULT NULL,
  PRIMARY KEY (`OrderNumber`),
  KEY `IgnorePush_relation_1` (`IgnoredBy`),
  CONSTRAINT `IgnorePush_relation_1` FOREIGN KEY (`IgnoredBy`) REFERENCES `Users` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `IgnorePush`
--

LOCK TABLES `IgnorePush` WRITE;
INSERT INTO `IgnorePush` VALUES ('51200299',NULL,NULL),('51200300',NULL,NULL),('51200303',NULL,NULL),('51200304',NULL,NULL),('51200314',NULL,NULL),('51200315',NULL,NULL),('51200316',NULL,NULL),('51200317',NULL,NULL),('51200318',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Logging`
--

DROP TABLE IF EXISTS `Logging`;
CREATE TABLE `Logging` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Level` varchar(256) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `Exception` varchar(1000) DEFAULT NULL,
  `Properties` varchar(1000) DEFAULT NULL,
  `JobName` varchar(30) NOT NULL,
  `MessageTemplate` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Logging`
--

LOCK TABLES `Logging` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `Maps`
--

DROP TABLE IF EXISTS `Maps`;
CREATE TABLE `Maps` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `IsoCountryCode` varchar(3) NOT NULL,
  `ErpCompanyId` varchar(50) NOT NULL,
  `IsoCurrencyCode` varchar(3) NOT NULL,
  `ErpCurrencyCode` varchar(10) NOT NULL,
  `SourceWarehouse` varchar(11) NOT NULL,
  `SourceShipMethod` varchar(100) DEFAULT NULL,
  `DestinationWarehouse` varchar(25) DEFAULT NULL,
  `ReturnsWarehouse` varchar(25) DEFAULT NULL,
  `IsVAT` tinyint DEFAULT NULL,
  `UseForErpPull` tinyint DEFAULT NULL,
  `ProcessingSequence` int DEFAULT NULL,
  `ActivatedAt` datetime DEFAULT NULL,
  `DeactivatedAt` datetime DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `CreatedBy` varchar(25) NOT NULL,
  `ModifiedAt` datetime DEFAULT NULL,
  `ModifiedBy` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Maps`
--

LOCK TABLES `Maps` WRITE;
INSERT INTO `Maps` VALUES (1,'US','CompanyId1','USD','USD','1',NULL,'DC-USASLC','DC-USARTRN',0,1,1,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1','2023-06-27 19:02:24','1'),(2,'CA','CompanyId2','CAD','CAD','2',NULL,'DC-CA','DC-CARTRN',0,1,2,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1',NULL,NULL),(3,'AU','CompanyId13','USD','USD','4',NULL,'DC-USASLC','DC-USARTRN',0,NULL,4,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1',NULL,NULL),(4,'PH','CompanyId4','PHP','PHP','5',NULL,'DC-PHL','DC-PHLRTRN',1,1,3,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1',NULL,NULL),(5,'PH','CompanyId5','PHP','PHP','5','Philippines Office Pickup','DC-PHLWC','DC-PHLRTRN',1,NULL,3,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1',NULL,NULL),(6,'US','CompanyId6','USD','USD','6',NULL,'DC-EVENTS','DC-USARTRN',0,NULL,1,'2023-01-01 00:00:00',NULL,'2023-01-02 23:11:19','1',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `OrderBatch`
--

DROP TABLE IF EXISTS `OrderBatch`;
CREATE TABLE `OrderBatch` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `DailyBatchNumber` int NOT NULL,
  `BatchDate` datetime NOT NULL,
  `Market` varchar(10) NOT NULL,
  `SelectedOrderCount` int NOT NULL,
  `ProcessedOrderCount` int DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `BatchMonth` int DEFAULT NULL,
  `OrderBatchSize` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=492 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `OrderBatch`
--

LOCK TABLES `OrderBatch` WRITE;
INSERT INTO `OrderBatch` VALUES (482,1,'2023-10-05 00:00:00','US',0,0,'2023-10-05 00:24:39',0,100),(483,2,'2023-10-05 00:00:00','US',0,0,'2023-10-05 00:26:48',0,100),(484,3,'2023-10-05 00:00:00','US',109,0,'2023-10-05 00:33:03',0,100),(485,4,'2023-10-05 00:00:00','US',101,0,'2023-10-05 00:35:55',0,100),(486,5,'2023-10-05 00:00:00','US',102,0,'2023-10-05 00:45:35',0,100),(487,6,'2023-10-05 00:00:00','US',101,0,'2023-10-05 00:49:27',0,100),(488,1,'2023-10-08 00:00:00','US',0,0,'2023-10-08 11:39:31',0,100),(489,2,'2023-10-08 00:00:00','US',2,1,'2023-10-08 23:30:34',0,0),(490,1,'2023-10-09 00:00:00','US',2,1,'2023-10-09 22:44:24',0,0),(491,1,'2023-10-10 00:00:00','PH',0,0,'2023-10-10 21:42:24',0,5);
UNLOCK TABLES;

--
-- Table structure for table `OrderBatchDetail`
--

DROP TABLE IF EXISTS `OrderBatchDetail`;
CREATE TABLE `OrderBatchDetail` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderBatchId` bigint NOT NULL,
  `OrderNumber` varchar(21) NOT NULL,
  `ErrorCode` varchar(50) DEFAULT NULL,
  `ErrorMessage` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_OrderBatch_OrderBatchDetail_Cascade` (`OrderBatchId`),
  CONSTRAINT `orderbatchdetail_ibfk_1` FOREIGN KEY (`OrderBatchId`) REFERENCES `OrderBatch` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18387 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `OrderBatchDetail`
--

LOCK TABLES `OrderBatchDetail` WRITE;
INSERT INTO `OrderBatchDetail` VALUES (18366,484,'51200299','Error Code 484','Sample batch-detail error 484'),(18367,484,'51200301','Error Code 488','Sample batch-detail error 488'),(18368,484,'51200302','Error Code 488','Sample batch-detail error 488'),(18369,484,'51200303','Error Code 484','Sample batch-detail error 484'),(18370,484,'51200304','Error Code 484','Sample batch-detail error 484'),(18371,484,'51200314','Error Code 484','Sample batch-detail error 484'),(18372,484,'51200315','Error Code 484','Sample batch-detail error 484'),(18373,484,'51200316','Error Code 484','Sample batch-detail error 484'),(18374,484,'51200317','Error Code 484','Sample batch-detail error 484'),(18376,485,'51200318','Error Code 485','Sample batch-detail error 485'),(18377,486,'51200320','Error Code 486','Sample batch-detail error 486'),(18378,486,'51200322','Error Code 486','Sample batch-detail error 486'),(18379,487,'51200712','Error Code 487','Sample batch-detail error 487'),(18380,489,'51200713','Error Code 489','Sample batch-detail error 489'),(18381,490,'51200714','Error Code 490','Sample batch-detail error 490'),(18382,488,'51200300','Error Code 488','Sample batch-detail error 488'),(18383,490,'51200715','Error Code 490','Sample batch-detail error 490'),(18384,490,'51200716','Error Code 490','Sample batch-detail error 490'),(18385,491,'51200719','Error Code 491','Sample batch-detail error 491'),(18386,491,'51200724','Error Code 491','Sample batch-detail error 491');
UNLOCK TABLES;

--
-- Table structure for table `Orderlines`
--

DROP TABLE IF EXISTS `Orderlines`;
CREATE TABLE `Orderlines` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(21) NOT NULL,
  `LineNumber` int DEFAULT NULL,
  `Sku` varchar(31) NOT NULL,
  `Quantity` decimal(18,2) NOT NULL,
  `UnitPrice` decimal(18,2) NOT NULL,
  `TaxRate` decimal(18,2) NOT NULL,
  `UnitTaxAmount` decimal(18,2) DEFAULT NULL,
  `ExtTaxAmount` decimal(18,2) DEFAULT NULL,
  `Warehouse` varchar(11) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `ParentSku` varchar(31) DEFAULT NULL,
  `ComponentPrice` decimal(18,2) DEFAULT NULL,
  `UnitCost` decimal(18,2) DEFAULT NULL,
  `ItemType` int NOT NULL,
  `IsVirtual` tinyint NOT NULL,
  `Weight` decimal(9,2) DEFAULT NULL,
  `CVolume` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Orderlines_Orders` (`OrderNumber`),
  CONSTRAINT `orderlines_ibfk_1` FOREIGN KEY (`OrderNumber`) REFERENCES `Orders` (`OrderNumber`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75604 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Orderlines`
--

LOCK TABLES `Orderlines` WRITE;
INSERT INTO `Orderlines` VALUES (75584,'51200299',1,'SUPerALTer-US',2.00,35.47,0.00,NULL,4.97,'DC-USA','Athlete',NULL,NULL,0.00,0,0,NULL,NULL),(75585,'51200299',2,'Promo',1.00,-6.27,0.00,NULL,0.00,'DC-USA','Holi+ Free Shipping Discount',NULL,NULL,0.00,0,1,NULL,NULL),(75586,'51200300',1,'TKPASSER-CA',1.00,344.97,0.00,NULL,17.25,'DC-CA','Holi T-Rex - Yessir & Fashion',NULL,NULL,0.00,2,0,NULL,NULL),(75587,'51200300',2,'1070010201',1.00,0.00,0.00,NULL,0.00,'DC-CA','Spur','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75588,'51200300',3,'SUPERRSVED-CA',1.00,0.00,0.00,NULL,0.00,'DC-CA','Revolve','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75589,'51200300',4,'1882670201',1.00,0.00,0.00,NULL,0.00,'DC-CA','20 oz Black Classic Bottle','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75590,'51200300',5,'1901080201',1.00,0.00,0.00,NULL,0.00,'DC-CA','X-Day Guide','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75591,'51200300',6,'YessirCHOC-CA',2.00,0.00,0.00,NULL,0.00,'DC-CA','Yessir Chocolate - X Servings','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75592,'51200300',7,'PASSERBKACK-CA',2.00,0.00,0.00,NULL,0.00,'DC-CA','Fashion Strawberry Kiwi - X CT','TKPASSER-CA',NULL,0.00,0,0,NULL,NULL),(75593,'51200300',8,'SUPERTALK-CA',2.00,0.00,0.00,NULL,0.00,'DC-CA','Athlete','TKPASER-CA',NULL,0.00,0,0,NULL,NULL),(75594,'51200301',1,'DY5207-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','One Bottle',NULL,NULL,0.00,2,0,NULL,NULL),(75595,'51200301',2,'SUPERTAKEBREAK-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Thermoburner','DYBN-US',NULL,0.00,0,0,NULL,NULL),(75596,'51200301',3,'HOLGCD-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Holi Gift Card ',NULL,NULL,0.00,0,0,NULL,NULL),(75597,'51200302',1,'DY-520-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','One Bottle',NULL,NULL,0.00,2,0,NULL,NULL),(75598,'51200302',2,'SUPERTAKEBREAK-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Thermoburner','DY-502-US',NULL,0.00,0,0,NULL,NULL),(75599,'51200302',3,'HOLGCD-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Holi Gift Card ',NULL,NULL,0.00,0,0,NULL,NULL),(75600,'51200303',1,'DY-502-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','One Bottle',NULL,NULL,0.00,2,0,NULL,NULL),(75601,'51200303',2,'SUPERTAKEBREAK-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Thermoburner','DY-502-US',NULL,0.00,0,0,NULL,NULL),(75602,'51200303',3,'HOLGCD-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','Holi Gift Card ',NULL,NULL,0.00,0,0,NULL,NULL),(75603,'51200304',1,'DY502-US',1.00,0.00,0.00,NULL,0.00,'DC-USA','One Bottle',NULL,NULL,0.00,2,0,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `OrderNumber` varchar(21) NOT NULL,
  `CustomerNumber` varchar(15) NOT NULL,
  `Market` varchar(10) NOT NULL,
  `CurrencyCode` varchar(10) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `OrderDate` datetime NOT NULL,
  `Warehouse` varchar(25) DEFAULT NULL,
  `PushStatusId` int DEFAULT NULL,
  `ShipToName` varchar(65) DEFAULT NULL,
  `ShipDate` datetime DEFAULT NULL,
  `ShipMethod` varchar(50) DEFAULT NULL,
  `TrackingNumber` varchar(41) DEFAULT NULL,
  `OrderTotalAmount` decimal(18,2) NOT NULL,
  `FreightAmount` decimal(18,2) NOT NULL,
  `FreightTaxAmount` decimal(18,2) NOT NULL,
  `TaxAmount` decimal(18,2) NOT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `OrderNotes` varchar(500) DEFAULT NULL,
  `Phone1` varchar(21) DEFAULT NULL,
  `Phone2` varchar(21) DEFAULT NULL,
  `Phone3` varchar(21) DEFAULT NULL,
  `BillAddressId` bigint DEFAULT NULL,
  `ShipAddressId` bigint DEFAULT NULL,
  `StagingImportDate` datetime NOT NULL,
  `PickupName` varchar(100) DEFAULT NULL,
  `OrderTypeDescription` varchar(20) DEFAULT NULL,
  `ReferenceOrderNumber` varchar(21) DEFAULT NULL,
  `ErpOrderNumber` varchar(25) DEFAULT NULL,
  `ErpId` varchar(40) DEFAULT NULL,
  `SentToErp` datetime DEFAULT NULL,
  `SentTo3PL` datetime DEFAULT NULL,
  PRIMARY KEY (`OrderNumber`),
  KEY `FK_Orders_Bill_Addresses` (`BillAddressId`),
  KEY `FK_Orders_Customers` (`CustomerNumber`),
  KEY `FK_Orders_PushStatuses` (`PushStatusId`),
  KEY `FK_Orders_Ship_Addresses` (`ShipAddressId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`BillAddressId`) REFERENCES `Addresses` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`CustomerNumber`) REFERENCES `Customers` (`CustomerNumber`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`PushStatusId`) REFERENCES `PushStatuses` (`Id`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`ShipAddressId`) REFERENCES `Addresses` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
INSERT INTO `Orders` VALUES ('51200299','1000008','US','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-USA',NULL,'Cat Bruh','2023-06-13 00:00:00','AUS 1st Class','9400116901714680149146',75.91,6.27,0.00,4.97,0.00,'','999-999-9999','',NULL,67461,67461,'2023-10-04 22:03:21','','Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200300','1000010','US','USD','2023-06-11 20:37:33','2023-06-11 20:37:30','DC-USA',NULL,'Belinda Bars','2023-06-12 00:00:00','USPS 1st Class','2007768008087719',372.47,10.25,0.00,17.25,0.00,'','999-999-9999','',NULL,67462,67462,'2023-10-04 22:07:49','','Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200301','1000040','US','USD','2023-06-11 20:48:04','2023-06-11 20:48:02','DC-USA',NULL,'Rob Murns','2023-06-12 00:00:00','UPS Ground','9400116901714680123627',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79124','999-999-9999','',NULL,67463,67463,'2023-10-04 22:08:00','','API Order',NULL,NULL,NULL,NULL,NULL),('51200302','1000117','US','USD','2023-06-11 20:48:06','2023-06-11 20:48:05','DC-USA',NULL,'Alice Queen','2023-06-12 00:00:00','UPS Ground','9400116901714680123658',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79125','999-999-9999','',NULL,67464,67464,'2023-10-04 22:08:03','','API Order',NULL,NULL,NULL,NULL,NULL),('51200303','1000273','PH','PHP','2023-06-11 20:48:08','2023-06-11 20:48:07','DC-PH',2,'Maria Rowena','2023-06-12 00:00:00','PH 1st Class','9400116901714680123665',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79126','999-999-9999','',NULL,67465,67465,'2023-10-04 22:11:16','','API Order',NULL,NULL,NULL,NULL,NULL),('51200304','1001089','PH','PHP','2023-06-11 20:48:10','2023-06-11 20:48:09','DC-PH',2,'Ruby Song','2023-06-12 00:00:00','PH Ground','9400116901714680123689',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79127','999-999-9999','',NULL,67466,67466,'2023-10-04 22:11:18','','API Order',NULL,NULL,NULL,NULL,NULL),('51200314','1001093','PH','PHP','2023-06-11 21:18:04','2023-06-11 21:18:02','DC-PH',2,'Kate Kong','2023-06-12 00:00:00','PH 1st Class','9400116901714680121241',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79130','999-999-9999','',NULL,67467,67467,'2023-10-04 22:11:19','','API Order',NULL,NULL,NULL,NULL,NULL),('51200315','1001176','CA','CAD','2023-06-11 21:18:07','2023-06-11 21:18:06','DC-CA',2,'M Trophy','2023-06-12 00:00:00','CAN 1st Class','9400116901714680123603',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79132','999-999-9999','',NULL,67468,67468,'2023-10-04 22:11:20','','API Order',NULL,NULL,NULL,NULL,NULL),('51200316','1001195','CA','CAD','2023-06-11 21:18:09','2023-06-11 21:18:08','DC-CA',2,'Omam Badsign','2023-06-12 00:00:00','CAN 1st Class','9400116901714680123931',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79131','999-999-9999','',NULL,67469,67469,'2023-10-04 22:11:21','','API Order',NULL,NULL,NULL,NULL,NULL),('51200317','1000008','US','USD','2023-06-11 21:18:11','2023-06-11 21:18:10','DC-USA',2,'Cat Bruh','2023-06-12 00:00:00','AUS 1st Class','9400116901714680195167',48.70,4.95,0.00,3.80,0.00,'Order created in WebForce with Order Number = 79133','999-999-9999','',NULL,67461,67461,'2023-10-04 22:11:23','','API Order',NULL,NULL,NULL,NULL,NULL),('51200318','1000010','US','USD','2023-06-11 21:18:13','2023-06-11 21:18:12','DC-USA',2,'Belinda Bars','2023-06-12 00:00:00','USPS 1st Class','9400116901714680121272',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79134','999-999-9999','',NULL,67462,67462,'2023-10-04 22:11:24','','API Order',NULL,NULL,NULL,NULL,NULL),('51200320','1000040','US','USD','2023-06-11 21:21:02','2023-06-11 21:20:49','DC-USA',2,'Rob Murns','2023-06-12 00:00:00','UPS Ground','1ZAF70280320664616',171.07,9.03,0.00,13.04,0.00,'','999-999-9999','',NULL,67463,67463,'2023-10-04 22:11:25','','Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200322','1000117','US','USD','2023-06-11 21:30:02','2023-06-11 21:29:58','DC-USA',2,'Alice Queen','2023-06-12 00:00:00','UPS Ground','9400116901714680120022',11.08,5.78,0.00,0.30,0.00,'','999-999-9999','',NULL,67464,67464,'2023-10-04 22:11:26','','Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200712','1000273','PH','PHP','2023-06-11 21:41:22','2023-06-11 21:41:18','DC-PH',NULL,'Maria Rowena','2023-06-12 00:00:00','PH Ground','1ZAF70280320669791',118.14,9.03,0.00,7.73,0.00,'','999-999-9999','',NULL,67465,67465,'2023-10-04 22:11:27','','Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200713','1001089','PH','PHP','2023-06-11 21:48:04','2023-06-11 21:48:02','DC-PH',NULL,'Ruby Song','2023-06-12 00:00:00','PH Ground','9400116901714680123917',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79136','999-999-9999','',NULL,67466,67466,'2023-10-04 22:11:28','','API Order',NULL,NULL,NULL,NULL,NULL),('51200714','1001093','PH','PHP','2023-06-11 21:48:05','2023-06-11 21:48:05','DC-PH',2,'Kate Kong','2023-06-12 00:00:00','PH 1st Class','9400116901714680121296',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79139','999-999-9999','',NULL,67467,67467,'2023-10-04 22:11:29','','API Order',NULL,NULL,NULL,NULL,NULL),('51200715','1001176','CA','CAD','2023-06-11 21:48:06','2023-06-11 21:48:06','DC-CA',2,'M Trophy','2023-06-12 00:00:00','CAN 1st Class','9400116901714680121227',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79129','999-999-9999','',NULL,67468,67468,'2023-10-04 22:11:31','','API Order',NULL,NULL,NULL,NULL,NULL),('51200716','1001195','CA','CAD','2023-06-11 21:48:08','2023-06-11 21:48:07','DC-CA',2,'Omam Badsign','2023-06-12 00:00:00','CAN 1st Class','9400116901714680121258',4.95,4.95,0.00,0.00,0.00,'Order created in WebForce with Order Number = 79128','999-999-9999','',NULL,67469,67469,'2023-10-04 22:11:32','','API Order',NULL,NULL,NULL,NULL,NULL),('51200717','1000009','CA','CAD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-CA',NULL,'Elena DeWilt','2023-06-13 00:00:00','CA Ground','9400116901714680149147',145.89,12.10,0.00,14.89,0.00,NULL,'999-999-9999',NULL,NULL,67470,67470,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200718','1000009','CA','CAD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-CA',NULL,'Elena DeWilt','2023-06-13 00:00:00','CA Ground','9400116901714680149148',16.78,1.25,0.00,0.12,0.00,NULL,'999-999-9999',NULL,NULL,67470,67470,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200719','1000011','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',2,'Jane Faustian','2023-06-13 00:00:00','AU Ground','9400116901714680149149',35.78,3.58,0.00,3.58,0.00,NULL,'999-999-9999',NULL,NULL,67471,67471,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200720','1000011','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',NULL,'Jane Faustian','2023-06-13 00:00:00','AU Ground','9400116901714680149150',54.58,1.25,0.00,5.46,0.00,NULL,'999-999-9999',NULL,NULL,67471,67471,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200721','1000012','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',NULL,'Marla Hanogan','2023-06-13 00:00:00','AU 1st Class','9400116901714680149151',198.41,6.80,0.00,20.00,0.00,NULL,'999-999-9999',NULL,NULL,67472,67472,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200722','1000012','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',NULL,'Marla Hanogan','2023-06-13 00:00:00','AU 1st Class','9400116901714680149152',269.51,12.00,0.00,28.00,0.00,NULL,'999-999-9999',NULL,NULL,67472,67472,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200723','1000013','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',NULL,'Adrian Kay','2023-06-13 00:00:00','AU 1st Class','9400116901714680149153',36.25,2.49,0.00,3.63,0.00,NULL,'999-999-9999',NULL,NULL,67473,67473,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL),('51200724','1000013','AU','USD','2023-06-11 20:36:29','2023-06-11 20:36:25','DC-AU',2,'Adrian Kay','2023-06-13 00:00:00','AU 1st Class','9400116901714680149154',68.34,4.60,0.00,6.83,0.00,NULL,'999-999-9999',NULL,NULL,67473,67473,'2023-10-04 22:03:21',NULL,'Shopping Cart',NULL,NULL,NULL,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `OrderStagingErrors`
--

DROP TABLE IF EXISTS `OrderStagingErrors`;
CREATE TABLE `OrderStagingErrors` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(21) NOT NULL,
  `OrderDate` datetime NOT NULL,
  `OrderTotal` decimal(18,2) NOT NULL,
  `CurrencyCode` varchar(3) NOT NULL,
  `Message` varchar(300) NOT NULL,
  `At` datetime NOT NULL,
  `IgnoredAt` datetime DEFAULT NULL,
  `Exception` varchar(8000) DEFAULT NULL,
  `IgnoredBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `NONCLUSTERED` (`OrderNumber`),
  KEY `OrderStagingErrors_Users_FK` (`IgnoredBy`),
  CONSTRAINT `OrderStagingErrors_Users_FK` FOREIGN KEY (`IgnoredBy`) REFERENCES `Users` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=32664 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `OrderStagingErrors`
--

LOCK TABLES `OrderStagingErrors` WRITE;
INSERT INTO `OrderStagingErrors` VALUES (32618,'51201523','2023-06-12 00:18:05',47.70,'usd','Calculated payment amount $45.25 does not add up to order total $47.70','2023-10-03 15:44:05',NULL,NULL,NULL),(32619,'51222018','2023-10-02 03:23:59',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:33',NULL,NULL,NULL),(32620,'51222037','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:34',NULL,NULL,NULL),(32621,'51222039','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:34',NULL,NULL,NULL),(32622,'51222040','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:34',NULL,NULL,NULL),(32623,'51222041','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:35',NULL,NULL,NULL),(32624,'51222042','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:35',NULL,NULL,NULL),(32625,'51222043','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:35',NULL,NULL,NULL),(32626,'51222044','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:35',NULL,NULL,NULL),(32627,'51222045','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:36',NULL,NULL,NULL),(32628,'51222047','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:36',NULL,NULL,NULL),(32629,'51222048','2023-10-03 03:24:16',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:36',NULL,NULL,NULL),(32630,'51222073','2023-10-04 03:24:43',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:36',NULL,NULL,NULL),(32631,'51222076','2023-10-04 03:24:43',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:37',NULL,NULL,NULL),(32632,'51222079','2023-10-04 03:24:43',0.00,'usd','Free order with only virtual items','2023-10-04 22:28:37',NULL,NULL,NULL),(32633,'51203956','2023-06-12 07:18:06',24.90,'usd','Calculated payment amount $26.96 does not add up to order total $24.90','2023-10-04 23:13:15',NULL,NULL,NULL),(32634,'51205177','2023-06-12 10:18:02',47.30,'usd','Calculated payment amount $45.30 does not add up to order total $47.30','2023-10-04 23:14:24',NULL,NULL,NULL),(32635,'51206397','2023-06-12 12:48:02',4.95,'usd','Calculated payment amount $48.00 does not add up to order total $4.95','2023-10-04 23:15:04',NULL,NULL,NULL),(32636,'51206803','2023-06-12 13:48:10',24.90,'usd','Calculated payment amount $26.96 does not add up to order total $24.90','2023-10-04 23:15:21',NULL,NULL,NULL),(32637,'51206825','2023-06-12 14:18:08',4.95,'usd','Calculated payment amount $48.70 does not add up to order total $4.95','2023-10-04 23:15:36',NULL,NULL,NULL),(32638,'51207220','2023-06-12 14:48:04',24.90,'usd','Calculated payment amount $26.10 does not add up to order total $24.90','2023-10-04 23:15:44',NULL,NULL,NULL),(32639,'51207222','2023-06-12 14:48:08',24.90,'usd','Calculated payment amount $26.10 does not add up to order total $24.90','2023-10-04 23:15:46',NULL,NULL,NULL),(32640,'51208042','2023-06-12 17:18:02',24.90,'usd','Calculated payment amount $26.96 does not add up to order total $24.90','2023-10-04 23:16:36',NULL,NULL,NULL),(32641,'51208445','2023-06-12 18:18:01',24.90,'usd','Calculated payment amount $26.55 does not add up to order total $24.90','2023-10-04 23:17:00',NULL,NULL,NULL),(32642,'51208837','2023-06-12 18:48:05',25.15,'usd','Calculated payment amount $27.40 does not add up to order total $25.15','2023-10-04 23:17:10',NULL,NULL,NULL),(32643,'51209253','2023-06-12 20:18:08',24.90,'usd','Calculated payment amount $26.96 does not add up to order total $24.90','2023-10-04 23:17:41',NULL,NULL,NULL),(32644,'51210840','2023-06-12 23:48:03',47.10,'usd','Calculated payment amount $45.27 does not add up to order total $47.10','2023-10-04 23:18:40',NULL,NULL,NULL),(32645,'51213496','2023-06-13 08:18:02',24.90,'usd','Calculated payment amount $26.55 does not add up to order total $24.90','2023-10-04 23:22:35',NULL,NULL,NULL),(32646,'51215935','2023-06-14 09:06:09',0.00,'usd','Free order with only virtual items','2023-10-04 23:22:42',NULL,NULL,NULL),(32647,'51215936','2023-06-14 09:09:16',0.00,'usd','Free order with only virtual items','2023-10-04 23:22:42',NULL,NULL,NULL),(32648,'51216410','2023-06-23 17:06:31',9.03,'usd','Calculated payment amount $0.00 does not add up to order total $9.03','2023-10-04 23:22:47',NULL,NULL,NULL),(32649,'51217064','2023-06-30 13:56:24',200.00,'usd','Calculated payment amount $0.00 does not add up to order total $200.00','2023-10-04 23:22:51',NULL,NULL,NULL),(32650,'51217217','2023-07-05 10:17:12',522.52,'usd','Calculated payment amount $0.00 does not add up to order total $522.52','2023-10-04 23:22:53',NULL,NULL,NULL),(32651,'51217614','2023-07-13 11:08:01',20.55,'usd','Calculated payment amount $0.00 does not add up to order total $20.55','2023-10-04 23:22:55',NULL,NULL,NULL),(32652,'51217630','2023-07-13 16:16:46',51.45,'usd','Calculated payment amount $0.00 does not add up to order total $51.45','2023-10-04 23:22:56',NULL,NULL,NULL),(32653,'51218967','2023-08-08 13:24:12',0.00,'usd','Free order with only virtual items','2023-10-04 23:23:03',NULL,NULL,NULL),(32654,'51219926','2023-08-23 16:18:37',21.50,'usd','Calculated payment amount $0.00 does not add up to order total $21.50','2023-10-04 23:23:03',NULL,NULL,NULL),(32655,'51219928','2023-08-23 16:38:04',21.50,'usd','Calculated payment amount $0.00 does not add up to order total $21.50','2023-10-04 23:23:03',NULL,NULL,NULL),(32656,'51220357','2023-09-05 09:08:18',158.85,'cad','Calculated payment amount $0.00 does not add up to order total $158.85','2023-10-04 23:23:04',NULL,NULL,NULL),(32657,'51220358','2023-09-05 09:32:32',519.22,'cad','Calculated payment amount $0.00 does not add up to order total $519.22','2023-10-04 23:23:04',NULL,NULL,NULL),(32658,'51220360','2023-09-05 09:38:46',54.05,'cad','Calculated payment amount $0.00 does not add up to order total $54.05','2023-10-04 23:23:04',NULL,NULL,NULL),(32659,'51220361','2023-09-05 09:50:52',4060.99,'php','Calculated payment amount $0.00 does not add up to order total $4,060.99','2023-10-04 23:23:04',NULL,NULL,NULL),(32660,'51220362','2023-09-05 09:54:16',4060.99,'php','Calculated payment amount $0.00 does not add up to order total $4,060.99','2023-10-04 23:23:05',NULL,NULL,NULL),(32661,'51220363','2023-09-05 09:55:02',4060.99,'php','Calculated payment amount $0.00 does not add up to order total $4,060.99','2023-10-04 23:23:05',NULL,NULL,NULL),(32662,'51220641','2023-09-11 18:13:46',415.21,'usd','Calculated payment amount $0.00 does not add up to order total $415.21','2023-10-04 23:23:05',NULL,NULL,NULL),(32663,'51221980','2023-09-30 15:49:15',308.97,'usd','Calculated payment amount $0.00 does not add up to order total $308.97','2023-10-04 23:23:06',NULL,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
CREATE TABLE `Payments` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `SourcePaymentId` varchar(20) DEFAULT NULL,
  `OrderNumber` varchar(21) NOT NULL,
  `PaymentType` varchar(30) DEFAULT NULL,
  `PaymentAmount` decimal(18,2) NOT NULL,
  `PaymentDate` datetime NOT NULL,
  `CardNumber` varchar(25) DEFAULT NULL,
  `AuthCode` varchar(25) DEFAULT NULL,
  `SentToErp` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Payments_Orders` (`OrderNumber`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`OrderNumber`) REFERENCES `Orders` (`OrderNumber`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26215 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Payments`
--

LOCK TABLES `Payments` WRITE;
INSERT INTO `Payments` VALUES (26189,'76217741','51200299','Holy Cash (USD)',87.15,'2023-06-11 20:36:27',NULL,'11235Z',NULL),(26190,'76217742','51200717','Holy Cash (USD)',172.88,'2023-06-11 20:36:30',NULL,NULL,NULL),(26191,'76217743','51200300','Credit Card',399.97,'2023-06-11 20:37:31','***********9963','02001Z',NULL),(26192,'76217744','51200301','Credit Card',9.90,'2023-06-11 01:00:00','***********7431','8432479801',NULL),(26193,'76217745','51200302','Holy Cash (USD)',9.90,'2023-06-11 01:00:00',NULL,'8432506055',NULL),(26194,'76217746','51200303','Credit Card',9.90,'2023-06-11 01:00:00','***********7475','8432511697',NULL),(26195,'76217747','51200304','Credit Card',9.90,'2023-06-11 01:00:00','***********9982','8432513302',NULL),(26196,'76217756','51200314','ACH',9.90,'2023-06-11 01:00:00',NULL,'8432533497',NULL),(26197,'76217757','51200315','Credit Card',9.90,'2023-06-11 01:00:00','***********3415','8432547130',NULL),(26198,'76217758','51200316','Credit Card',9.90,'2023-06-11 01:00:00','***********4938','8432539577',NULL),(26199,'76217759','51200317','Holy Cash (USD)',57.45,'2023-06-11 01:00:00',NULL,'8432550178',NULL),(26200,'76217760','51200718','Credit Card',18.15,'2023-06-11 01:00:00','***********8042','8432550991',NULL),(26201,'76217761','51200318','Credit Card',9.90,'2023-06-11 01:00:00','***********1614','8432550564',NULL),(26202,'76217762','51200320','Menvo',193.14,'2023-06-11 21:20:59',NULL,'45870Z',NULL),(26203,'76217764','51200322','Credit Card',17.16,'2023-06-11 21:30:00','***********6056','011137',NULL),(26204,'76217765','51200712','Credit Card',134.90,'2023-06-11 21:41:20','***********8052','354498',NULL),(26205,'76217766','51200713','Holy Cash (USD)',9.90,'2023-06-11 01:00:00',NULL,'8432560002',NULL),(26206,'76217767','51200714','Credit Card',9.90,'2023-06-11 01:00:00','***********4466','8432563752',NULL),(26207,'76217768','51200715','Credit Card',9.90,'2023-06-11 01:00:00','***********8202','8432526933',NULL),(26208,'76217769','51200716','Credit Card',9.90,'2023-06-11 01:00:00','***********7463','8432515694',NULL),(26209,'76217761','51200719','Menvo',42.94,'2023-06-11 01:00:00',NULL,NULL,NULL),(26210,'76217762','51200720','Menvo',61.29,'2023-06-11 01:00:00',NULL,NULL,NULL),(26211,'76217763','51200721','Menvo',225.21,'2023-06-11 01:00:00',NULL,NULL,NULL),(26212,'76217764','51200722','ACH',309.51,'2023-06-11 01:00:00',NULL,NULL,NULL),(26213,'76217765','51200723','ACH',42.37,'2023-06-11 01:00:00',NULL,NULL,NULL),(26214,'76217766','51200724','ACH',79.77,'2023-06-11 01:00:00',NULL,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `PaymentsTracking`
--

DROP TABLE IF EXISTS `PaymentsTracking`;
CREATE TABLE `PaymentsTracking` (
  `PaymentId` bigint NOT NULL,
  `DismissedAt` datetime DEFAULT NULL,
  `ErrorReason` varchar(200) DEFAULT NULL,
  `AttemptedAt` datetime NOT NULL,
  `RetiredAt` datetime NOT NULL,
  `DismissedBy` tinyint DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  CONSTRAINT `paymentstracking_ibfk_1` FOREIGN KEY (`PaymentId`) REFERENCES `Payments` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PaymentsTracking`
--

LOCK TABLES `PaymentsTracking` WRITE;
INSERT INTO `PaymentsTracking` VALUES (26189,NULL,NULL,'2024-01-29 05:55:02','9999-12-31 23:59:59',NULL),(26190,NULL,'Sample error','2024-01-29 05:57:42','9999-12-31 23:59:59',NULL),(26191,NULL,NULL,'2024-01-29 05:57:48','9999-12-31 23:59:59',NULL),(26192,NULL,NULL,'2024-01-29 05:57:48','9999-12-31 23:59:59',NULL),(26193,NULL,NULL,'2024-01-29 05:57:48','9999-12-31 23:59:59',NULL),(26194,NULL,'Sample error','2024-01-29 05:57:50','9999-12-31 23:59:59',NULL),(26195,NULL,NULL,'2024-01-29 05:57:51','9999-12-31 23:59:59',NULL),(26196,NULL,'A medium-sized sample error','2024-01-29 05:57:52','9999-12-31 23:59:59',NULL),(26197,NULL,NULL,'2024-01-29 05:57:54','9999-12-31 23:59:59',NULL),(26198,NULL,NULL,'2024-01-29 05:57:54','9999-12-31 23:59:59',NULL),(26199,NULL,NULL,'2024-01-29 05:57:55','9999-12-31 23:59:59',NULL),(26200,NULL,NULL,'2024-01-29 05:58:00','9999-12-31 23:59:59',NULL),(26201,NULL,'A medium-sized sample error','2024-01-29 05:58:00','9999-12-31 23:59:59',NULL),(26202,NULL,NULL,'2024-01-29 05:58:00','9999-12-31 23:59:59',NULL),(26204,NULL,NULL,'2024-01-29 05:58:01','9999-12-31 23:59:59',NULL),(26205,NULL,'A much longer sample error with more words in it','2024-01-29 05:58:02','9999-12-31 23:59:59',NULL),(26206,NULL,NULL,'2024-01-29 05:58:02','9999-12-31 23:59:59',NULL),(26207,NULL,NULL,'2024-01-29 05:58:03','9999-12-31 23:59:59',NULL),(26208,NULL,NULL,'2024-01-29 05:58:03','9999-12-31 23:59:59',NULL);
UNLOCK TABLES;

--
-- Table structure for table `ProcessedTransactions`
--

DROP TABLE IF EXISTS `ProcessedTransactions`;
CREATE TABLE `ProcessedTransactions` (
  `Id` bigint NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `EntryReceiedDate` datetime NOT NULL,
  `CustomerID` int NOT NULL,
  `LoginName` varchar(30) DEFAULT NULL,
  `OrderID` int NOT NULL,
  `AffiliateOrderID` varchar(10) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `Phone` varchar(12) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `City` varchar(40) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(10) DEFAULT NULL,
  `FileOrigin` varchar(45) NOT NULL,
  `Affiliate` varchar(10) DEFAULT NULL,
  `SuccessStatus` tinyint NOT NULL,
  `FailReason` varchar(200) DEFAULT NULL,
  `Emailed` tinyint DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ProcessedTransactions`
--

LOCK TABLES `ProcessedTransactions` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ProcessingErrors`
--

DROP TABLE IF EXISTS `ProcessingErrors`;
CREATE TABLE `ProcessingErrors` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `ProcessJobId` int NOT NULL,
  `Category` varchar(20) DEFAULT NULL,
  `OrderNumber` varchar(21) NOT NULL,
  `LineNumber` int DEFAULT NULL,
  `AltId` varchar(12) DEFAULT NULL,
  `Message` varchar(300) NOT NULL,
  `AdditionalData` varchar(300) DEFAULT NULL,
  `At` datetime NOT NULL,
  `DismissedAt` datetime DEFAULT NULL,
  `DismissedBy` varchar(20) DEFAULT NULL,
  `Exception` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_ProcessJobs_Id` (`ProcessJobId`),
  CONSTRAINT `processingerrors_ibfk_1` FOREIGN KEY (`ProcessJobId`) REFERENCES `ProcessJobs` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ProcessingErrors`
--

LOCK TABLES `ProcessingErrors` WRITE;
INSERT INTO `ProcessingErrors` VALUES (1,100,'Category 100','51200299',NULL,NULL,'Sample process error.',NULL,'2024-02-29 15:34:32',NULL,NULL,NULL),(2,100,'Category 100','51200300',NULL,NULL,'Sample process error.',NULL,'2024-02-28 15:34:32',NULL,NULL,NULL),(3,200,'Category 200','51200301',NULL,NULL,'Another sample processing error.',NULL,'2024-02-27 15:34:32',NULL,NULL,NULL),(4,310,'Category 310','51200302',NULL,NULL,'A fourth sample processing error.',NULL,'2024-02-26 15:34:32',NULL,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `ProcessJobs`
--

DROP TABLE IF EXISTS `ProcessJobs`;
CREATE TABLE `ProcessJobs` (
  `Id` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `ExternalSystem` varchar(15) NOT NULL,
  `DataDirection` varchar(3) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ProcessJobs`
--

LOCK TABLES `ProcessJobs` WRITE;
INSERT INTO `ProcessJobs` VALUES (100,'Pull Unshipped Orders','Burrito','IN'),(101,'Pull Shipped Orders','Burrito','IN'),(102,'Pull Fee Orders/Chargebacks','Burrito','IN'),(103,'Pull Completed ReturnOrders','Burrito','IN'),(110,'Push Tracking Info','Burrito','OUT'),(111,'Push ReturnOrders','Burrito','OUT'),(200,'Pull Tracking info','BC','IN'),(201,'Pull ReturnOrders','BC','IN'),(210,'Push Orders/Customers','BC','OUT'),(211,'Push Cash Receipts','BC','OUT'),(212,'Push Shipping Info','BC','OUT'),(213,'Push Completed ROs','BC','OUT'),(310,'Generate File Can','CCLS','OUT'),(311,'Parse File Can','CCLS','IN'),(320,'Generate File Phl','LBC','OUT'),(321,'Parse File Phl','LBC','IN');
UNLOCK TABLES;

--
-- Table structure for table `PurgeRunDetails`
--

DROP TABLE IF EXISTS `PurgeRunDetails`;
CREATE TABLE `PurgeRunDetails` (
  `PurgeRunDetailId` int NOT NULL AUTO_INCREMENT,
  `PurgeRunId` int NOT NULL,
  `TableName` varchar(20) NOT NULL,
  `PurgeCount` int NOT NULL,
  PRIMARY KEY (`PurgeRunDetailId`),
  KEY `FK_PurgeRunDetails_PurgeRuns` (`PurgeRunId`),
  CONSTRAINT `purgerundetails_ibfk_1` FOREIGN KEY (`PurgeRunId`) REFERENCES `PurgeRuns` (`PurgeRunId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PurgeRunDetails`
--

LOCK TABLES `PurgeRunDetails` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `PurgeRuns`
--

DROP TABLE IF EXISTS `PurgeRuns`;
CREATE TABLE `PurgeRuns` (
  `PurgeRunId` int NOT NULL AUTO_INCREMENT,
  `RunDate` datetime NOT NULL,
  `MonthsKept` int NOT NULL,
  PRIMARY KEY (`PurgeRunId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PurgeRuns`
--

LOCK TABLES `PurgeRuns` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `PushStatuses`
--

DROP TABLE IF EXISTS `PushStatuses`;
CREATE TABLE `PushStatuses` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PushStatuses`
--

LOCK TABLES `PushStatuses` WRITE;
INSERT INTO `PushStatuses` VALUES (1,'Sent'),(2,'Failed'),(3,'Ignored'),(4,'Placeholder');
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
CREATE TABLE `Roles` (
  `Id` tinyint NOT NULL,
  `Role` varchar(50) NOT NULL,
  `RestrictedPages` varchar(8000) NOT NULL,
  `RestrictedActions` varchar(8000) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
INSERT INTO `Roles` VALUES (1,'Admin','None','None'),(11,'Agent','Users, Settings','Delete'),(21,'User','Users, Settings','All');
UNLOCK TABLES;

--
-- Table structure for table `ShippedOrderlines`
--

DROP TABLE IF EXISTS `ShippedOrderlines`;
CREATE TABLE `ShippedOrderlines` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `OrderlineId` bigint NOT NULL,
  `ShippedAt` datetime NOT NULL,
  `ShippedQuantity` int NOT NULL,
  `Carrier` varchar(50) DEFAULT NULL,
  `ShipMethod` varchar(50) DEFAULT NULL,
  `TrackingNumber` varchar(50) DEFAULT NULL,
  `LotNumber` varchar(25) NOT NULL,
  `ShippedOrderSourceId` int NOT NULL,
  `SourceDocument` varchar(50) DEFAULT NULL,
  `CrmNotifiedAt` datetime DEFAULT NULL,
  `ErpNotifiedAt` datetime DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `CreatedBy` varchar(25) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Orders_OrderlineId` (`OrderlineId`),
  KEY `FK_Orders_SourceId` (`ShippedOrderSourceId`),
  CONSTRAINT `shippedorderlines_ibfk_1` FOREIGN KEY (`OrderlineId`) REFERENCES `Orderlines` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `shippedorderlines_ibfk_2` FOREIGN KEY (`ShippedOrderSourceId`) REFERENCES `ShippedOrderSources` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ShippedOrderlines`
--

LOCK TABLES `ShippedOrderlines` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `ShippedOrderSources`
--

DROP TABLE IF EXISTS `ShippedOrderSources`;
CREATE TABLE `ShippedOrderSources` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ShippedOrderSources`
--

LOCK TABLES `ShippedOrderSources` WRITE;
INSERT INTO `ShippedOrderSources` VALUES (1,'CRM-company'),(2,'company-ERP'),(3,'3PL-CAN'),(4,'3PL-PHL');
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Hash` varchar(8000) NOT NULL,
  `Role` tinyint NOT NULL,
  `DateRegistered` datetime NOT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LoggedIn` tinyint DEFAULT NULL,
  `FailedAttempts` tinyint DEFAULT NULL,
  `Active` tinyint DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Email` (`Email`),
  KEY `FK_Users_Roles` (`Role`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Role`) REFERENCES `Roles` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
INSERT INTO `Users` VALUES (1,'nrc4@hotmail.com','Nate Cox','$2a$12$bcbTc5wT9JSkH0xUFgLAouniqqm7xDLo9aH06l63HZFmTtuyPnP82',1,'2023-06-23 16:55:13','2024-06-13 12:43:21',1,0,1),(2,'example@sasha.rad','Sasha','$2a$12$ZUnPMVQ0zbVt8CSSjf9vVOW6Uc0pojXmFidxzL5Dbiy8UUvXCs1Ti',21,'2023-06-23 19:14:38','2023-06-29 17:05:33',0,0,1),(3,'real.neal@neal.real','Nigel Cooks','$2a$12$FhS7miw2gaaDxf2oCDR09.5AcHqOMkPksBFsMcOYP/gSdGwHFXp.y',11,'2023-06-23 19:15:08','2023-06-29 17:45:22',0,0,1);
UNLOCK TABLES;

-- Dump completed on 2024-06-13 13:29:20
