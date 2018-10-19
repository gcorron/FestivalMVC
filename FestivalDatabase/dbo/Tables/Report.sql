CREATE TABLE [dbo].[Report] (
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (50) NOT NULL,
    [Name]        VARCHAR (50) NOT NULL,
    [Role]        CHAR (1)     NOT NULL,
    [Params]      VARCHAR (5)  NOT NULL
);

