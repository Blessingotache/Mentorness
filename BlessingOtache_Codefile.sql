SELECT*FROM dbo.['Corona Virus Dataset$']

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values

SELECT Province, Country_Region, Latitude, Longitude, Date,
Confirmed, Deaths, Recovered FROM dbo.['Corona Virus Dataset$']
WHERE Province is NULL;








-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values

SELECT*FROM dbo.['Corona Virus Dataset$'] WHERE Province is null
or Country_Region is null or Latitude is null or
Longitude is null or Date is null or Confirmed is null or
Deaths is null or Recovered is null;



--Q2. If NULL values are present, update them with zeros for all columns. 
UPDATE dbo.['Corona Virus Dataset$']
SET Province = 0, Country_Region = 0,  Latitude = 0, Longitude = 0, Date = 0,
Confirmed = 0, Deaths = 0, Recovered = 0 WHERE Province is null;


-- Q3. check total number of rows
SELECT COUNT(*) AS Total_Rows FROM dbo.['Corona Virus Dataset$'];






-- Q4. Check what is start_date and end_date
SELECT 
MIN(TRY_CONVERT(date, Date, 103)) AS Start_Date,
MAX(TRY_CONVERT(date, Date, 103)) AS End_Date
FROM dbo.['Corona Virus Dataset$'];


-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT CONCAT(YEAR(TRY_CONVERT(date,Date,105)),'-',
MONTH(TRY_CONVERT(date,Date,105)))) AS Number_of_Months
FROM dbo.['Corona Virus Dataset$'];




-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
	DATEPART(YEAR, TRY_CONVERT(date, Date, 105)) AS Year,
	DATEPART(MONTH, TRY_CONVERT(date, Date, 105)) AS Month,
	AVG(CONVERT(float, TRY_CONVERT(int, Confirmed))) AS Average_Confirmed,
	AVG(CONVERT(float, TRY_CONVERT(int, Deaths))) AS Average_Deaths,
	AVG(CONVERT(float, TRY_CONVERT(int, Recovered))) AS Recovered
FROM dbo.['Corona Virus Dataset$']
WHERE
	DATEPART(YEAR, TRY_CONVERT(date, Date, 105)) IN (2020, 2021)
GROUP BY
	DATEPART(YEAR, TRY_CONVERT(date, Date, 105)),
	DATEPART(MONTH, TRY_CONVERT(date, Date, 105))
ORDER BY
	YEAR, MONTH;


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 



-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
	YEAR(TRY_CONVERT(date, Date, 105)) AS Year,
	MIN(TRY_CONVERT(int, Confirmed)) AS Minimum_Confirmed,
	MIN(TRY_CONVERT(int, Deaths)) AS Minimum_Deaths,
	MIN(Recovered) AS Minimum_Recovered
FROM dbo.['Corona Virus Dataset$']
GROUP BY 
	YEAR(TRY_CONVERT(date, Date, 105));





-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT
	YEAR(TRY_CONVERT(date, Date, 105)) AS Year,
	MAX(TRY_CONVERT(int, Confirmed)) AS Maximum_Confirmed,
	MAX(TRY_CONVERT(int, Deaths)) AS Maximum,
	MAX(Recovered) AS Maximum_Recovered
FROM dbo.['Corona Virus Dataset$']
GROUP BY 
	YEAR(TRY_CONVERT(date, Date, 105));



-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
	MONTH(TRY_CONVERT(date, Date, 105)) AS Month,
	SUM(TRY_CONVERT(int, Confirmed)) AS Total_Confirmed,
	SUM(TRY_CONVERT(int, Deaths)) AS Total_Deaths,
	SUM(TRY_CONVERT(int, Recovered)) AS Total_Recovered
FROM dbo.['Corona Virus Dataset$']
GROUP BY 
	MONTH(TRY_CONVERT(date, Date, 105))
ORDER BY 
	Month;


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
	COUNT(Confirmed) AS TotalConfirmedCases,
	AVG(Confirmed) AS AvgConfirmedCases,
	(STDEV(Confirmed)*(STDEV(Confirmed))) AS VarConfirmedCases,
	STDEV(Confirmed) AS StdevConfirmedCases
FROM dbo.['Corona Virus Dataset$'];


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
	MONTH(TRY_CONVERT(date, Date, 105)) AS Month,
	COUNT(Deaths) AS TotalDeathsCases,
	AVG(Deaths) AS AvgDeathsCases,
	(STDEV(Deaths)*(STDEV(Deaths))) AS VarDeathsCases,
	STDEV(Deaths) AS StdevDeathsCases
FROM dbo.['Corona Virus Dataset$']
GROUP BY 
	MONTH(TRY_CONVERT(date, Date, 105))
ORDER BY 
	Month;





-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
	COUNT(Recovered) AS TotalRecoveredCases,
	AVG(Recovered) AS AvgRecoveredCases,
	(STDEV(Recovered)*(STDEV(Recovered))) AS VarRecoveredCases,
	STDEV(Recovered) AS StdevRecoveredCases
FROM dbo.['Corona Virus Dataset$'];






-- Q14. Find Country having highest number of the Confirmed case

SELECT TOP 1
	Country_Region AS Country,
	SUM(CAST(Confirmed AS INT)) AS Total_Confirmed_Cases
FROM
	dbo.['Corona Virus Dataset$']
WHERE
	ISNUMERIC(Confirmed)=1
GROUP BY 
	Country_Region
ORDER BY
	SUM(CAST(Confirmed AS INT)) DESC;


-- Q15. Find Country having lowest number of the death case
SELECT TOP 1
	Country_Region AS Country,
	SUM(CAST(Deaths AS INT)) AS Total_Deaths_Cases

FROM
	dbo.['Corona Virus Dataset$']
WHERE
	ISNUMERIC(Deaths)=1
GROUP BY 
	Country_Region
HAVING
	SUM(CAST(Deaths AS INT)) = 0
ORDER BY
	Total_Deaths_Cases ASC;


-- Q16. Find top 5 countries having highest recovered case
SELECT TOP 5
Country_Region AS Country,
SUM(CAST(Recovered AS INT)) AS Total_Recovered_Cases
FROM dbo.['Corona Virus Dataset$']
WHERE ISNUMERIC(Recovered) = 1
GROUP BY Country_Region
ORDER BY Total_Recovered_Cases DESC;