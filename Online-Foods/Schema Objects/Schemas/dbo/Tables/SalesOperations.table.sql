﻿CREATE TABLE [dbo].[SalesOperations](
	[so_id] [int] IDENTITY(1,1) NOT NULL,
	[so_time] [datetime] NOT NULL,
 CONSTRAINT [PRIMARY012] PRIMARY KEY CLUSTERED 
(
	[so_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


