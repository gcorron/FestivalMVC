﻿CREATE TABLE [dbo].[__student] (
    [Id]         INT           NOT NULL,
    [Instrument] CHAR (1)      NOT NULL,
    [Teacher]    INT           NULL,
    [BirthDate]  SMALLDATETIME NOT NULL,
    [Phone]      VARCHAR (20)  NOT NULL,
    [LastName]   NVARCHAR (50) NOT NULL,
    [FirstName]  NVARCHAR (50) NOT NULL
);



