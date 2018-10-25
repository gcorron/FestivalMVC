CREATE TABLE [dbo].[__location] (
    [Id]             INT          IDENTITY (1, 1) NOT NULL,
    [ParentLocation] INT          NULL,
    [LocationType]   CHAR (1)     NOT NULL,
    [LocationName]   VARCHAR (30) NOT NULL,
    [ContactId]      INT          NULL
);

