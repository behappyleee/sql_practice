-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
-- 1.1 Select the names of all the products in the store.
SELECT name FROM products p;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, price  FROM products p;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name FROM products p WHERE p.price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
SELECT name FROM products p WHERE p.price BETWEEN 60 AND 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, (price * 100)AS cents FROM products;

-- 1.6 Compute the average price of all the products.
SELECT avg(price) FROM products p;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT avg(price) FROM products p INNER JOIN manufacturers m  ON p.Code = m.Code  WHERE p.Code = 2; 

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(name) FROM products p WHERE p.price <= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name, price FROM products p WHERE p.price >= 180 ORDER BY p.price, DESC p.name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT p.code, p.name, p.price, p.manufacturer, m.name FROM products p INNER JOIN manufacturers m ON p.manufacturer = m.code; 

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT p.name, p.price FROM products p INNER JOIN manufacturers m ON p.manufacturer = m.code; 

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT p.code, avg(p.price) FROM products p GROUP BY p.manufacturer ; 

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT m.Name, avg(p.Price) FROM products p INNER JOIN manufacturers m ON p.Manufacturer = m.Code GROUP BY p.manufacturer; 

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT p.name FROM products p INNER JOIN manufacturers m ON p.Manufacturer = m.Code GROUP BY p.Manufacturer HAVING avg(p.price) >= 150;  

-- 1.15 Select the name and price of the cheapest product.
SELECT name, MIN(p.price) FROM products p;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT name, max(p.Price) AS '최대가격', p.Manufacturer FROM products p GROUP BY p.Manufacturer;

SELECT * FROM products p;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products (code, name, Price, Manufacturer) VALUES(11, 'Loudspeakers', 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products SET name = 'Laser Printer' WHERE code = 8;

-- 1.19 Apply a 10% discount to all products.
UPDATE products SET price = (price * 0.9);

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products SET price = (price * 0.9) WHERE price >= 120;


