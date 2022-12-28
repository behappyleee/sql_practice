-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.

SELECT s.name    AS '과학자 이름'
     , p.name    AS '프로젝트 이름'
     , p.hours	
	  FROM scientists s
INNER JOIN assignedTo a
        ON s.ssn = a.scientist
INNER JOIN projects p     
		ON p.code = a.project
  ORDER BY p.name, s.name;

-- 6.2 Select the project names which are not assigned yet
	SELECT p.name
	     , a.project
	  FROM projects p 
 LEFT JOIN assignedto a 
        ON p.code = a.project
     WHERE a.project IS NULL;