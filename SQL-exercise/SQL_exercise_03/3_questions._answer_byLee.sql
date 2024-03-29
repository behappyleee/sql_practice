-- The Warehouse
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse

-- 3.1 Select all warehouses.
SELECT * FROM warehouses w; 

-- 3.2 Select all boxes with a value larger than $150.
SELECT * FROM boxes b WHERE b.value > 150;

-- 3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT(b.contents) FROM boxes b;

-- 3.4 Select the average value of all the boxes.
SELECT AVG(b.value) FROM boxes b;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
SELECT b.warehouse, AVG(b.value) FROM boxes b GROUP BY b.warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT b.warehouse, AVG(b.value) FROM boxes b GROUP BY b.warehouse HAVING AVG(b.Value)>150; 

-- TODO 내용 이해를 못함 확인하여 보기 !!!!!!!!!!!!!
-- 3.7 Select the code of each box, along with the name of the city the box is located in.
      SELECT * 
        FROM boxes b 
  INNER JOIN warehouses w 
          ON b.warehouse = w.code
    GROUP BY b.Code, w.Location ;

-- TODO 내용 이해를 못함 확인하여 보기 !!!!!!!!!!!!!
-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
SELECT w.code FROM warehouses w;
   

-- TODO 여기서 부터 진행하기 !!!!!!!!!!!!!
-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
SELECT * FROM warehouses w;
SELECT * FROM boxes b;
SELECT count(*), b.Warehouse FROM boxes b GROUP BY b.Warehouse;

SELECT * FROM boxes b INNER JOIN warehouses w ON b.warehouse = w.code; 

SELECT count(*), b.Warehouse FROM boxes b GROUP BY b.Warehouse;
SELECT * FROM warehouses w;

SELECT b.code, count(b.warehouse) AS capaBox 
  FROM boxes b 
INNER JOIN warehouses w 
        ON b.warehouse = w.Code  
GROUP BY b.warehouse HAVING count(b.warehouse) > w.capacity; 

SELECT b.code, count(b.warehouse)  
  FROM boxes b 
INNER JOIN warehouses w 
        ON b.warehouse = w.Code  
GROUP BY b.warehouse;

WHERE count(b.warehouse) > w.capacity; 



SELECT code FROM boxes b WHERE b.Code IN (
	SELECT code 
	  FROM boxes b2 
INNER JOIN warehouses w 
		ON b2.warehouse = w.code
  GROUP BY b2.warehouse
	 WHERE w.capacity 		
);

-- 3.10 Select the codes of all the boxes located in Chicago.
SELECT b.code, w.location FROM boxes b INNER JOIN warehouses w ON b.warehouse = w.code WHERE w.location = 'Chicago';

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouses(code, location, capacity) VALUES(6,'New York', 3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO boxes (code, contents, value, warehouse) VALUES ('H5RT', 'Papers', 200, 2);

-- 3.13 Reduce the value of all boxes by 15%.
UPDATE boxes SET value = (value*0.85);

-- 3.14 Remove all boxes with a value lower than $100.
DELETE FROM boxes WHERE value < 100;

SELECT * FROM warehouses w;
SELECT * FROM boxes b;

SELECT warehouse, count(*) FROM boxes b GROUP BY Warehouse;

-- 3.15 Remove all boxes from saturated warehouses.

-- 되지 않음 확인 하여보기 !!!!
DELETE FROM boxes b WHERE b.warehouse IN (
	SELECT	b2.warehouse
	  FROM  boxes b2
  GROUP BY b2.warehouse 				
  HAVING count(b2.warehouse) > (
  	SELECT w.capacity  
  	  FROM warehouses w
  	WHERE w.code = b2.warehouse 
  )
);

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SHOW INDEX FROM boxes; 	
CREATE INDEX box_warehouse ON boxes (warehouse);

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SHOW INDEX FROM boxes;

-- TODO INDEX 삭제 하기 Foreign Key 걸려 있음 !!!!!!!!!!!!!!!!!
-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice



