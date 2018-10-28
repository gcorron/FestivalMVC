CREATE TABLE [dbo].[Entry] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [Event]     INT          NOT NULL,
    [Teacher]   INT          NOT NULL,
    [Student]   INT          NOT NULL,
    [ClassType] CHAR (1)     NOT NULL,
    [ClassAbbr] VARCHAR (10) NOT NULL,
    [Status]    CHAR (1)     NOT NULL,
    CONSTRAINT [PK_Entry] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Entry_Contact] FOREIGN KEY ([Teacher]) REFERENCES [dbo].[Contact] ([Id]),
    CONSTRAINT [FK_Entry_Event] FOREIGN KEY ([Event]) REFERENCES [dbo].[Event] ([Id]),
    CONSTRAINT [FK_Entry_EventClass] FOREIGN KEY ([ClassAbbr]) REFERENCES [dbo].[EventClass] ([ClassAbbr]),
    CONSTRAINT [FK_Entry_EventClassType] FOREIGN KEY ([ClassType]) REFERENCES [dbo].[EventClassType] ([ClassType]),
    CONSTRAINT [FK_Entry_Student] FOREIGN KEY ([Student]) REFERENCES [dbo].[Student] ([Id])
);













