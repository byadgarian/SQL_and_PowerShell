-- QUESTION 1 ----------------------------------------------------------------------

-- CREATE THE SCHOOL TABLES --
CREATE TABLE STUDENT (
	Sid INT NOT NULL,
	Sname VARCHAR(20) NOT NULL,
	CONSTRAINT PK_STUDENT PRIMARY KEY (Sid)
);

TRUNCATE TABLE dbo.STUDENT;

CREATE TABLE COURSE (
	Cid INT NOT NULL,
	Cname VARCHAR(20) NOT NULL,
	CONSTRAINT PK_COURSE PRIMARY KEY (Cid)
);

CREATE TABLE ENROLLMENT (
	Cid INT NOT NULL,
	Sid INT NOT NULL,
	CONSTRAINT PK_ENROLLMENT PRIMARY KEY (Cid, Sid),
	CONSTRAINT FK_ENROLLMENT_COURSE FOREIGN KEY (Cid) REFERENCES dbo.COURSE (Cid),
	CONSTRAINT FK_ENROLLMENT_STUDENT FOREIGN KEY (Sid) REFERENCES dbo.STUDENT (Sid)
);

ALTER TABLE dbo.ENROLLMENT DROP CONSTRAINT FK_ENROLLMENT_STUDENT
ALTER TABLE dbo.ENROLLMENT ADD CONSTRAINT FK_ENROLLMENT_STUDENT FOREIGN KEY (Sid) REFERENCES dbo.STUDENT (Sid)
TRUNCATE TABLE dbo.ENROLLMENT;

-- POPULATE THE TABLES --
INSERT INTO dbo.STUDENT (Sid, Sname) VALUES
	(70, 'Brian'),
	(71, 'Amanda'),
	(72, 'Michael'),
	(73, 'David')
;

INSERT INTO dbo.COURSE (Cid, Cname) VALUES
	(670, 'Math'),
	(671, 'Physics'),
	(672, 'Chemistry')
;

INSERT INTO dbo.ENROLLMENT (Cid, Sid) VALUES
	(670, 70),
	(671, 70),
	(672, 70),
	(672, 71),
	(672, 72),
	(672, 73)
;

-- QUERIES --
SELECT C.Cname, T.NumOfEnrolledStudents 
FROM ((SELECT E.Cid, COUNT(E.Sid) AS NumOfEnrolledStudents
	   FROM dbo.ENROLLMENT AS E
	   GROUP BY E.Cid
	   HAVING COUNT(E.Sid) > 0) AS T JOIN dbo.COURSE AS C ON T.Cid = C.Cid)
ORDER BY T.NumOfEnrolledStudents

-- QUESTION 3 ----------------------------------------------------------------------

SELECT W.Essn, AVG(W.Hours) AS AvgHrsPerDep, P.Dnum
FROM dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber
GROUP BY W.Essn, P.Dnum
ORDER BY W.Essn;

-- OR --

SELECT W.Essn, AVG(W.Hours) AS AvgHrsPerDep, D.Dname
FROM (dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber) JOIN dbo.DEPARTMENT as D ON P.Dnum = D.Dnumber
GROUP BY W.Essn, D.Dname
ORDER BY W.Essn;

-- QUESTION 4 ----------------------------------------------------------------------

SELECT E.Fname, E.Lname, E.Dno
FROM dbo.EMPLOYEE AS E
WHERE E.Dno IN (SELECT T2.Dnum
				FROM (SELECT SUM(W.Hours) AS SumHrsPerDep, P.Dnum
					  FROM dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber
					  GROUP BY P.Dnum) AS T2
				WHERE T2.SumHrsPerDep IN (SELECT MAX(T1.SumHrsPerDep) AS MaxHrs
										  FROM (SELECT SUM(W.Hours) AS SumHrsPerDep, P.Dnum
												FROM dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber
												GROUP BY P.Dnum) AS T1))

-- QUESTION 5 ----------------------------------------------------------------------

ALTER TABLE dbo.EMPLOYEE ADD Rankk VARCHAR(5) NULL;		--the word 'Rank' reserved for SQL and cannot be used
														--to make the Rankk column NOT NULL we must first remove the restrictions and truncate the table
UPDATE dbo.EMPLOYEE SET Rankk = '1st'
WHERE Ssn IN (SELECT E.Ssn
			  FROM dbo.EMPLOYEE AS E
			  WHERE E.Ssn IN (SELECT T2.Essn
			  FROM (SELECT W.Essn, COUNT(W.Pno) AS NumOfProjs
					FROM dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber
					GROUP BY W.Essn) AS T2
			  WHERE T2.NumOfProjs IN (SELECT MAX(T1.NumOfProjs) AS MaxNumOfProjs
									  FROM (SELECT W.Essn, COUNT(W.Pno) AS NumOfProjs
											FROM dbo.WORKS_ON AS W JOIN dbo.PROJECT AS P ON W.Pno = P.Pnumber
											GROUP BY W.Essn) AS T1)))