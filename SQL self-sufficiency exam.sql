-- 1
SELECT 	column_name, data_type
FROM 	information_schema.columns
WHERE	table_name = 'naep';
	
-- 2
SELECT	*
FROM	naep
LIMIT 	50;

-- 3
SELECT
	state,
	COUNT(avg_math_4_score) AS year_count, 
	AVG(avg_math_4_score) AS m4_all_years_avg, 
	MIN(avg_math_4_score) AS m4_all_years_min, 
	MAX(avg_math_4_score) AS m4_all_years_max
FROM		naep
GROUP BY	state
ORDER BY	state;

-- 4
SELECT
	state,
	COUNT(avg_math_4_score) AS year_count, 
	AVG(avg_math_4_score) AS m4_all_years_avg, 
	MIN(avg_math_4_score) AS m4_all_years_min, 
	MAX(avg_math_4_score) AS m4_all_years_max
FROM		naep
GROUP BY	state
HAVING		MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY	state;

-- 5
SELECT		state AS bottom_10_states
FROM		naep
WHERE		year = 2000
ORDER BY	avg_math_4_score ASC
LIMIT 10;

-- 6
SELECT
	ROUND(AVG(avg_math_4_score), 2) AS national_m4_avg_y2000
FROM		naep
WHERE		year = 2000;

-- 7
SELECT		state AS below_average_states_y2000
FROM		naep
WHERE		year = 2000 
  AND 		avg_math_4_score <
	(SELECT AVG(avg_math_4_score)
	 FROM	naep
	 WHERE	year = 2000)
ORDER BY	avg_math_4_score;

-- 8
SELECT	state AS scores_missing_y2000
FROM	naep
WHERE	avg_math_4_score IS NULL
AND		year = 2000;

SELECT *
FROM finance;

-- 9
SELECT
	np.state,
	ROUND(np.avg_math_4_score, 2) as avg_math_4_score,
	f.total_expenditure
FROM
	naep np
LEFT OUTER JOIN
	finance f 
ON f.id = np.id
WHERE np.avg_math_4_score IS NOT NULL
AND f.total_expenditure IS NOT NULL
ORDER BY total_expenditure DESC;
