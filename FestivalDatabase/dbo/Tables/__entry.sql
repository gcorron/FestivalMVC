﻿CREATE TABLE [dbo].[__entry] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [Event]     INT          NOT NULL,
    [Teacher]   INT          NOT NULL,
    [Student]   INT          NOT NULL,
    [ClassType] CHAR (1)     NOT NULL,
    [ClassAbbr] VARCHAR (10) NOT NULL,
    [Status]    CHAR (1)     NOT NULL
);





