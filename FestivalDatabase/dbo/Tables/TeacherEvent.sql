CREATE TABLE [dbo].[TeacherEvent] (
    [Teacher] INT NOT NULL,
    [Event]   INT NOT NULL,
    CONSTRAINT [PK_TeacherEvent] PRIMARY KEY CLUSTERED ([Teacher] ASC, [Event] ASC),
    CONSTRAINT [FK_TeacherEvent_Contact] FOREIGN KEY ([Teacher]) REFERENCES [dbo].[Contact] ([Id]),
    CONSTRAINT [FK_TeacherEvent_Event] FOREIGN KEY ([Event]) REFERENCES [dbo].[Event] ([Id])
);






GO



GO
CREATE NONCLUSTERED INDEX [IX_TeacherEvent]
    ON [dbo].[TeacherEvent]([Event] ASC);

