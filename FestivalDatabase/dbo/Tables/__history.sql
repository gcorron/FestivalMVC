CREATE TABLE [dbo].[__history] (
    [Student]             INT           NOT NULL,
    [ClassType]           CHAR (1)      NOT NULL,
    [Event]               INT           NOT NULL,
    [EventDate]           SMALLDATETIME NULL,
    [ClassAbbr]           VARCHAR (10)  NOT NULL,
    [AwardRating]         CHAR (1)      NOT NULL,
    [AwardPoints]         TINYINT       NOT NULL,
    [ConsecutiveSuperior] TINYINT       NOT NULL,
    [AccumulatedPoints]   TINYINT       NOT NULL
);

