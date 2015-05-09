USE ReportServer;
GO
	
SELECT 
		RE.UserName
		--,RE.Status
		,(case when RE.Status= 'rsSuccess' then 'Success' else 'Failure' end ) AS Status
		,RE.TimeRendering AS 'Rendering Time'
		,RE.TimeDataRetrieval AS 'Time for query to execute'
		,RE.TimeProcessing AS 'Processing Time'
		,RE.Parameters

		--,RE.TimeStart as 'Execution date Time'
		--or
		--,CONVERT(varchar(11), RE.TimeStart,110) AS 'Execution Date'
		--,CONVERT(VARCHAR(5),RE.TimeStart, 108) AS 'Execution time'

		,CONVERT(varchar(11), RE.TimeStart,110) + '  '+
		CONVERT(VARCHAR(5),RE.TimeStart, 108) AS 'Execution Date-time'

FROM
	(
		SELECT TimeStart
			, c.Type
			, c.Name
			, e.UserName
			, e.Status
			, TimeDataRetrieval
			, TimeProcessing
			, TimeRendering
			,e.Parameters
			
		FROM dbo.Catalog AS c INNER JOIN ExecutionLogStorage AS e ON c.ItemID = e.ReportID
     )
	 AS RE
where RE.Name = 'Report2'
;

/*		SELECT 
				re.Name
				,count (re.Name) as ExecutionCount
				,sum ( case when re.Status= 'rsSuccess' then 1 else 0 end ) as Success
				,( count (re.Name) - sum ( case when re.Status= 'rsSuccess' then 1 else 0 end )) as Failure
				
		FROM
		(
		SELECT	c.Name
				,e.Status
				
		FROM dbo.Catalog AS c
		INNER JOIN dbo.ExecutionLog AS e ON c.ItemID = e.ReportID
		) AS re

		GROUP BY re.Name
		;
*/
/* 
-- http://blogs.wrox.com/article/creating-a-report-server-usage-report-with-sql-server-reporting-services/

--Top 5 Most Frequent:
	SELECT TOP 5  
	      COUNT(Name) AS ExecutionCount
				 , Name
    , SUM(TimeDataRetrieval) AS TimeDataRetrievalSum
    , SUM(TimeProcessing) AS TimeProcessingSum
    , SUM(TimeRendering) AS TimeRenderingSum
    , SUM(ByteCount) AS ByteCountSum
    , SUM([RowCount]) AS RowCountSum
FROM
(
    SELECT TimeStart, Catalog.Type, Catalog.Name,
      TimeDataRetrieval, TimeProcessing, TimeRendering, ByteCount, [RowCount]
    FROM
    Catalog INNER JOIN ExecutionLog ON Catalog.ItemID = ExecutionLog.ReportID
     WHERE ExecutionLog.TimeStart BETWEEN @DateFrom AND @DateTo AND Type = 2
) AS RE
GROUP BY
        Name
ORDER BY
        COUNT(Name) DESC
      , Name
*/