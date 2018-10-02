CREATE TABLE [dbo].[History] (
    [Student]             INT          NOT NULL,
    [ClassType]           CHAR (1)     NOT NULL,
    [Event]               INT          NOT NULL,
    [ClassAbbr]           VARCHAR (10) NOT NULL,
    [AwardRating]         CHAR (1)     NOT NULL,
    [AwardPoints]         TINYINT      NOT NULL,
    [ConsecutiveSuperior] TINYINT      NOT NULL,
    [AccumulatedPoints]   TINYINT      NOT NULL,
    CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED ([Student] ASC, [ClassType] ASC)
);










GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_History]
    ON [dbo].[History]([Student] ASC, [ClassType] ASC);

