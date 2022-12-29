SELECT * FROM Physician;
SELECT * FROM Department;
SELECT * FROM Affiliated_With;
SELECT * FROM Proceduress;
SELECT * FROM Trained_In;
SELECT * FROM Patient;
SELECT * FROM Nurse;
SELECT * FROM Appointment;
SELECT * FROM Medication;
SELECT * FROM Prescribes;
SELECT * FROM Block;
SELECT * FROM Room;
SELECT * FROM On_Call;
SELECT * FROM Stay;
SELECT * FROM Undergoes;

-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
SELECT * FROM physician;
SELECT * FROM procedures;
SELECT * FROM medication;
SELECT * FROM Affiliated_With;
SELECT * FROM Trained_In;
SELECT * FROM Undergoes; -- �����ϴ� �ǻ� List

     SELECT ph.name	AS '�ǻ� �̸�'
          , un.patient AS 'ȯ�� �ڵ�'
          , pr.name AS '���� �̸�'
       FROM physician ph
 INNER JOIN undergoes un
         ON ph.employeeId = un.physician
 INNER JOIN procedures pr
         ON un.procedures = pr.code
      WHERE ph.employeeID NOT IN (
      	SELECT t.physician  
      	  FROM trained_in t
      	 WHERE t.physician = ph.employeeId
      	   AND t.treatment = pr.code
      	); 

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
	SELECT ph.name	AS '�ǻ� �̸�'
          , un.patient AS 'ȯ�� �ڵ�'
          , pr.name AS '���� �̸�'
          , un.dateUndergoes AS '���� ��¥'
       FROM physician ph
 INNER JOIN undergoes un
         ON ph.employeeId = un.physician
 INNER JOIN procedures pr
         ON un.procedures = pr.code
      WHERE ph.employeeID NOT IN (
      	SELECT t.physician  
      	  FROM trained_in t
      	 WHERE t.physician = ph.employeeId
      	   AND t.treatment = pr.code
      	);
      
-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
      SELECT p.name
        FROM physician p 
  INNER JOIN undergoes u 
          ON p.employeeid = u.physician   
  INNER JOIN trained_in ti 		 
 		  ON p.employeeid = ti.physician
 	   WHERE u.DateUndergoes > ti.CertificationExpires;
 	 
 	   SELECT NAME 
 	  	 FROM physician
 	 	WHERE employeeId IN (
 	 		SELECT physician  
 	 		  FROM undergoes u 
 	 		 WHERE dateundergoes > 
 	 		  (
 	 		  	SELECT certificationExpires
 	 		  	  FROM trained_in ti
 	 		  	 WHERE u.physician = ti.physician
 	 		  	   AND ti.treatment = u.procedures
 	 		  )
 	 	);

 	 -- �ַμ� ���信 �ִ� ���� ...
 	 SELECT Name 
  FROM Physician 
 WHERE EmployeeID IN 
       (
         SELECT Physician FROM Undergoes U 
          WHERE u.dateundergoes > 
               (
                  SELECT CertificationExpires 
                    FROM Trained_In T 
                   WHERE T.Physician = U.Physician 
                     AND T.Treatment = U.Procedures 
               )
       );
 	  
-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
      SELECT p.name
           , ti.certificationExpires 
   		   , p2.name
   		   , u.DateUndergoes AS '���� ��¥'
   		   , p3.name AS 'ȯ�� �̸�'
   		   , ti.CertificationExpires AS '���� ��¥'
        FROM physician p 
  INNER JOIN undergoes u 
          ON p.employeeid = u.physician   
  INNER JOIN trained_in ti 		 
 		  ON p.employeeid = ti.physician
  INNER JOIN procedures p2	  
 		  ON p2.code = ti.treatment
  INNER JOIN patient p3 		  
 		  ON p3.ssn = u.patient
 	   WHERE u.DateUndergoes > ti.CertificationExpires;
 	  
-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

				SELECT * FROM appointment a  	  
 	  
 	  

 	  
 	  
-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

 	  
 	  -- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.