USE [master]
GO
/****** Object:  Database [Festival]    Script Date: 10/17/2018 6:12:57 PM ******/
CREATE DATABASE [Festival] ON  PRIMARY 
( NAME = N'Festival', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Festival.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Festival_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Festival_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Festival].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Festival] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Festival] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Festival] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Festival] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Festival] SET ARITHABORT OFF 
GO
ALTER DATABASE [Festival] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Festival] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Festival] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Festival] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Festival] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Festival] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Festival] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Festival] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Festival] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Festival] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Festival] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Festival] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Festival] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Festival] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Festival] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Festival] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Festival] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Festival] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Festival] SET  MULTI_USER 
GO
ALTER DATABASE [Festival] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Festival] SET DB_CHAINING OFF 
GO
USE [Festival]
GO
/****** Object:  User [Joe]    Script Date: 10/17/2018 6:12:57 PM ******/
CREATE USER [Joe] FOR LOGIN [Joe] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'Joe'
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audition]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audition](
	[id] [int] NOT NULL,
	[Schedule] [int] NOT NULL,
	[AuditionTime] [smalldatetime] NOT NULL,
	[AwardRating] [char](1) NOT NULL,
 CONSTRAINT [PK_Audition] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Composer]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Composer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Composer] [nvarchar](50) NOT NULL,
	[Nationality] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Composer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](10) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[ParentLocation] [int] NULL,
	[Available] [bit] NOT NULL,
	[Instrument] [char](1) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entry]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Event] [int] NOT NULL,
	[Teacher] [int] NOT NULL,
	[Student] [int] NOT NULL,
	[ClassType] [char](1) NOT NULL,
	[ClassAbbr] [varchar](10) NOT NULL,
	[Status] [char](1) NOT NULL,
 CONSTRAINT [PK_Entry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntryDetails]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntryDetails](
	[Id] [int] NOT NULL,
	[RequiredPiece] [int] NULL,
	[RequiredExtension] [char](1) NOT NULL,
	[ChoicePiece] [nvarchar](50) NULL,
	[ChoiceComposer] [nvarchar](50) NULL,
	[Publisher] [nvarchar](20) NULL,
	[Accompanist] [nvarchar](50) NULL,
	[Notes] [nvarchar](50) NULL,
 CONSTRAINT [PK_EntryDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Location] [int] NOT NULL,
	[OpenDate] [smalldatetime] NOT NULL,
	[CloseDate] [smalldatetime] NOT NULL,
	[EventDate] [smalldatetime] NOT NULL,
	[Instrument] [char](1) NOT NULL,
	[Status] [char](1) NOT NULL,
	[Venue] [nvarchar](50) NOT NULL,
	[Notes] [varchar](256) NOT NULL,
	[ClassTypes] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventClass]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventClass](
	[ClassAbbr] [varchar](10) NOT NULL,
	[ClassType] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[AuditionMinutes] [smallint] NOT NULL,
 CONSTRAINT [PK_EventClass] PRIMARY KEY CLUSTERED 
(
	[ClassAbbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventClassType]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventClassType](
	[ClassType] [char](1) NOT NULL,
	[TypeName] [varchar](50) NOT NULL,
	[RequiresChoicePiece] [bit] NOT NULL,
	[RequiresAccomp] [bit] NOT NULL,
 CONSTRAINT [PK_EventClassType] PRIMARY KEY CLUSTERED 
(
	[ClassType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[Student] [int] NOT NULL,
	[ClassType] [char](1) NOT NULL,
	[Event] [int] NOT NULL,
	[EventDate] [smalldatetime] NULL,
	[ClassAbbr] [varchar](10) NOT NULL,
	[AwardRating] [char](1) NOT NULL,
	[AwardPoints] [tinyint] NOT NULL,
	[ConsecutiveSuperior] [tinyint] NOT NULL,
	[AccumulatedPoints] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_History]    Script Date: 10/17/2018 6:12:57 PM ******/
CREATE CLUSTERED INDEX [IX_History] ON [dbo].[History]
(
	[Student] ASC,
	[Event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instrument]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instrument](
	[Id] [char](1) NOT NULL,
	[Instrument] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Instrument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Judge]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Judge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[event] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Judge] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentLocation] [int] NOT NULL,
	[LocationType] [char](1) NOT NULL,
	[LocationName] [varchar](30) NOT NULL,
	[ContactId] [int] NULL,
 CONSTRAINT [PK_Location_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Piece]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Piece](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassAbbr] [varchar](10) NOT NULL,
	[Composition] [varchar](100) NOT NULL,
	[Composer] [int] NOT NULL,
	[Extension] [tinyint] NOT NULL,
 CONSTRAINT [PK_Piece] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Judge] [int] NOT NULL,
	[StartTime] [smalldatetime] NOT NULL,
	[Minutes] [smallint] NOT NULL,
	[ClassType] [char](1) NOT NULL,
	[PrefHighLow] [char](1) NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Instrument] [char](1) NOT NULL,
	[Teacher] [int] NULL,
	[BirthDate] [smalldatetime] NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherEvent]    Script Date: 10/17/2018 6:12:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherEvent](
	[Teacher] [int] NOT NULL,
	[Event] [int] NOT NULL,
 CONSTRAINT [PK_TeacherEvent] PRIMARY KEY CLUSTERED 
(
	[Teacher] ASC,
	[Event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201808302041537_InitialCreate', N'FestivalEntry.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE336107D2FD07F10F4D416A9954B77B10DEC2D52276E836E2E5867177D5BD012ED102B51AA44651314FDB23EF493FA0B1DEA2E5E74B115DB290A14B1383C331C1E924372B8FFFEFDCFF8A747CF351E7018119F4ECCA3D1A169606AFB0EA1AB8919B3E5F76FCC9FDE7EFDD5F8C2F11E8D8FB9DC0997839A349A98F78C05A79615D9F7D843D1C82376E847FE928D6CDFB390E35BC787873F5A474716060813B00C63FC3EA68C7838F9013FA73EB571C062E45EF90E76A3EC3B94CC1354E31A79380A908D27E60C478C3C20F782B2F06994CA9BC6994B10D832C7EED23410A53E430C2C3DFD10E1390B7DBA9A07F001B9774F0106B92572239CB5E0B414EFDA98C363DE18ABAC9843D971C47CAF27E0D149E61D4BACBE968FCDC27BE03FF012614FBCD5890F27E6A583934FEF7D171C202A3C9DBA21179E9857858AB328B8C66C94571CA590B310E0BEF8E1E75115F1C0E85CEFA060D3F1E890FF77604C6397C5219E501CB310B907C66DBC7089FD1B7EBAF33F633A39395A2C4FDEBC7A8D9C93D73FE09357D596425B41AEF6013EDD867E8043B00D2F8BF69B8655AF6789158B6A953AA957804B30304CE30A3DBEC374C5EE61C81CBF318D1979C44EFE2523D7074A601C412516C6F0F33A765DB47071516E35EAE4FF6FD07AFCEAF5205AAFD10359255D2FE8878113C2B87A8FDDA434BA27413ABC6AFDFD29139B85BEC77FD7F995967E9AFB7168F3C6F85A913B14AE30AB5B37B64AF276A234871A9ED639EAFE539B5B2AD35B29CA1BB4CE48C8556C7B34E4F63EAFDECE8C3B0B02E8BC845ADC234D84532D5723A1FE8151932AE973D4953E149AF57F9E0D2F3C44DC01A6C30E5A20165992D0C3452B7FF6817C88F6B6F9164511CC06CEAF28BA6F301DFE1CC0F439B6E310483A67C80B9E5DDBEDBD4FF175EC2D38F7B7A76BB0AEB9FBE2CF90CDFCF082F25A1BE3BDF3EDCF7ECC2EA8738E18FEC0EC1C90FFBC235E778041CC39B36D1C4533203376A63E84DA39E0256527C7BDE1F814B5EB7064EA22E2A9E3116132FD948B9631895A428A4B3462AAD8A4C9D477FE8AD06EA6E6A27A535389565333B1BEA672B06E9666927A431381563B53A9C1A2BDA487860FF712D8FD8FF7365BBC757341C58D739821F12F98E210A631E7163186435AF64097796317C142D27D5CE9B3AF4D89A68FC88D8756B5D668482681E1474302BBFFA32131133E3F108747251D3641B930C0779257EFAFDAC79C60D9B68743AD99DB56BE9D3940375CCEA2C8B749320A14C75FD9E145DD7E88E18CF6938CB435E26908340C884EF892075FA06DA648AA1B7A8E5DCCB07166A7C7835314D9C891DD080D727A1896AFA80AC3CA5391BA71DF493A81E938E49510DF044530520965F2B020D42601725BBD24D4ECB884F1B6173AC492731C60CA15B67AA28B72F5210837A0D023744A9B87C6568571CD44D444ADBA3E6F0B61CB7E97CE26B6C2C996D859C3CB2C7E7B1662367B6C0BE46C76491703B4077ABB2068B657E94A0071E3B26F0415764C1A826621D556085AF7D80E085A77C98B2368BA45EDDAFFC27E75DFE859DF286F7F596F74D70EB859F3C79E51338D3DA10E831A3894E979BEE085F8912936676067B63F8BB25057A408079F63563FB229E35D651C6A358388246A022C89D6029A5D054A40D280EA615C7E96D7685D1645F480CDCFDD1A61B3B95F80AD7040C6AE5E895604F517A722393BED3E8A96156C9048DE69B350C15110429CBCEA0DEFE014DDB9ACEC982EB1709F68B8D2B0AC331A1CD412B96A9C943766702FE5D46CF7922A20EB13926DE425217CD278296FCCE05ECA38DAEE244550D0232CD8C845F5257CA0C1969F7414AB4D5136B6D25CA9ECC3D8D224558DAF501010BAAA2459655F8C799A6135FD7EDE3FF1C84B312C3B52E41F15D6169A981FA215164A4135583A2361C4CE11430BC4CF79A68E278929D756CDF49FABAC2E9F7227E6EB402ECDFF4E6B282FF06BABAD1C8E64283368A3C7639AE4205DC100757583A7BD2117858AB3FBA9EFC61ED58758FADAE90D5EB57EFA4546185B82FD520825F94B0A74EBCEEFD435F2B018AC9B8A1866FDAED243E81C9E47A05597EBA2523D4A7E485545D11D5CEDACEB74C14CCFEE1223C5FEBDD58AF03C632B4B4FA902649F7A6254321C24B04A5977D47A124A15B35ED21D51C834A9420A453DACACE693D48CAC16AC85A7F1A85AA2BB063983A48A2E97764756E49254A115C56B602B6C16CBBAA32AD24DAAC08AE2EED865EE89388DEEF1EAA5DDBF6CB07CA59BDCCDD62F0DC6F3CC89C32C7F95BBFC2A50E5734FACECB65E02CBBEEF259FB43BBD0DF8949E6E6CC6270D867EF6A9DD83D7279FC6CB7B3D66ED72BB36C1375DEEEBF1FAB1F659B9216DF54491427BB1E513B676E36C9BD5FEA846DA77A522A691BB1116F7A788616FC40546F33FDCA94B309FCA73812B44C9124897267498C78747C7C2AB9CFD7921634591E32AB6A9BA6732F53EDB426E167D40A17D8F4239536283572425A874087D491DFC3831FF4C6A9D26E719FCAFE4F38171197DA0E48F180AEEC2181B7FC9999FC364D57778C75118FAD78B7820D1DDE597BF7F4AAB1E1837210CA753E35070F43ADD5F7F36D1CB9AB4EA06D6ACFD98E2E58EB6DA2B0525AA305AD67F94B0206C900709B995DF78E8F1DBBEA6291F1D6C84A878583014DE202ED43D1C58074BFB68C0819F2C7934D0AFB1EA4704EB98A67D4040687F30F1F940F76928AFB9C37548B165DAC69494F8B935FD7AA35CCC5DAF4D5296F646035DCEC4EE013768B6F56621CA0BCB621E6CE95424290F86BD4BDE3F7B66F2BE24239741FB6E7390B79976DC70ADF4BFCA36DE83FC3845BECFEE738AB7CD35DD19F09E2766F6CB1CDE33B265CBFCEEF383B74D36DD01F19E93AD5716F09E716D57EBE78E99D67909DD794EAF9C9EA4B9CB519D22B7E5ECA647EEB0FD5FF8408234A24C9F5AAA93C474CA4AB2681596227AA5FAEC3451B1347024BD9244B3DA7E6DCD16FCC6C66632CD6A35399D4DBAB3F9BF517726D3AC5B9329B98B6C6365AEA22A03BC651E6B4AA27A49D9C5B596B424B3B7C5AC8D17F32F29997810A7D4468FE676F9E5E40E0FE29221874E8F5C61F9A218D6CECABFD108EB7744562504FF171B29B66BAB66217349977EBE780B16E522C209CD1566C88125F52C6464896C06C5FC003A792B9E1CEAF16B9005762EE94DCC82984193B1B7706B075E3C0868D29F2444D76D1EDF04FC57344413C04CC20FEE6FE8CF31719DC2EE99E24C4803C1A38BECB897F725E3C7BEABA702E9DAA71D8132F71541D11DF60217C0A21B3A470F781DDB807EEFF00AD94FE509A00EA4BD23EA6E1F9F13B40A91176518657DF8091C76BCC7B7FF01DCEA0F54AA540000, N'6.2.0-61023')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'2', N'Chair')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'3', N'Teacher')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'145f33d4-982d-44f0-94a7-aeb8425285aa', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1c00deee-d1a9-422e-9413-425b9f1b838a', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'222787a6-8a42-4a95-9ac5-0eafa0523b3a', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'23be0fec-cdea-42ec-b62f-39d6c8f0bcfc', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'23c5786e-6882-4271-b906-d4c52c488918', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d42c47a-b05f-4af3-854a-d6e2fa359a99', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2ef243ff-897e-4345-98cb-c88eba476290', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'479870b1-8071-447b-8637-965efd885245', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'50182c0d-d962-468c-8bec-6dcc82242b0b', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'51fb7775-48c2-45e2-a990-53cb6173712c', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'563c57ec-04ef-44e8-8278-1ba1b998818a', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f151046-c1e9-4cdd-bc1f-02664d2089b2', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7536d023-b9f6-45a0-a9fb-b39713bf4989', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7c5d811a-69a0-42fc-bda8-b629b8c745f7', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7f03bdbb-a179-40cd-9684-ebb8fde8f127', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'80e91de5-2234-42de-a0b8-41601e5cac3a', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9d3d7920-5305-4315-96f0-ff4f90f170ba', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b58f87f1-7990-4d64-99fb-ee4995bf4168', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b658b0ec-9144-412a-b8d4-aa0b97209cd7', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bacea174-d48b-45c2-a5d4-073e58dc51ab', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e0fa890d-3b59-406b-a2a7-f02c15e57c2b', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'eba81203-15d0-4186-ae97-6531b3eba088', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'488f855f-fdc2-47c8-9f52-53444421b1f1', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd3256475-47b4-4a68-bd56-16b864846dd0', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e6db1827-b8e4-4abe-9367-2bf84c55645e', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2270ab00-90dd-4070-98e3-143b6989d8be', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3d4b9312-1a72-4496-927d-363e03b77763', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'56e6b6f5-5d57-46a8-8ae8-c8fa183d5fca', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f88ecb6-dfc2-45ea-b9f7-d6659924cc4f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b560760e-d751-47ea-b3fb-012ec74a8f2f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd2fbc177-4e1a-4a64-aea3-c81a769a710b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fb4688ee-d93e-4a02-af87-746cc978d8c6', N'3')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'145f33d4-982d-44f0-94a7-aeb8425285aa', N'nolongerhere@upthere.com', 0, N'AN+Jc1P0OK8sKOZgWU83+nHrOzhVeVI8SbmhYib/C0oxgHRrNSjvga3EYcg0Y3HnRw==', N'b51dea9c-f332-40ce-8cbc-518e52f91a91', NULL, 0, 0, NULL, 1, 0, N'gvand1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1c00deee-d1a9-422e-9413-425b9f1b838a', N'alex@jeopary.com', 0, N'AGEf/sNBIwSfWNMcZcEtUTP/adIRu9cySJfijgh3lkNiGkgxzI3d7vYoGcBSnZfCHA==', N'520897c0-29f6-4133-bea2-1aea47085f93', NULL, 0, 0, NULL, 1, 0, N'atreb1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'222787a6-8a42-4a95-9ac5-0eafa0523b3a', N'russo@skylark.net', 0, N'AHNy0c6C9UTnzAfPmnaqP+VOLPhnlcbctalMFtNB3Obg/rpUkZ/tb+uGEdRdMvFY+A==', N'f99f99c0-a166-428f-a17e-3914bd725ba2', NULL, 0, 0, NULL, 1, 0, N'zruss1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'2270ab00-90dd-4070-98e3-143b6989d8be', N'singer@sop.com', 0, N'AKISOTWY/BDQmL6ZY6pVlvn3//0CeFeCIH5DGeOkFCdHIJSpKuvWfxcK3NeUmc0fRA==', N'aeca83b2-8b60-414c-b594-c34a0cbb4755', NULL, 0, 0, NULL, 1, 0, N'ssopr1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'23be0fec-cdea-42ec-b62f-39d6c8f0bcfc', N'rathernot@cbs.com', 0, N'AGXlz0vn/wkuOnYaBZaI6tvZXtcjaJwEvAU7w06u0PZp0DKOdDlZxBixmtOIvPslmQ==', N'64a1e7a7-858e-4547-b3e9-269a72f4431d', NULL, 0, 0, NULL, 1, 0, N'drath1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'23c5786e-6882-4271-b906-d4c52c488918', N'fb@fastmail.com', 0, N'ACcUzQEKow7qwsl+45ZYpJLS2rwMUdBeut4itveAmvca/3Z0tRDvKQG+5i7i2stVCQ==', N'30ec4cfb-14a2-4d83-b8dd-522b173fb25f', NULL, 0, 0, NULL, 1, 0, N'fbell1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'2d42c47a-b05f-4af3-854a-d6e2fa359a99', N'gp@234.com', 0, N'ABd/gC5WbcopuFBcTMl3Q5KTAAfYw4zVphm4710tpemw4DHXT6MmcdY+SQBG2fOZIA==', N'1565a6ec-a2ec-4157-8688-4d540a64b077', NULL, 0, 0, NULL, 1, 0, N'msamu1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'2ef243ff-897e-4345-98cb-c88eba476290', N'imok@coca.com', 0, N'AKZskdPVIUgbUChgv6xHPiELOWJkgp7FVcIUU9+bet/Y+WRh/jzsvFdE9tv0HHa5qA==', N'6ad233f6-78bf-4ada-85c5-45d405de41fa', NULL, 0, 0, NULL, 1, 0, N'icoca1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'3d4b9312-1a72-4496-927d-363e03b77763', N'gee@thatswell.com', 0, N'ACxh7xVztDWd43MR0mTrsqpvttJo7U/MOMF/9yK3Bz7QpY2+C+CEyuLRecy3KsLPIA==', N'66c05ec9-7786-4951-b200-18c8b4598068', NULL, 0, 0, NULL, 1, 0, N'hther1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'479870b1-8071-447b-8637-965efd885245', N'hfonda@mci.net', 0, N'AMvmgIvKxRJLn21iHj2ACciXzZOpzi2UOYVbYvaetFWx5ID7Ohiym+Fg/5g9Dcbw7A==', N'cce95f46-9461-40ef-b0aa-d84e646a0824', NULL, 0, 0, NULL, 1, 0, N'hfond1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'488f855f-fdc2-47c8-9f52-53444421b1f1', N'sdfjf@sjjf.com', 0, N'AIUxWhALBs5B+imcTStmBneNCG2tKJMSI6mrZvnoUJJT6RLo9l604giXfSHYi5l2tg==', N'fcc58c02-0c09-4e5c-b644-ccaf039f8a41', NULL, 0, 0, NULL, 1, 0, N'hthis1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'50182c0d-d962-468c-8bec-6dcc82242b0b', N'germanguy@gmail.com', 0, N'AC6pn2UlvEjkzrPynUuZvco3PumXCuS1U8zNrUMCIX6Pavmzb9eVxQ++asmOsM9yYg==', N'08a8ccde-dd8c-4cb2-88b2-232798c4dee4', NULL, 0, 0, NULL, 1, 0, N'rschu1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'51fb7775-48c2-45e2-a990-53cb6173712c', N'234@234.com', 0, N'AGN6leLcZm67dnFJ6p5Rk7+ZPwJtTwZ4HjKwUOmlwAntCsjpY3s0PO2IDObaDSVklA==', N'765af603-3983-4cdb-9c84-7957782c0c07', NULL, 0, 0, NULL, 1, 0, N'ltry1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'563c57ec-04ef-44e8-8278-1ba1b998818a', N'hr@gmail.com', 0, N'AD9HtQma7beZe90sVmhIbdPapuUNKDDOOnuwTqoFuxdtT58zJ19sywELGs/0qI++3w==', N'554f29d3-a227-4f54-b27f-bf82ba4f8a8e', NULL, 0, 0, NULL, 1, 0, N'hroar1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'565585dc-e0c1-4328-a6ae-a88f9d9a5bcd', N'gcorron@gmail.com', 0, N'AKvf6BxKSTj8WU1wJLL9vZBgY0FrE/i2gySWoLO3yeRPqXHxdMmqiSlJekosn1jK7g==', N'6eacd07c-3cbc-4c14-a8b0-b47a453d4c75', NULL, 0, 0, NULL, 1, 0, N'gcorr1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'56e6b6f5-5d57-46a8-8ae8-c8fa183d5fca', N'vt@tvs.com', 0, N'AOCg8bkhBuzIiIcss+6Y6rt4rPooUq5R4J/voN4Fuj2cjfZdIeNZbmCVB+HnXoapEQ==', N'f4dc035f-a44d-438f-8c51-625d2f7b658f', NULL, 0, 0, NULL, 1, 0, N'vteac1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'5f151046-c1e9-4cdd-bc1f-02664d2089b2', N'sasquatch@boo.com', 0, N'AL0tkbSoGWDJWT1GIFJLLUf/2rS95EsLWPN/NBrVLPR3ujM7yIiQpUytj9bsAEAqfQ==', N'72ed162e-bdb5-4355-9b9f-dd9417d5db3a', NULL, 0, 0, NULL, 1, 0, N'GBoo0001')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'5f88ecb6-dfc2-45ea-b9f7-d6659924cc4f', N'newguy@micro.com', 0, N'AFYcaxo7kYc88We8OFJ+oTawdc3WFvDxY7qycVQieFdPmVbCujqg1jDM2txg3CJPUQ==', N'597e626a-932f-4c0b-ac92-cadb8c92bd19', NULL, 0, 0, NULL, 1, 0, N'nguy1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'7536d023-b9f6-45a0-a9fb-b39713bf4989', N'dolly@new.com', 0, N'AFTNXxf3SaMPUnk/4zO0Uwbv49BNkQxqoO7RBocSmiglOnyEQslqjjrEYU+w6WepYQ==', N'de1b8308-ccae-4af2-a275-659017223b3e', NULL, 0, 0, NULL, 1, 0, N'hdoll1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'7c5d811a-69a0-42fc-bda8-b629b8c745f7', N'abc@123.com', 0, N'AFz5Nwn8dprEueU4q7+Bh02tfwAigOcxuyOCayMkyd6p5H6YQQWlDQgJ6GcHzmxa5w==', N'd3532d82-b822-4e4e-9cae-5e5f6025ca33', NULL, 0, 0, NULL, 1, 0, N'aabcd1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'7f03bdbb-a179-40cd-9684-ebb8fde8f127', N'hotdog@sd.com', 0, N'AK5r4wQUmz9HxMNOS2brMyinvWMUn6isQzL62JBgOy6BdF64JAuSEf3CtG7FtScdPQ==', N'7be10f0c-0b3b-4d63-a53e-74344882c9e1', NULL, 0, 0, NULL, 1, 0, N'ffurt1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'80e91de5-2234-42de-a0b8-41601e5cac3a', N'sldkj@sdjklsj', 0, N'APL84BR9sfyK5p9Xtehd/l/Fpl5i8qbO0vXXkAH5mzzvDk6u8BvLPx+rQyRlXZsmbQ==', N'f511c9e8-86c2-4edf-91f4-798f0015c980', NULL, 0, 0, NULL, 1, 0, N'bboop1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'852e6f39-73e7-4bbf-97bb-8d42ecb46959', N'about@test.com', 0, N'AAZiFNeG19gGWi/FS2hV5N9vwwm+HU+0kekHaj6bQBhTZexO7isDlavYsax+I3DUZw==', N'33f58c3c-97f8-4b42-9c48-97e9d54779fb', NULL, 0, 0, NULL, 1, 0, N'habou1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'9d3d7920-5305-4315-96f0-ff4f90f170ba', N'tfoot@bigsky.net', 0, N'AEfqqJShe1Nd3ntHQxhI2qnC06sUd51TtpZjvCzB3rIxh7vRPUt+VaKBaXxk7wUGFg==', N'e5bf4ab6-771a-43cf-9b59-e042010d7acd', NULL, 0, 0, NULL, 1, 0, N'tfoot1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'b560760e-d751-47ea-b3fb-012ec74a8f2f', N'gb@gnc.com', 0, N'AJYSP2bCPV0HRcbop10dUtyYaTX7r6GctBrRBqn8PQvI1ROI3rwXzb8KUZ817kbzRg==', N'9771a379-5158-4253-b68d-e7d2f1ead47c', NULL, 0, 0, NULL, 1, 0, N'gbroo1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'b58f87f1-7990-4d64-99fb-ee4995bf4168', N'gcoos22@gmail.com', 0, N'AJiHoeuKLC5rQqOmVPgvfTLMHi1MaI30TiH7VtaLkALq/kRGHL4XjjNf5ayRzldJrw==', N'955ec67e-6c6d-4806-81a4-e7cd73436592', N'523-2323', 0, 0, NULL, 1, 0, N'accc1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'b658b0ec-9144-412a-b8d4-aa0b97209cd7', N'gw@usa.gov', 0, N'AE4F8Xgy7FITUlex7Z7VOI5q4qX8bqsH8sDssOzhd66b1Zt52oc2EPV0gehgScUaXA==', N'4a5ee31f-85d3-4fd7-b017-dae910ce1d04', NULL, 0, 0, NULL, 1, 0, N'gwash1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'bacea174-d48b-45c2-a5d4-073e58dc51ab', N'how@ard.com', 0, N'AL/LZSUIJbid+sfIIrRBvI8h8DwRfq9llrk8Bj+VDHRjxW84OhmOElA1UCfWKGc67A==', N'baff940f-2b00-4d25-9a21-095abbc6fc83', NULL, 0, 0, NULL, 1, 0, N'hduty1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'd2fbc177-4e1a-4a64-aea3-c81a769a710b', N'barb@cutter.com', 0, N'AK4SLHguZLgzLNFVDLkfJM7HKn4HVofuN7oxS8RmSWtsEB06FVAWpQuWS8RA9nlevw==', N'192d88bb-fbcf-4ba9-aaa6-51cde85011da', NULL, 0, 0, NULL, 1, 0, N'bboxc1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'd3256475-47b4-4a68-bd56-16b864846dd0', N'ndsdf@dsldkj.net', 0, N'AB5CnPUdqAZzFtiNH8kzTWYoZ9UVN0cv+kOBHTjhd7GJrUM61Gknzd8m/VnTChIiJA==', N'ab88738e-3929-4256-b7f5-6daf8eb2fde8', NULL, 0, 0, NULL, 1, 0, N'hcard1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'e0fa890d-3b59-406b-a2a7-f02c15e57c2b', N'holy@crap.net', 0, N'AFKtocak5ioM3vjbZ0O+XXz0W+0uBazRyGClIIkabZJcafhF/Jl8gf8djLO1Ov2mFQ==', N'35f82c06-eb3b-420b-a09f-41bd3d47cd77', NULL, 0, 0, NULL, 1, 0, N'ynot1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'e419c21a-61d4-41ef-8eda-8aeb49a8749c', N'234@444.com', 0, N'AL0UZVGFjSO/D73w0TT5OuAbyOX+SvxF7Gz8fKJOdR0XJ1dHC/pjCn/HIuvMESLwtg==', N'905f619a-d16e-4a83-bc82-a2ba6d6ce5a6', NULL, 0, 0, NULL, 1, 0, N'tagai1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'e6db1827-b8e4-4abe-9367-2bf84c55645e', N'123', 0, N'AKk+hD5DmIt8BVbGcxWSqQ1cSUt0NxK9FFVM93cUJa73Esl0On2mmZvuXEW2barRmQ==', N'6b279d4b-da93-4aa9-9dbc-5b49e1cd0abc', NULL, 0, 0, NULL, 1, 0, N'ttest1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'eba81203-15d0-4186-ae97-6531b3eba088', N'two@twenty.com', 0, N'AB+0iZgD2APcajmvDcFXeKCyJJ/Tu17dPGbRvq5FkwcC5VOld7X+8N1EDt9/ONfyHQ==', N'a1975d76-a873-43a3-85ae-120328fc9d63', NULL, 0, 0, NULL, 1, 0, N'ttwo1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'fb4688ee-d93e-4a02-af87-746cc978d8c6', N'jros@abc.com', 0, N'AKeNurMDOAeN02mOBIqWr6pxQG3gTUS0leyJp83XauiEfK8DKDBkiba4a52eN69f5w==', N'8935dc19-3c67-4885-8473-f567dac8a9bc', NULL, 0, 0, NULL, 1, 0, N'jroga1000')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'fe9c78e4-ece2-4431-9e94-33697cce9e36', N'gcorron@fastmail.com', 0, N'ANPxtIBTSCyc0T5io76VMFIj8A5nEl20hbc9v9uMu9jhL2/b+p6g311XZ4PREx5NuA==', N'cea7be9b-32b0-49a6-8c34-92c714bf43c3', NULL, 0, 0, NULL, 1, 0, N'ttest0001')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (10, 5, CAST(N'2018-10-26T09:00:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (12, 8, CAST(N'2018-10-26T09:00:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (13, 5, CAST(N'2018-10-26T09:14:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (14, 8, CAST(N'2018-10-26T09:12:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (15, 5, CAST(N'2018-10-26T09:34:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (16, 5, CAST(N'2018-10-26T09:46:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (17, 5, CAST(N'2018-10-26T09:56:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (18, 5, CAST(N'2018-10-26T10:12:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (19, 8, CAST(N'2018-10-26T09:26:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (20, 8, CAST(N'2018-10-26T09:40:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (21, 5, CAST(N'2018-10-26T10:28:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (22, 8, CAST(N'2018-10-26T09:52:00' AS SmallDateTime), N'N')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (23, 8, CAST(N'2018-10-26T10:04:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (24, 5, CAST(N'2018-10-26T10:38:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (25, 8, CAST(N'2018-10-26T10:18:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (26, 5, CAST(N'2018-10-26T10:50:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (27, 8, CAST(N'2018-10-26T10:30:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (28, 8, CAST(N'2018-10-26T10:42:00' AS SmallDateTime), N'S')
INSERT [dbo].[Audition] ([id], [Schedule], [AuditionTime], [AwardRating]) VALUES (30, 5, CAST(N'2018-10-26T11:00:00' AS SmallDateTime), N'S')
SET IDENTITY_INSERT [dbo].[Composer] ON 

INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (1, N'Addinsell', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (2, N'Alexander', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (3, N'Anderson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (4, N'Antheil', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (5, N'Asch', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (6, N'Austin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (7, N'Bach', N'German')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (8, N'Badgett', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (9, N'Barber', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (10, N'Bartok', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (11, N'Bastien', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (12, N'Baumgartner', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (13, N'Beach', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (14, N'Beethoven', N'German')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (15, N'Benner', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (16, N'Bergsma', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (17, N'Berkovich', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (18, N'Bernstein', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (19, N'Bilotti', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (20, N'Bober', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (21, N'Bolcom', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (22, N'Boykin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (23, N'Brady', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (24, N'Brahms', N'German')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (25, N'Brechmacher', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (26, N'Brooks-Turner', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (27, N'Brown', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (28, N'Carpenter', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (29, N'Chopin', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (30, N'Chvostal', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (31, N'Copland', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (32, N'Costello', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (33, N'Costley', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (34, N'Cox', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (35, N'Creston', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (36, N'Cuellar', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (37, N'Deft', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (38, N'Dello Joio', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (39, N'Diamond', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (40, N'Diemer', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (41, N'Dohnanyi', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (42, N'Duncan', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (43, N'Dvorak', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (44, N'Edwards', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (45, N'Eklund', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (46, N'Evans', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (47, N'Faber', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (48, N'Franck', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (49, N'Garcia', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (50, N'Gargiulo', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (51, N'George', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (52, N'Gerou', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (53, N'Gershwin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (54, N'Gillock', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (55, N'Gottschalk', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (56, N'Gould', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (57, N'Greenleaf', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (58, N'Grieg', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (59, N'Griffes', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (60, N'Grill', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (61, N'Halloran', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (62, N'Hamm', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (63, N'Hanson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (64, N'Harris', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (65, N'Hartsell', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (66, N'Havhaness', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (67, N'Haydn', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (68, N'Henze', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (69, N'Hidy', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (70, N'Houle', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (71, N'Hummel', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (72, N'Ives', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (73, N'Johnson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (74, N'Joplin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (75, N'Kabalevsky', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (76, N'Karp', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (77, N'Kasschau', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (78, N'Kaylor', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (79, N'Kennan', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (80, N'Khachaturin', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (81, N'Klose', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (82, N'Komanetsky', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (83, N'Kraehenbuehl', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (84, N'Kraft', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (85, N'Labenske', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (86, N'LaMontaine', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (87, N'Lau', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (88, N'Leaf', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (89, N'Lees', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (90, N'Liebermann', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (91, N'Linn', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (92, N'Liszt', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (93, N'Lybeck-Robinson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (94, N'MacDowell', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (95, N'Marlais', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (96, N'Marshall', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (97, N'Matz', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (98, N'McLean', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (99, N'Mendelssohn', N'?')
GO
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (100, N'Menotti', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (101, N'Mier', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (102, N'Miller', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (103, N'Mozart', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (104, N'Muczynski', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (105, N'Ninov', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (106, N'Noona', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (107, N'Olson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (108, N'Persichetti', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (109, N'Peskanov', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (110, N'Petot', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (111, N'Poulenc', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (112, N'Prokofiev', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (113, N'Rachmaninoff', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (114, N'Rahbee', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (115, N'Ravel', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (116, N'Rejino', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (117, N'Ricker', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (118, N'Rochberg', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (119, N'Rocherolle', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (120, N'Rollin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (121, N'Rollins', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (122, N'Rorem', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (123, N'Rosco', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (124, N'Rossi', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (125, N'Roubos', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (126, N'Rowley', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (127, N'Rubenstein', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (128, N'Saint-Saens', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (129, N'Sallee', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (130, N'Schinske', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (131, N'Schumann', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (132, N'Scriabin', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (133, N'Setliff', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (134, N'Shostakovich', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (135, N'Sifford', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (136, N'Souers', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (137, N'Springer', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (138, N'Sprunger', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (139, N'Steffen', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (140, N'Stevens', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (141, N'Strickland', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (142, N'Tan', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (143, N'Tcherepnin', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (144, N'Thompson', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (145, N'Tsitsaros', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (146, N'Turner', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (147, N'Valenti', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (148, N'Vandall', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (149, N'Verne', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (150, N'Weber', N'?')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (151, N'Wells', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (152, N'Wheeler', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (153, N'Williams', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (154, N'Wolf', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (155, N'Zwillich', N'American')
INSERT [dbo].[Composer] ([Id], [Composer], [Nationality]) VALUES (156, N'Bach, J.C.', N'German')
SET IDENTITY_INSERT [dbo].[Composer] OFF
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (1, N'gcorr1000', N'Corron', N'Greg', N'gcorron@fastmail.com', N'208-378-4819', 11, 0, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (3, N'aabcd1', N'Zee', N'John', N'abc@123.com', N'555-1212', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (5, N'GBoo0001', N'Bookies', N'Gregory', N'sasquatch@boo.com', N'555-1212', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (6, N'gvand1000', N'Vanderbilt', N'Gloria', N'nolongerhere@upthere.com', N'555-5555', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (7, N'drath1000', N'Rather', N'Daniel', N'rathernot@cbs.com', N'212-2345', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (8, N'rschu1000', N'Schumann', N'Robert', N'germanguy@gmail.com', N'12121212', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (9, N'icoca1000', N'Coca', N'Imogen', N'imok@coca.com', N'5434543', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (10, N'ttwo1000', N'Two', N'Twenty', N'two@twenty.com', N'20202020', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (11, N'atreb1000', N'Trebec', N'Alex', N'alex@jeopary.com', N'234234', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (12, N'hduty1000', N'Duty', N'Howdy', N'how@ard.com', N'2342444', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (13, N'bboop1000', N'Boop', N'Betty', N'sldkj@sdjklsj', N'23234234', 2, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (14, N'hfond1000', N'Fonda', N'Henry', N'hfonda@mci.net', N'23487893', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (15, N'tfoot1000', N'Foote', N'Terese', N'tfoot@bigsky.net', N'333-3332', 10, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (16, N'hcard1000', N'Cardon', N'Harmon', N'ndsdf@dsldkj.net', N'23234234', 11, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (17, N'ttest1', N'testing', N'testing', N'123', N'123', 11, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (18, N'accc1000', N'Professional', N'Greg', N'gcoos22@gmail.com', N'523-2323', 11, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (19, N'hthis1000', N'This Works', N'Hope', N'sdfjf@sjjf.com', N's32343434', 11, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (20, N'jroga1000', N'Rogan', N'Joe', N'jros@abc.com', N'5122222', 15, 1, N'P')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (21, N'hroar1000', N'Roark', N'Howard E.', N'hr@gmail.com', N'1234', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (22, N'gwash1000', N'Washington', N'George', N'gw@usa.gov', N'555-2222', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (24, N'zruss1000', N'Russian', N'Zbiganew', N'russo@skylark.net', N'2342342', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (28, N'ffurt1000', N'Furter', N'Frank', N'hotdog@sd.com', N'24345', 1, 1, N'-')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (31, N'hther1000', N'There', N'Hello', N'gee@thatswell.com', N'5555555', 15, 1, N'S')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (32, N'vteac1000', N'Teacher', N'Voice', N'vt@tvs.com', N'234243', 15, 1, N'V')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (33, N'ssopr1000', N'Soprano Lady', N'Singer', N'singer@sop.com', N'5234234', 15, 1, N'V')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (34, N'bboxc1000', N'Boxcutter', N'Barbara', N'barb@cutter.com', N'howdydw', 15, 1, N'V')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (36, N'gbroo1000', N'Brookbank', N'George', N'gb@gnc.com', N'4234342', 15, 1, N'S')
INSERT [dbo].[Contact] ([Id], [UserName], [LastName], [FirstName], [Email], [Phone], [ParentLocation], [Available], [Instrument]) VALUES (37, N'fbell1000', N'Bellini', N'Fionualla', N'fb@fastmail.com', N'334-0001', 1, 1, N'-')
SET IDENTITY_INSERT [dbo].[Contact] OFF
SET IDENTITY_INSERT [dbo].[Entry] ON 

INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (10, 6, 36, 8, N'S', N'MED', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (12, 6, 36, 5, N'C', N'JRI-B', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (13, 6, 36, 11, N'S', N'MAI', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (14, 6, 36, 4, N'C', N'SR', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (15, 6, 36, 15, N'S', N'EIV', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (16, 6, 36, 14, N'S', N'PII', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (17, 6, 36, 9, N'S', N'DI', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (18, 6, 36, 13, N'S', N'DI', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (19, 6, 36, 9, N'C', N'SR', N'C')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (20, 6, 36, 15, N'C', N'JRI-B', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (21, 6, 36, 1, N'S', N'PP', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (22, 6, 36, 1, N'C', N'JRI-A', N'C')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (23, 6, 36, 11, N'C', N'SR', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (24, 6, 36, 3, N'S', N'EII', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (25, 6, 36, 3, N'C', N'JRIII', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (26, 6, 36, 2, N'S', N'PIV', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (27, 6, 36, 2, N'C', N'JRI-B', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (28, 6, 36, 14, N'C', N'JRI-B', N'A')
INSERT [dbo].[Entry] ([Id], [Event], [Teacher], [Student], [ClassType], [ClassAbbr], [Status]) VALUES (30, 6, 36, 17, N'S', N'PI', N'A')
SET IDENTITY_INSERT [dbo].[Entry] OFF
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (1, 1, N'0', N'Rondo', N'Mozart', N'KJOS', NULL, NULL)
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (2, 2, N'0', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (10, 288, N' ', N'sf', N'asdf', N'asdf', N'', N'OK')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (12, 455, N' ', N'', N'', N'bb', N'Henry Longfellow', N'Yes')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (13, 422, N' ', N'The Barber of Seville', N'Rossini', N'Publio', N'', N'This is going to be a very long note. Let''s see wh')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (14, 472, N' ', N'', N'', N'hh harriman', N'Don Juan', N'really')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (15, 280, N' ', N'asf', N'asdf', N'sdf', N'', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (16, 186, N' ', N'asf', N'asdf', N'asdf', N'', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (17, 346, N' ', N'Sonata Op. 10 no. 1', N'Beethoven', N'Schirmer', N'', N'no repeats')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (18, 353, N' ', N'as', N'asdf', N'asdf', N'', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (19, 114, N'2', N'', N'', N'ready', N'Helen Reddy', N'Really')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (20, 69, N'1', N'', N'', N'absolutely', N'John Browning', N'yep')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (21, 151, N' ', N'choice', N'composer', N'publisher', N'', N'notes')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (22, 61, N'1', N'', N'', N'asfa', N'adfaf', N'Jeremy Smith')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (23, 109, N'1', N'', N'', N'Petrof', N'Velma Morrison', N'not really')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (24, 251, N' ', N'sdf', N'asdf', N'sadf', N'', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (25, 468, N' ', N'', N'', N'asdf', N'asdf', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (26, 222, N' ', N'as', N'asdfasd', N'asd', N'', N'')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (27, 67, N'1', N'', N'', N'asd', N'asdf', N'fdf')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (28, 63, N'1', N'', N'', N'pub', N'accomp', N'notes')
INSERT [dbo].[EntryDetails] ([Id], [RequiredPiece], [RequiredExtension], [ChoicePiece], [ChoiceComposer], [Publisher], [Accompanist], [Notes]) VALUES (30, 163, N' ', N'abbasdf', N'asdfasdfas', N'asdf', N'', N'')
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([Id], [Location], [OpenDate], [CloseDate], [EventDate], [Instrument], [Status], [Venue], [Notes], [ClassTypes]) VALUES (4, 15, CAST(N'2018-09-06T00:00:00' AS SmallDateTime), CAST(N'2018-10-04T00:00:00' AS SmallDateTime), CAST(N'2018-11-22T00:00:00' AS SmallDateTime), N'S', N'A', N'Royal Albert Hall', N'That''s in London, England!!!', N'SC')
INSERT [dbo].[Event] ([Id], [Location], [OpenDate], [CloseDate], [EventDate], [Instrument], [Status], [Venue], [Notes], [ClassTypes]) VALUES (5, 15, CAST(N'2018-07-04T00:00:00' AS SmallDateTime), CAST(N'2018-08-07T00:00:00' AS SmallDateTime), CAST(N'2018-09-01T00:00:00' AS SmallDateTime), N'P', N'A', N'my house', N'sorry it''s over', N'SC')
INSERT [dbo].[Event] ([Id], [Location], [OpenDate], [CloseDate], [EventDate], [Instrument], [Status], [Venue], [Notes], [ClassTypes]) VALUES (6, 15, CAST(N'2018-09-29T00:00:00' AS SmallDateTime), CAST(N'2018-10-10T00:00:00' AS SmallDateTime), CAST(N'2018-10-14T00:00:00' AS SmallDateTime), N'S', N'D', N'Gatewood', N'Be there.', N'SC')
SET IDENTITY_INSERT [dbo].[Event] OFF
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'DI', N'S', 1, 16)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'DII', N'S', 1, 16)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'EI', N'S', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'EII', N'S', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'EIII', N'S', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'EIV', N'S', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'JRI-A', N'C', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'JRI-B', N'C', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'JRII', N'C', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'JRIII', N'C', 1, 12)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'MAI', N'S', 1, 20)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'MDI', N'S', 1, 14)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'MDII', N'S', 1, 14)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'MDIII', N'S', 1, 14)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'MED', N'S', 1, 14)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'PI', N'S', 1, 10)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'PII', N'S', 1, 10)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'PIII', N'S', 1, 10)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'PIV', N'S', 1, 10)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'PP', N'S', 1, 10)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'SR', N'C', 1, 14)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'VDI', N'S', 1, 20)
INSERT [dbo].[EventClass] ([ClassAbbr], [ClassType], [Active], [AuditionMinutes]) VALUES (N'VDII', N'S', 1, 20)
INSERT [dbo].[EventClassType] ([ClassType], [TypeName], [RequiresChoicePiece], [RequiresAccomp]) VALUES (N'C', N'Concerto', 0, 1)
INSERT [dbo].[EventClassType] ([ClassType], [TypeName], [RequiresChoicePiece], [RequiresAccomp]) VALUES (N'S', N'Solo', 1, 0)
INSERT [dbo].[History] ([Student], [ClassType], [Event], [EventDate], [ClassAbbr], [AwardRating], [AwardPoints], [ConsecutiveSuperior], [AccumulatedPoints]) VALUES (1, N'S', 4, CAST(N'2017-10-01T00:00:00' AS SmallDateTime), N'MED', N'S', 4, 2, 12)
INSERT [dbo].[History] ([Student], [ClassType], [Event], [EventDate], [ClassAbbr], [AwardRating], [AwardPoints], [ConsecutiveSuperior], [AccumulatedPoints]) VALUES (1, N'S', 4, CAST(N'2016-10-01T00:00:00' AS SmallDateTime), N'PP', N'S', 4, 1, 8)
INSERT [dbo].[History] ([Student], [ClassType], [Event], [EventDate], [ClassAbbr], [AwardRating], [AwardPoints], [ConsecutiveSuperior], [AccumulatedPoints]) VALUES (14, N'C', 4, CAST(N'2017-10-01T00:00:00' AS SmallDateTime), N'JRIII', N'E', 3, 0, 9)
INSERT [dbo].[Instrument] ([Id], [Instrument]) VALUES (N'-', N'None')
INSERT [dbo].[Instrument] ([Id], [Instrument]) VALUES (N'P', N'Piano')
INSERT [dbo].[Instrument] ([Id], [Instrument]) VALUES (N'S', N'Strings')
INSERT [dbo].[Instrument] ([Id], [Instrument]) VALUES (N'V', N'Voice')
INSERT [dbo].[Instrument] ([Id], [Instrument]) VALUES (N'W', N'Winds')
SET IDENTITY_INSERT [dbo].[Judge] ON 

INSERT [dbo].[Judge] ([Id], [event], [Name]) VALUES (3, 4, N'Judy Dench')
INSERT [dbo].[Judge] ([Id], [event], [Name]) VALUES (18, 4, N'Mark O''Conners')
INSERT [dbo].[Judge] ([Id], [event], [Name]) VALUES (20, 6, N'Mark Warbug')
INSERT [dbo].[Judge] ([Id], [event], [Name]) VALUES (21, 6, N'Jonas Beehive')
SET IDENTITY_INSERT [dbo].[Judge] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (1, 1, N'A', N'Top Level', 18)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (2, 1, N'B', N'West Coast', 5)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (6, 1, N'B', N'Southwest', 37)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (7, 1, N'B', N'Midwest', 22)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (8, 2, N'C', N'S. California', 9)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (9, 2, N'C', N'N. California', 6)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (10, 2, N'C', N'Oregon', 8)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (11, 10, N'D', N'Portland, OR', 15)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (12, 10, N'D', N'Salem, OR', NULL)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (13, 10, N'D', N'Eugene, OR', NULL)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (14, 11, N'E', N'Gresham', NULL)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (15, 11, N'E', N'Lloyd', 16)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (16, 11, N'E', N'Troutdale', NULL)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (18, 14, N'F', N'Gresham', NULL)
INSERT [dbo].[Location] ([Id], [ParentLocation], [LocationType], [LocationName], [ContactId]) VALUES (19, 15, N'F', N'Lloyd', NULL)
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[Piece] ON 

INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (1, N'JRI-B', N'Celebration! A Youth Concerto: 3 Parade', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (2, N'JRII', N'Concerto for Young Pianists: 1 Moderato', 44, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (3, N'JRII', N'Concerto for Young Pianists: 3 Animato only', 44, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (4, N'JRII', N'Spring Concerto: I The March of Spring', 109, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (5, N'JRII', N'Spring Concerto: II April Scherzo', 109, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (6, N'JRII', N'Spring Concerto: III Sunset', 109, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (7, N'JRIII', N'Concerto (for our time): 1 Gathering', 18, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (8, N'JRIII', N'Concerto (for our time): 2 Lament for Vietnam', 18, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (9, N'JRIII', N'Concerto (for our time): 3 Jubilation', 18, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (10, N'DI', N'Bagatelles, Op. 5, No. 1', 143, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (11, N'DI', N'Bagatelles, Op. 5, No. 10', 143, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (12, N'DII', N'Prelude, No. 6 in F Minor', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (13, N'DII', N'Prelude, No. 9 in Eb Major', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (14, N'VDII', N'Four Anniversaries (1948), No. 1&2', 18, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (15, N'VDII', N'Four Anniversaries (1948), No. 3&4', 18, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (16, N'VDII', N'Simple Sketches for Piano, No. 1', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (17, N'VDII', N'Simple Sketches for Piano, No. 2', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (18, N'VDII', N'Simple Sketches for Piano, No. 3', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (19, N'VDII', N'Prelude No. 1, No. 1', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (20, N'VDII', N'Prelude No. 1, No. 3', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (21, N'VDII', N'Prelude No. 1, No. 6', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (22, N'VDII', N'Prelude, No. 1 Water Nymphs', 145, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (23, N'VDII', N'Prelude, No. 3 Dionysian Rites', 145, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (24, N'MAI', N'Excursions Op. 20, No. 1', 9, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (25, N'MAI', N'Excursions Op. 20, No. 4', 9, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (26, N'MAI', N'Six Pieces, No. 3 Allegro', 43, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (27, N'MAI', N'Six Pieces, No. 6 Allegro con brio', 43, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (28, N'MAI', N'Suite Op. 13, No. 2 Flight', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (29, N'MAI', N'Suite Op. 13, No. 3 Vision', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (30, N'MAI', N'Suite Op. 13, No. 6 Scherzo', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (31, N'MAI', N'Preludes Op. 23, No. 1 in F# Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (32, N'MAI', N'Preludes Op. 23, No. 10 in Gb Major', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (33, N'MAI', N'Preludes Op. 32, No. 11 in B Major', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (34, N'MAI', N'Preludes Op. 32, No. 2 in Bb Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (35, N'MAI', N'Preludes Op. 32, No. 7 in F Major', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (36, N'MAI', N'Moment Musicale Op. 16, No. 4', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (37, N'MAI', N'Moment Musicale Op. 16, No. 6', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (38, N'MAI', N'Piano Preludes, No. 1', 147, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (39, N'MAI', N'Piano Preludes, No. 10', 147, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (40, N'MAI', N'Three Preludes for the Piano, No. 1', 79, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (41, N'MAI', N'Three Preludes for the Piano, No. 3', 79, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (42, N'MAI', N'Three Preludes for the Piano, No. 6', 79, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (43, N'MAI', N'Gargoyles, No. 1', 90, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (44, N'MAI', N'Gargoyles, No. 2', 90, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (45, N'MAI', N'Gargoyles, No. 3', 90, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (46, N'MAI', N'Gargoyles, No. 4', 90, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (47, N'MAI', N'Preludes Op. 23, No. 2 in Bb Major', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (48, N'MAI', N'Preludes Op. 23, No. 3 in D Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (49, N'MAI', N'Preludes Op. 23, No. 5 in G Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (50, N'MAI', N'Preludes Op. 23, No. 6 in Eb M', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (51, N'MAI', N'Preludes Op. 32, No. 10 in B Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (52, N'MAI', N'Preludes Op. 32, No. 12 in G# Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (53, N'MAI', N'Preludes Op. 32, No. 5 in G Major', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (54, N'PIV', N'Concerto in D minor', 91, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (55, N'DI', N'Jazz Suite No. 2', 6, 5)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (56, N'DI', N'American Sonatina', 27, 5)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (57, N'DI', N'Sonatine', 54, 5)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (58, N'MAI', N'Piano Sonata No. 8, Op. 41', 108, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (59, N'MAI', N'Piano Sonata No. 3, Op. 22', 108, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (60, N'JRI-A', N'Concertin in D Minor', 106, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (61, N'JRI-A', N'First Concerto in D Minor', 106, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (62, N'JRI-A', N'Little Concertino in C Major', 106, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (63, N'JRI-B', N'Country Concerto for Young Pianists', 77, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (64, N'JRI-B', N'Concerto in Classical Style', 101, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (65, N'JRI-B', N'Celebration! A Youth Concerto', 107, 1)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (66, N'JRI-B', N'Concerto in C Major', 120, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (67, N'JRI-B', N'Miniature Concerto', 123, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (68, N'JRI-B', N'Concerto Americana', 144, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (69, N'JRI-B', N'Peanuts Gallery for Piano and Orchestra', 155, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (70, N'JRII', N'Concertante in G Major', 2, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (71, N'JRII', N'Concertino in D Major', 2, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (72, N'JRII', N'Concerto in D Major, Op. XIII No. 2', 156, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (73, N'JRII', N'Concerto in F Major', 22, 3)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (74, N'JRII', N'Concerto No. 2 in G Major', 44, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (75, N'JRII', N'Piano Concertino', 61, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (76, N'JRII', N'Piano Concerto in C', 67, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (77, N'JRII', N'Concertino, Op. 73', 71, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (78, N'JRII', N'Concerto No. 1 for Piano and Strings', 109, 5)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (79, N'JRII', N'Concerto Romantique', 120, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (80, N'JRII', N'Minature Concerto', 126, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (81, N'JRII', N'Concertino in C Major', 148, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (82, N'JRII', N'Concerto in G Major', 148, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (83, N'JRII', N'Concerto for Piano', 152, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (84, N'JRIII', N'Concerto in C', 3, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (85, N'JRIII', N'Concerto in F Minor', 7, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (86, N'JRIII', N'Concerto in G Minor', 7, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (87, N'JRIII', N'Concerto No. 2 in Bb Major', 14, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (88, N'JRIII', N'Concertino', 39, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (89, N'JRIII', N'Concerto in F Major, Hob. XVIII: F1', 67, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (90, N'JRIII', N'Concerto in G Major, Hob. XVIII: 4', 67, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (91, N'JRIII', N'Concerto in D Major, Hob. XVIII: 11', 67, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (92, N'JRIII', N'Concerto No. 3 (Youth)', 75, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (93, N'JRIII', N'Concerto in A Major, K. 414', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (94, N'JRIII', N'Concerto in C Major, K. 415', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (95, N'JRIII', N'Concerto in C Major, K. 467', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (96, N'JRIII', N'Concerto in D Major, K. 451', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (97, N'JRIII', N'Concerto in Eb Major, K. 449', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (98, N'JRIII', N'Concerto in Eb Major, K. 482', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (99, N'JRIII', N'Concerto in F Major, K. 413', 103, 7)
GO
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (100, N'JRIII', N'Concerto in F Major, K. 569', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (101, N'JRIII', N'Concerto Bravo', 107, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (102, N'JRIII', N'Concerto No. 2, Op. 103', 134, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (103, N'JRIII', N'Concerto in A minor', 153, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (104, N'SR', N'Concerto in D minor', 7, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (105, N'SR', N'Piano Concerto No. 3', 10, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (106, N'SR', N'Concerto No. 1 in C Major, Op. 15', 14, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (107, N'SR', N'Concerto No. 3 in C Minor, Op. 37', 14, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (108, N'SR', N'Concerto No. 4 in G Major, Op. 58', 14, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (109, N'SR', N'Concerto No. 5 in Eb Major, Op. 73', 14, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (110, N'SR', N'Concerto in D Minor, Op. 15', 24, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (111, N'SR', N'Concerto No. 1 in E Minor, Op. 11', 29, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (112, N'SR', N'Concerto No. 2 in F Minor, Op. 21', 29, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (113, N'SR', N'Concerto in F', 53, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (114, N'SR', N'Concerto in A Minor, Op. 16', 58, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (115, N'SR', N'Concerto in G Major, Op. 36', 63, 15)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (116, N'SR', N'Piano Concerto', 80, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (117, N'SR', N'Concerto No. 1 in Eb Major', 92, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (118, N'SR', N'Concerto No. 2 in A Major', 92, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (119, N'SR', N'Second Concerto in D Minor, Op. 23', 94, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (120, N'SR', N'Concerto in D Minor, Op. 14', 99, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (121, N'SR', N'Concerto in G Minor, Op. 25', 99, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (122, N'SR', N'Concerto in F', 100, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (123, N'SR', N'Concerto in A Major, K. 488', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (124, N'SR', N'Concerto in Bb Major, K. 450', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (125, N'SR', N'Concerto in Bb Major, K. 456`', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (126, N'SR', N'Concerto in Bb Major, K. 595', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (127, N'SR', N'Concerto in C Major, K. 503', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (128, N'SR', N'Concerto in C Minor, K. 491', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (129, N'SR', N'Concerto in D Major, K. 537', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (130, N'SR', N'Concerto in D Minor, K. 466', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (131, N'SR', N'Concerto in Eb Major, K. 271', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (132, N'SR', N'Concerto in G Major, K. 453', 103, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (133, N'SR', N'Concerto for Piano and Orchestra', 111, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (134, N'SR', N'Concerto No. 1 in Db Major', 112, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (135, N'SR', N'Concerto No. 2 in G Minor', 112, 15)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (136, N'SR', N'Concerto No. 3 in C Major', 112, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (137, N'SR', N'Concerto No. 1 in F# Minor', 113, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (138, N'SR', N'Concerto No. 2 in C Minor', 113, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (139, N'SR', N'Concerto No. 3 in D Minor', 113, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (140, N'SR', N'Concerto in G', 115, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (141, N'SR', N'Concerto No. 4 in D Minor', 127, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (142, N'SR', N'Concerto No. 2 in G Minor', 128, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (143, N'SR', N'Concerto No. 4 in C Minor', 128, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (144, N'SR', N'Concerto in A Minor', 131, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (145, N'SR', N'Concerto in F# Minor', 132, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (146, N'SR', N'Concerto No. 1  in C Minor', 134, 7)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (147, N'PP', N'Wishing Star, The', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (148, N'PP', N'Chugging Choo-Choo', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (149, N'PP', N'Particularly Pleasing Piano Piece, A', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (150, N'PP', N'Pete, The Repeat Bird', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (151, N'PP', N'Pterodactyls, Really Neat', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (152, N'PP', N'Crazy Chase', 57, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (153, N'PP', N'Airplane Ticket', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (154, N'PP', N'My Dog Max', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (155, N'PP', N'Thirteen Robots', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (156, N'PP', N'A-choo!', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (157, N'PP', N'Hiccup Song, The', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (158, N'PP', N'My Imaginary Friend', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (159, N'PP', N'Ninja Power', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (160, N'PI', N'Chop Suey!', 6, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (161, N'PI', N'Got Those Monday Blues', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (162, N'PI', N'My Little Chiminea', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (163, N'PI', N'Starlings', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (164, N'PI', N'Mister Camel', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (165, N'PI', N'Sneaky', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (166, N'PI', N'Two Cool Pals', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (167, N'PI', N'Zelda Zebra', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (168, N'PI', N'Look at What I Can Do!', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (169, N'PI', N'Wee Small Bear', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (170, N'PI', N'Distant Bells', 57, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (171, N'PI', N'Jungle Safari', 97, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (172, N'PI', N'Spaceship To Mars', 97, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (173, N'PI', N'Creepy Crocodile', 121, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (174, N'PI', N'Run-Around Rag', 135, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (175, N'PI', N'Soaring Kite', 141, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (176, N'PII', N'Half-Step Waltz', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (177, N'PII', N'Jeepers,  Creepers!', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (178, N'PII', N'Trampoline Star', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (179, N'PII', N'Basketball Star', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (180, N'PII', N'Water Slide!', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (181, N'PII', N'Distant Chimes', 51, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (182, N'PII', N'Day Dreams', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (183, N'PII', N'Bugs on My Cheese', 68, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (184, N'PII', N'Mud Pies', 68, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (185, N'PII', N'Cheerful Chihuahua', 91, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (186, N'PII', N'Giraffe Can Laugh', 91, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (187, N'PII', N'Cowboy World', 93, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (188, N'PII', N'Moonbeam Waltz', 101, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (189, N'PII', N'Curious Rumba', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (190, N'PII', N'Skeleton in My Closet', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (191, N'PII', N'Tooth Fairy', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (192, N'PII', N'Yee-Haw!', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (193, N'PIII', N'Jazzy Cat', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (194, N'PIII', N'Trampoline Tricks', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (195, N'PIII', N'Penguin March', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (196, N'PIII', N'Ladybug Morning', 65, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (197, N'PIII', N'Sultan''s Palace, The', 95, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (198, N'PIII', N'Secret Agents', 97, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (199, N'PIII', N'Sports Car Boogie', 97, 0)
GO
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (200, N'PIII', N'Power Drive', 98, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (201, N'PIII', N'Hoe-Down', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (202, N'PIII', N'Hot Chili Peppers', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (203, N'PIII', N'Witches'' Brew', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (204, N'PIII', N'Banana Popsicle', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (205, N'PIII', N'Curious Shark', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (206, N'PIII', N'Viking Feast, The', 133, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (207, N'PIII', N'Crazy for Lemons', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (208, N'PIII', N'French Fries,  Ice Cream', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (209, N'PIII', N'Nice Exotic Blend, A', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (210, N'PIV', N'Mermaid and the Sea, The', 23, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (211, N'PIV', N'Pirates on the High Seas', 23, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (212, N'PIV', N'Dog Bone Draw', 26, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (213, N'PIV', N'Hangin'' Around', 30, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (214, N'PIV', N'End Game', 45, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (215, N'PIV', N'Spanish Dance', 45, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (216, N'PIV', N'Walkin'' Jazz', 101, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (217, N'PIV', N'Haunted Hollow', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (218, N'PIV', N'Ceremony at Stonehenge', 117, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (219, N'PIV', N'Running of the Bulls, The', 117, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (220, N'PIV', N'Pirates''s Tarantella', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (221, N'PIV', N'Tango Dramtico', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (222, N'PIV', N'Roses in Twilight', 133, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (223, N'PIV', N'Indian Pony', 139, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (224, N'PIV', N'Buzzer Beater', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (225, N'PIV', N'Land of Nod, The', 142, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (226, N'EI', N'Daydreaming', 15, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (227, N'EI', N'Jumping', 15, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (228, N'EI', N'Cool Cats', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (229, N'EI', N'Skeleton Stomp', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (230, N'EI', N'Dancing Goblins', 25, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (231, N'EI', N'Being Silly', 60, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (232, N'EI', N'I''m Happy', 60, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (233, N'EI', N'First Dancing Lesson', 82, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (234, N'EI', N'Simple Waltz', 82, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (235, N'EI', N'In a Bonsai Garden', 84, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (236, N'EI', N'Woodland Farewell', 87, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (237, N'EI', N'Morning Dew', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (238, N'EI', N'Raindrops on my Roof', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (239, N'EI', N'Blackbeard''s Shanty', 117, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (240, N'EI', N'Expedition to Everest', 117, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (241, N'EI', N'Bold Attitude', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (242, N'EII', N'Winter Memories', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (243, N'EII', N'Brontosaurus', 34, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (244, N'EII', N'Chaplin''s Cane', 62, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (245, N'EII', N'Damani''s Dance', 62, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (246, N'EII', N'Distant Shores', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (247, N'EII', N'Piper''s Jig, The', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (248, N'EII', N'Rainbow Prelude', 91, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (249, N'EII', N'Goldfish Pool, The', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (250, N'EII', N'American Gothic', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (251, N'EII', N'Mona Lisa', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (252, N'EII', N'Spanish Fire', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (253, N'EII', N'Hero Variations', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (254, N'EII', N'Prankster', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (255, N'EII', N'Bird''s Eye', 130, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (256, N'EII', N'Crazy Man''s Blues', 145, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (257, N'EII', N'Shadow Chase', 148, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (258, N'EIII', N'Black Cat Scherzo', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (259, N'EIII', N'Sandcastles', 42, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (260, N'EIII', N'New Kid on the Block', 45, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (261, N'EIII', N'Piece of Cake (walk), A', 49, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (262, N'EIII', N'Golden Aspens', 60, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (263, N'EIII', N'Butterfly Garden', 101, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (264, N'EIII', N'Rodeo Barrel Racing', 101, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (265, N'EIII', N'Knights of the Castle', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (266, N'EIII', N'Tango Espanol', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (267, N'EIII', N'Monday Morning Blues', 137, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (268, N'EIII', N'Red River Rag', 137, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (269, N'EIII', N'Barn Dance', 140, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (270, N'EIII', N'Hornet, The', 151, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (271, N'EIV', N'Latin Holiday', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (272, N'EIV', N'Stargazer', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (273, N'EIV', N'Meerkat Capers', 32, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (274, N'EIV', N'Prairie Wind', 33, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (275, N'EIV', N'Arabian Nights', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (276, N'EIV', N'Tango Taboo', 69, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (277, N'EIV', N'Wuthering Heights', 69, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (278, N'EIV', N'Spokane Falls', 85, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (279, N'EIV', N'Sunday Morning Revival', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (280, N'EIV', N'Shimmering Sea', 116, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (281, N'EIV', N'Nocturne in Black and Gold - The Falling Rocket', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (282, N'EIV', N'Asymmetry', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (283, N'EIV', N'Forget-Me-Not', 124, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (284, N'EIV', N'Berceuse for Connor', 138, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (285, N'EIV', N'Prelude to a Long Goodbye', 138, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (286, N'MED', N'Pastels', 26, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (287, N'MED', N'I May Have Lost My Girlfriend, But I''ve Still Got My Car', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (288, N'MED', N'Spy, The', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (289, N'MED', N'Salse Indigo', 47, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (290, N'MED', N'Carnival in Rio', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (291, N'MED', N'Journey in the Night', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (292, N'MED', N'To a Wild Rose from Woodland Sketches', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (293, N'MED', N'Romanza', 96, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (294, N'MED', N'See You Around Blues', 101, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (295, N'MED', N'Carnival Capers', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (296, N'MED', N'Canyon''s Raging River, The', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (297, N'MED', N'Cirque (Circus)', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (298, N'MED', N'Grand Tetons, The', 125, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (299, N'MED', N'Farewell to Fall', 129, 0)
GO
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (300, N'MDI', N'Blue Mood Waltz', 6, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (301, N'MDI', N'Tangorific', 6, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (302, N'MDI', N'Aretta''s Rhumba', 12, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (303, N'MDI', N'Journey''s End', 12, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (304, N'MDI', N'Serenade', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (305, N'MDI', N'Toccata in A Minor', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (306, N'MDI', N'Rustic Dance Op. 24, No. 1', 35, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (307, N'MDI', N'Winter Reverie', 45, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (308, N'MDI', N'Ragamuffin', 46, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (309, N'MDI', N'Bongo Bongo', 50, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (310, N'MDI', N'Money in My Pocket', 50, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (311, N'MDI', N'Reverie Op. 19, No. 15', 105, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (312, N'MDI', N'Starry Night, The', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (313, N'MDI', N'Notturno', 125, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (314, N'MDI', N'Kenya Rose', 154, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (315, N'MDII', N'Catherine''s Violin', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (316, N'MDII', N'Buckaroo Blues', 70, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (317, N'MDII', N'Dance of the Trolls', 81, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (318, N'MDII', N'Healing Garden, The', 81, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (319, N'MDII', N'Mighty River', 91, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (320, N'MDII', N'Beauty in the Rose Garden, Op. 4, No. 3', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (321, N'MDII', N'Flip', 110, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (322, N'MDII', N'Six O''Clock Groove', 110, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (323, N'MDII', N'Shimmering Sea', 116, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (324, N'MDII', N'Big Easy Blues', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (325, N'MDII', N'Nocturne', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (326, N'MDII', N'Polonaise', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (327, N'MDII', N'La Festividad', 146, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (328, N'MDII', N'Phrygian Toccata', 149, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (329, N'MDIII', N'Pantalon (Op. 25, No. 3)', 13, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (330, N'MDIII', N'Big Time Blues', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (331, N'MDIII', N'Morning in Congaree, A', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (332, N'MDIII', N'Myrtle Beach Boogie', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (333, N'MDIII', N'Rain on the Lake', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (334, N'MDIII', N'Black Gold Rag', 52, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (335, N'MDIII', N'Garden of Peace, A', 52, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (336, N'MDIII', N'Midnight Ride of Paul Revere, The', 73, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (337, N'MDIII', N'Banjo Player, The', 78, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (338, N'MDIII', N'Rondo Capriccioso', 81, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (339, N'MDIII', N'Jivin'' in Jackson Square', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (340, N'MDIII', N'Intermezzo in D-flat Major', 133, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (341, N'MDIII', N'Lofty Peaks', 144, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (342, N'MDIII', N'Scherzando in G Major', 144, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (343, N'MDIII', N'Toccata', 148, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (344, N'DI', N'Pope''s Rebellion', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (345, N'DI', N'Sunset on the Sandias', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (346, N'DI', N'Firefly, The', 19, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (347, N'DI', N'Magnificent Minnesota', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (348, N'DI', N'Mississippi River Adventure', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (349, N'DI', N'Romana', 36, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (350, N'DI', N'Elite Syncopations', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (351, N'DI', N'Solace', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (352, N'DI', N'Wizard Fantasy', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (353, N'DI', N'Effin Round No. 6, An', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (354, N'DI', N'To a Hummingbird, Op. 7, No. 2', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (355, N'DI', N'6th Street Stomp', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (356, N'DI', N'Fiesta!', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (357, N'DI', N'Kiss, The', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (358, N'DI', N'Summer', 120, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (359, N'DI', N'Contradanza', 125, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (360, N'DII', N'Battle of Little Bighorn', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (361, N'DII', N'Land of the Shining Mountains', 2, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (362, N'DII', N'Sea Nocturne', 6, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (363, N'DII', N'Berceuse pour un petit chauvre-souris', 8, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (364, N'DII', N'Suleman,  L''elephant sacre', 8, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (365, N'DII', N'Spanish Dance', 19, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (366, N'DII', N'Robotics', 20, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (367, N'DII', N'Juba', 37, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (368, N'DII', N'Song of Love, A', 43, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (369, N'DII', N'Prelude No. 2 (Blue Lullaby)', 53, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (370, N'DII', N'Memory of Vienna, A', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (371, N'DII', N'Valse Etude', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (372, N'DII', N'Easy Winners, The', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (373, N'DII', N'Pineapple Rag', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (374, N'DII', N'Samba Bamba', 76, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (375, N'DII', N'Northwoods Toccata', 81, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (376, N'DII', N'Enchanted Wood, The', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (377, N'DII', N'Alla Tarantella Op. 39, No. 2', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (378, N'DII', N'Arabesk, Op. 39 No. 4', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (379, N'DII', N'Front Range', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (380, N'VDI', N'Grand Waltz in F Flat Major', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (381, N'VDI', N'Soliloquy', 27, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (382, N'VDI', N'Caccia', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (383, N'VDI', N'Giga', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (384, N'VDI', N'Busy Toccata', 40, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (385, N'VDI', N'Prelude (Novelette in Fourths)', 53, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (386, N'VDI', N'Etude in A Major, The Coral Sea', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (387, N'VDI', N'Nocturne', 54, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (388, N'VDI', N'Clog Dance', 63, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (389, N'VDI', N'Macedonian Mountain Dance', 66, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (390, N'VDI', N'West Quoddy Sunrise', 73, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (391, N'VDI', N'Entertainer, The', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (392, N'VDI', N'Maple Leaf Rag', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (393, N'VDI', N'Summer Evening', 76, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (394, N'VDI', N'Improvisation Op. 46, No. 4', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (395, N'VDI', N'Scotch Poem,  Op. 31, No. 2', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (396, N'VDI', N'Impressions on Indigo', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (397, N'VDI', N'Impressions on Red', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (398, N'VDI', N'Prelude,  Op. 5, No. 3', 114, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (399, N'VDI', N'Cantico Iberico', 119, 0)
GO
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (400, N'VDI', N'La Chapelle', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (401, N'VDI', N'Le Salon de Musique', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (402, N'VDI', N'Rhapsodie Hongroise', 144, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (403, N'VDII', N'Toccata', 11, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (404, N'VDII', N'Monkin'' the Blues', 12, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (405, N'VDII', N'Barcarolle Op. 28, No. 1', 13, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (406, N'VDII', N'Prelude No. 1', 53, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (407, N'VDII', N'Gladiolus Rag', 74, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (408, N'VDII', N'Rhapsody in G Minor', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (409, N'VDII', N'Waves in the Monlight', 88, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (410, N'VDII', N'Hungarian Op. 39, No. 12', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (411, N'VDII', N'Shadow Dance Op. 39, No. 8', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (412, N'VDII', N'Melodie Op. 3, No. 3', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (413, N'VDII', N'Prelude in C# Minor Op. 3, No. 2', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (414, N'VDII', N'Rhapsody in G Minor', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (415, N'VDII', N'Impromptu', 136, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (416, N'MAI', N'In Autumn Op. 15, No. 1', 13, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (417, N'MAI', N'Graceful Ghost Rag', 21, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (418, N'MAI', N'Cat and the Mouse, The', 31, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (419, N'MAI', N'Romanza Op. 110', 35, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (420, N'MAI', N'Prelude to a Young Musician', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (421, N'MAI', N'Suite For Piano mv''t. 4', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (422, N'MAI', N'Prelude No. 3 (Spanish Prelude)', 53, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (423, N'MAI', N'Ojos Criollos Op. 37', 55, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (424, N'MAI', N'Lake at Evening, The', 59, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (425, N'MAI', N'Night Winds', 59, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (426, N'MAI', N'Toccata', 64, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (427, N'MAI', N'Toccata Op. 1', 86, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (428, N'MAI', N'March Wind Op. 46, No. 10', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (429, N'MAI', N'Polonaise Op. 46, No. 12', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (430, N'MAI', N'Elegie Op. 3,  No. 1', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (431, N'MAI', N'Toccata No. 2', 4, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (432, N'MAI', N'Ballade Op. 46', 9, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (433, N'MAI', N'Nocturne Op. 33', 9, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (434, N'MAI', N'Dreaming Op. 15 No. 3', 13, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (435, N'MAI', N'Three Fantasies,  No. 1', 16, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (436, N'MAI', N'Impromptu', 28, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (437, N'MAI', N'Polonaise Americaine', 28, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (438, N'MAI', N'Three Moods,  No. 3 Jazzy', 31, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (439, N'MAI', N'Third Sonata, mv''t. 1', 38, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (440, N'MAI', N'Banjo, The', 55, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (441, N'MAI', N'Boogie Woogie Etude', 56, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (442, N'MAI', N'Fountain of Acqua Paola, The', 59, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (443, N'MAI', N'Scherzo', 59, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (444, N'MAI', N'White Peacock, The', 59, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (445, N'MAI', N'Sonata No. 2 (Concord) mv''t. 3 (The Alcotts)', 72, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (446, N'MAI', N'Praeludium,  from First Modern Suite Op. 10', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (447, N'MAI', N'Witches'' Dance Op. 17, No. 2', 94, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (448, N'MAI', N'Toccata Op. 15', 104, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (449, N'MAI', N'Polichinelle Op. 3, No. 4 in F# Minor', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (450, N'MAI', N'Carnival Music,  Mv''t. 5 Toccata Rag', 118, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (451, N'MAI', N'Toccata', 122, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (452, N'JRI-A', N'Concertino No. 2', 5, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (453, N'JRI-A', N'Little Concerto in C Major Hob. XIV: 3', 67, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (454, N'JRI-A', N'Night Lights From Celebration!,  mv''t. 2', 107, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (455, N'JRI-B', N'Concerto Op. 44', 17, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (456, N'JRI-B', N'Concerto in F Major,  mv''t. 3', 22, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (457, N'JRI-B', N'Concerto for Young Pianists,  mv''t. 2 Adagio only', 44, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (458, N'JRI-B', N'Concerto No. 1 for Piano and Strings,  mv''t. 2', 109, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (459, N'JRII', N'Concertino', 5, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (460, N'JRII', N'Concerto No. 1 in A Minor,  mv''t. 3', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (461, N'JRII', N'Concert Rondo in D Major,  K. 382', 103, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (462, N'JRII', N'Concerto in Bb Major K. 238', 103, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (463, N'JRII', N'Concerto in C Major K. 246', 103, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (464, N'JRII', N'Concerto in D Major K. 175', 103, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (465, N'JRII', N'Concertino No. 1,  Op. 82', 114, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (466, N'JRII', N'Little Blues Concerto', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (467, N'JRII', N'Youth Concerto A Festival', 123, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (468, N'JRIII', N'Rhapsody in Rock', 83, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (469, N'JRIII', N'Concerto No. 1 in A Minor,  mv''t. 1', 102, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (470, N'JRIII', N'Blues Concerto', 119, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (471, N'SR', N'Warsaw Concerto', 1, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (472, N'SR', N'Variations on a Nursery Rhyme, Op. 25', 41, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (473, N'SR', N'Symphonic Variations', 48, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (474, N'SR', N'Rhapsody in Blue', 53, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (475, N'SR', N'Variations for Piano and Orchestra', 89, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (476, N'SR', N'Cappriccio Brilliante, Op. 22', 99, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (477, N'SR', N'Rhapsody on a Theme by Paganini', 113, 0)
INSERT [dbo].[Piece] ([Id], [ClassAbbr], [Composition], [Composer], [Extension]) VALUES (478, N'SR', N'Concertstuck in F Minor', 150, 0)
SET IDENTITY_INSERT [dbo].[Piece] OFF
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([Id], [Judge], [StartTime], [Minutes], [ClassType], [PrefHighLow]) VALUES (5, 20, CAST(N'2018-10-26T09:00:00' AS SmallDateTime), 150, N'S', N'*')
INSERT [dbo].[Schedule] ([Id], [Judge], [StartTime], [Minutes], [ClassType], [PrefHighLow]) VALUES (8, 21, CAST(N'2018-10-26T09:00:00' AS SmallDateTime), 240, N'C', N'*')
SET IDENTITY_INSERT [dbo].[Schedule] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (1, N'S', 36, CAST(N'2000-02-02T00:00:00' AS SmallDateTime), N'222', N'Hughers', N'Howard')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (2, N'S', 36, CAST(N'2002-03-03T00:00:00' AS SmallDateTime), N'2344434', N'zBean', N'Roy')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (3, N'S', 36, CAST(N'1975-01-01T00:00:00' AS SmallDateTime), N'9999999', N'Tesla', N'Nick')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (4, N'S', 36, CAST(N'1977-02-04T00:00:00' AS SmallDateTime), N'4343434', N'Beale', N'Howard')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (5, N'S', 36, CAST(N'1999-09-09T00:00:00' AS SmallDateTime), N'578234', N'Faraday', N'Michael')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (6, N'S', NULL, CAST(N'2012-12-12T00:00:00' AS SmallDateTime), N'121212', N'One', N'Another')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (7, N'S', NULL, CAST(N'2000-12-12T00:00:00' AS SmallDateTime), N'20000', N'Another', N'Yeti')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (8, N'S', 36, CAST(N'1999-09-09T00:00:00' AS SmallDateTime), N'test', N'eagle', N'bald')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (9, N'S', 36, CAST(N'2003-03-03T00:00:00' AS SmallDateTime), N'2003', N'Gregory', N'Helen')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (10, N'S', NULL, CAST(N'2000-01-01T00:00:00' AS SmallDateTime), N'2349094', N'Bbbbb', N'Aaaa')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (11, N'S', 36, CAST(N'1995-05-05T00:00:00' AS SmallDateTime), N'555555', N'Bob', N'Buffalo')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (12, N'S', NULL, CAST(N'1994-09-04T00:00:00' AS SmallDateTime), N'244342', N'One', N'Last')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (13, N'S', 36, CAST(N'1977-07-07T00:00:00' AS SmallDateTime), N'2343434', N'Stone', N'Rosetta')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (14, N'S', 36, CAST(N'1988-12-15T00:00:00' AS SmallDateTime), N'8888888', N'Pear', N'Prickly')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (15, N'S', 36, CAST(N'1977-07-07T00:00:00' AS SmallDateTime), N'2340904', N'Monument', N'Saguaro')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (16, N'S', NULL, CAST(N'1959-09-17T00:00:00' AS SmallDateTime), N'3324432', N'Carson', N'Johnny')
INSERT [dbo].[Student] ([Id], [Instrument], [Teacher], [BirthDate], [Phone], [LastName], [FirstName]) VALUES (17, N'S', 36, CAST(N'1959-09-17T00:00:00' AS SmallDateTime), N'2324344', N'Carsonino', N'Johnny')
SET IDENTITY_INSERT [dbo].[Student] OFF
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (31, 4)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (32, 4)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (33, 4)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (34, 4)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (36, 4)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (31, 6)
INSERT [dbo].[TeacherEvent] ([Teacher], [Event]) VALUES (36, 6)
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contact]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_Contact] ON [dbo].[Contact]
(
	[ParentLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_Event] ON [dbo].[Event]
(
	[Location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_1]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_Event_1] ON [dbo].[Event]
(
	[EventDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Judge]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_Judge] ON [dbo].[Judge]
(
	[event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeacherEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
CREATE NONCLUSTERED INDEX [IX_TeacherEvent] ON [dbo].[TeacherEvent]
(
	[Event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Audition]  WITH CHECK ADD  CONSTRAINT [FK_Audition_Entry] FOREIGN KEY([id])
REFERENCES [dbo].[Entry] ([Id])
GO
ALTER TABLE [dbo].[Audition] CHECK CONSTRAINT [FK_Audition_Entry]
GO
ALTER TABLE [dbo].[Audition]  WITH CHECK ADD  CONSTRAINT [FK_Audition_Schedule] FOREIGN KEY([Schedule])
REFERENCES [dbo].[Schedule] ([Id])
GO
ALTER TABLE [dbo].[Audition] CHECK CONSTRAINT [FK_Audition_Schedule]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Instrument] FOREIGN KEY([Instrument])
REFERENCES [dbo].[Instrument] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Instrument]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Instrument1] FOREIGN KEY([Instrument])
REFERENCES [dbo].[Instrument] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Instrument1]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Location] FOREIGN KEY([ParentLocation])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Location]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_Contact] FOREIGN KEY([Teacher])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_Contact]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_EntryDetails] FOREIGN KEY([Id])
REFERENCES [dbo].[EntryDetails] ([Id])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_EntryDetails]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_Event] FOREIGN KEY([Event])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_Event]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_EventClass] FOREIGN KEY([ClassAbbr])
REFERENCES [dbo].[EventClass] ([ClassAbbr])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_EventClass]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_EventClassType] FOREIGN KEY([ClassType])
REFERENCES [dbo].[EventClassType] ([ClassType])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_EventClassType]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_Student] FOREIGN KEY([Student])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_Student]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Instrument] FOREIGN KEY([Instrument])
REFERENCES [dbo].[Instrument] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Instrument]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Instrument1] FOREIGN KEY([Instrument])
REFERENCES [dbo].[Instrument] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Instrument1]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Location] FOREIGN KEY([Location])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Location]
GO
ALTER TABLE [dbo].[EventClass]  WITH CHECK ADD  CONSTRAINT [FK_EventClass_EventClassType] FOREIGN KEY([ClassType])
REFERENCES [dbo].[EventClassType] ([ClassType])
GO
ALTER TABLE [dbo].[EventClass] CHECK CONSTRAINT [FK_EventClass_EventClassType]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Event] FOREIGN KEY([Event])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Event]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_EventClass] FOREIGN KEY([ClassAbbr])
REFERENCES [dbo].[EventClass] ([ClassAbbr])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_EventClass]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_EventClassType] FOREIGN KEY([ClassType])
REFERENCES [dbo].[EventClassType] ([ClassType])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_EventClassType]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Student] FOREIGN KEY([Student])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Student]
GO
ALTER TABLE [dbo].[Judge]  WITH CHECK ADD  CONSTRAINT [FK_Judge_Event] FOREIGN KEY([event])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[Judge] CHECK CONSTRAINT [FK_Judge_Event]
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_Contact]
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_Location] FOREIGN KEY([ParentLocation])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_Location]
GO
ALTER TABLE [dbo].[Piece]  WITH CHECK ADD  CONSTRAINT [FK_Piece_Composer] FOREIGN KEY([Composer])
REFERENCES [dbo].[Composer] ([Id])
GO
ALTER TABLE [dbo].[Piece] CHECK CONSTRAINT [FK_Piece_Composer]
GO
ALTER TABLE [dbo].[Piece]  WITH CHECK ADD  CONSTRAINT [FK_Piece_EventClass] FOREIGN KEY([ClassAbbr])
REFERENCES [dbo].[EventClass] ([ClassAbbr])
GO
ALTER TABLE [dbo].[Piece] CHECK CONSTRAINT [FK_Piece_EventClass]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_EventClassType] FOREIGN KEY([ClassType])
REFERENCES [dbo].[EventClassType] ([ClassType])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_EventClassType]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Judge] FOREIGN KEY([Judge])
REFERENCES [dbo].[Judge] ([Id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Judge]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Contact] FOREIGN KEY([Teacher])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Contact]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Instrument] FOREIGN KEY([Instrument])
REFERENCES [dbo].[Instrument] ([Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Instrument]
GO
ALTER TABLE [dbo].[TeacherEvent]  WITH CHECK ADD  CONSTRAINT [FK_TeacherEvent_Contact] FOREIGN KEY([Teacher])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[TeacherEvent] CHECK CONSTRAINT [FK_TeacherEvent_Contact]
GO
ALTER TABLE [dbo].[TeacherEvent]  WITH CHECK ADD  CONSTRAINT [FK_TeacherEvent_Event] FOREIGN KEY([Event])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[TeacherEvent] CHECK CONSTRAINT [FK_TeacherEvent_Event]
GO
/****** Object:  StoredProcedure [dbo].[DeleteContact]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteContact] @id int
AS
BEGIN

-- constraints will throw an error if contact should not be deleted
	delete contact
	where id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteEvent] @id int
AS
BEGIN
	-- see if there are any entries yet for this event!
	if exists(select * from entry where event=@id)
		RAISERROR('Cannot delete event that already has entries!',11,1,'DeleteEvent') 
	
	delete event where id=@id
	if @@ROWCOUNT=0
		RAISERROR('No event found to be deleted!',11,1,'DeleteEvent') 

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteSchedule]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteSchedule] @id int
AS
BEGIN
	declare @ev int



	select @ev=event
	from judge a inner join schedule b
	on a.id=b.judge
	where b.id=@id

	delete schedule where id=@id

	exec SelectJudgeScheduleForEvent @ev

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateUserName]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GenerateUserName] @seed varchar(10) 
AS
BEGIN
	declare @userName nvarchar(256)
	declare @suffix nvarchar(10)
	declare @suffixstart smallint
	declare @suffixnum int

	-- validate seed first
	if not (@seed not like '%[^A-Z]%')
	BEGIN
		RAISERROR('Argument not alphabetic',11,1,'GenerateUserName')
	END

	-- make it lower case
	set @seed=lower(@seed)

	-- find the maximum suffix int used with this seed
	set @suffixstart=LEN(@seed)+1
	
	select @userName=max(UserName) from AspNetUsers
	where UserName like @seed + '[0-9][0-9][0-9][0-9]'


	if @userName is null
	BEGIN
		select @seed + '1000' as ret
		return
	END

	set @suffix=substring(@userName,@suffixstart,4)

	set @suffixnum=CONVERT(int,@suffix)

	select @seed + CONVERT(varchar(10),@suffixnum) as UserName


END
GO
/****** Object:  StoredProcedure [dbo].[GetLoginPerson]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoginPerson] @userName nvarchar(256)
AS
BEGIN

-- used for the currently logged in user only
-- selects by ASP identity userName, not Id, for simplicity

	select b.Id, b.LastName, b.FirstName, b.Instrument,
		c.id as ParentLocationId,c.locationName as ParentLocationName,
		d.id as LocationId, d.LocationName,
		case c.LocationType when 'E' then 'T' else isnull(d.LocationType,'-') end as RoleType
	from AspNetUsers a inner join contact b
		on a.UserName=b.UserName
		left outer join location c on b.ParentLocation=c.id
		left outer join location d
		on d.contactid=b.id
		
	where a.UserName=@userName

	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertAudition]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertAudition] @id int, @schedule int, @auditiontime smalldatetime
	AS
	insert audition (id,schedule,auditiontime, awardrating)
		values(@id,@schedule,@auditiontime, '-');
GO
/****** Object:  StoredProcedure [dbo].[RemoveStudentFromTeacher]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RemoveStudentFromTeacher] @id int, @teacher int
AS
BEGIN
	update student set teacher=NULL
	where id=@id and teacher=@teacher

	if @@ROWCOUNT=0
		RAISERROR('Remove failed - system could not locate this student.',11,1,'RemoveStudentFromTeacher')
END
GO
/****** Object:  StoredProcedure [dbo].[RollupEvents]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RollupEvents] @testing bit
as
BEGIN
declare @eventid int, @eventdate smalldatetime

declare mycsr cursor for
select id,eventdate from event
where status='D'
and datediff(d,eventdate,getdate())>36 -- allow 6 weeks past event date until rollup, unless testing

open mycsr
fetch next from mycsr into @eventid, @eventdate

while @@FETCH_STATUS=0
BEGIN

	;with cte_history as (
		select
			e.student, e.classtype, @eventid as event,
			(select eventdate from event where id=@eventid) as eventdate, e.classabbr,
			a.awardrating,
			case a.awardrating when 'S' then 4 when 'E' then 3 when 'G' then 2 when 'F' then 1 else 0 end as awardpoints,
			isnull(h.consecutivesuperior,0) as consecutivesuperior,isnull(h.accumulatedpoints,0) as accumulatedpoints,
			DENSE_RANK() over (partition by h.student,h.classtype order by case when accumulatedpoints is not null then eventdate end desc) as rn
		from entry e inner join audition a
			on e.id=a.id
		left outer join history h
			on e.student=h.student and e.classtype=h.classtype
		where e.Event=@eventid
	)
	insert history (student,classtype,event,eventdate,classabbr,awardrating,awardpoints,consecutivesuperior,accumulatedpoints)
		select student,classtype,event,eventdate,classabbr,awardrating,awardpoints
		,consecutivesuperior+case when awardrating='S' then 1 else 0 end
		,accumulatedpoints+awardpoints
		 from cte_history
		where rn=1
	update event
		set status='H'
	where id=@eventid
	
fetch next from mycsr into @eventid, @eventdate
END
deallocate mycsr

if @testing=1 
	return

--now purge entrydetails, audition, entry, and judge for all events with status 'H'
declare mycsr cursor for
select id from event
	where status='H'
open mycsr
fetch next from mycsr into @eventid
while @@FETCH_STATUS=0
BEGIN
	delete entrydetails
	where id in (select id from entry where event=@eventid)

	delete audition
	where id in (select id from entry where event=@eventid)

	delete entry
	where event=@eventid

	delete judge
	where event=@eventid
	
fetch next from mycsr into @eventid
END
deallocate mycsr
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAuditionForEventRating]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAuditionForEventRating] @ev int
AS
BEGIN
	select a.id, firstname + ' ' + lastname as StudentName, classtype,classabbr, awardrating
	from audition a inner join entry b
		on a.id=b.id
		inner join student c
		on b.Student=c.id
	where b.Event=@ev
	order by classtype,lastname,firstname


END
GO
/****** Object:  StoredProcedure [dbo].[SelectComposers]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectComposers]
AS
BEGIN
	select id, composer from composer
END
GO
/****** Object:  StoredProcedure [dbo].[SelectContactForAccount]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectContactForAccount] @userName nvarchar(10)
AS
BEGIN
	select Id, LastName,firstname, email, phone 
		from Contact
	where UserName=@userName
END
GO
/****** Object:  StoredProcedure [dbo].[SelectDataForChairLocation]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectDataForChairLocation] @location int
AS
BEGIN


set nocount off

-- everything needed for preparing and setting up events

	select id, userName, lastName,firstName, email, phone, available,instrument 
	from Contact
	where ParentLocation=@location and Available=1

	select id, openDate, closeDate,eventDate,instrument,status from event
	where location=@location and status<>'H' --history, previous years events

	select event,teacher from teacherevent -- this table is purged - no history kept, just for enrollment phase
	where event in (select id from event where location=@location)







END
GO
/****** Object:  StoredProcedure [dbo].[SelectDataForGeneratingSchedule]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectDataForGeneratingSchedule] @ev int
AS
BEGIN
select a.id, classtype,prefhighlow,
 starttime, starttime as auditiontime, minutes as minutesremain
from schedule a inner join judge b
on a.judge=b.id
where b.event=@ev

select id,a.classtype,auditionminutes, 0 as schedule, null as auditionTime
from entry a inner join eventclass b
on a.classabbr=b.classabbr
where a.event=@ev

--also clear out the auditions, they will be recreated
delete a from audition a inner join entry b
on a.id=b.id
where b.event=@ev

END
GO
/****** Object:  StoredProcedure [dbo].[SelectDataForLocation]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [dbo].[SelectDataForLocation] @location int
	as

	set nocount on

	select a.Id, UserName, LastName,firstname, email, phone, available,instrument, b.Id as AssignedToLocation 
		from Contact a left outer join Location b
			on a.id=b.ContactId
	where a.ParentLocation=@location

	select LocationName, id,contactId
		from Location
	where ParentLocation=@location
		and LocationType>'A'
	order by LocationName

GO
/****** Object:  StoredProcedure [dbo].[SelectDataForTeacherEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectDataForTeacherEvent] @teacher int, @ev int
as
BEGIN


	select id,birthdate,phone,lastname,FirstName
	from student
		where teacher=@teacher

	;with cteHistory as(
	select student, classtype, classabbr, awardrating, consecutivesuperior, accumulatedpoints
	,ROW_NUMBER() over(partition by student,classtype order by eventdate desc) as rn
	from history
	 a inner join student b on a.student=b.id
	where teacher=@teacher)
	
	select student,classtype,classabbr,awardrating,consecutivesuperior,accumulatedpoints
	from cteHistory where rn=1

	select student,classtype, classabbr,status
	from entry
	where teacher=@teacher and event=@ev

	exec SelectEvent @ev

	declare @classtypes varchar(10)
	select @classtypes=classtypes from event where id=@ev

	select classtype, classabbr, auditionMinutes
	from eventclass
	where active=1 and CHARINDEX(classtype,@classtypes)>0
	order by classtype, AuditionMinutes,classabbr



END
GO
/****** Object:  StoredProcedure [dbo].[SelectEntryDetails]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectEntryDetails] @ev int, @teacher int
AS
BEGIN

DECLARE @entries TABLE(
    Id int NOT NULL,
    Student int NOT NULL,
	ClassType char(1) NOT NULL,
	ClassAbbr varchar(10) NOT NULL,
	Status char(1) NOT NULL
);

INSERT INTO @entries (Id, Student, ClassType, ClassAbbr,Status)
select id, student,classtype,classabbr,status
from Entry
where event=@ev and teacher=@teacher and status<>'-'

declare @classtypes varchar(5)
select @classtypes=classtypes
from event
where id=@ev

select distinct a.id,a.firstname,a.lastname from student a inner join @entries b
on a.id=b.student 


select classtype,typename,requireschoicepiece,RequiresAccomp
from eventclasstype
where charindex(classtype,@classtypes)>0

select id,student,classtype,classabbr,status from @entries

select a.id, requiredPiece,RequiredExtension, ChoicePiece,ChoiceComposer,Publisher,Accompanist, Notes
from EntryDetails a inner join @entries b on a.id=b.id

select c.id, d.Composer + ' :' + c.Composition as RequiredDescription
from EntryDetails a inner join @entries b on a.id=b.id
 left outer join Piece c
 on a.RequiredPiece=c.Id
 left outer join Composer d
 on c.Composer=d.Id

	select id, lastName,firstName, email, phone
		from Contact a inner join teacherevent b
		on a.id=b.teacher
		where b.event=@ev
	order by lastName,FirstName




END
GO
/****** Object:  StoredProcedure [dbo].[SelectEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectEvent] @id int 
AS
BEGIN

	select id, location,openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where id=@id

	select a.instrument from instrument a inner join event b
		on a.id=b.instrument
	where b.id=@id


END
GO
/****** Object:  StoredProcedure [dbo].[SelectEventCountForRollup]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SelectEventCountForRollup]
as

select count(*) as number from event
where datediff(d,eventdate,getdate())>36 -- allow 6 weeks after event for any corrections
and status='D'
GO
/****** Object:  StoredProcedure [dbo].[SelectEventsForDistrict]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectEventsForDistrict] @location int
AS
BEGIN


set nocount off


	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@location and status<>'H' --history, previous years events
	order by eventDate

	select id, instrument from instrument

	select id,parentlocation,locationtype,locationname,contactid from location
	where id=@location

END
GO
/****** Object:  StoredProcedure [dbo].[SelectEventsForTeacher]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectEventsForTeacher] @parentLocation int, @currentTime smalldatetime
AS
BEGIN
	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@parentLocation

	select id, instrument from instrument


	select id,parentlocation,locationtype,locationname,contactid from location
	where id=@parentlocation

  END
GO
/****** Object:  StoredProcedure [dbo].[SelectJudgeScheduleForEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectJudgeScheduleForEvent] @ev int
AS

-- returns all the time blocks allocated for the judges in this event
select a.id,judge,starttime,minutes,prefhighlow,classtype
from schedule a inner join judge b
on a.judge=b.id
where b.event=@ev
order by starttime,judge

--returns judges for this event
select id,[name]
from judge
where event=@ev


GO
/****** Object:  StoredProcedure [dbo].[SelectPiecesForClassAbbr]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectPiecesForClassAbbr] @classAbbr varchar(10)
AS
BEGIN
	select Id,Composition,Composer,Extension
	from piece
	where classAbbr=@classAbbr
END
GO
/****** Object:  StoredProcedure [dbo].[SelectScheduleSetupData]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SelectScheduleSetupData] @ev int
as

-- this query returns a summary of unscheduled entries grouped and sorted by classtype and audition minutes
-- it allows the chair to allocate more judging time as needed

select coalesce(c.typeName,'Grand Total') classTypeDesc, coalesce(convert(varchar(10),a.auditionminutes),'Total') auditionMinutes, sum(a.auditionminutes) totalminutes, count(a.auditionminutes) as number
from eventclass a inner join entry b
on a.classabbr=b.classabbr
inner join eventclasstype c on a.classtype=c.classtype
where b.event=@ev and b.id not in (select id from audition)
group by c.typeName,a.auditionminutes
with rollup;


-- summary of currently scheduled entries
select lastname,firstname,phone,classabbr,b.classtype,name as judgeName,auditiontime from audition a inner join entry b 
on a.id=b.id
inner join student c
on b.Student=c.id
inner join schedule d
on a.Schedule=d.Id
inner join judge e
on d.Judge=e.id
where b.Event=@ev
order by auditiontime

exec SelectJudgeScheduleForEvent @ev



GO
/****** Object:  StoredProcedure [dbo].[SelectTeachersForEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectTeachersForEvent] @id int
AS
BEGIN


set nocount on

	declare @location int
	declare @instrument char(1)

	select @location=location, @instrument=instrument
		from event
	where id=@id
	
	select id, userName, lastName,firstName, email, phone
			,available,instrument,case when b.teacher is NULL then  0 else b.event end as AssignedToLocation 
		from Contact a left outer join teacherevent b
		on a.id=b.teacher and @id=b.event
	where ParentLocation=@location
		and a.Available=1
		and instrument=@instrument
	order by lastName,FirstName

	select id,event,name
		from judge
	where event=@id
	order by name



END
GO
/****** Object:  StoredProcedure [dbo].[TransferStudent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TransferStudent] @id int, @teacher int
AS
BEGIN
	update student set teacher=@teacher
	where id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAllEntryStatus]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAllEntryStatus] @ev int, @teacher int, @status char(1)
AS

Update entry
set status=@status
where event=@ev and teacher=@teacher and status<>@status

GO
/****** Object:  StoredProcedure [dbo].[UpdateAwardRating]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateAwardRating] @id int, @awardRating char(1)
as

update audition set awardrating=@awardrating
where id=@id

update entry set status='C'
where id=@id
GO
/****** Object:  StoredProcedure [dbo].[UpdateContact]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateContact]
	@id int, @userName nvarchar(10), @lastName nvarchar(50), @firstName nvarchar(50),
	 @email nvarchar(50), @phone nvarchar(50), @parentLocation int, @available bit, @instrument char(1)
		
AS
	declare @locationType char(1)
	declare @role nvarchar(128)
	declare @userId nvarchar(128)

	if @id=0
	BEGIN

		select @userId=Id from aspnetusers
		where @userName=userName
		if @userId is null
		BEGIN
			raiserror('Person not found on server!', 11,1,'UpdateContact')
		END

		select @locationtype=locationtype
		from location
		where id=@parentlocation

		if @locationtype is null
		BEGIN
			raiserror('Parent location not found on server!', 11,1,'UpdateContact')
		END
		set @role=case @locationType when 'A' then '1' when 'B' then '1' when 'C' then '1' when 'D' then '2' when 'E' then '3' end
		if @role is null
		BEGIN
			raiserror('Parent location type is not valid!', 11,1,'UpdateContact')
		END

		BEGIN Transaction
		insert Contact (userName, lastName, firstName,email,phone,parentLocation,available, instrument)
			values(@userName,@lastName,@firstName,@email,@phone,@parentLocation,@available,@instrument)
		
		set @id=SCOPE_IDENTITY()
		
		-- add to asp role based on the parent location type
		insert aspnetuserroles(userId, RoleId) values(@userId,@role)

		commit transaction
		
		select @id as Id
	END
	
	else
	
	BEGIN
		declare @existingusername nvarchar(128), @existingemail nvarchar(50)


		select @existingusername=username, @existingemail=email
			from contact
		where id=@id
			if @@ROWCOUNT=0
				raiserror('Person not found on server!', 11,1,'UpdateContact')

		 
		begin transaction

			update Contact
				set LastName=@lastName, FirstName=@firstName, Email=@email,
					Phone=@phone, Available=@available, Instrument=@instrument
				where Id=@id
			
			if @existingemail<>@email
			BEGIN
				update aspnetusers
					set email=@email
				where username=@existingusername
			END
		commit transaction

		select  @id as Id
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactForAccount]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateContactForAccount] @id int, @firstname nvarchar(50), @lastname nvarchar(50), @email nvarchar(50), @phone nvarchar(50)
	AS
BEGIN
	declare @username nvarchar(10)
	declare @message varchar(50)

	select @username=username
	from contact
	where id=@id

	if @username is null
	BEGIN
		RAISERROR('Missing row in table contact!',11,1,'UpdateContactForAccount') 
	END

	BEGIN TRANSACTION
		update contact
			set email=@email, phone=@phone, firstname=@firstname, lastname=@lastname
		where id=@id
		update aspnetusers
			set email=@email, phonenumber=@phone
		where username=@username

	COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEntry]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEntry] @event int, @teacher int, @student int, @classtype char(1), @classabbr varchar(10)
AS
BEGIN
	declare @status char(1),@id int

	select @id=id, @status=status
	from entry
	where event=@event and student=@student and classtype=@classtype
	if @id is null
		set @id=0

	if @id<>0 and @status<>'-'
			RAISERROR('Entry cannot be changed: already processed.',11,1,'UpdateEntry')

	if @classabbr is null
	BEGIN
		if @id=0
			RAISERROR('No entry found to delete.',11,1,'UpdateEntry')
		delete entry
		where event=@event and student=@student and status='-'
	END
	else if @id=0
	BEGIN
		insert entry(event,teacher,student,classtype,classabbr,status)
			values(@event,@teacher,@student,@classtype,@classabbr,'-')
	END
	else
	BEGIN
		update entry
			set classabbr=@classabbr
		where id=@id
	END
	select @event as event, @teacher as teacher, @student as Student, @classtype as ClassType, @classabbr as ClassAbbr

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEntryDetails]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEntryDetails] @id int, @requiredpiece int, @requiredExtension char(1), @choicePiece nvarchar(50), 
	@choiceComposer nvarchar(50), @publisher nvarchar(20), @accompanist nvarchar(50), @notes nvarchar(50)
as

update entrydetails
	set requiredpiece=@requiredpiece, requiredextension=@requiredextension, choicepiece=@choicepiece,
	choicecomposer=@choicecomposer, publisher=@publisher, accompanist=@accompanist, notes=@notes
where id=@id

if @@rowcount=0
begin
	insert entrydetails (id, requiredpiece,requiredextension, choicepiece,choicecomposer,publisher,accompanist, notes)
	values (@id, @requiredpiece, @requiredextension,@choicepiece, @choicecomposer,@publisher, @accompanist, @notes)
end
update entry
set status='R'
where id=@id and status in ('A','?')

GO
/****** Object:  StoredProcedure [dbo].[UpdateEntryPaid]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEntryPaid] @ev int, @teacher int, @totalAmt decimal(9,2)
AS
BEGIN



---- calculate the total --------

declare @count int, @amountDue decimal(9,2)
declare @message varchar(100)

set @amountDue=0

	select @count=count(*),@amountDue=sum(0.96*auditionMinutes + 10)
		from entry a inner join eventClass b
			on a.classabbr=b.classabbr
		where event=@ev and teacher=@teacher and status='-'

set @message='?'


if @totalAmt>0 and @totalAmt<>@amountDue
	set @message='Cannot process payment - calculated amount is ' + convert(varchar(10),abs(@totalAmt-@amountDue)) + ' different from original.'

if @count=0
	set @message='No entries are awaiting payment.'


if @totalAmt>0 and @message='?'
BEGIN
	update entry set status='P'
		where event=@ev and teacher=@teacher  and status='-'
	set @message='Thank you. Your payment has been processed.'
END

select @count as entries, @amountDue as amountDue, @message as message
	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEntryStatus]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEntryStatus] @id int, @status char, @notes varchar(50)
AS
BEGIN
	update entry
	set status=@status
	where id=@id

	update entrydetails
	set notes=@notes
	where id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEvent] @id int, @location int, @openDate smalldatetime, @closeDate smalldatetime, @eventDate smalldatetime
	, @instrument char(1), @status char(1), @venue nvarchar(50), @notes varchar(256),@classTypes varchar(5)
as
BEGIN
	set @venue=isnull(@venue,'')
	set @notes=isnull(@notes,'')

	if @id=0
	BEGIN
		insert Event (location, opendate, closedate, eventdate, instrument, status, venue, notes,classTypes)
			values(@location,@opendate, @closedate, @eventdate, @instrument, @status, @venue, @notes,@classTypes)
		set @id=SCOPE_IDENTITY()
	END
	else
	BEGIN
		declare @oldinstrument char(1), @oldclassTypes varchar(5)
		select @oldinstrument=instrument, @oldclassTypes=classTypes
		from event
		where id=@id

		if @oldinstrument is null
			RAISERROR('Event not found in system!',11,1,'UpdateEvent')
		
		if @oldinstrument <> @instrument
		BEGIN
			if exists(select * from teacherevent where event=@id)
				RAISERROR('Cannot change instrument when teachers are already signed up!',11,1,'UpdateEvent')
		END
		if charindex(@classtypes,@oldclasstypes,0)<0
		BEGIN
			if exists(select * from entry where event=@id)
				RAISERROR('Cannot remove a class type from the event after registration!',11,1,'UpdateEvent')
		END
				 

		update Event
			set opendate=@opendate, closedate=@closedate, eventdate=@eventdate, instrument=@instrument,
			 status=@status, venue=@venue, notes=@notes, classTypes=@classTypes -- do not update location
		where id=@id
	END

	select @id as id

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEventCompleted]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEventCompleted] @ev int
AS
BEGIN
	update event set status='D'
	where id=@ev
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateJudge]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateJudge] @id int, @event int, @name nvarchar(50)
AS
BEGIN
	if @id=0
	BEGIN
		insert judge (event,name) values(@event,@name)
	END
	else if @id<0
	BEGIN
		if exists(Select * from audition a inner join schedule b on a.schedule=b.id where b.Judge=judge)
			RAISERROR('This judge has been assigned to entries and cannot be deleted.',11,1,'UpdateJudge')
		delete judge where id=-@id

	END
	else
	BEGIN
		update judge set name=@name
		where id=@id
	END
	select Id, Event, Name  -- return all judges for the event
	from judge
	where event=@event
	order by Name
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateLocation]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateLocation] @id int,  @contactId int, @locationName varchar(50)
AS
BEGIN
	update location set ContactId=case @contactId when 0 then NULL else @contactId end
	where Id=@id

	if @@ROWCOUNT=0
		raiserror('Location not found on server!', 11,1,'UpdateLocation')
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSchedule]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSchedule] @id int, @judge int, @startTime smalldatetime, @minutes smallint, @classType char(1), @prefHighLow char(1)
	
AS
BEGIN
	update schedule set judge=@judge, starttime=@starttime, minutes=@minutes, classtype=@classtype, prefHighLow=@prefHighLow
	where id=@id
	
	if @@rowcount=0
		insert schedule(judge,starttime,minutes,classtype,prefHighLow)
		values(@judge,@starttime,@minutes,@classtype,@prefHighLow)

	declare @ev int
	select @ev=event
	from judge
	where id=@judge

		exec SelectJudgeScheduleForEvent @ev
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateStudent] @id int, @instrument char(1), @teacher int, @birthdate smalldatetime,
	@phone varchar(20), @lastname nvarchar(50),@firstname nvarchar(50)
as

if @Id=0
BEGIN
	insert student (instrument, teacher, birthdate,phone,lastname,firstname)
		values(@instrument, @teacher, @birthdate, @phone, @lastname,@firstname)
	set @id=SCOPE_IDENTITY()
END
else
BEGIN
	update student
		set teacher=@teacher, birthdate=@birthdate, phone=@phone, lastname=@lastname, firstname=@firstname
	where id=@id
END
select @id as Id
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudentRegistration]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudentRegistration] @student int, @teacher int, @ev int, @classtype char(1),
	@classAbbr varchar(10)
AS
BEGIN
	if @classabbr='DELETE'
	BEGIN
		delete entry
			where event=@ev and teacher=@teacher and student=@student	
				and classtype=@classtype and status='R'

	END
	update entry
		set classabbr=@classabbr
			where event=@ev and teacher=@teacher and student=@student	
				and classtype=@classtype and status='R'
	if @@ROWCOUNT=0
		insert entry(event,teacher,student,classtype,classabbr,status)
			values(@ev,@teacher,@student,@classtype,@classabbr,'R')

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateTeacherEvent]    Script Date: 10/17/2018 6:12:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateTeacherEvent] @teacher int, @ev int, @participate bit 
AS
BEGIN

	declare @exists char(1)='N'

	if exists(select * from teacherevent where teacher=@teacher and event=@ev)
		set @exists='Y'


	if @participate=1
	BEGIN
		if @exists='N'
			insert teacherevent (teacher, event) values (@teacher,@ev)
	END
	else
	BEGIN
		if @exists='Y'
			delete teacherevent where teacher=@teacher and event=@ev
	END
END
GO
USE [master]
GO
ALTER DATABASE [Festival] SET  READ_WRITE 
GO
