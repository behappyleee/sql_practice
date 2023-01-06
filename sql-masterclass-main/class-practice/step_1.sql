SELECT * FROM trading.members m;
SELECT * FROM trading.transactions t;
SELECT * FROM trading.prices p;

SELECT * FROM trading.prices p LIMIT 5;
SELECT * FROM trading.transactions t LIMIT 5;
SELECT * FROM trading.members m;

-- Question 1
-- Show only the top 5 rows from the trading.members table
SELECT * FROM trading.members m LIMIT 5;

--  Question 2
-- Sort all the rows in the table by first_name in alphabetical order and show the top 3 rows
SELECT m.first_name FROM trading.members m ORDER BY m.first_name LIMIT 3;

-- Question 3
-- Which records from trading.members are from the United States region?
SELECT * FROM trading.members m  WHERE m.region = 'United States';

-- Question 4
-- Select only the member_id and first_name columns for members who are not from Australia
SELECT m.member_id, m.first_name FROM trading.members m WHERE m.region != 'Australia';

-- Question 5
-- Return the unique region values from the trading.members table and sort the output by reverse alphabetical order
SELECT DISTINCT m.region  FROM trading.members m ORDER BY m.region DESC;

-- Question 6
-- How many mentors are there from Australia or the United States?
SELECT count(*) FROM trading.members m WHERE m.region = 'United States' OR m.region = 'Australia';
-- Answer
SELECT COUNT(*) AS mentor_count FROM trading.members WHERE region IN ('Australia', 'United States');

-- Question 7
-- How many mentors are not from Australia or the United States?
SELECT count(*) FROM members m WHERE m.region NOT IN ('Australia', 'United States');

-- Question 8
-- How many mentors are there per region? Sort the output by regions with the most mentors to the least
SELECT m.region, count(*) AS 'mentorCount' FROM members m GROUP BY m.region ORDER BY mentorCount DESC;

-- Question 9
-- How many US mentors and non US mentors are there?
SELECT count(*) AS 'US Count' 
    , (
    	SELECT count(*) FROM members m2 WHERE m2.region != 'United States'
      ) AS 'Non US Count'
FROM members m WHERE m.region = 'United States';

-- ANSWER
SELECT
  CASE
    WHEN region != 'United States' THEN 'Non US'
    ELSE region
  END AS mentor_region,
  COUNT(*) AS mentor_count
FROM trading.members
GROUP BY mentor_region
ORDER BY mentor_count DESC;

-- Question 10
-- How many mentors have a first name starting with a letter before 'E'?
SELECT * FROM members m WHERE m.first_name LIKE 'E%';
-- ANSWER  Alphabet E 보다 먼저 시작하는 멤버 수
SELECT COUNT(*) AS mentor_count FROM trading.members WHERE LEFT(first_name, 1) < 'E';















