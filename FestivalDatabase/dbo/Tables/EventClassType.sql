CREATE TABLE [dbo].[EventClassType] (
    [ClassType]           CHAR (1)     NOT NULL,
    [TypeName]            VARCHAR (50) NOT NULL,
    [RequiresChoicePiece] BIT          NOT NULL,
    [RequiresAccomp]      BIT          NOT NULL,
    CONSTRAINT [PK_EventClassType] PRIMARY KEY CLUSTERED ([ClassType] ASC)
);



