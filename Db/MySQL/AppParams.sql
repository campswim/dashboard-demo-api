-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql3.freesqldatabase.com
-- Generation Time: Feb 20, 2024 at 09:42 PM
-- Server version: 5.5.54-0ubuntu0.12.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql3684435`
--

-- --------------------------------------------------------

--
-- Table structure for table `AppParams`
--

CREATE TABLE IF NOT EXISTS `AppParams` (
  `Name` varchar(100) NOT NULL,
  `Value` text,
  `ProcessJobIds` varchar(25) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `SubCategory` varchar(50) DEFAULT NULL,
  `ValueTypeId` tinyint(4) NOT NULL,
  `Notes` tinytext,
  `EnabledDate` datetime DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `CreatedBy` varchar(25) NOT NULL,
  `ModifiedAt` datetime DEFAULT NULL,
  `ModifiedBy` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AppParams`
--

INSERT INTO `AppParams` (`Name`, `Value`, `ProcessJobIds`, `Category`, `SubCategory`, `ValueTypeId`, `Notes`, `EnabledDate`, `CreatedAt`, `CreatedBy`, `ModifiedAt`, `ModifiedBy`) VALUES
('WarehouseMap', 'Key=VALUE', '100', 'Order', 'Mapping', 10, 'Mapping Burrito-shipped orders for affiliates', '2023-06-01 00:00:00', '2023-03-27 21:49:39', 'UserX', NULL, NULL),
('TenantId', 'randomstringoflettersandnumbers', 'value,value,value,value', 'API', 'API', 10, ' AadTenantId', '2023-06-10 15:21:48', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('AccessToken', '{\"iv\":\"53595494006c2907dc54c0b0afa10f9e\",\"encryptedData\":\"N/A",\"key\":{\"type\":\"Buffer\",\"data\":140,151,11,2,7,78,211,19,18,96}}', '200,201,210', 'Order', 'API', 12, '168935908920', '2023-06-16 17:04:59', '2023-06-16 11:04:58', 'object Object', NULL, NULL),
('ClientId', '14c767fd-b54b-4470-9ee9-acdcd9c8a0b1', '200,201,210', 'API', 'API', 10, ' ClientId', '2022-05-13 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('ClientSecret', 'N/A', '200,201,210', 'API', 'API', 10, ' Client Secret', '2022-05-13 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('Environment', 'SandBx_holi_UAT_05122023', '200,201,210,211,212', 'API', 'API', 10, 'Environment name', '2022-05-13 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('MarketShipAgent', 'WILL CALL', '210', 'Shipping Info', 'Mapping', 10, 'Mapping shipping agents by market', '2022-03-27 00:00:00', '2023-03-27 21:39:10', 'UserX', NULL, NULL),
('OrderLineSequenceInterval', '10000', '210', 'Order', 'Line', 2, '16384 is the GP default value', '2023-04-21 00:18:23', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OrderShipAdvice', 'PARTIAL', '210', 'Order', 'ShippingAdvice', 10, 'Shipping advice override', '2023-06-28 18:03:05', '2023-06-28 18:03:04', 'UserX', NULL, NULL),
('OrderSummarySku', 'PRODUCT', '210', 'Order', 'Lines', 2, 'Put the  SKU here if wanting to summarize all regular items into a single orderline in ', '2023-09-14 00:00:00', '2023-09-14 00:00:00', 'UserX', NULL, NULL),
('PaymentMethods', '', '211', 'Payment', 'Methods', 12, ' Payment methods per company', '2023-09-06 00:00:00', '2023-09-06 00:00:00', 'UserX', NULL, NULL),
('PaymentMethodsFetchFrequency', '604800', '211', 'Payment', 'Methods', 2, 'Number of seconds before refetching payment methods from ', '2023-09-06 00:00:00', '2023-09-06 00:00:00', 'UserX', NULL, NULL),
('PmtJournalBatchName', 'Burrito', '211', 'Payment', 'Cash Receipt', 10, 'For  ', '2023-01-03 00:00:00', '2023-01-03 22:19:20', 'UserX', NULL, NULL),
('PmtJournalTemplateName', 'CASHRCPT', '211', 'Payment', 'Cash Receipt', 10, 'For cashreceipts', '2022-01-03 00:00:00', '2023-01-03 22:19:20', 'UserX', NULL, NULL),
('Scope', 'https://api.example.com/.default', '200,201,210', 'Order', 'API', 10, 'Auth scope', '2023-06-15 19:13:24', '2023-06-15 12:54:22', 'NCox', NULL, NULL),
('StatesToCountries', 'PRI', '210', 'Order', 'Mapping', 10, 'Mapping specific states to countries BurritoTo', '2022-03-25 00:00:00', '2023-03-25 19:25:14', 'UserX', NULL, NULL),
('Burrito3PLEnvironmentFlag', 'T', '310', 'Ship', '3PL Burrito', 10, 'Environment variable \"P\"roduction or \"T\"est', '2023-08-30 00:00:00', '2023-08-30 00:00:00', 'UserX', NULL, NULL),
('Burrito3PLFolders', 'Incoming=WarehouseTracking;Processed=WarehouseTrackingCompleted;Failed=WarehouseTrackingFailed;Out;ing=BurritoFTP', '310,311', '3PL', 'File', 10, 'file folder....', '2023-04-04 00:00:00', '2023-04-04 17:20:45', 'UserX', NULL, NULL),
('Burrito3PLIncomingFolder', 'Burrito Samples/ToProcess', '310', 'Ship', '3PL Burrito', 10, 'Incoming folder for Burrito 3PL response file processing', '2023-03-07 00:00:00', '2023-03-07 14:56:27', 'UserX', NULL, NULL),
('Burrito3PLParseFileExt', '*.txt', '311', '3PL', 'File extension', 10, 'Single File extension for Burrito 3PL incoming shipping files to process', '2023-08-28 00:00:00', '2023-08-28 00:00:00', 'UserX', NULL, NULL),
('Burrito3PLShippingCodes', '{\"Burritoada Post Standard\": \"10\", \"Burritoada Post Express\": \"11\"}', '310', '3PL', 'Shipping codes', 12, 'Out;ing 3PL shipping codes', '2023-08-28 00:00:00', '2023-08-28 00:00:00', 'UserX', NULL, NULL),
('CrmPullPaymentThresholdVariance', '1.01', '100', 'Order', 'Validation', 7, 'Allowed variance', '2021-01-01 00:00:00', '2020-09-02 00:00:00', 'nm', NULL, NULL),
('ErpCmGlAccountNumbers', 'TAX=2400;SHIPPING=4400;other=4500', '210', 'Order', 'CreditMemo', 10, 'Gl Account nbrs to use for CM categories', '2023-05-10 00:00:00', '2023-05-10 20:34:50', 'UserX', NULL, NULL),
('ErpPushOrdCalcThresholdVariance', '0.05', '210', 'Order', 'Validation', 7, 'Allowed variance', '2021-01-01 00:00:00', '2020-09-02 00:00:00', 'nm', NULL, NULL),
('BurritoApi', '{\"Url\": \"https://example.examplesite.com/3.0/exampleApi.asmx\",\"Company\": \"holi\",\"Username\": \"..testing123..\",\"Password\": \"....\"}', '111', 'ReturnOrder', 'Burrito Push', 12, 'Burrito API params', '2023-03-02 00:00:00', '2023-03-23 00:00:00', 'UserX', NULL, NULL),
('BurritoSkuMapping', 'CMPREVENUE=1014-UNV|1014-UNV-01', '210', 'Order', 'Line', 10, 'list of key-value pairs where the values are separated by pipe (|) char.  Skus on the left (key) and Burrito Skus on the right (value)', '2023-09-26 00:00:00', '2023-09-26 22:23:30', 'UserX', NULL, NULL),
('BurritoPromoAltSKUs', 'holi+ Free Shipping Discount=SHIPPING', '210', 'Order', 'Line', 10, 'dict key is Promo description and value is ALT SKU to use in ERP', '2022-08-09 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('BurritoPromoCatchAll', 'PROMO-PRODUCTS', '210', 'Order', 'Sku', 10, 'When Alt Skus do not match, use this one', '2023-05-02 14:11:05', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('BurritoPromoSKU', 'Promo', '210', 'Order', 'Line', 10, 'Single Burrito promotional SKU', '2022-08-09 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('BurritoRoOrderStatusToSet', 'Pending', '100', 'Order', 'BurritoApi', 10, 'OrderStatus to set the pulled unshipped order in Burrito', '2023-07-17 20:04:15', '2023-07-17 20:04:15', 'UserX', NULL, NULL),
('BurritoSkusToSkipPush', 'VR', '210', 'Order', 'Line', 10, 'List of delimited SKUs to skip on push of orderlines to  ERP', '2023-01-18 00:00:00', '2023-01-18 15:52:08', 'UserX', NULL, NULL),
('BurritoToPaymentTypes', 'Cash=S-CASH;Credit Card=S-CARD;', '211', 'Order', 'API', 10, 'Payment type mapping from Burrito', '2022-05-20 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('BurritoToShippingAgentCodes', 'Pick-Up=WILL-CALL~;Surepost=UPS~SUREPOST LESS THAN 1 LB;Surepost+=UPS~SUREPOST 1 LB OR GREATER;UPS 2nd Day=UPS~2ND DAY AIR;UPS Ground=UPS~GROUND;UPS Next Day=UPS~NEXT DAY AIR;USPS - Priority=USPOSTAL~PRIORITY-PARCEL;USPS 1st Class=USPOSTAL~FIRST-PARCEL;USPS (Avg 30-45 day delivery)=USPOSTAL~PARCELSELECT-PARCEL;International 1st class (Avg 30-45 day delivery)=USPOSTAL~FIRST-PARCEL;', '210', 'Order', 'Shipping', 10, 'Mapping shipping agent codes from Burrito', '2022-08-10 00:00:00', '2023-01-02 22:31:33', 'UserX', NULL, NULL),
('FileShareRoot', '/example/path/', '310,311,320,321', 'Ship', '3PL Proc', 10, 'FileShare root folder for 3PL response file processing', '2023-03-07 00:00:00', '2023-03-07 14:56:27', 'UserX', NULL, NULL),
('ImportCrmOrderNegativePayments', 'true', '100', 'Order', 'Payment', 1, 'Import CRM Order Payments with a negative amount', '2020-12-20 00:00:00', '2020-12-21 00:00:00', 'UserX', NULL, NULL),
('ImportIgnoreOrderTypes', '8', '100', 'Order', 'Select', 10, 'list of ordertypes to ignore', '2021-11-10 00:00:00', '2021-11-10 00:00:00', 'UserX', NULL, NULL),
('LastTimeShippigInfoWasImportedFrom', '2023-07-17T17:03:55.20Z', '200', 'Shipping', 'Shipped detail', 8, 'Fetch shipping info (posted packages) from ERP ()', '2023-01-01 00:00:00', '2023-01-30 00:00:00', 'UserX', NULL, NULL),
('OnlyImportOrdersOverAmount', '0.00', '100', 'Order', 'Select', 5, 'Minimum amount of order to consider importing', NULL, '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OnlyImportOrderStatusCodes', '7', '100', 'Order', 'Select', 10, 'comma separated codes-values: n/a', '2021-10-25 00:00:00', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OrderPullAllowMoneyMismatch', 'true', '100', 'Order', 'Header', 1, 'description', '2023-06-07 20:52:34', '2023-06-07 20:52:33', 'UserX', NULL, NULL),
('OrderPullBatchsize', '500', '100,101', 'Order', 'Select', 2, NULL, '2021-01-01 00:00:00', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OrderPullDaysBack', '4', '100,101', 'Order', 'Select', 2, NULL, NULL, '2020-09-22 00:00:00', 'UserX', NULL, NULL),
('OrderPullHourDelay', '2', '100', 'Order', 'Header', 2, 'Number of hour delay for unshipped orders', '2023-01-01 00:00:00', '2023-01-01 00:00:00', 'UserX', NULL, NULL),
('OrderPullLastDate', '', '100', 'Order', 'Select', 8, 'description', '2021-10-18 00:00:00', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OrderPullMinOrderNumber', '51800000', '100,101,102', 'Order', 'Select', 2, 'Only pull order#s > than this value. Use 0 to turn this off', '2021-10-15 00:00:00', '2021-10-26 00:00:00', 'UserX', NULL, NULL),
('OrderPullPickupShipMethodIds', '8,18,23', '100', 'Order', 'Selection', 10, 'Limit to these Burrito pickup ship methods', '2023-08-28 00:00:00', '2023-08-28 21:49:39', 'UserX', NULL, NULL),
('OrderPushBatchSize', '200', '210', 'Order', 'Select', 2, NULL, '2021-10-15 00:00:00', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('OrdersPushFetchSize', '165', '210', 'Order', 'Batch', 2, 'Number of orders to fetch for building a batch', '2021-01-01 00:00:00', '2020-09-20 00:00:00', 'UserX', NULL, NULL),
('OverrideOrderShipmethodWithDefault', 'false', '210', 'Order', 'Header', 1, NULL, '2021-01-01 00:00:00', '2020-06-10 20:14:49', 'UserX', NULL, NULL),
('PaymentsBatchFetchSize', '60', '211', 'Payment', NULL, 2, 'TOP x Payments to fetch for pushing to ERP', '2023-01-14 10:36:51', '2023-01-14 10:36:50', 'UserX', NULL, NULL),
('PHL3PLFolders', 'Incoming=WarehouseTracking;Processed=WarehouseTrackingCompleted;Failed=WarehouseTrackingFailed;Out;ing=BurritoFTP', '320,321', '3PL', 'File', 10, 'file folder....', '2023-04-04 00:00:00', '2023-04-04 17:23:02', 'UserX', NULL, NULL),
('PushCountriesForTaxId', 'PH', '100', 'Customer', 'Tax', 10, 'County list for pulling customer TaxId', '2023-01-02 22:23:30', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('RemoveNegPosCancelOutLines', 'True', '100', 'Order', 'Line', 1, 'Remove matching negative and positive lines that cancel each other out', '2022-08-07 00:00:00', '2023-01-02 22:23:30', 'UserX', NULL, NULL),
('StagingIgnoreAddresses', 'false', '100,101', 'Order', 'Header', 1, 'Ignore addresses on pull', '2020-10-20 00:00:00', '2020-10-25 00:00:00', 'UserX', NULL, NULL),
('UseLastPaymentDateForOrder', 'true', NULL, 'Order', 'Header', 1, 'Use Last payment date for the order date. ;od for partial paid orders or stale orders that sat in shopping cart', '2021-09-01 00:00:00', '2021-09-01 00:00:00', 'UserX', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AppParams`
--
ALTER TABLE `AppParams`
  ADD PRIMARY KEY (`Name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
