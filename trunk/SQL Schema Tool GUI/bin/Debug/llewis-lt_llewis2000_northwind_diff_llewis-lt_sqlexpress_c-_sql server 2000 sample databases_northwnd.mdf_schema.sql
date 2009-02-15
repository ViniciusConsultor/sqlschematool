
-- DB Name: C:\Documents and Settings\llewis.VPI\My Documents\My Projects\SQL Schema Tool\SQL Schema Tool GUI\bin\Debug\llewis-lt_llewis2000_northwind_diff_llewis-lt_sqlexpress_c-_sql server 2000 sample databases_northwnd.mdf_schema.sql
-- Output Date: 7/29/2007
-- Output Time: 7:44 PM
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
BEGIN TRANSACTION T1 WITH MARK 'Apply Diffgram SQL'
	
	    
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
	