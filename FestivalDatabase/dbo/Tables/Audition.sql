CREATE TABLE [dbo].[Audition] (
    [id]           INT           NOT NULL,
    [Schedule]     INT           NOT NULL,
    [AuditionTime] SMALLDATETIME NOT NULL,
    [AwardRating]  CHAR (1)      NOT NULL,
    CONSTRAINT [PK_Audition] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Audition_Entry] FOREIGN KEY ([id]) REFERENCES [dbo].[Entry] ([Id]),
    CONSTRAINT [FK_Audition_Schedule] FOREIGN KEY ([Schedule]) REFERENCES [dbo].[Schedule] ([Id])
);








GO


