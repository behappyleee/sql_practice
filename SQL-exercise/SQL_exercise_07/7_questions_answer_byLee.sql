-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".

SELECT * FROM Employee;
SELECT * FROM client;
SELECT * FROM Planet;
SELECT * FROM Shipment;
SELECT * FROM Has_Clearance;
SELECT * FROM Package;

		SELECT c.name
		  FROM client c
	INNER JOIN package p 
		    ON c.accountnumber = p.recipient
	WHERE p.weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?
	  SELECT c.name
	       , SUM(p.weight)	AS '¹«°Ô ÃÑ ÇÕ'
		FROM client c
  INNER JOIN package p		
		  ON c.accountNumber = p.recipient
	   WHERE p.sender = 2
    GROUP BY p.recipient;		 
       -- HAVING c.name = "Al Gore's Head";
	
   SELECT SUM(p.weight) 
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.Name = "Al Gore's Head";

SELECT SUM(p.weight), COUNT(1)
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.AccountNumber = (
  SELECT Client.AccountNumber
  FROM Client JOIN Package 
    ON Client.AccountNumber = Package.Recipient 
  WHERE Package.weight = 1.5
);


	
	
	