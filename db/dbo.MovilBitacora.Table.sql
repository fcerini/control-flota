USE [SISEP_ControlFlota]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilBitacora](
	[mobiId] [int] IDENTITY(1,1) NOT NULL,
	[mobiMoviId] [int] NOT NULL,
	[mobiMoseId] [int] NULL,
	[mobiServId] [int] NULL,
	[mobiFecha] [date] NULL,
	[mobiObservaciones] [varchar](200) NULL,
	[mobiOdometro] [int] NULL,
	[mobiProximoOdometro] [int] NULL,
	[mobiProximaFecha] [date] NULL,
	[mobiIdAnterior] [int] NULL,
	[mobiIdSiguiente] [int] NULL,
	[mobiPendiente] [bit] NULL,
	[mobiFechaAlta] [datetime] NULL,
	[mobiBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_MovilBitacora] PRIMARY KEY CLUSTERED 
(
	[mobiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
