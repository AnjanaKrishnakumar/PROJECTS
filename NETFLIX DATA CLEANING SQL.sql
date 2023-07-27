SELECT * FROM project_2.`netflix cleaning` order by title;

-- finding  duplicates USING cte
 with cte  AS (
SELECT*, 
ROW_NUMBER  ()
 OVER( PARTITION BY 
Title  ORDER BY Title ) row_num FROM project_2.`netflix cleaning` )
select * FROM CTE WHERE row_num>1;



-- delete duplicates using groupby 


SELECT title,genre ,COUNT(*) FROM project_2.`netflix cleaning`
 GROUP BY title,genre 
 HAVING Count(*)>1;
 -- ALL DUPLICATES ARE IN THE TABLE WITH TITLE AWAITING RELAESE SO WE GONNA DELETE IT 
 
 DELETE FROM project_2.`netflix cleaning` WHERE title = "Awaiting Release";
 
 
 
 
 -- removing  rows with no data in any column 
 DELETE FROM project_2.`netflix cleaning` WHERE genre = ""; 
 
 -- removing unwanted characters 
 SELECT Premiere FROM project_2.`netflix cleaning`;
 
 
SELECT*, SUBSTRING_INDEX(Premiere,'[',1) as CleanPremiere FROM project_2.`netflix cleaning`;
  ALTER TABLE  project_2.`netflix cleaning`
 ADD (CleanPremiere varchar(40));
 UPDATE project_2.`netflix cleaning`
 SET CleanPremiere = SUBSTRING_INDEX(Premiere,'[',1) ;
 
 
 -- converting Cleanpremiere column  into date format
 
 SELECT*, STR_TO_DATE(CleanPremiere ,"%M %d,%Y")   FROM project_2.`netflix cleaning`;
 
 -- adding converted date into the table 
 
 ALTER TABLE  project_2.`netflix cleaning`
 ADD (Converted_date Date);
 UPDATE project_2.`netflix cleaning`
 SET Converted_date = STR_TO_DATE(CleanPremiere ,"%M %d,%Y") ;
 