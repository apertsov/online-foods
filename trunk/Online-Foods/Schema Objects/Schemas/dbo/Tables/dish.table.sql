CREATE TABLE [dbo].[dish](
	[id_dish] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[time] [datetime] NULL,
	[info] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
	[tags] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
	[receipt] [nvarchar](200) COLLATE Ukrainian_CI_AS NULL,
	[price] [decimal](15, 2) NULL,
 CONSTRAINT [PRIMARY002] PRIMARY KEY CLUSTERED 
(
	[id_dish] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_dish] UNIQUE NONCLUSTERED 
(
	[id_dish] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


