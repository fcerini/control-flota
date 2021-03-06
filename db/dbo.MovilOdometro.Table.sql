USE [SISEP_ControlFlota]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilOdometro](
	[modoId] [int] IDENTITY(1,1) NOT NULL,
	[modoMoviId] [int] NOT NULL,
	[modoFecha] [date] NOT NULL,
	[modoOdometro] [int] NOT NULL,
	[modoFechaAlta] [datetime] NULL,
	[modoBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_MovilOdometro] PRIMARY KEY CLUSTERED 
(
	[modoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
