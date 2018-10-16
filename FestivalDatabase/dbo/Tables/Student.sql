CREATE TABLE [dbo].[Student] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Instrument] CHAR (1)      NOT NULL,
    [Teacher]    INT           NULL,
    [BirthDate]  SMALLDATETIME NOT NULL,
    [Phone]      VARCHAR (20)  NOT NULL,
    [LastName]   NVARCHAR (50) NOT NULL,
    [FirstName]  NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Student_Contact] FOREIGN KEY ([Teacher]) REFERENCES [dbo].[Contact] ([Id]),
    CONSTRAINT [FK_Student_Instrument] FOREIGN KEY ([Instrument]) REFERENCES [dbo].[Instrument] ([Id])
);







