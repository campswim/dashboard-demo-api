USE [StagingHub]
GO
/****** Object:  Table [dbo].[PaymentsTracking]    Script Date: 2/21/2024 4:42:36 PM ******/
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
	[DismissedBy] [int] NULL,
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
ALTER TABLE [dbo].[PaymentsTracking]  WITH CHECK ADD  CONSTRAINT [FK_PaymentsTracking_Payments] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PaymentsTracking] CHECK CONSTRAINT [FK_PaymentsTracking_Payments]
GO
ALTER TABLE [dbo].[PaymentsTracking]  WITH CHECK ADD  CONSTRAINT [FK_PaymentsTracking_Users] FOREIGN KEY([DismissedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PaymentsTracking] CHECK CONSTRAINT [FK_PaymentsTracking_Users]
GO
