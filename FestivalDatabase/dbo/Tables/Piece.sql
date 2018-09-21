CREATE TABLE [dbo].[Piece] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [ClassAbbr]   VARCHAR (10)  NULL,
    [Composition] VARCHAR (100) NOT NULL,
    [Composer]    INT           NOT NULL,
    [Movement]    VARCHAR (100) NULL,
    CONSTRAINT [PK_Piece] PRIMARY KEY CLUSTERED ([Id] ASC)
);

