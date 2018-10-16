CREATE TABLE [dbo].[Contact] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [UserName]       NVARCHAR (10) NOT NULL,
    [LastName]       NVARCHAR (50) NOT NULL,
    [FirstName]      NVARCHAR (50) NOT NULL,
    [Email]          NVARCHAR (50) NOT NULL,
    [Phone]          NVARCHAR (50) NOT NULL,
    [ParentLocation] INT           NULL,
    [Available]      BIT           NOT NULL,
    [Instrument]     CHAR (1)      NOT NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Contact_Instrument] FOREIGN KEY ([Instrument]) REFERENCES [dbo].[Instrument] ([Id]),
    CONSTRAINT [FK_Contact_Instrument1] FOREIGN KEY ([Instrument]) REFERENCES [dbo].[Instrument] ([Id]),
    CONSTRAINT [FK_Contact_Location] FOREIGN KEY ([ParentLocation]) REFERENCES [dbo].[Location] ([Id])
);








GO
CREATE NONCLUSTERED INDEX [IX_Contact]
    ON [dbo].[Contact]([ParentLocation] ASC);

