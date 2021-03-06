USE [SISEP_ControlFlota]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarea](
	[tareId] [int] IDENTITY(1,1) NOT NULL,
	[tareNombre] [varchar](100) NULL,
	[tareDescripcion] [varchar](200) NULL,
	[tareUnidadMedida] [varchar](50) NULL,
	[tareCantidad] [float] NULL,
	[tareCosto] [float] NULL,
	[tareFechaAlta] [datetime] NULL,
	[tareBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Tarea] PRIMARY KEY CLUSTERED 
(
	[tareId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
