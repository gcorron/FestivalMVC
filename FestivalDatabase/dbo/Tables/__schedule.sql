CREATE TABLE [dbo].[__schedule] (
    [Id]          INT           NOT NULL,
    [Judge]       INT           NOT NULL,
    [StartTime]   SMALLDATETIME NOT NULL,
    [Minutes]     SMALLINT      NOT NULL,
    [ClassType]   CHAR (1)      NOT NULL,
    [PrefHighLow] CHAR (1)      NOT NULL
);



