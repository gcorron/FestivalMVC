CREATE TABLE [dbo].[Schedule] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Judge]       INT           NOT NULL,
    [StartTime]   SMALLDATETIME NOT NULL,
    [Minutes]     SMALLINT      NOT NULL,
    [ClassType]   CHAR (1)      NOT NULL,
    [PrefHighLow] CHAR (1)      NOT NULL,
    CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Schedule_EventClassType] FOREIGN KEY ([ClassType]) REFERENCES [dbo].[EventClassType] ([ClassType]),
    CONSTRAINT [FK_Schedule_Judge] FOREIGN KEY ([Judge]) REFERENCES [dbo].[Judge] ([Id])
);





