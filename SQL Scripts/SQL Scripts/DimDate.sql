USE AWN_DW


-- Create DimDate dimension table
CREATE TABLE [dbo].[DimDate] (
    [DateKey]              [int] NOT NULL,
    [FullDateAlternateKey] [date] NULL,
    [DayNumberOfWeek]      [tinyint] NULL,
    [DayNumberOfMonth]     [tinyint] NULL,
    [DayNumberOfYear]      [smallint] NULL,
    [WeekNumberOfYear]     [tinyint] NULL,
    [MonthNumberOfYear]    [tinyint] NULL,
    [CalendarQuarter]      [tinyint] NULL,
    [CalendarYear]         [smallint] NULL,
    [CalendarSemester]     [tinyint] NULL,
    [FiscalQuarter]        [tinyint] NULL,
    [FiscalYear]           [smallint] NULL,
    [FiscalSemester]       [tinyint] NULL,
    CONSTRAINT [PK_DimDate_DateKey] PRIMARY KEY CLUSTERED (
        [DateKey] ASC
    ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY];
GO




CREATE PROCEDURE [dbo].[Refresh_DimDate]
AS
BEGIN
    DECLARE @startdate date = '2001-01-01', @enddate date = '2014-12-31';

    IF @startdate IS NULL
    BEGIN
        SELECT TOP 1 @startdate = FullDateAlternateKey
        FROM DimDate
        ORDER BY DateKey ASC;
    END

    DECLARE @datelist TABLE (FullDate date);

    -- Loop through date range
    WHILE @startdate <= @enddate
    BEGIN
        INSERT INTO @datelist (FullDate)
        SELECT @startdate;

        SET @startdate = DATEADD(dd, 1, @startdate);
    END

    -- Insert new records into DimDate
    INSERT INTO dbo.DimDate (
        DateKey,
        FullDateAlternateKey,
        DayNumberOfWeek,
        DayNumberOfMonth,
        DayNumberOfYear,
        WeekNumberOfYear,
        MonthNumberOfYear,
        CalendarQuarter,
        CalendarYear,
        CalendarSemester,
        FiscalQuarter,
        FiscalYear,
        FiscalSemester
    )
    SELECT 
        CONVERT(int, CONVERT(varchar, dl.FullDate, 112)) AS DateKey,
        dl.FullDate,
        DATEPART(dw, dl.FullDate) AS DayNumberOfWeek,
        DATEPART(d, dl.FullDate) AS DayNumberOfMonth,
        DATEPART(dy, dl.FullDate) AS DayNumberOfYear,
        DATEPART(wk, dl.FullDate) AS WeekNumberOfYear,
        MONTH(dl.FullDate) AS MonthNumberOfYear,
        DATEPART(qq, dl.FullDate) AS CalendarQuarter,
        YEAR(dl.FullDate) AS CalendarYear,
        CASE DATEPART(qq, dl.FullDate)
            WHEN 1 THEN 1
            WHEN 2 THEN 1
            WHEN 3 THEN 2
            WHEN 4 THEN 2
        END AS CalendarSemester,
        CASE DATEPART(qq, dl.FullDate)
            WHEN 1 THEN 3
            WHEN 2 THEN 4
            WHEN 3 THEN 1
            WHEN 4 THEN 2
        END AS FiscalQuarter,
        CASE DATEPART(qq, dl.FullDate)
            WHEN 1 THEN YEAR(dl.FullDate)
            WHEN 2 THEN YEAR(dl.FullDate)
            WHEN 3 THEN YEAR(dl.FullDate) + 1
            WHEN 4 THEN YEAR(dl.FullDate) + 1
        END AS FiscalYear,
        CASE DATEPART(qq, dl.FullDate)
            WHEN 1 THEN 2
            WHEN 2 THEN 2
            WHEN 3 THEN 1
            WHEN 4 THEN 1
        END AS FiscalSemester
    FROM @datelist dl
    LEFT JOIN DimDate dd ON dl.FullDate = dd.FullDateAlternateKey
    WHERE dd.FullDateAlternateKey IS NULL;
END;
GO
