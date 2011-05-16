CREATE TABLE [dbo].[agents](
	[id_agents] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
	[login] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[psw] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[phone] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
	[adress] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
 CONSTRAINT [PRIMARY] PRIMARY KEY CLUSTERED 
(
	[id_agents] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
 CONSTRAINT [id_agents] UNIQUE NONCLUSTERED 
(
	[id_agents] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
)


