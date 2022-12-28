-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces. 
SELECT p.name FROM pieces p;

-- 5.2  Select all the providers' data. 
SELECT code, name FROM providers p;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
		SELECT 
			  p.code
			, AVG(pv.price) AS 'Æò±Õ°¡°Ý'	
		  FROM pieces p 
    INNER JOIN provides pv 
            ON p.code = pv.piece  
	GROUP BY p.code;

-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT * FROM pieces pe INNER JOIN providers p ON pe.code = p.code; 

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT pv.piece FROM provides pv WHERE pv.provider = 'HAL';

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
	   SELECT pv.piece
	   		, p.name
	        , MAX(pv.price)
	        , pr.name
         FROM pieces p 
   INNER JOIN provides pv 
   		   ON p.code = pv.piece
   INNER JOIN providers pr		  
           ON pv.provider = pr.code
     GROUP BY pv.piece;  
    
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides (piece, provider, price) VALUES(1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
UPDATE provides SET price = (price + 1);

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM provides  
     WHERE piece = 4 
       AND provider = "RBT"; 

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE FROM provides WHERE provider = 'RBT';     
      
