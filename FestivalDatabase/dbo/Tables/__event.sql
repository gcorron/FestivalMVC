CREATE TABLE [dbo].[__event] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Location]   INT           NOT NULL,
    [OpenDate]   SMALLDATETIME NOT NULL,
    [CloseDate]  SMALLDATETIME NOT NULL,
    [EventDate]  SMALLDATETIME NOT NULL,
    [Instrument] CHAR (1)      NOT NULL,
    [Status]     CHAR (1)      NOT NULL,
    [Venue]      NVARCHAR (50) NOT NULL,
    [Notes]      VARCHAR (256) NOT NULL,
    [ClassTypes] VARCHAR (5)   NOT NULL
);





