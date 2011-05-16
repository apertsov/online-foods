CREATE TABLE [dbo].[Goods](
	[good_id] [int] IDENTITY(1,1) NOT NULL,
	[good_name] [nvarchar](50) COLLATE Ukrainian_CI_AS NOT NULL,
	[good_count] [int] NOT NULL,
	[good_curprice] [int] NOT NULL,
 CONSTRAINT [PRIMARY005] PRIMARY KEY CLUSTERED 
(
	[good_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


