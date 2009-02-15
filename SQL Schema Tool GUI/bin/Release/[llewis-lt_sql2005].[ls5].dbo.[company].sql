
-- DB Name: LS5
-- Output Date: 10/14/2008
-- Output Time: 5:19 PM
-- AutoGenerated SQL: using the SQL Schema Tool.

/*
When SET XACT_ABORT is ON, if a Transact-SQL statement raises a run-time 
error, the entire transaction is terminated and rolled back. When OFF, only the 
Transact-SQL statement that raised the error is rolled back and the transaction 
continues processing. Compile errors, such as syntax errors, are not affected by 
SET XACT_ABORT.
*/

SET QUOTED_IDENTIFIER ON
SET XACT_ABORT ON
BEGIN TRANSACTION T1 WITH MARK 'Apply Create SQL'
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	DROP TABLE [dbo].[company]
END	
GO

IF (SELECT FILEGROUP_ID('PRIMARY')) IS NOT NULL
	CREATE TABLE [dbo].[company]
	( 	
		[company_code] [char] (10)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[person_id] [int]  NOT NULL,
		[allow_aus_approval_flag] [int]  NULL,
		[correspondence_directory] [varchar] (255)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[full_time_employee_count] [int]  NULL,
		[percent_eligible_employees] [numeric]  NULL,
		[percent_eligible_dependants] [numeric]  NULL,
		[current_cobra_indicator] [int]  NULL,
		[expiration_date] [datetime]  NULL
	)   ON [PRIMARY] 
ELSE
	RAISERROR ('You will have to manually add the filegroup PRIMARY to the SQL DB or edit this SQL script to set the FileGroups to PRIMARY', 16, 1)
RETURN
GO

		--2nd pass thru after add/alter table columns to handle those columns having UDDTs 
	ALTER TABLE [dbo].[company]
	ALTER COLUMN [company_code] [char]  (10)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
	ALTER TABLE [dbo].[company]
	ALTER COLUMN [person_id] [int]  NOT NULL
GO


IF (  (SELECT COLUMNPROPERTY( OBJECT_ID(N'company'), N'person_id', 'AllowsNull')) IS NOT NULL   ) and EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) AND (SELECT FILEGROUP_ID('PRIMARY')) IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[company] ADD 
	CONSTRAINT [PK_COMPANY] PRIMARY KEY CLUSTERED 
	(
		[person_id]
	)  ON [PRIMARY] 
END
ELSE
	RAISERROR ('Constraint column(s): person_id do(es) not exist, or Table or File Group does not exist.  Check for other errors.', 16, 1)
GO
		
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) AND (SELECT FILEGROUP_ID('PRIMARY')) IS NOT NULL
BEGIN
	CREATE  INDEX [ix_company_code] ON [dbo].[company]([company_code]) ON [PRIMARY]
END
ELSE
	RAISERROR ('Table or File Group does not exist.  Check for other errors that caused the table to not be created.', 16, 1)
	
GO
		

DECLARE @ERR int

SET @ERR = @@ERROR
IF @@TRANCOUNT > 0
BEGIN
	IF @ERR > 0
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION T1
END
SET XACT_ABORT OFF
	