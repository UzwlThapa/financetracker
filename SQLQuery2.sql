USE [master]
GO
/****** Object:  Database [WaiterModuleMultiTenants]    Script Date: 9/22/2026 5:26:33 PM ******/
CREATE DATABASE [WaiterModuleMultiTenants]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WaiterModuleMultiTenants', FILENAME = N'E:\SQLDB\Data\SQLDB\WaiterModuleMultiTenants\WaiterModuleMultiTenants.mdf' , SIZE = 598016KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WaiterModuleMultiTenants_log', FILENAME = N'E:\SQLDB\Data\SQLDB\WaiterModuleMultiTenants\WaiterModuleMultiTenants_log.ldf' , SIZE = 69568KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WaiterModuleMultiTenants].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ARITHABORT OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET  MULTI_USER 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WaiterModuleMultiTenants', N'ON'
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET QUERY_STORE = ON
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WaiterModuleMultiTenants]
GO
/****** Object:  User [waitermodule_admin]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE USER [waitermodule_admin] FOR LOGIN [waitermodule_admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [newrelic]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE USER [newrelic] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [waitermodule_admin]
GO
/****** Object:  Schema [HangFire]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdDailyStats]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdDailyStats](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdId] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[TotalImpressions] [int] NOT NULL,
	[TotalVisibleSeconds] [int] NOT NULL,
	[TotalPlayedSeconds] [int] NOT NULL,
	[CompletedPlays] [int] NOT NULL,
	[UniqueDevices] [int] NOT NULL,
 CONSTRAINT [PK_AdDailyStats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdLogs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AdId] [int] NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[DeviceName] [nvarchar](max) NULL,
	[IpAddress] [nvarchar](max) NULL,
	[ShownAt] [datetime2](7) NOT NULL,
	[HiddenAt] [datetime2](7) NULL,
	[VisibleSeconds] [int] NULL,
	[PlayedSeconds] [int] NULL,
	[WasCompleted] [bit] NOT NULL,
	[WasSkipped] [bit] NOT NULL,
	[DisplayReason] [int] NOT NULL,
	[ScreenName] [nvarchar](max) NULL,
	[AppVersion] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[AdLogsBatchId] [int] NOT NULL,
	[LocalLogDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AdLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdLogsBatches]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdLogsBatches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchCode] [nvarchar](max) NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[BatchDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AdLogsBatches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ads]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ads](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MediaType] [int] NOT NULL,
	[MediaPath] [nvarchar](max) NOT NULL,
	[ThumbnailPath] [nvarchar](max) NULL,
	[Priority] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DurationSeconds] [int] NULL,
	[VideoLengthSeconds] [int] NULL,
	[TargetAllDevices] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[AdFormat] [int] NOT NULL,
	[AdvertiserId] [int] NOT NULL,
	[ImageSize] [int] NULL,
	[Tags] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Ads] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdSchedules]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdSchedules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdId] [int] NOT NULL,
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
	[Sunday] [bit] NOT NULL,
	[Monday] [bit] NOT NULL,
	[Tuesday] [bit] NOT NULL,
	[Wednesday] [bit] NOT NULL,
	[Thursday] [bit] NOT NULL,
	[Friday] [bit] NOT NULL,
	[Saturday] [bit] NOT NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AdSchedules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdsTags]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdsTags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[UsageCount] [int] NULL,
 CONSTRAINT [PK_AdsTags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Advertisers]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdvertiserName] [nvarchar](max) NOT NULL,
	[AdvertiserLocation] [nvarchar](max) NULL,
	[AdvertiserContact] [nvarchar](max) NULL,
	[AdvertiserEmail] [nvarchar](max) NULL,
	[ContactPerson] [nvarchar](max) NOT NULL,
	[ContactPhone] [nvarchar](max) NULL,
	[ContactEmail] [nvarchar](max) NULL,
 CONSTRAINT [PK_Advertisers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiKey] [nvarchar](max) NOT NULL,
	[RegDate] [datetime2](7) NOT NULL,
	[Status] [bit] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [int] NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CampaignAd]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CampaignAd](
	[CampaignId] [int] NOT NULL,
	[AdId] [int] NOT NULL,
	[PriorityOverride] [int] NULL,
	[AssignedAt] [datetime2](7) NOT NULL,
	[Duration] [int] NULL,
	[OrderIndex] [int] NOT NULL,
 CONSTRAINT [PK_CampaignAd] PRIMARY KEY CLUSTERED 
(
	[CampaignId] ASC,
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campaigns]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaigns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[Tags] [nvarchar](max) NOT NULL,
	[IsDraft] [bit] NOT NULL,
	[PlayUntilTurnedOff] [bit] NOT NULL,
	[TargetAudienceSize] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Campaigns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CampaignSchedules]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CampaignSchedules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
	[Sunday] [bit] NOT NULL,
	[Monday] [bit] NOT NULL,
	[Tuesday] [bit] NOT NULL,
	[Wednesday] [bit] NOT NULL,
	[Thursday] [bit] NOT NULL,
	[Friday] [bit] NOT NULL,
	[Saturday] [bit] NOT NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CampaignSchedules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CloudRestroGracePeriodLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CloudRestroGracePeriodLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrgCode] [nvarchar](max) NOT NULL,
	[OrgName] [nvarchar](max) NOT NULL,
	[PreviousDate] [datetime2](7) NOT NULL,
	[FinalDate] [datetime2](7) NOT NULL,
	[UpdatedOn] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](max) NOT NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_CloudRestroGracePeriodLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CloudRestroPaymentLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CloudRestroPaymentLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrgCode] [nvarchar](max) NOT NULL,
	[OrgName] [nvarchar](max) NOT NULL,
	[AmountRecived] [decimal](18, 2) NOT NULL,
	[PaymentType] [int] NOT NULL,
	[ChequeBankName] [nvarchar](max) NULL,
	[IsPaymentSuccessfull] [bit] NOT NULL,
	[PaymentDate] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CloudRestroPaymentLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NOT NULL,
	[TaskId] [int] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbManagements]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbManagements](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DbServer] [nvarchar](max) NOT NULL,
	[DbName] [nvarchar](max) NOT NULL,
	[DbUser] [nvarchar](max) NOT NULL,
	[DbPassword] [nvarchar](max) NOT NULL,
	[RegDate] [datetime2](7) NOT NULL,
	[Status] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_DbManagements] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceActivityLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceActivityLogs](
	[Id] [uniqueidentifier] NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[DeviceCode] [nvarchar](max) NULL,
	[ActivityType] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[OccurredAt] [datetime2](7) NOT NULL,
	[MachineName] [nvarchar](max) NULL,
	[LocalIp] [nvarchar](max) NULL,
	[Origin] [int] NOT NULL,
 CONSTRAINT [PK_DeviceActivityLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceCampaigns]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceCampaigns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderIndex] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[CampaignId] [int] NOT NULL,
 CONSTRAINT [PK_DeviceCampaigns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceHeartbeats]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceHeartbeats](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[IsAppRunning] [bit] NULL,
	[MachineName] [nvarchar](max) NULL,
	[LocalIp] [nvarchar](max) NULL,
	[HeartbeatAt] [datetime2](7) NOT NULL,
	[IsDeviceRunning] [bit] NULL,
	[Origin] [int] NOT NULL,
 CONSTRAINT [PK_DeviceHeartbeats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DevicesAds]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevicesAds](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderIndex] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[MacId] [nvarchar](max) NOT NULL,
	[AdId] [int] NOT NULL,
 CONSTRAINT [PK_DevicesAds] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ToEmail] [nvarchar](max) NOT NULL,
	[IsHtml] [bit] NOT NULL,
	[Sent] [bit] NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[SentAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_EmailLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GracePeriodLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GracePeriodLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiKey] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](max) NOT NULL,
	[PreviousDate] [datetime2](7) NOT NULL,
	[FinalDate] [datetime2](7) NOT NULL,
	[UpdatedOn] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](max) NOT NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_GracePeriodLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryDbManagement]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryDbManagement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DbServer] [nvarchar](max) NOT NULL,
	[DbName] [nvarchar](max) NOT NULL,
	[DbUser] [nvarchar](max) NOT NULL,
	[DbPassword] [nvarchar](max) NOT NULL,
	[RegDate] [datetime2](7) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_InventoryDbManagement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[Id] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](260) NOT NULL,
	[Url] [nvarchar](1000) NOT NULL,
	[MimeType] [nvarchar](100) NOT NULL,
	[Size] [bigint] NOT NULL,
	[UploadedAt] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Page]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[Id] [uniqueidentifier] NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Title] [nvarchar](300) NOT NULL,
	[Subtitle] [nvarchar](500) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[FeaturedMediaId] [uniqueidentifier] NULL,
	[MetaTitle] [nvarchar](300) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetimeoffset](7) NOT NULL,
	[UpdatedAt] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ColorCode] [nvarchar](max) NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersContactPersons]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersContactPersons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RestroUsersInfoApiKey] [uniqueidentifier] NOT NULL,
	[ContactPersonName] [nvarchar](max) NOT NULL,
	[ContactPersonEmail] [nvarchar](max) NULL,
	[ContactPersonPhone] [nvarchar](max) NOT NULL,
	[Designation] [nvarchar](max) NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_RestroUsersContactPersons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersDateUpdateLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersDateUpdateLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiKey] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](max) NOT NULL,
	[PreviousDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[UpdatedOn] [datetime2](7) NOT NULL,
	[UpdatedBy] [nvarchar](max) NOT NULL,
	[Remarks] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RestroUsersDateUpdateLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersInfo]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersInfo](
	[ApiKey] [uniqueidentifier] NOT NULL,
	[TenantName] [nvarchar](max) NOT NULL,
	[TenantCode] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Country] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[RegsiteredDate] [datetime2](7) NOT NULL,
	[ValidTill] [datetime2](7) NOT NULL,
	[AMCStartDate] [datetime2](7) NULL,
	[AMCEndDate] [datetime2](7) NULL,
	[IsDemoVersion] [bit] NOT NULL,
	[IsCloudVersion] [bit] NOT NULL,
	[PanVatNumber] [nvarchar](max) NULL,
	[IsIRDVeriied] [bit] NOT NULL,
	[CBMSUsername] [nvarchar](max) NULL,
	[CBMSPassword] [nvarchar](max) NULL,
	[AbbreviatedValue] [nvarchar](max) NULL,
	[IsAbbreviated] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[GracePeriodDays] [int] NOT NULL,
	[EmailAddress] [nvarchar](max) NULL,
	[Version] [nvarchar](max) NULL,
	[VatName] [nvarchar](max) NULL,
 CONSTRAINT [PK_RestroUsersInfo] PRIMARY KEY CLUSTERED 
(
	[ApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiKey] [uniqueidentifier] NOT NULL,
	[LogTime] [datetime2](7) NOT NULL,
	[LogFor] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NOT NULL,
	[LogDetails] [nvarchar](max) NULL,
 CONSTRAINT [PK_RestroUsersLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersPaymentLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersPaymentLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiKey] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](max) NOT NULL,
	[AmountRecived] [decimal](18, 2) NOT NULL,
	[PaymentType] [int] NOT NULL,
	[ChequeBankName] [nvarchar](max) NULL,
	[IsPaymentSuccessfull] [bit] NOT NULL,
	[PaymentDate] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](max) NOT NULL,
	[DateUpdateLogId] [int] NULL,
 CONSTRAINT [PK_RestroUsersPaymentLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestroUsersQueryLogs]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestroUsersQueryLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RestroUsersInfoApiKey] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](max) NOT NULL,
	[QueryText] [nvarchar](max) NULL,
	[ExecutedAt] [datetime2](7) NOT NULL,
	[IsActiveUserRequest] [bit] NOT NULL,
	[ResponseStatus] [nvarchar](max) NULL,
	[LogFor] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RestroUsersQueryLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[ProjectId] [int] NOT NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 9/22/2026 5:26:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_AdDailyStats_AdId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdDailyStats_AdId] ON [dbo].[AdDailyStats]
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AdLogs_AdId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdLogs_AdId] ON [dbo].[AdLogs]
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AdLogs_AdLogsBatchId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdLogs_AdLogsBatchId] ON [dbo].[AdLogs]
(
	[AdLogsBatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ads_AdvertiserId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Ads_AdvertiserId] ON [dbo].[Ads]
(
	[AdvertiserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AdSchedules_AdId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AdSchedules_AdId] ON [dbo].[AdSchedules]
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CampaignAd_AdId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_CampaignAd_AdId] ON [dbo].[CampaignAd]
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CampaignSchedules_CampaignId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_CampaignSchedules_CampaignId] ON [dbo].[CampaignSchedules]
(
	[CampaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Comments_TaskId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Comments_TaskId] ON [dbo].[Comments]
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DbManagements_UserId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_DbManagements_UserId] ON [dbo].[DbManagements]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DeviceCampaigns_CampaignId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_DeviceCampaigns_CampaignId] ON [dbo].[DeviceCampaigns]
(
	[CampaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DevicesAds_AdId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_DevicesAds_AdId] ON [dbo].[DevicesAds]
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GracePeriodLogs_ApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_GracePeriodLogs_ApiKey] ON [dbo].[GracePeriodLogs]
(
	[ApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_InventoryDbManagement_UserId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_InventoryDbManagement_UserId] ON [dbo].[InventoryDbManagement]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Page_FeaturedMediaId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Page_FeaturedMediaId] ON [dbo].[Page]
(
	[FeaturedMediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersContactPersons_RestroUsersInfoApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestroUsersContactPersons_RestroUsersInfoApiKey] ON [dbo].[RestroUsersContactPersons]
(
	[RestroUsersInfoApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersDateUpdateLogs_ApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestroUsersDateUpdateLogs_ApiKey] ON [dbo].[RestroUsersDateUpdateLogs]
(
	[ApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersLogs_ApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestroUsersLogs_ApiKey] ON [dbo].[RestroUsersLogs]
(
	[ApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersPaymentLogs_ApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestroUsersPaymentLogs_ApiKey] ON [dbo].[RestroUsersPaymentLogs]
(
	[ApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersPaymentLogs_DateUpdateLogId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RestroUsersPaymentLogs_DateUpdateLogId] ON [dbo].[RestroUsersPaymentLogs]
(
	[DateUpdateLogId] ASC
)
WHERE ([DateUpdateLogId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestroUsersQueryLogs_RestroUsersInfoApiKey]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestroUsersQueryLogs_RestroUsersInfoApiKey] ON [dbo].[RestroUsersQueryLogs]
(
	[RestroUsersInfoApiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tasks_ProjectId]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tasks_ProjectId] ON [dbo].[Tasks]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_State_CreatedAt]    Script Date: 9/22/2026 5:26:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_State_CreatedAt] ON [HangFire].[State]
(
	[CreatedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdLogs] ADD  DEFAULT ((0)) FOR [AdLogsBatchId]
GO
ALTER TABLE [dbo].[AdLogs] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [LocalLogDateTime]
GO
ALTER TABLE [dbo].[Ads] ADD  DEFAULT ((0)) FOR [AdFormat]
GO
ALTER TABLE [dbo].[Ads] ADD  DEFAULT ((0)) FOR [AdvertiserId]
GO
ALTER TABLE [dbo].[Ads] ADD  DEFAULT (N'[]') FOR [Tags]
GO
ALTER TABLE [dbo].[Ads] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AdSchedules] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[CampaignAd] ADD  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[Campaigns] ADD  DEFAULT (N'[]') FOR [Tags]
GO
ALTER TABLE [dbo].[Campaigns] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDraft]
GO
ALTER TABLE [dbo].[Campaigns] ADD  DEFAULT (CONVERT([bit],(0))) FOR [PlayUntilTurnedOff]
GO
ALTER TABLE [dbo].[Campaigns] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[DeviceActivityLogs] ADD  DEFAULT ((0)) FOR [Origin]
GO
ALTER TABLE [dbo].[DeviceHeartbeats] ADD  DEFAULT ((0)) FOR [Origin]
GO
ALTER TABLE [dbo].[RestroUsersInfo] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsActive]
GO
ALTER TABLE [dbo].[RestroUsersInfo] ADD  DEFAULT ((0)) FOR [GracePeriodDays]
GO
ALTER TABLE [dbo].[RestroUsersQueryLogs] ADD  DEFAULT (N'') FOR [LogFor]
GO
ALTER TABLE [dbo].[AdDailyStats]  WITH CHECK ADD  CONSTRAINT [FK_AdDailyStats_Ads_AdId] FOREIGN KEY([AdId])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdDailyStats] CHECK CONSTRAINT [FK_AdDailyStats_Ads_AdId]
GO
ALTER TABLE [dbo].[AdLogs]  WITH CHECK ADD  CONSTRAINT [FK_AdLogs_AdLogsBatches_AdLogsBatchId] FOREIGN KEY([AdLogsBatchId])
REFERENCES [dbo].[AdLogsBatches] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdLogs] CHECK CONSTRAINT [FK_AdLogs_AdLogsBatches_AdLogsBatchId]
GO
ALTER TABLE [dbo].[AdLogs]  WITH CHECK ADD  CONSTRAINT [FK_AdLogs_Ads_AdId] FOREIGN KEY([AdId])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdLogs] CHECK CONSTRAINT [FK_AdLogs_Ads_AdId]
GO
ALTER TABLE [dbo].[Ads]  WITH CHECK ADD  CONSTRAINT [FK_Ads_Advertisers_AdvertiserId] FOREIGN KEY([AdvertiserId])
REFERENCES [dbo].[Advertisers] ([Id])
GO
ALTER TABLE [dbo].[Ads] CHECK CONSTRAINT [FK_Ads_Advertisers_AdvertiserId]
GO
ALTER TABLE [dbo].[AdSchedules]  WITH CHECK ADD  CONSTRAINT [FK_AdSchedules_Ads_AdId] FOREIGN KEY([AdId])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdSchedules] CHECK CONSTRAINT [FK_AdSchedules_Ads_AdId]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[CampaignAd]  WITH CHECK ADD  CONSTRAINT [FK_CampaignAd_Ads_AdId] FOREIGN KEY([AdId])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CampaignAd] CHECK CONSTRAINT [FK_CampaignAd_Ads_AdId]
GO
ALTER TABLE [dbo].[CampaignAd]  WITH CHECK ADD  CONSTRAINT [FK_CampaignAd_Campaigns_CampaignId] FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CampaignAd] CHECK CONSTRAINT [FK_CampaignAd_Campaigns_CampaignId]
GO
ALTER TABLE [dbo].[CampaignSchedules]  WITH CHECK ADD  CONSTRAINT [FK_CampaignSchedules_Campaigns_CampaignId] FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CampaignSchedules] CHECK CONSTRAINT [FK_CampaignSchedules_Campaigns_CampaignId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Tasks_TaskId] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Tasks] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Tasks_TaskId]
GO
ALTER TABLE [dbo].[DbManagements]  WITH CHECK ADD  CONSTRAINT [FK_DbManagements_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DbManagements] CHECK CONSTRAINT [FK_DbManagements_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[DeviceCampaigns]  WITH CHECK ADD  CONSTRAINT [FK_DeviceCampaigns_Campaigns_CampaignId] FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DeviceCampaigns] CHECK CONSTRAINT [FK_DeviceCampaigns_Campaigns_CampaignId]
GO
ALTER TABLE [dbo].[DevicesAds]  WITH CHECK ADD  CONSTRAINT [FK_DevicesAds_Ads_AdId] FOREIGN KEY([AdId])
REFERENCES [dbo].[Ads] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DevicesAds] CHECK CONSTRAINT [FK_DevicesAds_Ads_AdId]
GO
ALTER TABLE [dbo].[GracePeriodLogs]  WITH CHECK ADD  CONSTRAINT [FK_GracePeriodLogs_RestroUsersInfo_ApiKey] FOREIGN KEY([ApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GracePeriodLogs] CHECK CONSTRAINT [FK_GracePeriodLogs_RestroUsersInfo_ApiKey]
GO
ALTER TABLE [dbo].[InventoryDbManagement]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDbManagement_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryDbManagement] CHECK CONSTRAINT [FK_InventoryDbManagement_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Page]  WITH CHECK ADD  CONSTRAINT [FK_Page_Media_FeaturedMediaId] FOREIGN KEY([FeaturedMediaId])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Page] CHECK CONSTRAINT [FK_Page_Media_FeaturedMediaId]
GO
ALTER TABLE [dbo].[RestroUsersContactPersons]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersContactPersons_RestroUsersInfo_RestroUsersInfoApiKey] FOREIGN KEY([RestroUsersInfoApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RestroUsersContactPersons] CHECK CONSTRAINT [FK_RestroUsersContactPersons_RestroUsersInfo_RestroUsersInfoApiKey]
GO
ALTER TABLE [dbo].[RestroUsersDateUpdateLogs]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersDateUpdateLogs_RestroUsersInfo_ApiKey] FOREIGN KEY([ApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RestroUsersDateUpdateLogs] CHECK CONSTRAINT [FK_RestroUsersDateUpdateLogs_RestroUsersInfo_ApiKey]
GO
ALTER TABLE [dbo].[RestroUsersLogs]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersLogs_RestroUsersInfo_ApiKey] FOREIGN KEY([ApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RestroUsersLogs] CHECK CONSTRAINT [FK_RestroUsersLogs_RestroUsersInfo_ApiKey]
GO
ALTER TABLE [dbo].[RestroUsersPaymentLogs]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersPaymentLogs_RestroUsersDateUpdateLogs_DateUpdateLogId] FOREIGN KEY([DateUpdateLogId])
REFERENCES [dbo].[RestroUsersDateUpdateLogs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[RestroUsersPaymentLogs] CHECK CONSTRAINT [FK_RestroUsersPaymentLogs_RestroUsersDateUpdateLogs_DateUpdateLogId]
GO
ALTER TABLE [dbo].[RestroUsersPaymentLogs]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersPaymentLogs_RestroUsersInfo_ApiKey] FOREIGN KEY([ApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
GO
ALTER TABLE [dbo].[RestroUsersPaymentLogs] CHECK CONSTRAINT [FK_RestroUsersPaymentLogs_RestroUsersInfo_ApiKey]
GO
ALTER TABLE [dbo].[RestroUsersQueryLogs]  WITH CHECK ADD  CONSTRAINT [FK_RestroUsersQueryLogs_RestroUsersInfo_RestroUsersInfoApiKey] FOREIGN KEY([RestroUsersInfoApiKey])
REFERENCES [dbo].[RestroUsersInfo] ([ApiKey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RestroUsersQueryLogs] CHECK CONSTRAINT [FK_RestroUsersQueryLogs_RestroUsersInfo_RestroUsersInfoApiKey]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Projects_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Projects_ProjectId]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
USE [master]
GO
ALTER DATABASE [WaiterModuleMultiTenants] SET  READ_WRITE 
GO
