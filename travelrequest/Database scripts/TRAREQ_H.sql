﻿--class id : pbs.BO.HR.TRARH
--class name : Travel Request Accomodation

CREATE TABLE [dbo].[pbs_HR_TRAVEL_REQ_ACCOMODATION_{XXX}](
	[REQUEST_NO] [varchar](15) NOT NULL,
	[LINE_NO] [varchar](5) NOT NULL,
	[HOTEL] [nvarchar](50) NOT NULL,
	[CHECK_IN_DATE] [int] NOT NULL,
	[CHECK_IN_TIME] [int] NOT NULL,
	[CHECK_OUT_DATE] [int] NOT NULL,
	[CHECK_OUT_TIME] [int] NOT NULL,
	[STAYING_DAYS] [numeric](18, 2) NOT NULL,
	[PRICE] [numeric](18, 2) NOT NULL,
	[TAX] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_pbs_HR_TRAVEL_REQ_ACCOMODATION_{XXX}_1] PRIMARY KEY CLUSTERED 
(
	[REQUEST_NO] ASC,
	[LINE_NO] ASC
)
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[pbs_TRARH_{XXX}_InsertUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [pbs_TRARH_{XXX}_InsertUpdate]
	@REQUEST_NO System.String(15),
@LINE_NO System.String(5),
@HOTEL System.String(50),
@CHECK_IN_DATE int,
@CHECK_IN_TIME int,
@CHECK_OUT_DATE int,
@CHECK_OUT_TIME int,
@STAYING_DAYS System.Decimal(18, 2),
@PRICE System.Decimal(18, 2),
@TAX System.Decimal(18, 2)
AS

SET NOCOUNT ON

IF EXISTS(SELECT REQUEST_NO,LINE_NO FROM [pbs_HR_TRAVEL_REQ_ACCOMODATION_{XXX}] WHERE [REQUEST_NO] = @REQUEST_NO AND [LINE_NO] = @LINE_NO)
BEGIN
	UPDATE [pbs_HR_TRAVEL_REQ_ACCOMODATION_{XXX}] SET
		[HOTEL] = @HOTEL,
[CHECK_IN_DATE] = @CHECK_IN_DATE,
[CHECK_IN_TIME] = @CHECK_IN_TIME,
[CHECK_OUT_DATE] = @CHECK_OUT_DATE,
[CHECK_OUT_TIME] = @CHECK_OUT_TIME,
[STAYING_DAYS] = @STAYING_DAYS,
[PRICE] = @PRICE,
[TAX] = @TAX
	WHERE [REQUEST_NO] = @REQUEST_NO AND [LINE_NO] = @LINE_NO
END
ELSE
BEGIN
	INSERT INTO [pbs_HR_TRAVEL_REQ_ACCOMODATION_{XXX}] (
		[REQUEST_NO],
[LINE_NO],
[HOTEL],
[CHECK_IN_DATE],
[CHECK_IN_TIME],
[CHECK_OUT_DATE],
[CHECK_OUT_TIME],
[STAYING_DAYS],
[PRICE],
[TAX]
	) VALUES (
		@REQUEST_NO,
@LINE_NO,
@HOTEL,
@CHECK_IN_DATE,
@CHECK_IN_TIME,
@CHECK_OUT_DATE,
@CHECK_OUT_TIME,
@STAYING_DAYS,
@PRICE,
@TAX
	)
END' 
END