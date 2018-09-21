CREATE TABLE [dbo].[Student] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [Teacher]   INT           NOT NULL,
    [BirthDate] SMALLDATETIME NOT NULL,
    [Phone]     VARCHAR (20)  NOT NULL,
    [LastName]  NVARCHAR (50) NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL
);



