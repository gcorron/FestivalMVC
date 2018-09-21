CREATE TABLE [dbo].[TeacherEvent] (
    [Location] INT      NOT NULL,
    [Event]    INT      NOT NULL,
    [Teacher]  INT      NOT NULL,
    [Status]   CHAR (1) NOT NULL,
    CONSTRAINT [PK_TeacherEvent] PRIMARY KEY CLUSTERED ([Location] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_TeacherEvent_1]
    ON [dbo].[TeacherEvent]([Teacher] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TeacherEvent]
    ON [dbo].[TeacherEvent]([Event] ASC);

