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
    CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED ([Id] ASC)
);








GO
CREATE NONCLUSTERED INDEX [IX_Event_1]
    ON [dbo].[Event]([EventDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Event]
    ON [dbo].[Event]([Location] ASC);

