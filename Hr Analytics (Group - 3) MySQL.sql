 create database project3;
 use project3;
 -- Count Of Total Employee 
 select distinct(count(EmployeeNumber))
 from hr_1csv;
 
 -- Average Distance 
select round(Avg(DistanceFromHome),2)
from hr_1csv;

 -- KPI
 -- 1. Average Attrition rate for all Departments .
 
SELECT 
    Department,
   CONCAT(ROUND( AVG(`Attrition Rate`),2) *100,"%") AS Average_Attrition_Rate
FROM hr_1csv
GROUP BY Department
ORDER BY Average_Attrition_Rate DESC;

-- 2. Average Hourly rate of Male Research Scientist .

select JobRole ,
      round(avg(HourlyRate),2) as `Avg Hourly Rate `
from hr_1csv
where Gender ='Male'
and JobRole ='Research Scientist';

-- 3. Attrition rate Vs Monthly income stats.

    SELECT 
    h2.`Monthly Income Range`,
   CONCAT(ROUND(AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END),2)* 100,"%")
        AS Avg_Attrition_Rate_Percent,SUM(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END)* 100
        AS Monthly_Attrition_Rate
FROM `hr_1 - copy` h1
JOIN `hr_2 - copy` h2 
    ON h1.`Employee ID` = h2.`Employee ID`
GROUP BY h2.`Monthly Income Range`
ORDER BY h2.`Monthly Income Range`;


-- 4. Average working years for each Department .
 SELECT 
    h1.`Department`,
    ROUND(AVG(h2.`TotalWorkingYears`), 2) AS Avg_Working_Years
FROM 
    hr_1csv h1
JOIN 
    hr_2csv h2
ON 
    h1.`EmployeeNumber` = h2.`Employee ID`
GROUP BY 
    h1.`Department`
ORDER BY 
    Avg_Working_Years DESC;
    
-- 5. Job Role Vs Average Work life balance

SELECT
    h1.JobRole,

      SUM(CASE WHEN WorkLifeBalance = 3 THEN 1 ELSE 0 END) AS Average,
    SUM(CASE WHEN WorkLifeBalance = 4 THEN 1 ELSE 0 END) AS Excellent,
    SUM(CASE WHEN WorkLifeBalance = 2 THEN 1 ELSE 0 END) AS Good,
    SUM(CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) AS Poor

FROM `hr_1 - copy` h1
JOIN `hr_2 - copy` h2 
    ON h1.`Employee ID` = h2.`Employee ID`
GROUP BY h1.JobRole
ORDER BY h1.JobRole;
    
    
-- 6. Attrition rate Vs Year since last promotion relation
SELECT 
    `Yearly Since Lst Promotion`,
    sum(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 
        AS AttritionRate,CONCAT(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100,"%")
        AS `Avgerage Attrition Rate`
FROM `hr_1 - copy` h1
JOIN `hr_2 - copy` h2 
    ON h1.`Employee ID` = h2.`Employee ID`
GROUP BY `Yearly Since Lst Promotion`
ORDER BY `Yearly Since Lst Promotion`;


select *from `hr_1 - copy`;