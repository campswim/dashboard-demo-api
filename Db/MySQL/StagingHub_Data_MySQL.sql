USE campswim_StagingHub
;
-- INSERT PushStatuses (Name) VALUES ('Sent')
-- ;
-- INSERT PushStatuses (Name) VALUES ('Failed')
-- ;
-- INSERT PushStatuses (Name) VALUES ('Ignored')
-- ;
-- INSERT PushStatuses (Name) VALUES ('Placeholder')
-- ;

INSERT ShippedOrderSources (Name) VALUES ('CRM-company')
;
INSERT ShippedOrderSources (Name) VALUES ('company-ERP')
;
INSERT ShippedOrderSources (Name) VALUES ('3PL-CAN')
;
INSERT ShippedOrderSources (Name) VALUES ('3PL-PHL')
;

-- INSERT AppParamValueTypes (Type) VALUES (N'bool')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'int')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'long')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'byte')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'float')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'double')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'decimal')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'DateTime')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'char')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'string')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'object')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'JSON')
-- ;
-- INSERT AppParamValueTypes (Type) VALUES (N'XML')
-- ;

DELETE FROM Maps
;
DELETE FROM Users
;
DELETE FROM Roles
;
DELETE FROM AppParams
;
DELETE FROM AppParamValueTypes
;

INSERT AppParamValueTypes (Id, Type) VALUES (1, N'bool')
;
INSERT AppParamValueTypes (Id, Type) VALUES (2, N'int')
;
INSERT AppParamValueTypes (Id, Type) VALUES (3, N'long')
;
INSERT AppParamValueTypes (Id, Type) VALUES (4, N'byte')
;
INSERT AppParamValueTypes (Id, Type) VALUES (5, N'float')
;
INSERT AppParamValueTypes (Id, Type) VALUES (6, N'double')
;
INSERT AppParamValueTypes (Id, Type) VALUES (7, N'decimal')
;
INSERT AppParamValueTypes (Id, Type) VALUES (8, N'DateTime')
;
INSERT AppParamValueTypes (Id, Type) VALUES (9, N'char')
;
INSERT AppParamValueTypes (Id, Type) VALUES (10, N'string')
;
INSERT AppParamValueTypes (Id, Type) VALUES (11, N'object')
;
INSERT AppParamValueTypes (Id, Type) VALUES (12, N'JSON')
;
INSERT AppParamValueTypes (Id, Type) VALUES (13, N'XML')
;

INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'AfilliateWarehouseMap', N'SC-SHIPOFFRR=SHIPOFFERS', N'100', N'Order', N'Mapping', 10, N'Mapping company shipped orders for affiliates', CAST(N'2023-06-01T00:00:00.0000000' AS datetime), CAST(N'2023-03-27T21:49:39.8400000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPAadTenantId', N'SampleNumber', N'200,201,210,211,212', N'ERPAPI', N'API', 10, N'D365 ERP AADTenantId', CAST(N'2023-06-10T1:21:48.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'AccessToken', N'{"iv":"SampleToken","encryptedData":"SampleData","key":{"type":"Buffer","data":140,151,11,2,7,78,211,19,18,96,11,88,119,221,199,21,84,183,240,118,102,57,213,92,25,74,116,27,217,173,122,31}}', N'200,201,210,211,212', N'Order', N'API', 12, N'1689359089208', CAST(N'2023-06-16T17:04:59.0000000' AS datetime), CAST(N'2023-06-16T11:04:58.8700000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPClientId', N'SampleNumber', N'200,201,210,211,212', N'ERPAPI', N'API', 10, N'D365 ERP ClientId', CAST(N'2022-05-13T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPClientSecret', N'SampleSecret', N'200,201,210,211,212', N'ERPAPI', N'API', 10, N'D365 ERP Client Secret', CAST(N'2022-05-13T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPEnvironment', N'SandBx_CLIENT_Sample_Numbers', N'200,201,210,211,212', N'ERPAPI', N'API', 10, N'D365 ERP environment name', CAST(N'2022-05-13T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPMarketShipAgent', N'US=,PH=WILL CALL', N'210', N'Shipping Info', N'Mapping', 10, N'Mapping shipping agents by market', CAST(N'2022-03-27T00:00:00.0000000' AS datetime), CAST(N'2023-03-27T21:39:10.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPOrderLineSequenceInterval', N'10000', N'210', N'Order', N'Line', 2, N'16384 is the ERP default value', CAST(N'2023-04-21T00:18:23.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPOrderShipAdvice', N'PH=PARTIAL;CA=PARTIAL', N'210', N'Order', N'ShippingAdvice', 10, N'Shipping advice override', CAST(N'2023-06-28T18:03:05.0000000' AS datetime), CAST(N'2023-06-28T18:03:04.8600000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPPaymentMethodsFetchFrequency', N'604800', N'211', N'Payment', N'Methods', 2, N'Number of seconds before refetching payment methods from ERP', CAST(N'2023-09-06T00:00:00.0000000' AS datetime), CAST(N'2023-09-06T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPPaymentMethods', N'', N'211', N'Payment', N'Methods', 12, N'ERP Payment methods per company', CAST(N'2023-09-06T00:00:00.0000000' AS datetime), CAST(N'2023-09-06T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPPmtJournalBatchName', N'company', N'211', N'Payment', N'Cash Receipt', 10, N'For  ', CAST(N'2023-01-03T00:00:00.0000000' AS datetime), CAST(N'2023-01-03T22:19:20.0600000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPPmtJournalTemplateName', N'CASHRCPT', N'211', N'Payment', N'Cash Receipt', 10, N'For cashreceipts', CAST(N'2022-01-03T00:00:00.0000000' AS datetime), CAST(N'2023-01-03T22:19:20.0600000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPScope', N'https://api.samplesite.com/.default', N'200,201,210,211,212', N'Order', N'API', 10, N'D365 ERP auth scope', CAST(N'2023-06-15T19:13:24.0000000' AS datetime), CAST(N'2023-06-15T12:54:22.9100000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPStatesToCountries', N'GU=GUM
PR=PRI', N'210', N'Order', N'Mapping', 10, N'Mapping specific states to countries companyToERP', CAST(N'2022-03-25T00:00:00.0000000' AS datetime), CAST(N'2023-03-25T19:25:14.3900000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CAN3PLFolders', N'Incoming=Warehouse\Tracking\CAN;Processed=Warehouse\Tracking\CAN\Completed;Failed=Warehouse\Tracking\CAN\Failed;Out;ing=companyFTP\CAN', N'310,311', N'3PL', N'File', 10, N'file folder....', CAST(N'2023-04-04T00:00:00.0000000' AS datetime), CAST(N'2023-04-04T17:20:45.8900000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CAN3PLIncomingFolder', N'CAN Samples/ToProcess', N'310', N'Ship', N'3PL CAN', 10, N'Incoming folder for CAN 3PL response file processing', CAST(N'2023-03-07T00:00:00.0000000' AS datetime), CAST(N'2023-03-07T14:56:27.9500000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CAN3PLEnvironmentFlag', N'T', N'310', N'Ship', N'3PL CAN', 10, N'Environment variable "P"roduction or "T"est', CAST(N'2023-08-30T00:00:00' AS datetime), CAST(N'2023-08-30T00:00:00' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CAN3PLShippingCodes', N'{"Canada Post Standard": "10", "Canada Post Express": "11"}', N'310', N'3PL', N'Shipping codes', 12, N'Out;ing 3PL shipping codes', CAST(N'2023-08-28T00:00:00.0000000' AS datetime), CAST(N'2023-08-28T00:00:00.00000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CAN3PLParseFileExt', N'*.txt', N'311', N'3PL', N'File extension', 10, N'Single File extension for CAN 3PL incoming shipping files to process', CAST(N'2023-08-28T00:00:00.0000000' AS datetime), CAST(N'2023-08-28T00:00:00.00000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'CrmPullPaymentThresholdVariance', N'1.01', N'100', N'Order', N'Validation', 7, N'Allowed variance', CAST(N'2021-01-01T00:00:00.0000000' AS datetime), CAST(N'2020-09-02T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ErpCmGlAccountNumbers', N'TAX=001;SHIPPING=002;other=003', N'210', N'Order', N'CreditMemo', 10, N'Gl Account nbrs to use for CM categories', CAST(N'2023-05-10T00:00:00.0000000' AS datetime), CAST(N'2023-05-10T20:34:50.1900000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ErpPushOrdCalcThresholdVariance', N'0.05', N'210', N'Order', N'Validation', 7, N'Allowed variance', CAST(N'2021-01-01T00:00:00.0000000' AS datetime), CAST(N'2020-09-02T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyApi', N'{"Url": "https://sandboxapi.company.com/3.0/companyApi.asmx","Company": "CLIENT","Username": "..testing123..","Password": "...."}', N'111', N'ReturnOrder', N'company Push', 12, N'company API params', CAST(N'2023-03-02T00:00:00.0000000' AS datetime), CAST(N'2023-03-23T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyPromoAltSKUs', N'CLIENT+ Free Shipping Discount=SHIPPING', N'210', N'Order', N'Line', 10, N'dict key is Promo description and value is ALT SKU to use in ERP', CAST(N'2022-08-09T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyERPSkuMapping', N'CMPREVENUE=1016-UNV|1016-UNV-01|1024-UNV|1016-UNV-BLK,CONFERENCE TICKET=EVCON-UNIV-2023|EVVCON-UNIV-2023,MEMBERSHIPFEE=19819801|19819802|MemberShipFee-US|MembershipFee-CA|MemberShipFee-PH,REWARD TRIP=EVCRS-UNIV-24-01|77EVCRS-UNIV-24-02|EVCRS-UNIV-24-03,SHIPPING=1011-UNIV|10246-UNIV|BN-5022-US|BN-5022-CA|BN-5023-PH|REFUSALFEE-UNIV|INTERCEPTFEE-US|REROUTEFEE-US|REROUTEOOS-US', N'210', N'Order', N'Line', 10, N'list of key-value pairs where the values are separated by pipe (|) char. ERP Skus on the left (key) and company Skus on the right (value)', CAST(N'2023-09-26T00:00:00.0000000' AS datetime), CAST(N'2023-09-26T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyPromoCatchAll', N'PROMO-PRODUCTS', N'210', N'Order', N'Sku', 10, N'When Alt Skus do not match, use this one', CAST(N'2023-05-02T14:11:05.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyPromoSKU', N'Promo', N'210', N'Order', N'Line', 10, N'Single company promotional SKU', CAST(N'2022-08-09T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyRoOrderStatusToSet', N'Pending', N'100', N'Order', N'companyApi', 10, N'OrderStatus to set the pulled unshipped order in company', CAST(N'2023-07-17T20:04:15.0000000' AS datetime), CAST(N'2023-07-17T20:04:15.2300000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companySkusToSkipPush', N'VR', N'210', N'Order', N'Line', 10, N'List of delimited SKUs to skip on push of orderlines to ERP', CAST(N'2023-01-18T00:00:00.0000000' AS datetime), CAST(N'2023-01-18T15:52:08.8000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyToERPPaymentTypes', N'Cash=S-CASH;Credit Card=S-CARD;CLIENT Cash (USD)=S-CLIENTCASH;CLIENT Cash (AU)(USD)=S-CLIENTCASH;CLIENT Cash (CAN)=S-CLIENTCASH;CLIENT Cash (PHL)=S-CLIENTCASH;CLIENT Bonus (USD)=S-BONUS;CLIENT Bonus (CAN)=S-BONUS;CLIENT Bonus (PHL)=S-BONUS;CLIENT Rewards (AU/USA)=S-REWARD;CLIENT Rewards (CAN)=S-REWARD;CLIENT Rewards (PHL)=S-REWARD;AmazonPay=S-Amazon;Wallet=S-Amazon', N'211', N'Order', N'API', 10, N'Payment type mapping from company to ERP', CAST(N'2022-05-20T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'companyToERPShippingAgentCodes', N'Pick-Up=WILL-CALL~;Surepost=UPS~SUREPOST LESS THAN 1 LB;Surepost+=UPS~SUREPOST 1 LB OR GREATER;UPS 2nd Day=UPS~2ND DAY AIR;UPS Ground=UPS~GROUND;UPS Next Day=UPS~NEXT DAY AIR;USPS - Priority=USPOSTAL~PRIORITY-PARCEL;USPS 1st Class=USPOSTAL~FIRST-PARCEL;USPS (Avg 30-45 day delivery)=USPOSTAL~PARCELSELECT-PARCEL;International 1st class (Avg 30-45 day delivery)=USPOSTAL~FIRST-PARCEL;Canada Post Express=CANP~CANP-EXPRESS;Canada Post Standard=CANP~CANP-STANDARD;LBC=LBC~;Philippines Office Pickup=WILL-CALL~', N'210', N'Order', N'Shipping', 10, N'Mapping shipping agent codes from companyToERP', CAST(N'2022-08-10T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:31:33.5500000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'FileShareRoot', N'/Users/User/Downloads/', N'310,311,320,321', N'Ship', N'3PL Proc', 10, N'FileShare root folder for 3PL response file processing', CAST(N'2023-03-07T00:00:00.0000000' AS datetime), CAST(N'2023-03-07T14:56:27.9500000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ImportCrmOrderNegativePayments', N'true', N'100', N'Order', N'Payment', 1, N'Import ERP Order Payments with a negative amount', CAST(N'2020-12-20T00:00:00.0000000' AS datetime), CAST(N'2020-12-21T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ImportIgnoreOrderTypes', N'8', N'100', N'Order', N'Select', 10, N'Comma separated list of ordertypes to ignore', CAST(N'2021-11-10T00:00:00.0000000' AS datetime), CAST(N'2021-11-10T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'LastTimeShippigInfoWasImportedFromERP', N'2023-07-17T17:03:55.20Z', N'200', N'Shipping', N'Shipped detail', 8, N'Fetch shipping info (posted packages) from ERP', CAST(N'2023-01-01T00:00:00.0000000' AS datetime), CAST(N'2023-01-30T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OnlyImportOrdersOverAmount', N'0.00', N'100', N'Order', N'Select', 5, N'Minimum amount of order to consider importing', NULL, CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OnlyImportOrderStatusCodes', N'7', N'100', N'Order', N'Select', 10, N'comma separated codes-values: 2,3,4,5,7,8,13', CAST(N'2021-10-25T00:00:00.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullAllowMoneyMismatch', N'true', N'100', N'Order', N'Header', 1, N'Whether we allow orders pulled where there is a mismatch in ordertotal vs sum of payment(s)', CAST(N'2023-06-07T20:52:34.0000000' AS datetime), CAST(N'2023-06-07T20:52:33.8600000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullBatchsize', N'500', N'100,101', N'Order', N'Select', 2, NULL, CAST(N'2021-01-01T00:00:00.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullDaysBack', N'4', N'100,101', N'Order', N'Select', 2, NULL, NULL, CAST(N'2020-09-22T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullHourDelay', N'2', N'100', N'Order', N'Header', 2, N'Number of hour delay for unshipped orders', CAST(N'2023-01-01T00:00:00.0000000' AS datetime), CAST(N'2023-01-01T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullLastDate', N'', N'100', N'Order', N'Select', 8, N'Last date of order pull from source system', CAST(N'2021-10-18T00:00:00.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullMinOrderNumber', N'51800000', N'100,101,102', N'Order', N'Select', 2, N'Only pull order#s > than this value. Use 0 to turn this off', CAST(N'2021-10-15T00:00:00.0000000' AS datetime), CAST(N'2021-10-26T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPushBatchSize', N'200', N'210', N'Order', N'Select', 2, NULL, CAST(N'2021-10-15T00:00:00.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrdersPushFetchSize', N'165', N'210', N'Order', N'Batch', 2, N'Number of orders to fetch for building a batch', CAST(N'2021-01-01T00:00:00.0000000' AS datetime), CAST(N'2020-09-20T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OverrideOrderShipmethodWithDefault', N'false', N'210', N'Order', N'Header', 1, NULL, CAST(N'2021-01-01T00:00:00.0000000' AS datetime), CAST(N'2020-06-10T20:14:49.6800000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'PaymentsBatchFetchSize', N'60', N'211', N'Payment', NULL, 2, N'TOP x Payments to fetch for pushing to ERP', CAST(N'2023-01-14T10:36:51.0000000' AS datetime), CAST(N'2023-01-14T10:36:50.6300000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'PHL3PLFolders', N'Incoming=Warehouse\Tracking\PHI;Processed=Warehouse\Tracking\PHI\Completed;Failed=Warehouse\Tracking\PHI\Failed;Out;ing=companyFTP\PHI', N'320,321', N'3PL', N'File', 10, N'file folder....', CAST(N'2023-04-04T00:00:00.0000000' AS datetime), CAST(N'2023-04-04T17:23:02.1900000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'PushCountriesForTaxId', N'PH', N'100', N'Customer', N'Tax', 10, N'County list for pulling customer TaxId', CAST(N'2023-01-02T22:23:30.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'RemoveNegPosCancelOutLines', N'True', N'100', N'Order', N'Line', 1, N'Remove matching negative and positive lines that cancel each other out', CAST(N'2022-08-07T00:00:00.0000000' AS datetime), CAST(N'2023-01-02T22:23:30.2200000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'StagingIgnoreAddresses', N'false', N'100,101', N'Order', N'Header', 1, N'Ignore addresses on pull', CAST(N'2020-10-20T00:00:00.0000000' AS datetime), CAST(N'2020-10-25T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'UseLastPaymentDateForOrder', N'true', NULL, N'Order', N'Header', 1, N'Use Last payment date for the order date. ;od for partial paid orders or stale orders that sat in shopping cart', CAST(N'2021-09-01T00:00:00.0000000' AS datetime), CAST(N'2021-09-01T00:00:00.0000000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'OrderPullPickupShipMethodIds', N'8,18,23', N'100', N'Order', N'Selection', 10, N'Limit to these company pickup ship methods', CAST(N'2023-08-28T00:00:00.0000000' AS datetime), CAST(N'2023-08-28T21:49:39.8400000' AS datetime), 1)
;
INSERT AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedAt, CreatedBy) VALUES (N'ERPOrderSummarySku', N'PRODUCT', N'210', N'Order', N'Lines', 2, N'Put the ERP SKU here if wanting to summarize all regular items into a single orderline in ERP', CAST(N'2023-09-14T00:00:00.0000000' AS datetime), CAST(N'2023-09-14T00:00:00.0000000' AS datetime), 1)
;


INSERT Roles (Id, Role, RestrictedPages, RestrictedActions) VALUES (1, N'Admin', N'None', N'None')
;
INSERT Roles (Id, Role, RestrictedPages, RestrictedActions) VALUES (11, N'Agent', N'Users, Settings', N'Delete')
;
INSERT Roles (Id, Role, RestrictedPages, RestrictedActions) VALUES (21, N'User', N'Users, Settings', N'All')
;

INSERT Users (Email, Name, Hash, Role, DateRegistered, LastLogin, LoggedIn, FailedAttempts, Active) VALUES (N'nrc4@hotmail.com', N'Nate Cox', N'$2a$12$bcbTc5wT9JSkH0xUFgLAouniqqm7xDLo9aH06l63HZFmTtuyPnP82', 1, CAST(N'2023-06-23T16:55:13.177' AS DateTime), CAST(N'2023-07-13T21:40:29.963' AS DateTime), 1, 0, 1)
;
INSERT Users (Email, Name, Hash, Role, DateRegistered, LastLogin, LoggedIn, FailedAttempts, Active) VALUES (N'example@sasha.rad', N'Sasha', N'$2a$12$ZUnPMVQ0zbVt8CSSjf9vVOW6Uc0pojXmFidxzL5Dbiy8UUvXCs1Ti', 21, CAST(N'2023-06-23T19:14:38.067' AS DateTime), CAST(N'2023-06-29T17:05:32.703' AS DateTime), 0, 0, 1)
;
INSERT Users (Email, Name, Hash, Role, DateRegistered, LastLogin, LoggedIn, FailedAttempts, Active) VALUES (N'real.neal@neal.real', N'Nigel Cooks', N'$2a$12$FhS7miw2gaaDxf2oCDR09.5AcHqOMkPksBFsMcOYP/gSdGwHFXp.y', 11, CAST(N'2023-06-23T19:15:07.800' AS DateTime), CAST(N'2023-06-29T17:45:22.090' AS DateTime), 0, 0, 1)
;

INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy, ModifiedAt, ModifiedBy) VALUES (1, N'US', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'1', NULL, N'DC-USASLC', N'DC-USARTRN', 0, 1, 1, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0330000' AS datetime), 1, CAST(N'2023-06-27T19:02:24.4470000' AS datetime), 1)
;
INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy) VALUES (2, N'CA', N'b242ba0f-ff51-ec11-9f08-000d3a14a707', N'CAD', N'CAD', N'2', NULL, N'DC-CA', N'DC-CARTRN', 0, 1, 2, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0400000' AS datetime), 1)
;
INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy) VALUES (3, N'AU', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'4', NULL, N'DC-USASLC', N'DC-USARTRN', 0, NULL, 4, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0400000' AS datetime), 1)
;
INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy) VALUES (4, N'PH', N'34195264-ff51-ec11-9f08-000d3a14a707', N'PHP', N'PHP', N'5', NULL, N'DC-PHL', N'DC-PHLRTRN', 1, 1, 3, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0700000' AS datetime), 1)
;
INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy) VALUES (5, N'PH', N'34195264-ff51-ec11-9f08-000d3a14a707', N'PHP', N'PHP', N'5', N'Philippines Office Pickup', N'DC-PHLWC', N'DC-PHLRTRN', 1, NULL, 3, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0730000' AS datetime), 1)
;
INSERT Maps (Id, IsoCountryCode, ErpCompanyId, IsoCurrencyCode, ErpCurrencyCode, SourceWarehouse, SourceShipMethod, DestinationWarehouse, ReturnsWarehouse, IsVAT, UseForErpPull, ProcessingSequence, ActivatedAt, DeactivatedAt, CreatedAt, CreatedBy) VALUES (6, N'US', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'6', NULL, N'DC-EVENTS', N'DC-USARTRN', 0, NULL, 1, CAST(N'2023-01-01T00:00:00.0000000' AS datetime), NULL, CAST(N'2023-01-02T23:11:19.0800000' AS datetime), 1)
;

INSERT ProcessJobs (Id, Name, ExternalSystem, DataDirection)
VALUES 
 (100,'Pull Unshipped Orders','company','IN')
, (101,'Pull Shipped Orders','company','IN')
, (102,'Pull Fee Orders','company','IN')
, (103,'Pull Completed ReturnOrders','company','IN')
, (110,'Push Tracking Info','company','OUT')
, (111,'Push ReturnOrders','company','OUT')

, (200,'Pull Tracking info','ERP','IN')
, (201,'Pull ReturnOrders','ERP','IN')
, (210,'Push Orders/Customers','ERP','OUT')
, (211,'Push Cash Receipts','ERP','OUT')
, (212,'Push Shipping Info','ERP','OUT')

, (310,'Generate File Can','CCLS','OUT')
, (311,'Parse File Can','CCLS','IN')
, (320,'Generate File Phl','LBC','OUT')
, (321,'Parse File Phl','LBC','IN')