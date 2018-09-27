CREATE TABLE [dbo].[Judge] (
    [Id]    INT           IDENTITY (1, 1) NOT NULL,
    [event] INT           NOT NULL,
    [Name]  NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Judge] PRIMARY KEY CLUSTERED ([Id] ASC)
);






GO
CREATE NONCLUSTERED INDEX [IX_Judge]
    ON [dbo].[Judge]([event] ASC);

