CREATE TABLE [dbo].[History] (
    [Id]                INT      IDENTITY (1, 1) NOT NULL,
    [Event]             INT      NOT NULL,
    [Teacher]           INT      NOT NULL,
    [Student]           INT      NOT NULL,
    [AccumulatedPoints] TINYINT  NOT NULL,
    [AwardRating]       CHAR (1) NOT NULL,
    [AwardPoints]       TINYINT  NOT NULL
);



