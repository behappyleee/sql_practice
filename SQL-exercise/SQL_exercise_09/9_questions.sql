-- 9.1 give the total number of recordings in this table
SELECT count(*) FROM cran_logs cl;

-- 9.2 the number of packages listed in this table?
SELECT * FROM cran_logs cl;
		SELECT *
	  	  FROM cran_logs cl 
	  GROUP BY cl.package;
	
	SELECT count(*) FROM (SELECT count(*) FROM cran_logs cl GROUP BY cl.package) b;
	
	SELECT count (*)
	   FROM (
	   		SELECT * FROM cran_logs cl GROUP BY cl.package
	   );
	 
	SELECT count(*)
	  FROM (
	  	SELECT *
	  	  FROM cran_logs cl 
	  GROUP BY cl.package	  
	  );
	 
	SELECT *
	  FROM cran_logs cl 
  GROUP BY cl.package; 
 
 	SELECT * FROM cran_logs cl WHERE cl.package = 'Rcpp';
	 
-- 9.3 How many times the package "Rcpp" was downloaded?
				SELECT count(*)
				     , cl.package 
				  FROM cran_logs cl
				 WHERE cl.package = 'Rcpp'; 
				
-- 9.4 How many recordings are from China ("CN")?
SELECT cl.country, count(*) FROM cran_logs cl WHERE cl.country = 'CN';
				
-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT cl.package, count(*) AS 'Download Count' FROM cran_logs cl GROUP BY cl.package ORDER BY count(*) DESC;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
SELECT * FROM cran_logs cl;

			  SELECT cl.package, count(*) 
			    FROM cran_logs cl 
			   WHERE cl.`time` BETWEEN '09:00:00' AND '11:00:00' 
			GROUP BY cl.package 
			ORDER BY count(*) DESC;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
			SELECT count(*) 
			  FROM cran_logs cl 
			 WHERE cl.country IN ('CN', 'JP', 'SG');
		
			SELECT * FROM cran_logs cl;
			
-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
			SELECT cl.country  
			  FROM cran_logs cl  
		  GROUP BY cl.country
			HAVING cl.country IN (
				SELECT count(*)
				    , cl2.country 
				  FROM cran_logs cl2 
			  GROUP BY cl2.country 
			);	
			
		SELECT count(*)
				    , cl2.country 
				  FROM cran_logs cl2 
			  GROUP BY cl2.country;
		
		
		
		
-- 9.9 Print the average length of the package name of all the UNIQUE packages
			 
			 
			 
			 
-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
			 
			 
-- 9.11 Print the name of the package whose download count is bigger than 1000.
			 
			 
-- 9.12 The field "r_os" is the operating system of the users.
-- Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
			 
			 
			 
			 
			 

