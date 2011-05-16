CREATE TABLE [dbo].[GoodsSales](
	[gs_id] [int] IDENTITY(1,1) NOT NULL,
	[gs_so_id] [int] NOT NULL,
	[gs_good_id] [int] NOT NULL,
	[gs_count] [int] NOT NULL,
	[gs_price] [int] NOT NULL,
 CONSTRAINT [PRIMARY006] PRIMARY KEY CLUSTERED 
(
	[gs_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


