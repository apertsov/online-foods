CREATE TABLE [dbo].[dish_groups](
	[id_dish_group] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[description] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[id_owner_group] [int] NULL,
 CONSTRAINT [PRIMARY003] PRIMARY KEY CLUSTERED 
(
	[id_dish_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_dish_goup] UNIQUE NONCLUSTERED 
(
	[id_dish_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


