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
