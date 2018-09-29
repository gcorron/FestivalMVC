CREATE TABLE [dbo].[Piece] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [ClassAbbr]   VARCHAR (10)  NOT NULL,
    [Composition] VARCHAR (100) NOT NULL,
    [Composer]    INT           NOT NULL,
    [Extension]   TINYINT       NOT NULL
);



