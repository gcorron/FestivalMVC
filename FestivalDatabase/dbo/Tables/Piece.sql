CREATE TABLE [dbo].[Piece] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [ClassAbbr]   VARCHAR (10)  NOT NULL,
    [Composition] VARCHAR (100) NOT NULL,
    [Composer]    INT           NOT NULL,
    [Extension]   TINYINT       NOT NULL,
    CONSTRAINT [PK_Piece] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Piece_Composer] FOREIGN KEY ([Composer]) REFERENCES [dbo].[Composer] ([Id]),
    CONSTRAINT [FK_Piece_EventClass] FOREIGN KEY ([ClassAbbr]) REFERENCES [dbo].[EventClass] ([ClassAbbr])
);





