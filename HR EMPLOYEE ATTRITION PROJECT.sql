/*
HR ANALYSIS DATA EXPLORATION 
*/
SELECT * FROM project_1.`hr-employee-attrition`;


-- FINDING TOTAL NUMBER OF EMPLOYEES 

SELECT COUNT(EmployeeCount) FROM project_1.`hr-employee-attrition`;


-- finding attrition count

SELECT Attrition , COUNT(Attrition) as Attritioncount FROM project_1.`hr-employee-attrition`
WHERE Attrition = "Yes";


-- finding attrition rate
SELECT (237 /1470 ) * 100  AS AttritionRate;


-- jobrole vs attrition

SELECT JobRole, COUNT(Attrition) FROM project_1.`hr-employee-attrition`
 WHERE Attrition = "Yes"
 GROUP BY JobRole 
 Order by COUNT(Attrition) desc;
 
 
 -- income vs attrition 
 
 SELECT MonthlyIncome , count(Attrition)  FROM project_1.`hr-employee-attrition` 
 group by  MonthlyIncome
 order by COUNT(Attrition)  desc;
 
 -- education vs attrition
 
SELECT EducationField , Count(Attrition ) FROM project_1.`hr-employee-attrition` 
WHERE Attrition = "Yes"
GROUP BY EducationField
order by COUNT(Attrition)  desc; ;


-- MARITAL STATUS VS ATTRITION 

SELECT MaritalStatus , Count(Attrition ) FROM project_1.`hr-employee-attrition` 
where Attrition = "yes"
GROUP BY MaritalStatus
order by COUNT(Attrition)  desc; 


-- Total years at company vs attrition by creating view

 DROP TABLE IF EXISTS Yw;
 CREATE VIEW Yw AS 
 SELECT YearsAtCompany, COUNT(Attrition) 
FROM project_1.`hr-employee-attrition`
Where Attrition = "Yes"
GROUP BY YearsAtCompany
order by YearsAtCompany  desc; 
SELECT * FROM YEARSVSATTRI ;


-- department vs attrition using cte

  with dep_1 as
  (
  SELECT Department , COUNT(Attrition) 
FROM project_1.`hr-employee-attrition`
WHERE Attrition = "Yes"
GROUP BY Department
order by COUNT(Attrition)   desc
)
select * from dep_1 ;

  -- performnance rating
select PerformanceRating, COUNT(PerformanceRating) from project_1.`hr-employee-attrition` group by PerformanceRating ;

 -- job satisfaction 

select JobSatisfaction , count(JobSatisfaction) from project_1.`hr-employee-attrition` group by JobSatisfaction;

-- attrition by different gender within an age group 18 and 35

SELECT gender,COUNT( Attrition) FROM project_1.`hr-employee-attrition`
 WHERE (ï»¿Age >= 18 and ï»¿Age<35) AND (Attrition="Yes")
 group by gender;
 
 -- attrition by different gender within an age group 35 and 50
 
 SELECT gender,COUNT(Attrition) FROM project_1.`hr-employee-attrition`
 WHERE (ï»¿Age >= 35 and ï»¿Age <50 ) and (Attrition="Yes")
 group by gender ;

-- attrition by different gender within an age group 50 and 60

 SELECT gender,COUNT(Attrition) FROM project_1.`hr-employee-attrition`
 WHERE (ï»¿Age >= 50 and ï»¿Age <=60) and (Attrition="Yes")
 group by gender;
 
  -- percentage attrition of male and female
  
  select Gender, count(Attrition) FROM project_1.`hr-employee-attrition` 
  where Attrition ="Yes"
  group by Gender;
  
  -- count attrition of female is 87 and that of male is 150
  
 select Gender, count(Gender) FROM project_1.`hr-employee-attrition` where gender="Male" UNION
 select Gender, count(Gender) FROM project_1.`hr-employee-attrition` where gender="Female";
 
  ---- total  number of male employees is 882 and that of female employees is 588
 
 SELECT (87/588)*100;
    --- percentage attrition of female employees is 14.79%
    
    SELECT (150/882)*100;
    --- percentage attrition of male employees is 17.006%







