USE [sql3684435]

SET IDENTITY_INSERT [dbo].PushStatuses ON 
GO
INSERT dbo.PushStatuses VALUES ('Sent')
GO
INSERT dbo.PushStatuses VALUES ('Failed')
GO
INSERT dbo.PushStatuses VALUES ('Ignored')
GO
INSERT dbo.PushStatuses VALUES ('Placeholder')
GO
SET IDENTITY_INSERT [dbo].PushStatuses OFF
GO

INSERT dbo.ShippedOrderSources VALUES (1,'CRM-Exigo')
GO
INSERT dbo.ShippedOrderSources VALUES (2,'ERP-BusinessCentral')
GO
INSERT dbo.ShippedOrderSources VALUES (3,'3PL-CAN')
GO
INSERT dbo.ShippedOrderSources VALUES (4,'3PL-PHL')
GO

SET IDENTITY_INSERT [dbo].[Modules] ON 
GO
INSERT [dbo].[Modules] ([Id], [Name]) VALUES (1, N'Pull/Source')
GO
INSERT [dbo].[Modules] ([Id], [Name]) VALUES (2, N'Push/GP')
GO
INSERT [dbo].[Modules] ([Id], [Name]) VALUES (3, N'Common')
GO
INSERT [dbo].[Modules] ([Id], [Name]) VALUES (4, N'Dashboard')
GO
INSERT [dbo].[Modules] ([Id], [Name]) VALUES (5, N'Other')
GO
SET IDENTITY_INSERT [dbo].[Modules] OFF
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (1, N'bool')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (2, N'int')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (3, N'long')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (4, N'byte')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (5, N'float')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (6, N'double')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (7, N'decimal')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (8, N'DateTime')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (9, N'char')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (10, N'string')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (11, N'object')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (12, N'JSON')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (13, N'XML')
GO

GO
DELETE FROM [dbo].[Maps]
GO
DELETE FROM [dbo].[Users]
GO
DELETE FROM [dbo].[Roles]
GO
DELETE FROM [dbo].[AppParams]
GO
DELETE FROM [dbo].[AppParamValueTypes]
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (1, N'bool')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (2, N'int')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (3, N'long')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (4, N'byte')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (5, N'float')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (6, N'double')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (7, N'decimal')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (8, N'DateTime')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (9, N'char')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (10, N'string')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (11, N'object')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (12, N'JSON')
GO
INSERT [dbo].[AppParamValueTypes] ([Id], [Type]) VALUES (13, N'XML')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'AfilliateWarehouseMap', N'SC-SHIPOFR=SHIPOFFERS', N'100', N'Order', N'Mapping', 10, N'Mapping exigo shipped orders for affiliates', CAST(N'2023-06-01T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-27T21:49:39.8400000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcAadTenantId', N'39d40a19-5ff8-48fe-bdd9-5958ff0f8835', N'200,201,210,211,212', N'BCAPI', N'API', 10, N'D365 Business Central AADTenantId', CAST(N'2023-06-10T15:21:48.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcAccessToken', N'{"iv":"43595494006c2907dc54c0b0afa10f9e","encryptedData":"ce576c6b1f8af9d5cc14de4fb6df1bc5d72dfc3ab2c75854c03249bdd6cb040244ff5189859926b03ebc080dfce5ed36ccecc06673b045c73390964384ae490dfa8993782d0463567f095ff774ae5f2ab4be170e38f104c214e6253d0d03f92b97bdef23ae1d381d4a4cd906d826424e7af06566f28265aec9cd778a7887093417a9483dce19326d86f2bf32f721478aafac006178d28ff1974a39641db035d4ad11a1d4a01d8c6c6dcfe6887ba2b1721f33ec7675d9b6ca99a66e970a3525bb6c4a7d26b899455e39b57d9862dbe3d57e4406b42b2d9cc863b3b29562faf1b8488a69b96bca94727ee82f5b109204d1be76207dbffe96a18d483d31b49ff02bf189d46ba7bba0a97e3eda1db52df97dda6a34fb46911f129503241e3e38fd4aedb79c129495ac711608ae3a65101c59b244d0a4757209fa91b425e34b3055195cd96307ef154b40b85b56e02eb3e526ac8dedc586a2c8386b74dd27bc56692dda8604da9293dd427bb7410b9cf67779db1f331c00c474b685e85d55a4a14345b67c6625f3ff8cea83a0c97666d5b40d95cd92e72c6bd7f83ce37b2e543287008b98f161bfc40e7017627057b30cc67b031cb584f3a77b376a8303c74bd7cc2f053c3d49003378a3404c0f38edae1785b8bb0cf6b6ed0e5637570d16569f5813365f09b80985e34c9b1794d3d2d042da6b73aa6b4bfa479e61b513a194b616696458b7a1c6548e5689d18252decbff52be91d9db34f0413117713e635b49db62498354878fa4223a860d6d47fdf615c415c49d925c49c064a2dc79164e482e71ada4858469dac5aa4eff1e36ae9651c10c3aeb5f8c0a5cfc85f4b8e5d468ced75c34ae34eef400be380a2f2c909e499c38a4aa1811550058cc2a5d7fd34b04db2df211a7a42f72641c00eb748e726f6ad43adaa19f5c7fecb663e441c31deb014dc2aa02d4ca7c8813384e7d9eebb0197816421e966ab2cfcafc27fe9df9fe12ff9b529488a7ae24dc0d0ead86d158dfb17c30285aa080f9ee3cdd523d2fb5ef61fdfd875554d94d84077c06616b6c8d11418cf2b90007e9be0ec05252b5ebd88a1356a0514053dbd176fe0c0dfc31c50eb88f0e902c5f24bac27ff69cca4d79acd5ff93f639641a758c608cd83e19588c035d322e923a4cbd4b9e119d311a55c33465e3402c193ec436f069d98501ffe69e380bc3579a470e1a913fb9d311e7ae82e3ca0c14c1f8271c5d50b7fa7c8d636c3b05b2cce0462795c7d7e66de399a9b4b9e4d99c742e106e6f2c52b21902c1158bf95b45abb8aefad8d1147d1a90dce2ecc57c12844e25ce41a131038a299866038cb9160a4e6f40b655ea840df8d0825d8f20f0f9d2e9a3a2cf06e3b506c3a26ee1c5e4ed2d0020687ebfa0108d374b954ab79d74e22bd6de3e549a8b0ea892d9309071eb7b1283243b6ea64c35b987d4a2979473a40aa1c246f9465b59e2e127a677ecbf459ddb9e1a13d16c67a5a1e8610f9a701ef5fc33095c3080857a256043ded2508340e350768e9e8cfa793a6b1e399e4ec78da573b25fde3661074c32e5921e591b5ed4da4905530a0b708115783434010ee3112e14a582815a40ce2b933be51477865986813ba706040891486c27816be818a6b1a4a148927faf97793f186c3deba623b941f501bc5e2fbd5b83c70d6759c2ae23ec806749d640017d846f7d4a59e689526c834839a59e0567a48837bf6e7001d74b62707987daace60e93cf4d73925779ff252fcac9cb02e3174e4c2e65b38968841cd739387e21cdcf393619da93322f2550952071c78d6dedef14631b5ebbcf9aecc1b706a7edef157a28ad593f886173a35580118271e9bbd09769a2b86fe1dd1d10b365b2dd74a53d1f632a59921f69897d6f8b0022e0cff45e53bf2f00caeb982c504e","key":{"type":"Buffer","data":[140,151,11,2,7,78,211,19,18,96,11,88,119,221,199,21,84,183,240,118,102,57,213,92,25,74,116,27,217,173,122,31]}}', N'200,201,210,211,212', N'Order', N'API', 12, N'1689359089208', CAST(N'2023-06-16T17:04:59.0000000' AS DateTime2), CAST(N'2023-06-16T11:04:58.8700000' AS DateTime2), N'[object Object]')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcClientId', N'13c767fd-b54b-4470-9ee9-acdcd9c8a0b1', N'200,201,210,211,212', N'BCAPI', N'API', 10, N'D365 Business Central ClientId', CAST(N'2022-05-13T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcClientSecret', N'nN17Q~HJn3ABQhcfnKQG7UNymH3-HRQl9-PVt', N'200,201,210,211,212', N'BCAPI', N'API', 10, N'D365 Business Central Client Secret', CAST(N'2022-05-13T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcEnvironment', N'SandBx_YOLI_UAT_05122023', N'200,201,210,211,212', N'BCAPI', N'API', 10, N'D365 Business Central environment name', CAST(N'2022-05-13T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcMarketShipAgent', N'US=,PH=WILL CALL', N'210', N'Shipping Info', N'Mapping', 10, N'Mapping shipping agents by market', CAST(N'2022-03-27T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-27T21:39:10.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcOrderLineSequenceInterval', N'10000', N'210', N'Order', N'Line', 2, N'16384 is the GP default value', CAST(N'2023-04-21T00:18:23.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcOrderShipAdvice', N'PH=PARTIAL;CA=PARTIAL', N'210', N'Order', N'ShippingAdvice', 10, N'Shipping advice override', CAST(N'2023-06-28T18:03:05.0000000' AS DateTime2), CAST(N'2023-06-28T18:03:04.8600000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcPaymentMethodsFetchFrequency', N'604800', N'211', N'Payment', N'Methods', 2, N'Number of seconds before refetching payment methods from BC', CAST(N'2023-09-06T00:00:00.0000000' AS DateTime2), CAST(N'2023-09-06T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcPaymentMethods', N'', N'211', N'Payment', N'Methods', 12, N'BC Payment methods per company', CAST(N'2023-09-06T00:00:00.0000000' AS DateTime2), CAST(N'2023-09-06T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcPmtJournalBatchName', N'EXIGO', N'211', N'Payment', N'Cash Receipt', 10, N'For  ', CAST(N'2023-01-03T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-03T22:19:20.0600000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcPmtJournalTemplateName', N'CASHRCPT', N'211', N'Payment', N'Cash Receipt', 10, N'For cashreceipts', CAST(N'2022-01-03T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-03T22:19:20.0600000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcScope', N'https://api.businesscentral.dynamics.com/.default', N'200,201,210,211,212', N'Order', N'API', 10, N'D365 Business Central auth scope', CAST(N'2023-06-15T19:13:24.0000000' AS DateTime2), CAST(N'2023-06-15T12:54:22.9100000' AS DateTime2), N'NCox')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcStatesToCountries', N'GU=GUM
PR=PRI', N'210', N'Order', N'Mapping', 10, N'Mapping specific states to countries ExigoToBC', CAST(N'2022-03-25T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-25T19:25:14.3900000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CAN3PLFolders', N'Incoming=Warehouse\Tracking\CAN;Processed=Warehouse\Tracking\CAN\Completed;Failed=Warehouse\Tracking\CAN\Failed;Outgoing=ExigoFTP\CAN', N'310,311', N'3PL', N'File', 10, N'file folder....', CAST(N'2023-04-04T00:00:00.0000000' AS DateTime2), CAST(N'2023-04-04T17:20:45.8900000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CAN3PLIncomingFolder', N'CAN Samples/ToProcess', N'310', N'Ship', N'3PL CAN', 10, N'Incoming folder for CAN 3PL response file processing', CAST(N'2023-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-07T14:56:27.9500000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CAN3PLEnvironmentFlag', N'T', N'310', N'Ship', N'3PL CAN', 10, N'Environment variable "P"roduction or "T"est', CAST(N'2023-08-30T00:00:00' AS DateTime2), CAST(N'2023-08-30T00:00:00' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CAN3PLShippingCodes', N'{"Canada Post Standard": "10", "Canada Post Express": "11"}', N'310', N'3PL', N'Shipping codes', 12, N'Outgoing 3PL shipping codes', CAST(N'2023-08-28T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-28T00:00:00.00000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CAN3PLParseFileExt', N'*.txt', N'311', N'3PL', N'File extension', 10, N'Single File extension for CAN 3PL incoming shipping files to process', CAST(N'2023-08-28T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-28T00:00:00.00000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'CrmPullPaymentThresholdVariance', N'1.01', N'100', N'Order', N'Validation', 7, N'Allowed variance', CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-09-02T00:00:00.0000000' AS DateTime2), N'nm')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ErpCmGlAccountNumbers', N'TAX=2400;SHIPPING=4400;other=4500', N'210', N'Order', N'CreditMemo', 10, N'Gl Account nbrs to use for CM categories', CAST(N'2023-05-10T00:00:00.0000000' AS DateTime2), CAST(N'2023-05-10T20:34:50.1900000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ErpPushOrdCalcThresholdVariance', N'0.05', N'210', N'Order', N'Validation', 7, N'Allowed variance', CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-09-02T00:00:00.0000000' AS DateTime2), N'nm')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoApi', N'{"Url": "https://sandboxapi2.exigo.com/3.0/ExigoApi.asmx","Company": "yoli","Username": "..testing123..","Password": "...."}', N'111', N'ReturnOrder', N'Exigo Push', 12, N'Exigo API params', CAST(N'2023-03-02T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-23T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoPromoAltSKUs', N'Yoli+ Free Shipping Discount=SHIPPING', N'210', N'Order', N'Line', 10, N'dict key is Promo description and value is ALT SKU to use in ERP', CAST(N'2022-08-09T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoBcSkuMapping', N'CMPREVENUE=10166-UNV|10166-UNV-01|10248-UNV|10166-UNV-BLK,CONFERENCE TICKET=EVCON-UNV-2023|EVVCON-UNV-2023,MEMBERSHIPFEE=1981980101|1981980201|MemberShipFee-US|MembershipFee-CA|MemberShipFee-PH,REWARD TRIP=EVCRS-UNV-24-01|77EVCRS-UNV-24-02|EVCRS-UNV-24-03,SHIPPING=10111-UNV|10246-UNV|BN-50228-US|BN-50229-CA|BN-50230-PH|REFUSALFEE-UNV|INTERCEPTFEE-US|REROUTEFEE-US|REROUTEOOS-US', N'210', N'Order', N'Line', 10, N'list of key-value pairs where the values are separated by pipe (|) char. BC Skus on the left (key) and Exigo Skus on the right (value)', CAST(N'2023-09-26T00:00:00.0000000' AS DateTime2), CAST(N'2023-09-26T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoPromoCatchAll', N'PROMO-PRODUCTS', N'210', N'Order', N'Sku', 10, N'When Alt Skus do not match, use this one', CAST(N'2023-05-02T14:11:05.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoPromoSKU', N'Promo', N'210', N'Order', N'Line', 10, N'Single Exigo promotional SKU', CAST(N'2022-08-09T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoRoOrderStatusToSet', N'Pending', N'100', N'Order', N'ExigoApi', 10, N'OrderStatus to set the pulled unshipped order in Exigo', CAST(N'2023-07-17T20:04:15.0000000' AS DateTime2), CAST(N'2023-07-17T20:04:15.2300000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoSkusToSkipPush', N'VR', N'210', N'Order', N'Line', 10, N'List of delimited SKUs to skip on push of orderlines to BC ERP', CAST(N'2023-01-18T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-18T15:52:08.8000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoToBCPaymentTypes', N'Cash=S-CASH;Credit Card=S-CARD;Yoli Cash (USD)=S-YOLICASH;Yoli Cash (AU)(USD)=S-YOLICASH;Yoli Cash (CAN)=S-YOLICASH;Yoli Cash (PHL)=S-YOLICASH;Yoli Bonus (USD)=S-YBONUS;Yoli Bonus (CAN)=S-YBONUS;Yoli Bonus (PHL)=S-YBONUS;Yoli Rewards (AU/USA)=S-YREWARD;Yoli Rewards (CAN)=S-YREWARD;Yoli Rewards (PHL)=S-YREWARD;AmazonPay=S-Amazon;Wallet=S-Amazon', N'211', N'Order', N'API', 10, N'Payment type mapping from Exigo to BC', CAST(N'2022-05-20T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ExigoToBCShippingAgentCodes', N'Pick-Up=WILL-CALL~;Surepost=UPS~SUREPOST LESS THAN 1 LB;Surepost+=UPS~SUREPOST 1 LB OR GREATER;UPS 2nd Day=UPS~2ND DAY AIR;UPS Ground=UPS~GROUND;UPS Next Day=UPS~NEXT DAY AIR;USPS - Priority=USPOSTAL~PRIORITY-PARCEL;USPS 1st Class=USPOSTAL~FIRST-PARCEL;USPS (Avg 30-45 day delivery)=USPOSTAL~PARCELSELECT-PARCEL;International 1st class (Avg 30-45 day delivery)=USPOSTAL~FIRST-PARCEL;Canada Post Express=CANP~CANP-EXPRESS;Canada Post Standard=CANP~CANP-STANDARD;LBC=LBC~;Philippines Office Pickup=WILL-CALL~', N'210', N'Order', N'Shipping', 10, N'Mapping shipping agent codes from ExigoToBC', CAST(N'2022-08-10T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:31:33.5500000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'FileShareRoot', N'/Users/Chadlarson/Downloads/', N'310,311,320,321', N'Ship', N'3PL Proc', 10, N'FileShare root folder for 3PL response file processing', CAST(N'2023-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2023-03-07T14:56:27.9500000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ImportCrmOrderNegativePayments', N'true', N'100', N'Order', N'Payment', 1, N'Import CRM Order Payments with a negative amount', CAST(N'2020-12-20T00:00:00.0000000' AS DateTime2), CAST(N'2020-12-21T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'ImportIgnoreOrderTypes', N'8', N'100', N'Order', N'Select', 10, N'Comma separated list of ordertypes to ignore', CAST(N'2021-11-10T00:00:00.0000000' AS DateTime2), CAST(N'2021-11-10T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'LastTimeShippigInfoWasImportedFromBusinessCentral', N'2023-07-17T17:03:55.20Z', N'200', N'Shipping', N'Shipped detail', 8, N'Fetch shipping info (posted packages) from ERP (BC)', CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-30T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OnlyImportOrdersOverAmount', N'0.00', N'100', N'Order', N'Select', 5, N'Minimum amount of order to consider importing', NULL, CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OnlyImportOrderStatusCodes', N'7', N'100', N'Order', N'Select', 10, N'comma separated codes-values: 2,3,4,5,7,8,13', CAST(N'2021-10-25T00:00:00.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullAllowMoneyMismatch', N'true', N'100', N'Order', N'Header', 1, N'Whether we allow orders pulled where there is a mismatch in ordertotal vs sum of payment(s)', CAST(N'2023-06-07T20:52:34.0000000' AS DateTime2), CAST(N'2023-06-07T20:52:33.8600000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullBatchsize', N'500', N'100,101', N'Order', N'Select', 2, NULL, CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullDaysBack', N'4', N'100,101', N'Order', N'Select', 2, NULL, NULL, CAST(N'2020-09-22T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullHourDelay', N'2', N'100', N'Order', N'Header', 2, N'Number of hour delay for unshipped orders', CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullLastDate', N'', N'100', N'Order', N'Select', 8, N'Last date of order pull from source system', CAST(N'2021-10-18T00:00:00.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullMinOrderNumber', N'51800000', N'100,101,102', N'Order', N'Select', 2, N'Only pull order#s > than this value. Use 0 to turn this off', CAST(N'2021-10-15T00:00:00.0000000' AS DateTime2), CAST(N'2021-10-26T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPushBatchSize', N'200', N'210', N'Order', N'Select', 2, NULL, CAST(N'2021-10-15T00:00:00.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrdersPushFetchSize', N'165', N'210', N'Order', N'Batch', 2, N'Number of orders to fetch for building a batch', CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-09-20T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OverrideOrderShipmethodWithDefault', N'false', N'210', N'Order', N'Header', 1, NULL, CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-06-10T20:14:49.6800000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'PaymentsBatchFetchSize', N'60', N'211', N'Payment', NULL, 2, N'TOP x Payments to fetch for pushing to ERP', CAST(N'2023-01-14T10:36:51.0000000' AS DateTime2), CAST(N'2023-01-14T10:36:50.6300000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'PHL3PLFolders', N'Incoming=Warehouse\Tracking\PHI;Processed=Warehouse\Tracking\PHI\Completed;Failed=Warehouse\Tracking\PHI\Failed;Outgoing=ExigoFTP\PHI', N'320,321', N'3PL', N'File', 10, N'file folder....', CAST(N'2023-04-04T00:00:00.0000000' AS DateTime2), CAST(N'2023-04-04T17:23:02.1900000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'PushCountriesForTaxId', N'PH', N'100', N'Customer', N'Tax', 10, N'County list for pulling customer TaxId', CAST(N'2023-01-02T22:23:30.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'RemoveNegPosCancelOutLines', N'True', N'100', N'Order', N'Line', 1, N'Remove matching negative and positive lines that cancel each other out', CAST(N'2022-08-07T00:00:00.0000000' AS DateTime2), CAST(N'2023-01-02T22:23:30.2200000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'StagingIgnoreAddresses', N'false', N'100,101', N'Order', N'Header', 1, N'Ignore addresses on pull', CAST(N'2020-10-20T00:00:00.0000000' AS DateTime2), CAST(N'2020-10-25T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'UseLastPaymentDateForOrder', N'true', NULL, N'Order', N'Header', 1, N'Use Last payment date for the order date. Good for partial paid orders or stale orders that sat in shopping cart', CAST(N'2021-09-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-09-01T00:00:00.0000000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'OrderPullPickupShipMethodIds', N'8,18,23', N'100', N'Order', N'Selection', 10, N'Limit to these Exigo pickup ship methods', CAST(N'2023-08-28T00:00:00.0000000' AS DateTime2), CAST(N'2023-08-28T21:49:39.8400000' AS DateTime2), N'Chadl')
GO
INSERT [dbo].[AppParams] ([Name], [Value], [ProcessJobIds], [Category], [SubCategory], [ValueTypeId], [Notes], [EnabledDate], [CreatedAt], [CreatedBy]) VALUES (N'BcOrderSummarySku', N'PRODUCT', N'210', N'Order', N'Lines', 2, N'Put the BC SKU here if wanting to summarize all regular items into a single orderline in BC', CAST(N'2023-09-14T00:00:00.0000000' AS DateTime2), CAST(N'2023-09-14T00:00:00.0000000' AS DateTime2), N'Chadl')
GO


INSERT [dbo].[Roles] ([Id], [Role], [RestrictedPages], [RestrictedActions]) VALUES (1, N'Admin', N'None', N'None')
GO
INSERT [dbo].[Roles] ([Id], [Role], [RestrictedPages], [RestrictedActions]) VALUES (11, N'Agent', N'Users, Settings', N'Delete')
GO
INSERT [dbo].[Roles] ([Id], [Role], [RestrictedPages], [RestrictedActions]) VALUES (21, N'User', N'Users, Settings', N'All')
GO

SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (15, N'nrc4@hotmail.com', N'Nate Cox', N'$2a$12$bcbTc5wT9JSkH0xUFgLAouniqqm7xDLo9aH06l63HZFmTtuyPnP82', 1, CAST(N'2023-06-23T16:55:13.177' AS DateTime), CAST(N'2023-07-13T21:40:29.963' AS DateTime), 1, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (16, N'example@sasha.rad', N'Sasha', N'$2a$12$ZUnPMVQ0zbVt8CSSjf9vVOW6Uc0pojXmFidxzL5Dbiy8UUvXCs1Ti', 21, CAST(N'2023-06-23T19:14:38.067' AS DateTime), CAST(N'2023-06-29T17:05:32.703' AS DateTime), 0, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (17, N'real.neal@neal.real', N'Nigel Cooks', N'$2a$12$FhS7miw2gaaDxf2oCDR09.5AcHqOMkPksBFsMcOYP/gSdGwHFXp.y', 11, CAST(N'2023-06-23T19:15:07.800' AS DateTime), CAST(N'2023-06-29T17:45:22.090' AS DateTime), 0, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (18, N'chad@ncompass.org', N'Chad Larson', N'$2a$12$ql7fpMaipL1AA//vrHd/Ju6WbPUieRoWt0igZqQ0c6yYX/OIRF4Nq', 1, CAST(N'2023-06-27T17:39:19.280' AS DateTime), CAST(N'2023-06-27T17:49:10.787' AS DateTime), 1, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (19, N'jwinn@yoli.com', N'Jason Winn', N'$2a$12$P05UY3zSLFdu9OIIbIvtUePsLuBYEas9Kk9.HOXS0gqwRU5E3OujC', 1, CAST(N'2023-06-27T17:58:14.013' AS DateTime), NULL, NULL, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (20, N'chadl@yoli.com', N'Chad Yoli', N'$2a$12$eo3FZGxPcqoQ6i5bNX/ZY.6djHo0TvTY/wmMsIJDTCBDt3mfgP6OK', 21, CAST(N'2023-06-27T17:58:55.997' AS DateTime), NULL, NULL, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (21, N'braydenp@yoli.com', N'Brayden Purtshert', N'$2a$12$ltMgstQfbGsCVtK.QSH1POKzQKbDi37/8X7ydgJRJt5vhI5zLi/36', 11, CAST(N'2023-06-28T23:32:53.580' AS DateTime), NULL, NULL, 0, 1)
GO
INSERT [dbo].[Users] ([Id], [Email], [Name], [Hash], [Role], [DateRegistered], [LastLogin], [LoggedIn], [FailedAttempts], [Active]) VALUES (22, N'olgalake@gmail.com', N'Olga Cox', N'$2a$12$XD4biiOHDO6gQPUQ4o5yN.7yd23tURuN8FNnH.FWCidSprjv93Uxq', 1, CAST(N'2023-06-29T17:06:48.207' AS DateTime), CAST(N'2023-06-29T17:10:00.760' AS DateTime), 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Maps] ON 
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (1, N'US', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'1', NULL, N'DC-USASLC', N'DC-USARTRN', 0, 1, 1, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0330000' AS DateTime2), N'chadl', CAST(N'2023-06-27T19:02:24.4470000' AS DateTime2), N'15')
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (2, N'CA', N'b242ba0f-ff51-ec11-9f08-000d3a14a707', N'CAD', N'CAD', N'2', NULL, N'DC-CA', N'DC-CARTRN', 0, 1, 2, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0400000' AS DateTime2), N'chadl')
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (3, N'AU', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'4', NULL, N'DC-USASLC', N'DC-USARTRN', 0, NULL, 4, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0400000' AS DateTime2), N'chadl')
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (4, N'PH', N'34195264-ff51-ec11-9f08-000d3a14a707', N'PHP', N'PHP', N'5', NULL, N'DC-PHL', N'DC-PHLRTRN', 1, 1, 3, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0700000' AS DateTime2), N'chadl')
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (5, N'PH', N'34195264-ff51-ec11-9f08-000d3a14a707', N'PHP', N'PHP', N'5', N'Philippines Office Pickup', N'DC-PHLWC', N'DC-PHLRTRN', 1, NULL, 3, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0730000' AS DateTime2), N'chadl')
GO
INSERT [dbo].[Maps] ([Id], [IsoCountryCode], [ErpCompanyId], [IsoCurrencyCode], [ErpCurrencyCode], [SourceWarehouse], [SourceShipMethod], [DestinationWarehouse], [ReturnsWarehouse], [IsVAT], [UseForErpPull], [ProcessingSequence], [ActivatedAt], [DeactivatedAt], [CreatedAt], [CreatedBy]) VALUES (6, N'US', N'd88d601b-1c22-ec11-8f45-000d3a1bd9aa', N'USD', N'USD', N'6', NULL, N'DC-EVENTS', N'DC-USARTRN', 0, NULL, 1, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2023-01-02T23:11:19.0800000' AS DateTime2), N'chadl')
GO
SET IDENTITY_INSERT [dbo].[Maps] OFF
GO


INSERT dbo.ProcessJobs (Id, Name, ExternalSystem, DataDirection)
VALUES 
--Exigo
 (100,'Pull Unshipped Orders','Exigo','IN')
, (101,'Pull Shipped Orders','Exigo','IN')
, (102,'Pull Fee Orders','Exigo','IN')
, (103,'Pull Completed ReturnOrders','Exigo','IN')
, (110,'Push Tracking Info','Exigo','OUT')
, (111,'Push ReturnOrders','Exigo','OUT')

--BC
, (200,'Pull Tracking info','BC','IN')
, (201,'Pull ReturnOrders','BC','IN')
, (210,'Push Orders/Customers','BC','OUT')
, (211,'Push Cash Receipts','BC','OUT')
, (212,'Push Shipping Info','BC','OUT')
--CMs??

--3PLs
, (310,'Generate File Can','CCLS','OUT')
, (311,'Parse File Can','CCLS','IN')
, (320,'Generate File Phl','LBC','OUT')
, (321,'Parse File Phl','LBC','IN')

