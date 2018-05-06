DROP TABLE IF EXISTS fcourselist;
DROP TABLE IF EXISTS scourselist;
DROP TABLE IF EXISTS tcourselist;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS problemset;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS tutor;
DROP TABLE IF EXISTS account;

--Account Table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
--hashed pass is  null for now, must figure out when adding students, admin/prof doesn't have password or?
CREATE TABLE account(
    hawkid VARCHAR(10) NOT NULL,
    fname VARCHAR(120) NOT NULL,
    lname VARCHAR(120) NULL,
    hashedpass VARCHAR(120) NULL,
    student BOOLEAN NOT NULL,
    tutor BOOLEAN NOT NULL,
    administrator BOOLEAN NOT NULL,
    faculty BOOLEAN NOT NULL,
    
    PRIMARY KEY(hawkid)
);



--CREATE TABLE budget{
 --   budgetid VARCHAR(10) NOT NULL;
--    budget INT NOT NULL;
--    PRIMARY KEY (budget);
--    FOREIGN KEY(budgetid) REFERENCES account(hawkid)

--}

--Tutor table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE tutor (
    tutorid VARCHAR(10) NOT NULL,
    fname VARCHAR(120),
    lname VARCHAR(120),
    PRIMARY KEY(tutorid),
    FOREIGN KEY(tutorid) REFERENCES account(hawkid)
);

--Student table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE student (
    studentid VARCHAR(10) NOT NULL,
    budget VARCHAR(120) NULL,
    PRIMARY KEY(studentid),
    FOREIGN KEY(studentid) REFERENCES account(hawkid)
);

--Session Table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE sessions (
    sessionid INT AUTO_INCREMENT,
    -- look at sql time/date data types. timestamp, datetime, etc
    timeofsession VARCHAR(120) NOT NULL,
    dateofsession VARCHAR(255) NOT NULL,
    placeofsession VARCHAR(255) NOT NULL,
    tutorid VARCHAR(10) NOT NULL,
    PRIMARY KEY(sessionid)
);

--Course table
CREATE TABLE course(
    courseid INT NOT NULL,
    coursename VARCHAR(120) NOT NULL,
    PRIMARY KEY (courseid)
);

--Problem table
CREATE TABLE problemset (
    problemid INT AUTO_INCREMENT,
    filename VARCHAR(3000),
    problemnotes VARCHAR(3000),
	courseid INT NOT NULL,
    PRIMARY KEY (problemid),
    FOREIGN KEY(courseid) REFERENCES course(courseid)
);

 
--Reservation Table
-- for all the columns/varibles that will eventually sent to the web app, use exactly the same words --
CREATE TABLE reservation(
    reservationid INT NOT NULL AUTO_INCREMENT,
    notes VARCHAR(3000),
    cancel BOOLEAN NOT NULL,
    sessionid INT NOT NULL,
    problemid INT,
    studentid VARCHAR(10) NOT NULL,
    PRIMARY KEY(reservationid),
    FOREIGN KEY(sessionid) REFERENCES sessions(sessionID),
    FOREIGN KEY(problemid) REFERENCES problemset(ProblemID)    
);



CREATE TABLE scourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid INT NOT NULL
);

--tutorcourseid 
CREATE TABLE tcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid INT NOT NULL
);

--faculty table 
CREATE TABLE fcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid INT NOT NULL
);


-- test cases for each data type
INSERT INTO account VALUES('studenttutor','John','Doe','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',True,True,False,False);
INSERT INTO account VALUES('student','Student','Foe','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',True,False,False,False);
INSERT INTO account VALUES('tutor','Tutor','Wizard','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',False,True,False,False);
INSERT INTO account VALUES('admin','Admin',NULL,'$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',False,False,True,False);
INSERT INTO account VALUES('faculty','Faculty','Bob','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',False,False,False,True);
INSERT INTO account VALUES('faculty2','Faculty','Admin','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',False,False,True,True);
INSERT INTO account VALUES('arangl','Andres','Rangel','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',False,False,True,False);





INSERT INTO scourselist VALUES('student', 1210);
INSERT INTO scourselist VALUES('studenttutor', 1020);
INSERT INTO scourselist VALUES('test', 1110);

INSERT INTO tcourselist VALUES('studenttutor', 1210);
INSERT INTO tcourselist VALUES('tutor', 1210);

INSERT INTO fcourselist VALUES('faculty', 1210);
INSERT INTO fcourselist VALUES('faculty', 1020);
INSERT INTO fcourselist VALUES('faculty', 1110);
INSERT INTO fcourselist VALUES('faculty2', 1210);


INSERT INTO course VALUES(1210, 'CS:1210');
INSERT INTO course VALUES(1020, 'CS:1020');
INSERT INTO course VALUES(1110, 'CS:1110');

