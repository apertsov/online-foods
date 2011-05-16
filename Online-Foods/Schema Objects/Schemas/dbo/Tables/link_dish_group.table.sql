CREATE TABLE [dbo].[link_dish_group](
	[id_link_dish_group] [int] IDENTITY(1,1) NOT NULL,
	[id_dish] [int] NULL,
	[id_group] [int] NULL,
 CONSTRAINT [PRIMARY008] PRIMARY KEY CLUSTERED 
(
	[id_link_dish_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_link_dish_group] UNIQUE NONCLUSTERED 
(
	[id_link_dish_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


