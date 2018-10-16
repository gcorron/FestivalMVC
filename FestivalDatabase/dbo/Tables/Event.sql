CREATE TABLE [dbo].[Event] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Location]   INT           NOT NULL,
    [OpenDate]   SMALLDATETIME NOT NULL,
    [CloseDate]  SMALLDATETIME NOT NULL,
    [EventDate]  SMALLDATETIME NOT NULL,
    [Instrument] CHAR (1)      NOT NULL,
    [Status]     CHAR (1)      NOT NULL,
    [Venue]      NVARCHAR (50) NOT NULL,
    [Notes]      VARCHAR (256) NOT NULL,
    [ClassTypes] VARCHAR (5)   NOT NULL,
    CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Event_Instrument] FOREIGN KEY ([Instrument]) REFERENCES [dbo].[Instrument] ([Id]),
    CONSTRAINT [FK_Event_Instrument1] FOREIGN KEY ([Instrument]) REFERENCES [dbo].[Instrument] ([Id]),
    CONSTRAINT [FK_Event_Location] FOREIGN KEY ([Location]) REFERENCES [dbo].[Location] ([Id])
);












GO
CREATE NONCLUSTERED INDEX [IX_Event_1]
    ON [dbo].[Event]([EventDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Event]
    ON [dbo].[Event]([Location] ASC);

