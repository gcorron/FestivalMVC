CREATE TABLE [dbo].[__schedule] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Judge]       INT           NOT NULL,
    [StartTime]   SMALLDATETIME NOT NULL,
    [Minutes]     SMALLINT      NOT NULL,
    [ClassType]   CHAR (1)      NOT NULL,
    [PrefHighLow] CHAR (1)      NOT NULL
);

