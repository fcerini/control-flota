USE [SISEP_ControlFlota]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovilGrupo](
	[mogrId] [int] IDENTITY(1,1) NOT NULL,
	[mogrMoviId] [int] NOT NULL,
	[mogrGrupId] [int] NOT NULL,
	[mogrFechaAlta] [datetime] NULL,
	[mogrBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_MovilGrupo] PRIMARY KEY CLUSTERED 
(
	[mogrId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
