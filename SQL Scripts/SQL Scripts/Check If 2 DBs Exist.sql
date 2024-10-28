IF EXISTS (SELECT * FROM sys.databases WHERE name = 'AdventureWorks')
    AND EXISTS (SELECT * FROM sys.databases WHERE name = 'STAGING')

  BEGIN
    SELECT 1 AS Status; -- Indicates both databases exist
	PRINT 'Both databases exist. Continuing with the process.';
  END

ELSE

  BEGIN
    SELECT 0 AS Status; -- Indicates one or both databases do not exist
	PRINT 'one or both databases do not exist. Wrute into the logging file.';
  END