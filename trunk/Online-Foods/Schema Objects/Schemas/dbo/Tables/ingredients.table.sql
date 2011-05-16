CREATE TABLE [dbo].[ingredients](
	[id_ingredients] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
	[short_name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[id_measure] [int] NULL,
 CONSTRAINT [PRIMARY007] PRIMARY KEY CLUSTERED 
(
	[id_ingredients] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_ingredients] UNIQUE NONCLUSTERED 
(
	[id_ingredients] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


