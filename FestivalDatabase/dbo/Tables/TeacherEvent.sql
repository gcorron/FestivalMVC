CREATE TABLE [dbo].[TeacherEvent] (
    [Teacher] INT NOT NULL,
    [Event]   INT NOT NULL,
    CONSTRAINT [PK_TeacherEvent] PRIMARY KEY CLUSTERED ([Teacher] ASC, [Event] ASC)
);




GO



GO
CREATE NONCLUSTERED INDEX [IX_TeacherEvent]
    ON [dbo].[TeacherEvent]([Event] ASC);

