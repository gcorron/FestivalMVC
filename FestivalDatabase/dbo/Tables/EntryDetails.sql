CREATE TABLE [dbo].[EntryDetails] (
    [Id]                INT           NOT NULL,
    [RequiredPiece]     INT           NULL,
    [RequiredExtension] CHAR (1)      NOT NULL,
    [ChoicePiece]       NVARCHAR (50) NULL,
    [ChoiceComposer]    NVARCHAR (50) NULL,
    [Publisher]         NVARCHAR (20) NULL,
    [Accompanist]       NVARCHAR (50) NULL,
    [Notes]             NVARCHAR (50) NULL
);






GO
CREATE UNIQUE CLUSTERED INDEX [IX_EntryDetails]
    ON [dbo].[EntryDetails]([Id] ASC);



