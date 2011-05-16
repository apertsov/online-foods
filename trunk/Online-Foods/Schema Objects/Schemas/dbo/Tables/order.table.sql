CREATE TABLE [dbo].[order](
	[id_order] [int] IDENTITY(1,1) NOT NULL,
	[date_order] [datetime] NULL,
	[id_agent] [int] NULL,
	[info] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
	[execution_time] [datetime] NULL,
	[execution_date] [datetime] NULL,
	[sum_order] [decimal](15, 2) NULL,
	[sum_discount] [decimal](15, 2) NULL,
	[state] [tinyint] NULL,
	[phone] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[adress] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
 CONSTRAINT [PRIMARY010] PRIMARY KEY CLUSTERED 
(
	[id_order] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_order] UNIQUE NONCLUSTERED 
(
	[id_order] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


