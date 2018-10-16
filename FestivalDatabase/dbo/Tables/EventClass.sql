CREATE TABLE [dbo].[EventClass] (
    [ClassAbbr]       VARCHAR (10) NOT NULL,
    [ClassType]       CHAR (1)     NOT NULL,
    [Active]          BIT          NOT NULL,
    [AuditionMinutes] SMALLINT     NOT NULL,
    CONSTRAINT [PK_EventClass] PRIMARY KEY CLUSTERED ([ClassAbbr] ASC),
    CONSTRAINT [FK_EventClass_EventClassType] FOREIGN KEY ([ClassType]) REFERENCES [dbo].[EventClassType] ([ClassType])
);







