CREATE TABLE [dbo].[dish_ingredients](
	[id_dish_ingredients] [int] IDENTITY(1,1) NOT NULL,
	[id_dish] [int] NULL,
	[id_ingredient] [int] NULL,
	[count] [decimal](15, 2) NULL,
 CONSTRAINT [PRIMARY004] PRIMARY KEY CLUSTERED 
(
	[id_dish_ingredients] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_dish_ingredients] UNIQUE NONCLUSTERED 
(
	[id_dish_ingredients] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


