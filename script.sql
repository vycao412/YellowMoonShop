USE [master]
GO
/****** Object:  Database [J3.L.P0011]    Script Date: 12/16/2020 10:31:39 PM ******/
CREATE DATABASE [J3.L.P0011]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'J3.L.P0011', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\J3.L.P0011.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'J3.L.P0011_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\J3.L.P0011_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [J3.L.P0011] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [J3.L.P0011].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [J3.L.P0011] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [J3.L.P0011] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [J3.L.P0011] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [J3.L.P0011] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [J3.L.P0011] SET ARITHABORT OFF 
GO
ALTER DATABASE [J3.L.P0011] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [J3.L.P0011] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [J3.L.P0011] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [J3.L.P0011] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [J3.L.P0011] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [J3.L.P0011] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [J3.L.P0011] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [J3.L.P0011] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [J3.L.P0011] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [J3.L.P0011] SET  DISABLE_BROKER 
GO
ALTER DATABASE [J3.L.P0011] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [J3.L.P0011] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [J3.L.P0011] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [J3.L.P0011] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [J3.L.P0011] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [J3.L.P0011] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [J3.L.P0011] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [J3.L.P0011] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [J3.L.P0011] SET  MULTI_USER 
GO
ALTER DATABASE [J3.L.P0011] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [J3.L.P0011] SET DB_CHAINING OFF 
GO
ALTER DATABASE [J3.L.P0011] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [J3.L.P0011] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [J3.L.P0011] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [J3.L.P0011] SET QUERY_STORE = OFF
GO
USE [J3.L.P0011]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[catID] [varchar](10) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLog](
	[logID] [uniqueidentifier] NOT NULL,
	[userID] [varchar](50) NULL,
	[productID] [uniqueidentifier] NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_tblLog_1] PRIMARY KEY CLUSTERED 
(
	[logID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderID] [varchar](50) NOT NULL,
	[userID] [varchar](50) NULL,
	[total] [float] NULL,
	[date] [date] NULL,
	[name] [nvarchar](100) NULL,
	[phone] [varchar](10) NULL,
	[address] [nvarchar](max) NULL,
	[paymentMethod] [varchar](50) NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[orderDetailID] [uniqueidentifier] NOT NULL,
	[orderID] [varchar](50) NOT NULL,
	[productID] [uniqueidentifier] NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_tblOrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[categoryID] [varchar](10) NOT NULL,
	[image] [varchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[createDate] [date] NOT NULL,
	[expiredDate] [date] NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_tblProduct_1] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [varchar](10) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[statusID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12/16/2020 10:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [varchar](50) NOT NULL,
	[name] [nvarchar](100) NULL,
	[password] [varchar](64) NULL,
	[address] [nvarchar](max) NULL,
	[phone] [varchar](10) NULL,
	[roleID] [varchar](10) NULL,
	[status] [varchar](10) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[tblCategory] ([catID], [name]) VALUES (N'CAT001', N'Bánh nướng')
INSERT [dbo].[tblCategory] ([catID], [name]) VALUES (N'CAT002', N'Bánh dẻo')
GO
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'6cd9a67a-42ce-4872-9de5-1fdbba7876b6', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'11c99c5c-903e-eb11-a0c7-482ae3753c46', N'ad', N'afb42693-1b09-482b-93ef-49c1384a2454', CAST(N'2020-12-15' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'8f7eec39-913e-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-15' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'c52a5f64-913e-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-15' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'c533e6ab-913e-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-15' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'6a13707e-853f-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'29b39cc1-853f-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'e85adcff-853f-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'59111c49-863f-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'43d52e3e-873f-eb11-a0c7-482ae3753c46', N'ad', N'32a391ee-4965-497c-a54f-423bccb42dea', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'ab573515-893f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'ac573515-893f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'4a0ebb1e-893f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'3bc6b145-893f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'e262610c-8a3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'e362610c-8a3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'56b9d5dc-8a3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'f7ab32f2-8a3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'65ba3f34-8b3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'b6cb983a-8b3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'2fbf7795-8b3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'6f7d60bb-8b3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'd093b52a-8c3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'c8b0714c-8d3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'c9b0714c-8d3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'eec30987-8d3f-eb11-a0c7-482ae3753c46', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'a7b9780a-9104-4e5b-86ac-63a57abf71c7', N'ad', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'72e5e143-3218-4ab3-98c8-debae8353ccf', N'ad', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', CAST(N'2020-12-16' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'1ecea26c-0198-44b9-8c40-e39fd82e56ac', N'ad', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', CAST(N'2020-12-16' AS Date))
GO
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608016033844', NULL, 601000, CAST(N'2020-12-15' AS Date), N'test cart', N'01234', N'test cart ne', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608103970664', NULL, 478000, CAST(N'2020-12-16' AS Date), N'12', N'23', N'23', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608104484369', N'test', 601000, CAST(N'2020-12-16' AS Date), N'tester', N'0123', N't', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608105421853', N'test', 724000, CAST(N'2020-12-16' AS Date), N'tester', N'0123', N't', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608109451571', NULL, 478000, CAST(N'2020-12-16' AS Date), N'Vy Cao', N'01234', N'4', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608110346815', NULL, 123000, CAST(N'2020-12-16' AS Date), N'update Quan', N'132', N'update Quan', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608110448369', NULL, 738000, CAST(N'2020-12-16' AS Date), N'test checkquan', N'01234', N'test checkquan', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608119715160', N'1306144389741097', 27478000, CAST(N'2020-12-16' AS Date), N'Cao N. Nhat Vy', N'01234', N'4', N'Cash', 3)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [phone], [address], [paymentMethod], [status]) VALUES (N'1608131789120', N'test', 5400000, CAST(N'2020-12-16' AS Date), N'tester', N'0123', N't', N'Cash', 4)
GO
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'b2ec261f-91eb-4617-87f6-1b00e214dc5f', N'1608104484369', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', 123000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'6343a2f7-5971-4ee0-9d0c-1c54d9793687', N'1608119715160', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'3a445f97-ff39-45a6-872a-287b9ecccf4c', N'1608103970664', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'c863ffea-8a79-4666-823d-3f0bd6522e43', N'1608016033844', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'6547e429-5725-4652-8cc3-6c688a300866', N'1608105421853', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'7ef6d9f4-6341-4829-97ab-7045f611634c', N'1608119715160', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', 5400000, 5)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'5b0e0f39-dfdf-4374-b3b1-7ed9ec5b4961', N'1608109451571', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'efa29608-0dad-4626-a496-a02883a1c9fc', N'1608105421853', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', 123000, 2)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'507851b7-9f37-4c9d-b7bc-b58a0fddbae8', N'1608131789120', N'74632263-d8dc-4a16-aa0f-110f6b54ab73', 5400000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'd0f62963-1e68-4bcf-8c42-ba513d19248e', N'1608104484369', N'32a391ee-4965-497c-a54f-423bccb42dea', 478000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'b0fa940e-9d24-4d88-9411-dba6ad1da20c', N'1608110346815', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', 123000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'dba4c979-7f9f-4914-add9-df6f20dd496d', N'1608016033844', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', 123000, 1)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (N'be3acf6b-ec1b-43db-844f-f362db9f685f', N'1608110448369', N'9b5b8e80-cb49-4372-a165-68ee25b8da49', 123000, 6)
GO
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [description], [createDate], [expiredDate], [status]) VALUES (N'74632263-d8dc-4a16-aa0f-110f6b54ab73', N'Banh nuong ne', 5400000, 14, N'CAT001', N'cach-lam-banh-trung-thu-nhan-thap-cam-chay-cho-ngay-tet-trung-V-620x620.jpg', N'Banh trung thu nhan thap cam', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-30' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [description], [createDate], [expiredDate], [status]) VALUES (N'32a391ee-4965-497c-a54f-423bccb42dea', N'Banh nuong nhan trai dep', 478000, 23, N'CAT001', N'photo-1-15980381652301887654095-1598038280511942896426-15980595731092104203308-crop-1598060438886593462215.png', N'Banh nuong mlem mlem', CAST(N'2020-12-16' AS Date), CAST(N'2020-12-30' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [description], [createDate], [expiredDate], [status]) VALUES (N'afb42693-1b09-482b-93ef-49c1384a2454', N'Bánh nướng nhân tiền', 123000, 30, N'CAT001', N'trung-thu-25.jpg', N'Hết rồi', CAST(N'2020-12-17' AS Date), CAST(N'2020-12-28' AS Date), 2)
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [description], [createDate], [expiredDate], [status]) VALUES (N'9b5b8e80-cb49-4372-a165-68ee25b8da49', N'Banh deo trung muoi', 123000, 13, N'CAT002', N'1567587838-363-thumbnail.jpg', N'Banh deo thom ngon voi huong vi trung muoi beo ngay', CAST(N'2020-12-17' AS Date), CAST(N'2020-12-28' AS Date), 1)
GO
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R1', N'Admin')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R2', N'Member')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R3', N'Guest')
GO
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (1, N'In-stock')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (2, N'Out-stock')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (3, N'Done')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (4, N'Not yet')
GO
INSERT [dbo].[tblUser] ([userID], [name], [password], [address], [phone], [roleID], [status]) VALUES (N'1306144389741097', N'Cao N. Nhat Vy', NULL, NULL, NULL, N'R2', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [address], [phone], [roleID], [status]) VALUES (N'ad', N'admin', N'admin', N'wrwe', N'01234', N'R1', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [address], [phone], [roleID], [status]) VALUES (N'test', N'tester', N'test', N't', N'0123      ', N'R2', N'Active')
GO
ALTER TABLE [dbo].[tblLog] ADD  CONSTRAINT [DF_tblLog_logID]  DEFAULT (newid()) FOR [logID]
GO
ALTER TABLE [dbo].[tblLog] ADD  CONSTRAINT [DF_tblLog_productID]  DEFAULT (newid()) FOR [productID]
GO
ALTER TABLE [dbo].[tblOrderDetail] ADD  CONSTRAINT [DF_tblOrderDetail_orderDetailID]  DEFAULT (newid()) FOR [orderDetailID]
GO
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF_tblProduct_productID]  DEFAULT (newid()) FOR [productID]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblProduct]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblUser]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblStatus] FOREIGN KEY([status])
REFERENCES [dbo].[tblStatus] ([statusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblStatus]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblUser]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([catID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblStatus] FOREIGN KEY([status])
REFERENCES [dbo].[tblStatus] ([statusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblStatus]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [J3.L.P0011] SET  READ_WRITE 
GO
