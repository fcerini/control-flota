USE [SISEP_ControlFlota]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilServicio](
	[moseId] [int] IDENTITY(1,1) NOT NULL,
	[moseMoviId] [int] NOT NULL,
	[moseServId] [int] NOT NULL,
	[mosePeriodo] [int] NULL,
	[moseKM] [int] NULL,
	[moseFecha] [bit] NULL,
	[moseFechaAlta] [datetime] NULL,
	[moseBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_MovilServicio] PRIMARY KEY CLUSTERED 
(
	[moseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
