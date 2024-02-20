USE [master]
GO
/****** Object:  Database [StagingHub]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE DATABASE [StagingHub]
 CONTAINMENT = NONE
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [StagingHub] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StagingHub].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StagingHub] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StagingHub] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StagingHub] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StagingHub] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StagingHub] SET ARITHABORT OFF 
GO
ALTER DATABASE [StagingHub] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StagingHub] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StagingHub] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StagingHub] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StagingHub] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StagingHub] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StagingHub] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StagingHub] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StagingHub] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StagingHub] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StagingHub] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StagingHub] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StagingHub] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StagingHub] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StagingHub] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StagingHub] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StagingHub] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StagingHub] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StagingHub] SET  MULTI_USER 
GO
ALTER DATABASE [StagingHub] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StagingHub] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StagingHub] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StagingHub] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [StagingHub] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StagingHub] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StagingHub] SET QUERY_STORE = OFF
GO
USE [StagingHub]
GO
/****** Object:  Table [dbo].[PaymentsTrackingHistory]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentsTrackingHistory](
	[PaymentId] [bigint] NOT NULL,
	[DismissedAt] [datetime2](0) NULL,
	[ErrorReason] [varchar](200) NULL,
	[AttemptedAt] [datetime2](7) NOT NULL,
	[RetiredAt] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_PaymentsTrackingHistory]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE CLUSTERED INDEX [ix_PaymentsTrackingHistory] ON [dbo].[PaymentsTrackingHistory]
(
	[RetiredAt] ASC,
	[AttemptedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentsTracking]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentsTracking](
	[PaymentId] [bigint] NOT NULL,
	[DismissedAt] [datetime2](0) NULL,
	[ErrorReason] [varchar](200) NULL,
	[AttemptedAt] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[RetiredAt] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_Payments_PaymentId] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([AttemptedAt], [RetiredAt])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PaymentsTrackingHistory] )
)
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AddressLine1] [varchar](61) NOT NULL,
	[AddressLine2] [varchar](61) NULL,
	[AddressLine3] [varchar](61) NULL,
	[City] [varchar](35) NOT NULL,
	[StateProvince] [varchar](29) NOT NULL,
	[PostalCode] [varchar](11) NOT NULL,
	[Country] [varchar](60) NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppParams]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppParams](
	[Name] [varchar](100) NOT NULL,
	[Value] [varchar](4000) NULL,
	[ProcessJobIds] [varchar](25) NULL,
	[Category] [varchar](50) NULL,
	[SubCategory] [varchar](50) NULL,
	[ValueTypeId] [int] NOT NULL,
	[Notes] [varchar](200) NULL,
	[EnabledDate] [datetime2](0) NULL,
	[CreatedAt] [datetime2](2) NOT NULL,
	[CreatedBy] [varchar](25) NOT NULL,
	[ModifiedAt] [datetime2](3) NULL,
	[ModifiedBy] [varchar](25) NULL,
 CONSTRAINT [PK_AppParams] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppParamValueTypes]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppParamValueTypes](
	[Id] [int] NOT NULL,
	[Type] [varchar](20) NOT NULL,
 CONSTRAINT [PK_ParamValueTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CanadaFileTracking]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CanadaFileTracking](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[At] [datetime2](7) NOT NULL,
	[Filename] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CanadaFileTracking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeLog]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[ColumnName] [varchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[PrevValue] [varchar](max) NULL,
	[NewValue] [varchar](max) NULL,
	[ValueType] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ChangeLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNumber] [varchar](15) NOT NULL,
	[CustomerName] [varchar](65) NULL,
	[ContactName] [varchar](61) NULL,
	[CompanyName] [varchar](35) NULL,
	[Phone1] [varchar](21) NULL,
	[Phone2] [varchar](21) NULL,
	[Phone3] [varchar](21) NULL,
	[EmailAddress] [varchar](80) NULL,
	[EnteredDate] [datetime2](0) NULL,
	[BillAddressId] [bigint] NULL,
	[ShipAddressId] [bigint] NULL,
	[ImportedDate] [datetime2](2) NULL,
	[TaxId] [varchar](30) NULL,
	[TaxIdType] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DashboardPages]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DashboardPages](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Page] [varchar](50) NOT NULL,
	[Actions] [varchar](max) NULL,
 CONSTRAINT [PK_DashboardPages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErpReturnOrderLines]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErpReturnOrderLines](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ErpId] [varchar](40) NULL,
	[ErpHeaderId] [varchar](40) NOT NULL,
	[OrderNumber] [varchar](20) NOT NULL,
	[ParentLineNumber] [int] NULL,
	[LineNumber] [int] NOT NULL,
	[Sku] [varchar](20) NOT NULL,
	[Description] [varchar](50) NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[UnitTax] [decimal](18, 2) NULL,
	[Warehouse] [varchar](20) NULL,
 CONSTRAINT [PK_ErpReturnOrderLines] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErpReturnOrders]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErpReturnOrders](
	[ErpId] [varchar](40) NOT NULL,
	[OrderNumber] [varchar](20) NOT NULL,
	[CustomerNumber] [varchar](15) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[OrderDate] [datetime2](0) NOT NULL,
	[ShipDate] [datetime2](0) NOT NULL,
	[CustomerName] [varchar](35) NULL,
	[Address] [varchar](35) NULL,
	[Address2] [varchar](35) NULL,
	[City] [varchar](35) NULL,
	[State] [varchar](25) NULL,
	[Country] [varchar](3) NULL,
	[PostalCode] [varchar](10) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Warehouse] [varchar](25) NOT NULL,
	[OriginalOrderNumber] [int] NOT NULL,
	[ImportedAt] [datetime2](2) NOT NULL,
	[SentToCrmAt] [datetime2](2) NULL,
	[CrmOrderId] [int] NULL,
 CONSTRAINT [PK_ReturnOrders_ErpId] PRIMARY KEY CLUSTERED 
(
	[ErpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErpShipmentTracking]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErpShipmentTracking](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ErpPostedPackageId] [varchar](40) NOT NULL,
	[ErpOrderNumber] [varchar](25) NOT NULL,
	[When] [datetime2](7) NOT NULL,
 CONSTRAINT [unique_ErpPostedPkgId] UNIQUE NONCLUSTERED 
(
	[ErpPostedPackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logging]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logging](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Level] [varchar](max) NULL,
	[TimeStamp] [datetime] NULL,
	[Message] [varchar](max) NULL,
	[Exception] [varchar](max) NULL,
	[Properties] [varchar](max) NULL,
	[JobName] [varchar](30) NOT NULL,
	[MessageTemplate] [varchar](max) NULL,
 CONSTRAINT [PK_Logging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maps]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maps](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsoCountryCode] [varchar](3) NOT NULL,
	[ErpCompanyId] [varchar](50) NOT NULL,
	[IsoCurrencyCode] [char](3) NOT NULL,
	[ErpCurrencyCode] [varchar](10) NOT NULL,
	[SourceWarehouse] [varchar](11) NOT NULL,
	[SourceShipMethod] [varchar](100) NULL,
	[DestinationWarehouse] [varchar](25) NULL,
	[ReturnsWarehouse] [varchar](25) NULL,
	[IsVAT] [bit] NULL,
	[UseForErpPull] [bit] NULL,
	[ProcessingSequence] [smallint] NULL,
	[ActivatedAt] [datetime2](0) NULL,
	[DeactivatedAt] [datetime2](0) NULL,
	[CreatedAt] [datetime2](3) NOT NULL,
	[CreatedBy] [varchar](25) NOT NULL,
	[ModifiedAt] [datetime2](3) NULL,
	[ModifiedBy] [varchar](25) NULL,
 CONSTRAINT [PK_Maps] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderBatch]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderBatch](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DailyBatchNumber] [int] NOT NULL,
	[BatchDate] [datetime2](0) NOT NULL,
	[Market] [varchar](10) NOT NULL,
	[SelectedOrderCount] [int] NOT NULL,
	[ProcessedOrderCount] [int] NULL,
	[CreatedAt] [datetime2](3) NOT NULL,
	[BatchMonth] [int] NULL,
	[OrderBatchSize] [int] NULL,
 CONSTRAINT [PK_OrderBatch_OrderBatchId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderBatchDetail]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderBatchDetail](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderBatchId] [bigint] NOT NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[ErrorCode] [varchar](50) NULL,
	[ErrorMessage] [varchar](2000) NULL,
 CONSTRAINT [PK_OrderBatchDetail_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orderlines]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orderlines](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[LineNumber] [int] NULL,
	[Sku] [varchar](31) NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[TaxRate] [decimal](18, 2) NOT NULL,
	[UnitTaxAmount] [decimal](18, 2) NULL,
	[ExtTaxAmount] [decimal](18, 2) NULL,
	[Warehouse] [varchar](11) NULL,
	[Description] [varchar](200) NULL,
	[ParentSku] [varchar](31) NULL,
	[ComponentPrice] [decimal](18, 2) NULL,
	[UnitCost] [decimal](18, 2) NULL,
	[ItemType] [int] NOT NULL,
	[IsVirtual] [bit] NOT NULL,
	[Weight] [decimal](9, 2) NULL,
	[CVolume] [decimal](18, 2) NULL,
 CONSTRAINT [PK_orderline_Clustered] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderNumber] [varchar](21) NOT NULL,
	[CustomerNumber] [varchar](15) NOT NULL,
	[Market] [varchar](10) NOT NULL,
	[CurrencyCode] [varchar](10) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[OrderDate] [datetime2](0) NOT NULL,
	[Warehouse] [varchar](25) NULL,
	[PushStatusId] [int] NULL,
	[ShipToName] [varchar](65) NULL,
	[ShipDate] [datetime] NULL,
	[ShipMethod] [varchar](50) NULL,
	[TrackingNumber] [varchar](41) NULL,
	[OrderTotalAmount] [decimal](18, 2) NOT NULL,
	[FreightAmount] [decimal](18, 2) NOT NULL,
	[FreightTaxAmount] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[OrderNotes] [varchar](500) NULL,
	[Phone1] [varchar](21) NULL,
	[Phone2] [varchar](21) NULL,
	[Phone3] [varchar](21) NULL,
	[BillAddressId] [bigint] NULL,
	[ShipAddressId] [bigint] NULL,
	[StagingImportDate] [datetime2](4) NOT NULL,
	[PickupName] [varchar](100) NULL,
	[OrderTypeDescription] [varchar](20) NULL,
	[ReferenceOrderNumber] [varchar](21) NULL,
	[ErpOrderNumber] [varchar](25) NULL,
	[ErpId] [varchar](40) NULL,
	[SentToErp] [datetime2](2) NULL,
	[SentTo3PL] [datetime2](2) NULL,
 CONSTRAINT [PK_orders_OrderNumber] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStagingErrors]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStagingErrors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[OrderDate] [datetime2](0) NOT NULL,
	[OrderTotal] [decimal](18, 2) NOT NULL,
	[CurrencyCode] [char](3) NOT NULL,
	[Message] [varchar](300) NOT NULL,
	[At] [datetime2](3) NOT NULL,
	[IgnoredAt] [datetime2](3) NULL,
	[Exception] [varchar](max) NULL,
 CONSTRAINT [PK_OrderStagingErrors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [unique_ordnum] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SourcePaymentId] [varchar](20) NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[PaymentType] [varchar](30) NULL,
	[PaymentAmount] [decimal](18, 2) NOT NULL,
	[PaymentDate] [datetime2](0) NOT NULL,
	[CardNumber] [varchar](25) NULL,
	[AuthCode] [varchar](25) NULL,
	[SentToErp] [datetime2](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessedTransactions]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessedTransactions](
	[Id] [bigint] NOT NULL,
	[OrderDate] [datetime2](0) NULL,
	[EntryReceiedDate] [datetime2](5) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[LoginName] [varchar](30) NULL,
	[OrderID] [int] NOT NULL,
	[AffiliateOrderID] [varchar](10) NULL,
	[FirstName] [varchar](25) NULL,
	[LastName] [varchar](25) NULL,
	[Phone] [varchar](12) NULL,
	[Email] [varchar](40) NULL,
	[City] [varchar](40) NULL,
	[State] [varchar](2) NULL,
	[PostalCode] [varchar](10) NULL,
	[Country] [varchar](10) NULL,
	[FileOrigin] [varchar](45) NOT NULL,
	[Affiliate] [varchar](10) NULL,
	[SuccessStatus] [bit] NOT NULL,
	[FailReason] [varchar](200) NULL,
	[Emailed] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessingErrors]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessingErrors](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProcessJobId] [int] NOT NULL,
	[Category] [varchar](20) NULL,
	[OrderNumber] [varchar](21) NOT NULL,
	[LineNumber] [int] NULL,
	[AltId] [varchar](12) NULL,
	[Message] [varchar](300) NOT NULL,
	[AdditionalData] [varchar](300) NULL,
	[At] [datetime2](2) NOT NULL,
	[DismissedAt] [datetime2](2) NULL,
	[DismissedBy] [varchar](20) NULL,
	[Exception] [varchar](max) NULL,
 CONSTRAINT [PK_ProcessingErrors_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessJobs]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessJobs](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ExternalSystem] [varchar](15) NOT NULL,
	[DataDirection] [varchar](3) NOT NULL,
 CONSTRAINT [PK_ProcessJobs_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurgeRunDetails]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurgeRunDetails](
	[PurgeRunDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PurgeRunId] [int] NOT NULL,
	[TableName] [varchar](20) NOT NULL,
	[PurgeCount] [int] NOT NULL,
 CONSTRAINT [PK_PurgeRunDetails] PRIMARY KEY CLUSTERED 
(
	[PurgeRunDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurgeRuns]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurgeRuns](
	[PurgeRunId] [int] IDENTITY(1,1) NOT NULL,
	[RunDate] [datetime2](2) NOT NULL,
	[MonthsKept] [int] NOT NULL,
 CONSTRAINT [PK_PurgeRuns] PRIMARY KEY CLUSTERED 
(
	[PurgeRunId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PushStatuses]    Script Date: 9/30/2023 12:10:04 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [tinyint] NOT NULL,
	[Role] [varchar](50) NOT NULL,
	[RestrictedPages] [varchar](max) NOT NULL,
	[RestrictedActions] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippedOrderlines]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippedOrderlines](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderlineId] [bigint] NOT NULL,
	[ShippedAt] [datetime2](3) NOT NULL,
	[ShippedQuantity] [int] NOT NULL,
	[Carrier] [varchar](50) NULL,
	[ShipMethod] [varchar](50) NULL,
	[TrackingNumber] [varchar](50) NULL,
	[LotNumber] [varchar](25) NOT NULL,
	[ShippedOrderSourceId] [int] NOT NULL,
	[SourceDocument] [varchar](50) NULL,
	[CrmNotifiedAt] [datetime2](0) NULL,
	[ErpNotifiedAt] [datetime2](0) NULL,
	[CreatedAt] [datetime2](3) NOT NULL,
	[CreatedBy] [varchar](25) NOT NULL,
 CONSTRAINT [[PK_ShippedOrderLines_Id]]] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippedOrderSources]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippedOrderSources](
	[Id] [int] NOT NULL,
	[Name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/30/2023 12:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Hash] [varchar](max) NOT NULL,
	[Role] [tinyint] NOT NULL,
	[DateRegistered] [datetime2](2) NOT NULL,
	[LastLogin] [datetime2](2) NULL,
	[LoggedIn] [bit] NULL,
	[FailedAttempts] [tinyint] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OBD_OrdNbr]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_OBD_OrdNbr] ON [dbo].[OrderBatchDetail]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Ol_OrdNbr]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Ol_OrdNbr] ON [dbo].[Orderlines]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Orders_MktPushStErpOrdNbr]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_MktPushStErpOrdNbr] ON [dbo].[Orders]
(
	[Market] ASC,
	[PushStatusId] ASC,
	[ErpOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Pmt_OrdNbr]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Pmt_OrdNbr] ON [dbo].[Payments]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Pmts_OrdNbr]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Pmts_OrdNbr] ON [dbo].[Payments]
(
	[SentToErp] ASC,
	[PaymentDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_OrderNumber]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [ix_OrderNumber] ON [dbo].[ProcessingErrors]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ShippedOrderlines_SourceDocument]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippedOrderlines_SourceDocument] ON [dbo].[ShippedOrderlines]
(
	[SourceDocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SOL_OrdLnId]    Script Date: 9/30/2023 12:10:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_SOL_OrdLnId] ON [dbo].[ShippedOrderlines]
(
	[OrderlineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppParams] ADD  CONSTRAINT [DF_AppParams_Created]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ChangeLog] ADD  CONSTRAINT [DF_ChangeLog_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[ErpReturnOrders] ADD  CONSTRAINT [DF_ReturnOrder_Imported]  DEFAULT (getdate()) FOR [ImportedAt]
GO
ALTER TABLE [dbo].[ErpShipmentTracking] ADD  CONSTRAINT [DF_ErpShipmentTracking_When]  DEFAULT (getdate()) FOR [When]
GO
ALTER TABLE [dbo].[Maps] ADD  CONSTRAINT [DF_Gpm_Created]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_orders_ImportDate]  DEFAULT (getdate()) FOR [StagingImportDate]
GO
ALTER TABLE [dbo].[ProcessingErrors] ADD  CONSTRAINT [DF__ProcessingEr__At__719CDDE7]  DEFAULT (getdate()) FOR [At]
GO
ALTER TABLE [dbo].[PurgeRuns] ADD  CONSTRAINT [DF_PurgeRuns_RunDate]  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_FailedAttempts]  DEFAULT ((0)) FOR [FailedAttempts]
GO
ALTER TABLE [dbo].[AppParams]  WITH CHECK ADD  CONSTRAINT [FK_AppParams_ParamValueTypes] FOREIGN KEY([ValueTypeId])
REFERENCES [dbo].[AppParamValueTypes] ([Id])
GO
ALTER TABLE [dbo].[AppParams] CHECK CONSTRAINT [FK_AppParams_ParamValueTypes]
GO
ALTER TABLE [dbo].[CanadaFileTracking]  WITH CHECK ADD  CONSTRAINT [FK_CanadaFileTracking_Orders] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[Orders] ([OrderNumber])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CanadaFileTracking] CHECK CONSTRAINT [FK_CanadaFileTracking_Orders]
GO
ALTER TABLE [dbo].[ChangeLog]  WITH CHECK ADD  CONSTRAINT [FK_ChangeLog_AppParamValueTypes] FOREIGN KEY([ValueType])
REFERENCES [dbo].[AppParamValueTypes] ([Id])
GO
ALTER TABLE [dbo].[ChangeLog] CHECK CONSTRAINT [FK_ChangeLog_AppParamValueTypes]
GO
ALTER TABLE [dbo].[ChangeLog]  WITH CHECK ADD  CONSTRAINT [FK_ChangeLog_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ChangeLog] CHECK CONSTRAINT [FK_ChangeLog_Users]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Addresses] FOREIGN KEY([ShipAddressId])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Addresses]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Addresses1] FOREIGN KEY([BillAddressId])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Addresses1]
GO
ALTER TABLE [dbo].[ErpReturnOrderLines]  WITH CHECK ADD  CONSTRAINT [FK_ReturnOrderLines_ROs] FOREIGN KEY([ErpHeaderId])
REFERENCES [dbo].[ErpReturnOrders] ([ErpId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ErpReturnOrderLines] CHECK CONSTRAINT [FK_ReturnOrderLines_ROs]
GO
ALTER TABLE [dbo].[ErpReturnOrders]  WITH CHECK ADD  CONSTRAINT [FK_ErpReturnOrders_Customers] FOREIGN KEY([CustomerNumber])
REFERENCES [dbo].[Customers] ([CustomerNumber])
GO
ALTER TABLE [dbo].[ErpReturnOrders] CHECK CONSTRAINT [FK_ErpReturnOrders_Customers]
GO
ALTER TABLE [dbo].[OrderBatchDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderBatch_OrderBatchDetail_Cascade] FOREIGN KEY([OrderBatchId])
REFERENCES [dbo].[OrderBatch] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderBatchDetail] CHECK CONSTRAINT [FK_OrderBatch_OrderBatchDetail_Cascade]
GO
ALTER TABLE [dbo].[Orderlines]  WITH CHECK ADD  CONSTRAINT [FK_Orderlines_Orders] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[Orders] ([OrderNumber])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orderlines] CHECK CONSTRAINT [FK_Orderlines_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Bill_Addresses] FOREIGN KEY([BillAddressId])
REFERENCES [dbo].[Addresses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Bill_Addresses]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerNumber])
REFERENCES [dbo].[Customers] ([CustomerNumber])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PushStatuses] FOREIGN KEY([PushStatusId])
REFERENCES [dbo].[PushStatuses] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_PushStatuses]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Ship_Addresses] FOREIGN KEY([ShipAddressId])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Ship_Addresses]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[Orders] ([OrderNumber])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[PaymentsTracking]  WITH CHECK ADD  CONSTRAINT [FK_PaymentsTracking_Payments] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PaymentsTracking] CHECK CONSTRAINT [FK_PaymentsTracking_Payments]
GO
ALTER TABLE [dbo].[ProcessingErrors]  WITH CHECK ADD  CONSTRAINT [FK_ProcessJobs_Id] FOREIGN KEY([ProcessJobId])
REFERENCES [dbo].[ProcessJobs] ([Id])
GO
ALTER TABLE [dbo].[ProcessingErrors] CHECK CONSTRAINT [FK_ProcessJobs_Id]
GO
ALTER TABLE [dbo].[PurgeRunDetails]  WITH CHECK ADD  CONSTRAINT [FK_PurgeRunDetails_PurgeRuns] FOREIGN KEY([PurgeRunId])
REFERENCES [dbo].[PurgeRuns] ([PurgeRunId])
GO
ALTER TABLE [dbo].[PurgeRunDetails] CHECK CONSTRAINT [FK_PurgeRunDetails_PurgeRuns]
GO
ALTER TABLE [dbo].[ShippedOrderlines]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderlineId] FOREIGN KEY([OrderlineId])
REFERENCES [dbo].[Orderlines] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShippedOrderlines] CHECK CONSTRAINT [FK_Orders_OrderlineId]
GO
ALTER TABLE [dbo].[ShippedOrderlines]  WITH CHECK ADD  CONSTRAINT [FK_Orders_SourceId] FOREIGN KEY([ShippedOrderSourceId])
REFERENCES [dbo].[ShippedOrderSources] ([Id])
GO
ALTER TABLE [dbo].[ShippedOrderlines] CHECK CONSTRAINT [FK_Orders_SourceId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([Role])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  Trigger [dbo].[trg_DismissPaymentTrackingWhenProcessingErrorsDismissed]    Script Date: 9/30/2023 12:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_DismissPaymentTrackingWhenProcessingErrorsDismissed]
ON [dbo].[ProcessingErrors]
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
GO
ALTER TABLE [dbo].[ProcessingErrors] ENABLE TRIGGER [trg_DismissPaymentTrackingWhenProcessingErrorsDismissed]
GO
USE [master]
GO
ALTER DATABASE [StagingHub] SET  READ_WRITE 
GO
