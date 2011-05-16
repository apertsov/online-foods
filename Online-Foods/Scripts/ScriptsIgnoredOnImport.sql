
/****** Object:  Table [dbo].[agents]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[agents]') AND type in (N'U'))
DROP TABLE [dbo].[agents]
GO
/****** Object:  Table [dbo].[comments]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[comments]') AND type in (N'U'))
DROP TABLE [dbo].[comments]
GO
/****** Object:  Table [dbo].[dish]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish]') AND type in (N'U'))
DROP TABLE [dbo].[dish]
GO
/****** Object:  Table [dbo].[dish_groups]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish_groups]') AND type in (N'U'))
DROP TABLE [dbo].[dish_groups]
GO
/****** Object:  Table [dbo].[dish_ingredients]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish_ingredients]') AND type in (N'U'))
DROP TABLE [dbo].[dish_ingredients]
GO
/****** Object:  Table [dbo].[Goods]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Goods]') AND type in (N'U'))
DROP TABLE [dbo].[Goods]
GO
/****** Object:  Table [dbo].[GoodsSales]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GoodsSales]') AND type in (N'U'))
DROP TABLE [dbo].[GoodsSales]
GO
/****** Object:  Table [dbo].[ingredients]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ingredients]') AND type in (N'U'))
DROP TABLE [dbo].[ingredients]
GO
/****** Object:  Table [dbo].[link_dish_group]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[link_dish_group]') AND type in (N'U'))
DROP TABLE [dbo].[link_dish_group]
GO
/****** Object:  Table [dbo].[measurement]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[measurement]') AND type in (N'U'))
DROP TABLE [dbo].[measurement]
GO
/****** Object:  Table [dbo].[order]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[order]') AND type in (N'U'))
DROP TABLE [dbo].[order]
GO
/****** Object:  Table [dbo].[order_rows]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[order_rows]') AND type in (N'U'))
DROP TABLE [dbo].[order_rows]
GO
/****** Object:  Table [dbo].[SalesOperations]    Script Date: 05/06/2011 23:48:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalesOperations]') AND type in (N'U'))
DROP TABLE [dbo].[SalesOperations]
GO
/****** Object:  Default [DF__dish__price__0425A276]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__dish__price__0425A276]') AND parent_object_id = OBJECT_ID(N'[dbo].[dish]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__dish__price__0425A276]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[dish] DROP CONSTRAINT [DF__dish__price__0425A276]
END


End
GO
/****** Object:  Default [DF__Goods__good_coun__0DAF0CB0]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Goods__good_coun__0DAF0CB0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Goods]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Goods__good_coun__0DAF0CB0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Goods] DROP CONSTRAINT [DF__Goods__good_coun__0DAF0CB0]
END


End
GO
/****** Object:  Default [DF__Goods__good_curp__0EA330E9]    Script Date: 05/06/2011 23:48:23 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Goods__good_curp__0EA330E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[Goods]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Goods__good_curp__0EA330E9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Goods] DROP CONSTRAINT [DF__Goods__good_curp__0EA330E9]
END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_so__117F9D94]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_so__117F9D94]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_so__117F9D94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GoodsSales] DROP CONSTRAINT [DF__GoodsSale__gs_so__117F9D94]
END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_go__1273C1CD]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_go__1273C1CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_go__1273C1CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GoodsSales] DROP CONSTRAINT [DF__GoodsSale__gs_go__1273C1CD]
END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_co__1367E606]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_co__1367E606]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_co__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GoodsSales] DROP CONSTRAINT [DF__GoodsSale__gs_co__1367E606]
END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_pr__145C0A3F]    Script Date: 05/06/2011 23:48:24 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_pr__145C0A3F]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_pr__145C0A3F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GoodsSales] DROP CONSTRAINT [DF__GoodsSale__gs_pr__145C0A3F]
END


End
GO
/****** Object:  Default [DF__SalesOper__so_ti__25869641]    Script Date: 05/06/2011 23:48:25 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__SalesOper__so_ti__25869641]') AND parent_object_id = OBJECT_ID(N'[dbo].[SalesOperations]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SalesOper__so_ti__25869641]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SalesOperations] DROP CONSTRAINT [DF__SalesOper__so_ti__25869641]
END


End
GO
/****** Object:  Table [dbo].[SalesOperations]    Script Date: 05/06/2011 23:48:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalesOperations]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.SalesOperations.
--CREATE TABLE [dbo].[SalesOperations](
--	[so_id] [int] IDENTITY(1,1) NOT NULL,
--	[so_time] [datetime] NOT NULL,
-- CONSTRAINT [PRIMARY012] PRIMARY KEY CLUSTERED 
--(
--	[so_id] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[SalesOperations] ON
GO
INSERT [dbo].[SalesOperations] ([so_id], [so_time]) VALUES (1, CAST(0x00009ED600F8B074 AS DateTime))
GO
INSERT [dbo].[SalesOperations] ([so_id], [so_time]) VALUES (2, CAST(0x00009ED700F8BD58 AS DateTime))
GO
INSERT [dbo].[SalesOperations] ([so_id], [so_time]) VALUES (3, CAST(0x00009ED800F8C460 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[SalesOperations] OFF
GO
/****** Object:  Table [dbo].[order_rows]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[order_rows]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.order_rows.
--CREATE TABLE [dbo].[order_rows](
--	[id_order_rows] [int] IDENTITY(1,1) NOT NULL,
--	[id_order] [int] NULL,
--	[id_dish] [int] NULL,
--	[count] [decimal](15, 3) NULL,
-- CONSTRAINT [PRIMARY011] PRIMARY KEY CLUSTERED 
--(
--	[id_order_rows] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_order_rows] UNIQUE NONCLUSTERED 
--(
--	[id_order_rows] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[order_rows] ON
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (10, 24, 2357, CAST(1.000 AS Decimal(15, 3)))
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (11, 26, 23586, CAST(2.000 AS Decimal(15, 3)))
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (12, 26, 2357, CAST(1.000 AS Decimal(15, 3)))
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (13, 27, 1, CAST(10.000 AS Decimal(15, 3)))
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (14, 28, 2356, CAST(1.000 AS Decimal(15, 3)))
GO
INSERT [dbo].[order_rows] ([id_order_rows], [id_order], [id_dish], [count]) VALUES (15, 28, 23586, CAST(1.000 AS Decimal(15, 3)))
GO
SET IDENTITY_INSERT [dbo].[order_rows] OFF
GO
/****** Object:  Table [dbo].[order]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[order]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.order.
--CREATE TABLE [dbo].[order](
--	[id_order] [int] IDENTITY(1,1) NOT NULL,
--	[date_order] [datetime] NULL,
--	[id_agent] [int] NULL,
--	[info] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[execution_time] [datetime] NULL,
--	[execution_date] [datetime] NULL,
--	[sum_order] [decimal](15, 2) NULL,
--	[sum_discount] [decimal](15, 2) NULL,
--	[state] [tinyint] NULL,
--	[phone] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[adress] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
-- CONSTRAINT [PRIMARY010] PRIMARY KEY CLUSTERED 
--(
--	[id_order] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_order] UNIQUE NONCLUSTERED 
--(
--	[id_order] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
/****** Object:  Table [dbo].[measurement]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[measurement]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.measurement.
--CREATE TABLE [dbo].[measurement](
--	[id_measurement] [int] IDENTITY(1,1) NOT NULL,
--	[full_name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[short_name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
-- CONSTRAINT [PRIMARY009] PRIMARY KEY CLUSTERED 
--(
--	[id_measurement] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_measurement] UNIQUE NONCLUSTERED 
--(
--	[id_measurement] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
/****** Object:  Table [dbo].[link_dish_group]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[link_dish_group]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.link_dish_group.
--CREATE TABLE [dbo].[link_dish_group](
--	[id_link_dish_group] [int] IDENTITY(1,1) NOT NULL,
--	[id_dish] [int] NULL,
--	[id_group] [int] NULL,
-- CONSTRAINT [PRIMARY008] PRIMARY KEY CLUSTERED 
--(
--	[id_link_dish_group] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_link_dish_group] UNIQUE NONCLUSTERED 
--(
--	[id_link_dish_group] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[link_dish_group] ON
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (1, 1, 1)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (2, 1, 2)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (3, 2, 1)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (4, 3, 1)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (5, 3, 2)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (6, 4, 2)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (7, 1, 5)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (8, 5, 3)
GO
INSERT [dbo].[link_dish_group] ([id_link_dish_group], [id_dish], [id_group]) VALUES (9, 5, 2)
GO
SET IDENTITY_INSERT [dbo].[link_dish_group] OFF
GO
/****** Object:  Table [dbo].[ingredients]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ingredients]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.ingredients.
--CREATE TABLE [dbo].[ingredients](
--	[id_ingredients] [int] IDENTITY(1,1) NOT NULL,
--	[full_name] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[short_name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[id_measure] [int] NULL,
-- CONSTRAINT [PRIMARY007] PRIMARY KEY CLUSTERED 
--(
--	[id_ingredients] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_ingredients] UNIQUE NONCLUSTERED 
--(
--	[id_ingredients] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[ingredients] ON
GO
INSERT [dbo].[ingredients] ([id_ingredients], [full_name], [short_name], [id_measure]) VALUES (1, N'траляля', N'ля', NULL)
GO
INSERT [dbo].[ingredients] ([id_ingredients], [full_name], [short_name], [id_measure]) VALUES (2, N'пум-пурум', N'пум', NULL)
GO
INSERT [dbo].[ingredients] ([id_ingredients], [full_name], [short_name], [id_measure]) VALUES (3, N'вай-вай', N'вай', NULL)
GO
INSERT [dbo].[ingredients] ([id_ingredients], [full_name], [short_name], [id_measure]) VALUES (4, N'гоц-гоц', N'гоц', NULL)
GO
INSERT [dbo].[ingredients] ([id_ingredients], [full_name], [short_name], [id_measure]) VALUES (5, N'хрум хрум', N'хрум', NULL)
GO
SET IDENTITY_INSERT [dbo].[ingredients] OFF
GO
/****** Object:  Table [dbo].[GoodsSales]    Script Date: 05/06/2011 23:48:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GoodsSales]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.GoodsSales.
--CREATE TABLE [dbo].[GoodsSales](
--	[gs_id] [int] IDENTITY(1,1) NOT NULL,
--	[gs_so_id] [int] NOT NULL,
--	[gs_good_id] [int] NOT NULL,
--	[gs_count] [int] NOT NULL,
--	[gs_price] [int] NOT NULL,
-- CONSTRAINT [PRIMARY006] PRIMARY KEY CLUSTERED 
--(
--	[gs_id] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[GoodsSales] ON
GO
INSERT [dbo].[GoodsSales] ([gs_id], [gs_so_id], [gs_good_id], [gs_count], [gs_price]) VALUES (1, 1, 3, 213, 324)
GO
INSERT [dbo].[GoodsSales] ([gs_id], [gs_so_id], [gs_good_id], [gs_count], [gs_price]) VALUES (2, 2, 2, 342, 15)
GO
INSERT [dbo].[GoodsSales] ([gs_id], [gs_so_id], [gs_good_id], [gs_count], [gs_price]) VALUES (3, 1, 1, 324, 1)
GO
SET IDENTITY_INSERT [dbo].[GoodsSales] OFF
GO
/****** Object:  Table [dbo].[Goods]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Goods]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.Goods.
--CREATE TABLE [dbo].[Goods](
--	[good_id] [int] IDENTITY(1,1) NOT NULL,
--	[good_name] [nvarchar](50) COLLATE Ukrainian_CI_AS NOT NULL,
--	[good_count] [int] NOT NULL,
--	[good_curprice] [int] NOT NULL,
-- CONSTRAINT [PRIMARY005] PRIMARY KEY CLUSTERED 
--(
--	[good_id] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[Goods] ON
GO
INSERT [dbo].[Goods] ([good_id], [good_name], [good_count], [good_curprice]) VALUES (1, N'good1', 543, 5)
GO
INSERT [dbo].[Goods] ([good_id], [good_name], [good_count], [good_curprice]) VALUES (2, N'good2', 3, 19)
GO
INSERT [dbo].[Goods] ([good_id], [good_name], [good_count], [good_curprice]) VALUES (3, N'good3', 2343, 23)
GO
SET IDENTITY_INSERT [dbo].[Goods] OFF
GO
/****** Object:  Table [dbo].[dish_ingredients]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish_ingredients]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.dish_ingredients.
--CREATE TABLE [dbo].[dish_ingredients](
--	[id_dish_ingredients] [int] IDENTITY(1,1) NOT NULL,
--	[id_dish] [int] NULL,
--	[id_ingredient] [int] NULL,
--	[count] [decimal](15, 2) NULL,
-- CONSTRAINT [PRIMARY004] PRIMARY KEY CLUSTERED 
--(
--	[id_dish_ingredients] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_dish_ingredients] UNIQUE NONCLUSTERED 
--(
--	[id_dish_ingredients] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[dish_ingredients] ON
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (14, 4, 1, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (15, 4, 2, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (16, 4, 4, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (17, 46, 1, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (18, 46, 2, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (19, 46, 3, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (20, 46, 4, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (21, 5, 1, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (22, 5, 3, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (24, 42, 42, CAST(43.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (25, 41, 2, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (26, 41, 3, CAST(1.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (27, 41, 4, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (28, 41, 5, NULL)
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (30, 5, 2, CAST(20.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish_ingredients] ([id_dish_ingredients], [id_dish], [id_ingredient], [count]) VALUES (31, 5, 4, NULL)
GO
SET IDENTITY_INSERT [dbo].[dish_ingredients] OFF
GO
/****** Object:  Table [dbo].[dish_groups]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish_groups]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.dish_groups.
--CREATE TABLE [dbo].[dish_groups](
--	[id_dish_group] [int] IDENTITY(1,1) NOT NULL,
--	[name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[description] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[id_owner_group] [int] NULL,
-- CONSTRAINT [PRIMARY003] PRIMARY KEY CLUSTERED 
--(
--	[id_dish_group] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_dish_goup] UNIQUE NONCLUSTERED 
--(
--	[id_dish_group] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[dish_groups] ON
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (1, N'Страви', N'Страви', NULL)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (2, N'Піца', N'піца', 1)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (3, N'Салати', N'салати', 1)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (4, N'Закуска', N'закуска', 1)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (5, N'Алкоголь', N'випивка', NULL)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (6, N'Пивко', N'пивко', 5)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (7, N'Горілочка', N'горілочка', 5)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (8, N'Соки', N'соки', NULL)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (9, N'Sandora', NULL, 8)
GO
INSERT [dbo].[dish_groups] ([id_dish_group], [name], [description], [id_owner_group]) VALUES (10, N'Садочок', NULL, 8)
GO
SET IDENTITY_INSERT [dbo].[dish_groups] OFF
GO
/****** Object:  Table [dbo].[dish]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dish]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.dish.
--CREATE TABLE [dbo].[dish](
--	[id_dish] [int] IDENTITY(1,1) NOT NULL,
--	[name] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[time] [datetime] NULL,
--	[info] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[tags] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[receipt] [nvarchar](200) COLLATE Ukrainian_CI_AS NULL,
--	[price] [decimal](15, 2) NULL,
-- CONSTRAINT [PRIMARY002] PRIMARY KEY CLUSTERED 
--(
--	[id_dish] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_dish] UNIQUE NONCLUSTERED 
--(
--	[id_dish] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[dish] ON
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (1, N'qqqq', CAST(0xFFFFFFFE00107AC0 AS DateTime), N'qwe', N'qwe', N'qwe', CAST(1.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (2, N'qwe', CAST(0xFFFFFFFE00000000 AS DateTime), N'info', N'tags', N'receipt', CAST(2.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (3, N'qwe11', CAST(0xFFFFFFFE00083D60 AS DateTime), N'qwe11', N'qwe1', N'qwe', CAST(3.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (4, N'void', CAST(0xFFFFFFFE00000000 AS DateTime), N'void', N'void', N'void', CAST(4.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (5, N'yyyy', CAST(0xFFFFFFFE00041EB0 AS DateTime), N'sdasd', N'солодка страва', N'приготування страви риває 20 хв.', CAST(5.00 AS Decimal(15, 2)))
GO
INSERT [dbo].[dish] ([id_dish], [name], [time], [info], [tags], [receipt], [price]) VALUES (6, N'tyu', CAST(0xFFFFFFFE00035D54 AS DateTime), N'sadsddsad', N'курага десерт пиво недобре', NULL, CAST(6.00 AS Decimal(15, 2)))
GO
SET IDENTITY_INSERT [dbo].[dish] OFF
GO
/****** Object:  Table [dbo].[comments]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[comments]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.comments.
--CREATE TABLE [dbo].[comments](
--	[id_comments] [int] IDENTITY(1,1) NOT NULL,
--	[text] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[id_client] [int] NULL,
-- CONSTRAINT [PRIMARY001] PRIMARY KEY CLUSTERED 
--(
--	[id_comments] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_comments] UNIQUE NONCLUSTERED 
--(
--	[id_comments] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
/****** Object:  Table [dbo].[agents]    Script Date: 05/06/2011 23:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[agents]') AND type in (N'U'))
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.agents.
--CREATE TABLE [dbo].[agents](
--	[id_agents] [int] IDENTITY(1,1) NOT NULL,
--	[name] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
--	[login] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[psw] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[phone] [nvarchar](45) COLLATE Ukrainian_CI_AS NULL,
--	[adress] [nvarchar](100) COLLATE Ukrainian_CI_AS NULL,
-- CONSTRAINT [PRIMARY] PRIMARY KEY CLUSTERED 
--(
--	[id_agents] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF),
-- CONSTRAINT [id_agents] UNIQUE NONCLUSTERED 
--(
--	[id_agents] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = OFF, ALLOW_PAGE_LOCKS  = OFF)
--)

END
GO
SET IDENTITY_INSERT [dbo].[agents] ON
GO
INSERT [dbo].[agents] ([id_agents], [name], [login], [psw], [phone], [adress]) VALUES (1, N'1', N'2', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[agents] OFF
GO
/****** Object:  Default [DF__dish__price__0425A276]    Script Date: 05/06/2011 23:48:23 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__dish__price__0425A276]') AND parent_object_id = OBJECT_ID(N'[dbo].[dish]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__dish__price__0425A276]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__dish__price__0425A276.
--ALTER TABLE [dbo].[dish] ADD  CONSTRAINT [DF__dish__price__0425A276]  DEFAULT ((0.00)) FOR [price]

END


End
GO
/****** Object:  Default [DF__Goods__good_coun__0DAF0CB0]    Script Date: 05/06/2011 23:48:23 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Goods__good_coun__0DAF0CB0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Goods]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Goods__good_coun__0DAF0CB0]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__Goods__good_coun__0DAF0CB0.
--ALTER TABLE [dbo].[Goods] ADD  CONSTRAINT [DF__Goods__good_coun__0DAF0CB0]  DEFAULT ((0)) FOR [good_count]

END


End
GO
/****** Object:  Default [DF__Goods__good_curp__0EA330E9]    Script Date: 05/06/2011 23:48:23 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Goods__good_curp__0EA330E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[Goods]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Goods__good_curp__0EA330E9]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__Goods__good_curp__0EA330E9.
--ALTER TABLE [dbo].[Goods] ADD  CONSTRAINT [DF__Goods__good_curp__0EA330E9]  DEFAULT ((0)) FOR [good_curprice]

END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_so__117F9D94]    Script Date: 05/06/2011 23:48:24 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_so__117F9D94]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_so__117F9D94]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__GoodsSale__gs_so__117F9D94.
--ALTER TABLE [dbo].[GoodsSales] ADD  CONSTRAINT [DF__GoodsSale__gs_so__117F9D94]  DEFAULT ((0)) FOR [gs_so_id]

END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_go__1273C1CD]    Script Date: 05/06/2011 23:48:24 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_go__1273C1CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_go__1273C1CD]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__GoodsSale__gs_go__1273C1CD.
--ALTER TABLE [dbo].[GoodsSales] ADD  CONSTRAINT [DF__GoodsSale__gs_go__1273C1CD]  DEFAULT ((0)) FOR [gs_good_id]

END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_co__1367E606]    Script Date: 05/06/2011 23:48:24 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_co__1367E606]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_co__1367E606]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__GoodsSale__gs_co__1367E606.
--ALTER TABLE [dbo].[GoodsSales] ADD  CONSTRAINT [DF__GoodsSale__gs_co__1367E606]  DEFAULT ((0)) FOR [gs_count]

END


End
GO
/****** Object:  Default [DF__GoodsSale__gs_pr__145C0A3F]    Script Date: 05/06/2011 23:48:24 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__GoodsSale__gs_pr__145C0A3F]') AND parent_object_id = OBJECT_ID(N'[dbo].[GoodsSales]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__GoodsSale__gs_pr__145C0A3F]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__GoodsSale__gs_pr__145C0A3F.
--ALTER TABLE [dbo].[GoodsSales] ADD  CONSTRAINT [DF__GoodsSale__gs_pr__145C0A3F]  DEFAULT ((0)) FOR [gs_price]

END


End
GO
/****** Object:  Default [DF__SalesOper__so_ti__25869641]    Script Date: 05/06/2011 23:48:25 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__SalesOper__so_ti__25869641]') AND parent_object_id = OBJECT_ID(N'[dbo].[SalesOperations]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SalesOper__so_ti__25869641]') AND type = 'D')
BEGIN
--Указанная ниже инструкция импортирована в проект базы данных как объект схемы с именем dbo.DF__SalesOper__so_ti__25869641.
--ALTER TABLE [dbo].[SalesOperations] ADD  CONSTRAINT [DF__SalesOper__so_ti__25869641]  DEFAULT ('0000-00-00 00:00:00') FOR [so_time]

END


End

GO
