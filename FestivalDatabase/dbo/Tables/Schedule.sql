CREATE TABLE [dbo].[Schedule] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Judge]      INT           NOT NULL,
    [StartTime]  SMALLDATETIME NOT NULL,
    [Minutes]    SMALLINT      NOT NULL,
    [ClassTypes] VARCHAR (5)   NOT NULL,
    [MinMinutes] SMALLINT      NOT NULL,
    [MaxMinutes] SMALLINT      NOT NULL
);

