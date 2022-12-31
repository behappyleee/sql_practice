-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
		SELECT * FROM people;
		SELECT * FROM address a;
	
	    SELECT *
		  FROM people p 
    INNER JOIN address a 
            ON p.id = a.id
      GROUP BY p.id; 

-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
		     SELECT p.id AS 'PERSON ID'
		         ,  a.address AS 'ADDR'
		      FROM people p 
		INNER JOIN address a 
		        ON p.id = a.id
   		     WHERE a.updatedate IN (
   		     		SELECT max(a2.updatedate)
   		     		  FROM address a2 
   		     	  GROUP BY a2.id 
   		     )
   		GROUP BY a.id;
             		     
   SELECT * FROM people p;
   SELECT * FROM address a;
   


