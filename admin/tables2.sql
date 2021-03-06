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
CREATE TABLE account(
    hawkid VARCHAR(20) NOT NULL,
    name VARCHAR(120) NOT NULL,
    hashedpass VARCHAR(120) NOT NULL,
    student BIT NOT NULL,
    tutor BIT NOT NULL,
    administrator BIT NOT NULL,
    faculty BIT NOT NULL,
    PRIMARY KEY(hawkid)
                  );
--Tutor table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE tutor (
    tutorid VARCHAR(20) NOT NULL,
    name VARCHAR(120) NOT NULL,
    budget VARCHAR(120) NOT NULL,
    PRIMARY KEY(tutorid),
    FOREIGN KEY(tutorid) REFERENCES account(hawkid)
                  );

--Student table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE student (
    studentid VARCHAR(20) NOT NULL,
    name VARCHAR(120) NOT NULL,
    budget VARCHAR(120) NOT NULL,
    PRIMARY KEY(studentid),
    FOREIGN KEY(studentid) REFERENCES account(hawkid)
                  );
--Session Table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE sessions (
    sessionid INT AUTO_INCREMENT,
    sessiontime smalldatetime NOT NULL,
    location VARCHAR(255) NOT NULL,
    tutorid VARCHAR(10) NOT NULL,
    PRIMARY KEY(sessionid),
    FOREIGN KEY(tutorid) REFERENCES tcourselist(tutorid)
                  );
--Course table
CREATE TABLE course(
    courseid VARCHAR(20) NOT NULL,
    coursename VARCHAR(120) NOT NULL,
    PRIMARY KEY (courseid)
);

--Problem table
CREATE TABLE problemset (
    problemid INT AUTO_INCREMENT,
    problemnotes VARCHAR(3000),
	courseid VARCHAR(20) NOT NULL,
    PRIMARY KEY (problemid),
    FOREIGN KEY(courseid) REFERENCES course(courseid)
);

 
--Reservation Table
-- for all the columns/varibles that will eventually sent to the web app, use exactly the same words --
CREATE TABLE reservation(
    reservationid INT NOT NULL AUTO_INCREMENT,
    notes VARCHAR(3000),
    cancel BIT NOT NULL,
    sessionid INT NOT NULL,
    problemid INT,
    studentid VARCHAR(10) NOT NULL,
    PRIMARY KEY(reservationid),
    FOREIGN KEY(sessionid) REFERENCES sessions(sessionID),
    FOREIGN KEY(problemid) REFERENCES problemset(problemID)
                  );

CREATE TABLE scourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
    budget INT NOT NULL
)
CREATE TABLE tcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
    budget INT NOT NULL
)
CREATE TABLE fcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
)

-- test cases for each data type
INSERT INTO account VALUES('studenttutor','StudentTutor','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor2','StudentTutor2','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor3','StudentTutor3','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor4','StudentTutor4','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);

INSERT INTO account VALUES('student','Student','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student2','Student2','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student3','Student3','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student4','Student4','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);

INSERT INTO account VALUES('tutor','Tutor','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor2','Tutor2','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor3','Tutor3','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor4','Tutor4','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);

INSERT INTO account VALUES('admin','Admin','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,0,1,0);

INSERT INTO account VALUES('faculty','Faculty','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,0,0,1);

INSERT INTO account VALUES('facultyadmin','FacultyAdmin','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,0,1,1);

INSERT INTO course VALUES('CS:101','Intro to Computer Science');

INSERT INTO scourselist VALUES('student','CS:101',3);
INSERT INTO tcourselist VALUES('tutor','CS:101',3);
INSERT INTO fcourselist VALUES('faculty','CS:101');

                  

© 2018 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
API
Training
Shop
Blog
About
Press h to open a hovercard with more details.