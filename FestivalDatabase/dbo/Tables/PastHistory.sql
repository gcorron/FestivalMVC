CREATE TABLE [dbo].[PastHistory] (
    [Student]             INT          IDENTITY (1, 1) NOT NULL,
    [ClassType]           CHAR (1)     NOT NULL,
    [Event]               INT          NOT NULL,
    [ClassAbbr]           VARCHAR (10) NOT NULL,
    [AwardRating]         CHAR (1)     NOT NULL,
    [AwardPoints]         TINYINT      NOT NULL,
    [ConsecutiveSuperior] TINYINT      NOT NULL,
    [AccumulatedPoints]   TINYINT      NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_PastHistory]
    ON [dbo].[PastHistory]([Student] ASC);

