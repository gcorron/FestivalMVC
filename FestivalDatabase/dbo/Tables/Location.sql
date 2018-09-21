CREATE TABLE [dbo].[Location] (
    [Id]             INT          IDENTITY (1, 1) NOT NULL,
    [ParentLocation] INT          NOT NULL,
    [LocationType]   CHAR (1)     NOT NULL,
    [LocationName]   VARCHAR (30) NOT NULL,
    [ContactId]      INT          NULL,
    CONSTRAINT [PK_Location_1] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Location_Location] FOREIGN KEY ([ParentLocation]) REFERENCES [dbo].[Location] ([Id])
);



