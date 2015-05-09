

use ReportServer;
go


		SELECT 
				re.Name
				,count (re.Name) as ExecutionCount
				,sum ( case when re.Status= 'rsSuccess' then 1 else 0 end ) as Success
				,( count (re.Name) - sum ( case when re.Status= 'rsSuccess' then 1 else 0 end )) as Failure
				--sum(case when final_event_type in(4,6,8,9) then 1 else 0 end) as failures,
		FROM
		(
		SELECT	c.Name
				,e.Status
				
		FROM dbo.Catalog AS c
		INNER JOIN dbo.ExecutionLog AS e ON c.ItemID = e.ReportID
		) AS re

		GROUP BY re.Name
		;


