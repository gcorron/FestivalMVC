CREATE TABLE [dbo].[History] (
    [Student]             INT           NOT NULL,
    [ClassType]           CHAR (1)      NOT NULL,
    [Event]               INT           NOT NULL,
    [EventDate]           SMALLDATETIME NULL,
    [ClassAbbr]           VARCHAR (10)  NOT NULL,
    [AwardRating]         CHAR (1)      NOT NULL,
    [AwardPoints]         TINYINT       NOT NULL,
    [ConsecutiveSuperior] TINYINT       NOT NULL,
    [AccumulatedPoints]   TINYINT       NOT NULL,
    CONSTRAINT [FK_History_Event] FOREIGN KEY ([Event]) REFERENCES [dbo].[Event] ([Id]),
    CONSTRAINT [FK_History_EventClass] FOREIGN KEY ([ClassAbbr]) REFERENCES [dbo].[EventClass] ([ClassAbbr]),
    CONSTRAINT [FK_History_EventClassType] FOREIGN KEY ([ClassType]) REFERENCES [dbo].[EventClassType] ([ClassType]),
    CONSTRAINT [FK_History_Student] FOREIGN KEY ([Student]) REFERENCES [dbo].[Student] ([Id])
);














GO
CREATE CLUSTERED INDEX [IX_History]
    ON [dbo].[History]([Student] ASC, [Event] ASC);



