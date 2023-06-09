USE [SportDB]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatusID] [int] NOT NULL,
	[PickupPointID] [int] NOT NULL,
	[OrderCreateDate] [datetime] NOT NULL,
	[OrderDeliveryDate] [datetime] NOT NULL,
	[UserID] [int] NULL,
	[OrderGetCode] [int] NOT NULL,
 CONSTRAINT [PK__Order__C3905BAFAD93ECDB] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED 
(
	[OrderProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusID] [int] NOT NULL,
	[OrderStatusName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickupPoint](
	[PickupPointID] [int] NOT NULL,
	[Address] [varchar](max) NOT NULL,
 CONSTRAINT [PK_PickUpPoint] PRIMARY KEY CLUSTERED 
(
	[PickupPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[UnitTypeID] [int] NOT NULL,
	[ProductCost] [decimal](19, 4) NOT NULL,
	[ProductMaxDiscountAmount] [tinyint] NULL,
	[ProductManufacturerID] [int] NOT NULL,
	[ProductSupplierID] [int] NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[ProductDiscountAmount] [tinyint] NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductPhoto] [nvarchar](100) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductCategoryID] [int] NOT NULL,
	[ProductCategoryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductManufacturer]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductManufacturer](
	[ProductManufacturerID] [int] NOT NULL,
	[ProductManufacturerName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ProductManufacturer] PRIMARY KEY CLUSTERED 
(
	[ProductManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSupplier]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSupplier](
	[ProductSupplierID] [int] NOT NULL,
	[ProductSupplierName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ProductSupplier] PRIMARY KEY CLUSTERED 
(
	[ProductSupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitType]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitType](
	[UnitTypeID] [int] NOT NULL,
	[UnitTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_UnitType] PRIMARY KEY CLUSTERED 
(
	[UnitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 29.04.2023 9:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserLogin] [nvarchar](max) NOT NULL,
	[UserPassword] [nvarchar](max) NOT NULL,
	[UserSurname] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPatronymic] [nvarchar](100) NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (1, 1, 18, CAST(N'2022-05-15T00:00:00.000' AS DateTime), CAST(N'2022-05-21T00:00:00.000' AS DateTime), 51, 401)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (2, 1, 20, CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(N'2022-05-22T00:00:00.000' AS DateTime), 52, 402)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (3, 2, 20, CAST(N'2022-05-17T00:00:00.000' AS DateTime), CAST(N'2022-05-23T00:00:00.000' AS DateTime), 53, 403)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (4, 1, 22, CAST(N'2022-05-18T00:00:00.000' AS DateTime), CAST(N'2022-05-24T00:00:00.000' AS DateTime), 54, 404)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (5, 1, 22, CAST(N'2022-05-19T00:00:00.000' AS DateTime), CAST(N'2022-05-25T00:00:00.000' AS DateTime), NULL, 405)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (6, 1, 16, CAST(N'2022-05-19T00:00:00.000' AS DateTime), CAST(N'2022-05-25T00:00:00.000' AS DateTime), NULL, 406)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (7, 2, 16, CAST(N'2022-05-21T00:00:00.000' AS DateTime), CAST(N'2022-05-27T00:00:00.000' AS DateTime), NULL, 407)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (8, 2, 18, CAST(N'2022-05-22T00:00:00.000' AS DateTime), CAST(N'2022-05-28T00:00:00.000' AS DateTime), NULL, 408)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (9, 1, 24, CAST(N'2022-05-23T00:00:00.000' AS DateTime), CAST(N'2022-05-29T00:00:00.000' AS DateTime), NULL, 409)
INSERT [dbo].[Order] ([OrderID], [OrderStatusID], [PickupPointID], [OrderCreateDate], [OrderDeliveryDate], [UserID], [OrderGetCode]) VALUES (10, 2, 24, CAST(N'2022-05-24T00:00:00.000' AS DateTime), CAST(N'2022-05-30T00:00:00.000' AS DateTime), NULL, 410)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderProduct] ON 

INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (1, 1, 1, 2)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (2, 2, 1, 2)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (3, 3, 2, 3)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (4, 4, 2, 3)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (5, 6, 3, 10)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (6, 7, 3, 10)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (7, 8, 4, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (8, 9, 4, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (9, 11, 5, 10)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (10, 12, 5, 10)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (11, 13, 6, 2)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (12, 14, 6, 2)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (13, 15, 7, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (14, 16, 7, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (15, 17, 8, 3)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (16, 18, 8, 3)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (17, 23, 9, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (18, 24, 9, 1)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (19, 28, 10, 5)
INSERT [dbo].[OrderProduct] ([OrderProductID], [ProductID], [OrderID], [Count]) VALUES (20, 29, 10, 5)
SET IDENTITY_INSERT [dbo].[OrderProduct] OFF
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (1, N'Новый ')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (2, N'Завершен')
GO
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (1, N'344288, г. Дубна, ул. Чехова, 1')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (2, N'614164, г.Дубна,  ул. Степная, 30')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (3, N'394242, г. Дубна, ул. Коммунистическая, 43')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (4, N'660540, г. Дубна, ул. Солнечная, 25')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (5, N'125837, г. Дубна, ул. Шоссейная, 40')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (6, N'125703, г. Дубна, ул. Партизанская, 49')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (7, N'625283, г. Дубна, ул. Победы, 46')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (8, N'614611, г. Дубна, ул. Молодежная, 50')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (9, N'454311, г.Дубна, ул. Новая, 19')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (10, N'660007, г.Дубна, ул. Октябрьская, 19')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (11, N'603036, г. Дубна, ул. Садовая, 4')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (12, N'450983, г.Дубна, ул. Комсомольская, 26')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (13, N'394782, г. Дубна, ул. Чехова, 3')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (14, N'603002, г. Дубна, ул. Дзержинского, 28')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (15, N'450558, г. Дубна, ул. Набережная, 30')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (16, N'394060, г.Дубна, ул. Фрунзе, 43')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (17, N'410661, г. Дубна, ул. Школьная, 50')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (18, N'625590, г. Дубна, ул. Коммунистическая, 20')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (19, N'625683, г. Дубна, ул. 8 Марта')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (20, N'400562, г. Дубна, ул. Зеленая, 32')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (21, N'614510, г. Дубна, ул. Маяковского, 47')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (22, N'410542, г. Дубна, ул. Светлая, 46')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (23, N'620839, г. Дубна, ул. Цветочная, 8')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (24, N'443890, г. Дубна, ул. Коммунистическая, 1')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (25, N'603379, г. Дубна, ул. Спортивная, 46')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (26, N'603721, г. Дубна, ул. Гоголя, 41')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (27, N'410172, г. Дубна, ул. Северная, 13')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (28, N'420151, г. Дубна, ул. Вишневая, 32')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (29, N'125061, г. Дубна, ул. Подгорная, 8')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (30, N'630370, г. Дубна, ул. Шоссейная, 24')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (31, N'614753, г. Дубна, ул. Полевая, 35')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (32, N'426030, г. Дубна, ул. Маяковского, 44')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (33, N'450375, г. Дубна ул. Клубная, 44')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (34, N'625560, г. Дубна, ул. Некрасова, 12')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (35, N'630201, г. Дубна, ул. Комсомольская, 17')
INSERT [dbo].[PickupPoint] ([PickupPointID], [Address]) VALUES (36, N'190949, г. Дубна, ул. Мичурина, 26')
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (1, N'А112Т4', N'Боксерская груша', 1, CAST(778.0000 AS Decimal(19, 4)), 30, 1, 1, 1, 5, 6, N'Боксерская груша X-Match черная', N'А112Т4.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (2, N'G598Y6', N'Спортивный мат', 1, CAST(2390.0000 AS Decimal(19, 4)), 15, 2, 2, 1, 2, 16, N'Спортивный мат 100x100x10 см Perfetto Sport № 3 бежевый', N'G598Y6.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (3, N'F746E6', N'Шведская стенка', 1, CAST(9900.0000 AS Decimal(19, 4)), 10, 3, 2, 1, 3, 5, N'Шведская стенка ROMANA Next, pastel', N'F746E6.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (4, N'D830R5', N'Тренажер прыжков', 1, CAST(1120.0000 AS Decimal(19, 4)), 15, 4, 1, 1, 4, 8, N'Тренажер для прыжков Moby Kids Moby-Jumper со счетчиком', N'D830R5.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (5, N'B538G6', N'Спортивный костюм', 1, CAST(839.0000 AS Decimal(19, 4)), 5, 5, 1, 2, 3, 17, N'Спортивный костюм playToday (футболка + шорты)', N'B538G6.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (6, N'D648N7', N'Набор для хоккея', 1, CAST(350.0000 AS Decimal(19, 4)), 10, 6, 2, 1, 4, 7, N'Набор для хоккея Совтехстром', N'D648N7.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (7, N'F735B6', N'Игровой набор', 1, CAST(320.0000 AS Decimal(19, 4)), 15, 6, 2, 1, 2, 9, N'Игровой набор Совтехстром Кегли и шары', N'F735B6.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (8, N'F937G4', N'Игровой набор', 1, CAST(480.0000 AS Decimal(19, 4)), 10, 7, 1, 1, 4, 12, N'Набор Abtoys Бадминтон и теннис ', N'F937G4.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (9, N'E324U7', N'Велотренажер', 1, CAST(6480.0000 AS Decimal(19, 4)), 25, 8, 1, 1, 5, 5, N'Велотренажер двойной DFC B804 dual bike', N'E324U7.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (10, N'G403T5', N'Тюбинг', 1, CAST(1450.0000 AS Decimal(19, 4)), 15, 9, 1, 1, 4, 13, N'Тюбинг Nordway, 73 см', N'G403T5.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (11, N'N483G5', N'Клюшка', 1, CAST(1299.0000 AS Decimal(19, 4)), 10, 9, 2, 1, 3, 4, N'Клюшка Nordway NDW300 (2019/2020) SR лев. 19 150см', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (12, N'D038G6', N'Лыжный комплект', 1, CAST(3000.0000 AS Decimal(19, 4)), 30, 9, 2, 1, 4, 23, N'Лыжный комплект беговые NORDWAY XC Classic, 45-45-45мм, 160см', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (13, N'G480F5', N'Ролики', 1, CAST(1600.0000 AS Decimal(19, 4)), 15, 10, 1, 1, 4, 7, N'Коньки роликовые Ridex Cricket жен. ABEC 3 кол.:72мм р.:39-42 синий', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (14, N'C324S5', N'Шлем', 1, CAST(4000.0000 AS Decimal(19, 4)), 10, 11, 2, 1, 5, 16, N'Шлем г.л./сноуб. Salomon Grom р.:KS черный (L40836800)', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (15, N'V312R4', N'Мяч', 1, CAST(4150.0000 AS Decimal(19, 4)), 20, 12, 2, 1, 2, 5, N'Мяч волейбольный MIKASA VT370W, для зала, 5-й размер, желтый/синий', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (16, N'J4DF5E', N'Насос', 1, CAST(300.0000 AS Decimal(19, 4)), 5, 13, 1, 1, 4, 12, N'Насос Molten HP-18-B для мячей мультиколор', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (17, N'G522B5', N'Ласты', 1, CAST(1980.0000 AS Decimal(19, 4)), 15, 14, 2, 1, 3, 6, N'Ласты Colton CF-02 для плавания р.:33-34 серый/голубой', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (18, N'K432G6', N'Шапочка для плавания', 1, CAST(440.0000 AS Decimal(19, 4)), 25, 15, 2, 1, 5, 17, N'Шапочка для плавания Atemi PU 140 ткань с покрытием желтый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (19, N'J532D4', N'Перчатки для карате', 1, CAST(1050.0000 AS Decimal(19, 4)), 15, 16, 1, 1, 3, 5, N'Перчатки для каратэ Green Hill KMС-6083 L красный', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (20, N'G873H4', N'Велосипед', 1, CAST(14930.0000 AS Decimal(19, 4)), 5, 17, 1, 1, 4, 6, N'Велосипед SKIF 29 Disc (2021), горный (взрослый), рама: 17", колеса: 29", темно-серый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (21, N'V423D4', N'Штанга', 1, CAST(5600.0000 AS Decimal(19, 4)), 10, 18, 2, 1, 3, 8, N'Штанга Starfit BB-401 30кг пласт. черный ', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (22, N'K937A5', N'Гиря', 1, CAST(890.0000 AS Decimal(19, 4)), 5, 18, 2, 1, 4, 10, N'Гиря Starfit ГМБ4 мягкое 4кг синий/оранжевый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (23, N'F047J7', N'Коврик', 1, CAST(720.0000 AS Decimal(19, 4)), 15, 19, 1, 1, 5, 11, N'Коврик Bradex для мягкой йоги дл.:1730мм ш.:610мм т.:3мм серый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (24, N'S374B5', N'Ролик для йоги', 1, CAST(700.0000 AS Decimal(19, 4)), 10, 19, 1, 1, 3, 12, N'Ролик для йоги Bradex Туба d=14см ш.:33см оранжевый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (25, N'F687G5', N'Защита голени', 1, CAST(1900.0000 AS Decimal(19, 4)), 15, 16, 1, 1, 4, 6, N'Защита голени GREEN HILL Panther, L, синий/черный', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (26, N'N892G6', N'Очки для плавания', 1, CAST(500.0000 AS Decimal(19, 4)), 5, 15, 2, 1, 5, 14, N'Очки для плавания Atemi N8401 синий', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (27, N'D893W4', N'Мяч', 1, CAST(900.0000 AS Decimal(19, 4)), 5, 20, 1, 1, 2, 5, N'Мяч футбольный DEMIX 1STLS1JWWW, универсальный, 4-й размер, белый/зеленый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (28, N'N836R5', N'Коньки', 1, CAST(2000.0000 AS Decimal(19, 4)), 10, 15, 2, 1, 3, 16, N'Коньки ATEMI AKSK01DXS, раздвижные, прогулочные, унисекс, 27-30, черный/зеленый', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (29, N'D927K3', N'Перчатки ', 1, CAST(660.0000 AS Decimal(19, 4)), 15, 18, 2, 1, 4, 3, N'Перчатки Starfit SU-125 атлетические S черный', N'')
INSERT [dbo].[Product] ([ProductID], [ProductArticleNumber], [ProductName], [UnitTypeID], [ProductCost], [ProductMaxDiscountAmount], [ProductManufacturerID], [ProductSupplierID], [ProductCategoryID], [ProductDiscountAmount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (30, N'V392H7', N'Степ-платформа', 1, CAST(4790.0000 AS Decimal(19, 4)), 10, 18, 1, 1, 3, 15, N'Степ-платформа Starfit SP-204 серый/черный', N'')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [ProductCategoryName]) VALUES (1, N'Спортивный инвентарь')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [ProductCategoryName]) VALUES (2, N'Одежда')
GO
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (1, N'X-Match')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (2, N'Perfetto Sport')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (3, N'ROMANA Next')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (4, N'Moby Kids')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (5, N'playToday')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (6, N'Совтехстром')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (7, N'Abtoys')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (8, N'DFC')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (9, N'Nordway')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (10, N'Ridex')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (11, N'Salomon')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (12, N'Mikasa')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (13, N'Molten')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (14, N'Colton')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (15, N'Atemi')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (16, N'Green Hill')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (17, N'SKIF')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (18, N'Starfit')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (19, N'Bradex')
INSERT [dbo].[ProductManufacturer] ([ProductManufacturerID], [ProductManufacturerName]) VALUES (20, N'Demix')
GO
INSERT [dbo].[ProductSupplier] ([ProductSupplierID], [ProductSupplierName]) VALUES (1, N'Спортмастер')
INSERT [dbo].[ProductSupplier] ([ProductSupplierID], [ProductSupplierName]) VALUES (2, N'Декатлон')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Администратор')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Менеджер')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[UnitType] ([UnitTypeID], [UnitTypeName]) VALUES (1, N'шт.')
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (1, N'Никифоров ', N'Всеволод', N'Иванович', N'loginDEjrm2018', N'Cpb+Im', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (2, N'Воронов ', N'Донат', N'Никитевич', N'loginDEpxl2018', N'P6h4Jq', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (3, N'Игнатьева ', N'Евгения', N'Валентиновна', N'loginDEwgk2018', N'&mfI9l', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (4, N'Буров ', N'Федот', N'Егорович', N'loginDEpou2018', N'gX3f5Z', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (5, N'Иван ', N'Семёновна', N'', N'loginDEjwl2018', N'D4ZYHt', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (6, N'Денисов ', N'Дамир', N'Филатович', N'loginDEabf2018', N'*Tasm+', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (7, N'Ершов ', N'Максим', N'Геласьевич', N'loginDEwjm2018', N'k}DJKo', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (8, N'Копылов ', N'Куприян', N'Пётрович', N'loginDEjvz2018', N'&|bGTy', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (9, N'Носов ', N'Валерьян', N'Дмитрьевич', N'loginDEuyv2018', N'8hhrZ}', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (10, N'Силин ', N'Игорь', N'Авдеевич', N'loginDExdm2018', N'DH68L9', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (11, N'Дроздова ', N'Александра', N'Мартыновна', N'loginDEeiv2018', N'H*BxlS', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (12, N'Дроздов ', N'Аркадий', N'Геласьевич', N'loginDEfuc2018', N'VuM+QT', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (13, N'Боброва ', N'Варвара', N'Евсеевна', N'loginDEoot2018', N'usi{aT', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (14, N'Чернова ', N'Агата', N'Данииловна', N'loginDElhk2018', N'Okk0jY', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (15, N'Лыткина ', N'Ульяна', N'Станиславовна', N'loginDEazg2018', N's3bb|V', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (16, N'Лаврентьев ', N'Леонид', N'Игнатьевич', N'loginDEaba2018', N'#ИМЯ?', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (17, N'Кулаков ', N'Юрий', N'Владленович', N'loginDEtco2018', N'tTKDJB', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (18, N'Соловьёв ', N'Андрей', N'Александрович', N'loginDEsyq2018', N'2QbpBN', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (19, N'Корнилова ', N'Марфа', N'Макаровна', N'loginDEpxi2018', N'+5X&hy', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (20, N'Белоусова ', N'Любовь', N'Георгьевна', N'loginDEicr2018', N'3+|Sn{', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (21, N'Анисимов ', N'Никита', N'Гордеевич', N'loginDEcui2018', N'Zi1Tth', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (22, N'Стрелкова ', N'Фаина', N'Федосеевна', N'loginDEpxc2018', N'G+nFsv', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (23, N'Осипов ', N'Евгений', N'Иванович', N'loginDEqrd2018', N'sApUbt', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (24, N'Владимирова ', N'Иванна', N'Павловна', N'loginDEsso2018', N'#ИМЯ?', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (25, N'Кудрявцева ', N'Жанна', N'Демьяновна', N'loginDErsy2018', N'{Aa6nS', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (26, N'Матвиенко ', N'Яков', N'Брониславович', N'loginDEvpz2018', N'mS0UxK', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (27, N'Селезнёв ', N'Егор', N'Артёмович', N'loginDEfog2018', N'glICay', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (28, N'Брагин ', N'Куприян', N'Митрофанович', N'loginDEpii2018', N'Ob}RZB', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (29, N'Гордеев ', N'Виктор', N'Эдуардович', N'loginDEhyk2018', N'*gN}Tc', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (30, N'Мартынов ', N'Онисим', N'Брониславович', N'loginDEdxi2018', N'ywLUbA', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (31, N'Никонова ', N'Евгения', N'Павловна', N'loginDEzro2018', N'B24s6o', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (32, N'Полякова ', N'Анна', N'Денисовна', N'loginDEuxg2018', N'K8jui7', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (33, N'Макарова ', N'Пелагея', N'Антониновна', N'loginDEllw2018', N'jNtNUr', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (34, N'Андреева ', N'Анна', N'Вячеславовна', N'loginDEddg2018', N'gGGhvD', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (35, N'Кудрявцева ', N'Кира', N'Ефимовна', N'loginDEpdz2018', N'#ИМЯ?', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (36, N'Шилова ', N'Кира', N'Егоровна', N'loginDEyiw2018', N'cnj3QR', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (37, N'Ситников ', N'Игорь', N'Борисович', N'loginDEqup2018', N'95AU|R', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (38, N'Русаков ', N'Борис', N'Христофорович', N'loginDExil2018', N'w+++Ht', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (39, N'Капустина ', N'Ульяна', N'Игоревна', N'loginDEkuv2018', N'Ade++|', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (40, N'Беляков ', N'Семён', N'Германнович', N'loginDEmox2018', N'Je}9e7', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (41, N'Гурьев ', N'Ириней', N'Игнатьевич', N'loginDEvug2018', N'lEa{Cn', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (42, N'Мишин ', N'Христофор', N'Леонидович', N'loginDEzre2018', N'N*VX+G', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (43, N'Лазарева ', N'Антонина', N'Христофоровна', N'loginDEbes2018', N'NaVtyH', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (44, N'Маркова ', N'Ираида', N'Сергеевна', N'loginDEkfg2018', N'r1060q', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (45, N'Носкова ', N'Пелагея', N'Валерьевна', N'loginDEyek2018', N'KY2BL4', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (46, N'Баранов ', N'Станислав', N'Дмитрьевич', N'loginDEloq2018', N'NZV5WR', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (47, N'Ефремов ', N'Демьян', N'Артёмович', N'loginDEjfb2018', N'TNT+}h', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (48, N'Константинов ', N'Всеволод', N'Мэлсович', N'loginDEueq2018', N'GqAUZ6', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (49, N'Ситникова ', N'Ираида', N'Андреевна', N'loginDEpqz2018', N'F0Bp7F', 3)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (50, N'Матвеев ', N'Кондрат', N'Иванович', N'loginDEovk2018', N'JyJM{A', 2)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (51, N'Поляков', N'Степан', N'Егорович', N'user1', N'1', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (52, N'Леонова', N'Алиса', N'Кирилловна', N'user2', N'2', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (53, N'Яковлев', N'Платон', N'Константинович', N'user3', N'3', 1)
INSERT [dbo].[User] ([UserID], [UserLogin], [UserPassword], [UserSurname], [UserName], [UserPatronymic], [RoleID]) VALUES (54, N'Ковалева', N'Ева', N'Яковлевна', N'user4', N'4', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupPoint] FOREIGN KEY([PickupPointID])
REFERENCES [dbo].[PickupPoint] ([PickupPointID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickupPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Order]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductCategory] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[ProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductCategory]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductManufacturer] FOREIGN KEY([ProductManufacturerID])
REFERENCES [dbo].[ProductManufacturer] ([ProductManufacturerID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductManufacturer]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductSupplier] FOREIGN KEY([ProductSupplierID])
REFERENCES [dbo].[ProductSupplier] ([ProductSupplierID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductSupplier]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitType] FOREIGN KEY([UnitTypeID])
REFERENCES [dbo].[UnitType] ([UnitTypeID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_UnitType]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
