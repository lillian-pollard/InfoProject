DROP TABLE IF EXISTS fcourselist;
DROP TABLE IF EXISTS scourselist;
DROP TABLE IF EXISTS tcourselist;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS problemset;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS account;


--Account Table
-- for all the columns/varibles that will we eventually sent to the web app, use exactly the same words --
CREATE TABLE account(
    hawkid VARCHAR(20) NOT NULL,
    fname VARCHAR(120) NOT NULL,
    lname VARCHAR(120) NOT NULL,
    hashedpass VARCHAR(120) NOT NULL,
    student BIT NOT NULL,
    tutor BIT NOT NULL,
    administrator BIT NOT NULL,
    faculty BIT NOT NULL,
    PRIMARY KEY(hawkid)
                  );


--Course table
CREATE TABLE course(
    courseid VARCHAR(20) NOT NULL,
    coursename VARCHAR(120) NOT NULL,
    PRIMARY KEY (courseid)
);

--Session Table
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE sessions(
    sessionid INT AUTO_INCREMENT,
    sessiontime  VARCHAR(20) NOT NULL,
    sessiondate VARCHAR(20) NOT NULL,
    tutorid VARCHAR(10) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
    cancel BIT,
    PRIMARY KEY(sessionid),
    FOREIGN KEY(courseid) REFERENCES course(courseid)
                  );

--Problem table
CREATE TABLE problemset (
    problemid INT AUTO_INCREMENT,
    filename VARCHAR(3000),
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
    cancel BIT,
    rate INT,
    sessionid INT NOT NULL,
    studentid VARCHAR(10) NOT NULL,
    PRIMARY KEY(reservationid),
    FOREIGN KEY(sessionid) REFERENCES sessions(sessionid)
                  );

CREATE TABLE scourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
    budget INT NOT NULL,
    currbudget INT NOT NULL,
    FOREIGN KEY(courseid) REFERENCES course(courseid)
);
CREATE TABLE tcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL,
    budget INT NOT NULL,
    currbudget INT NOT NULL,
    FOREIGN KEY(courseid) REFERENCES course(courseid)
);
CREATE TABLE fcourselist(
    hawkid VARCHAR(20) NOT NULL,
    courseid VARCHAR(20) NOT NULL
);

-- test cases for each data type

INSERT INTO account VALUES('studenttutor','Student','Tutor','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor2','Student','Tutor2','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor3','Student','Tutor3','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);
INSERT INTO account VALUES('studenttutor4','Student','Tutor4','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,1,0,0);

INSERT INTO account VALUES('student','Student','One','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student2','Student','Two','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student3','Student','Three','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);
INSERT INTO account VALUES('student4','Student','Four','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',1,0,0,0);

INSERT INTO account VALUES('tutor','Tutor','One','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor2','Tutor','Two','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor3','Tutor','Three','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);
INSERT INTO account VALUES('tutor4','Tutor','Four','$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS',0,1,0,0);


INSERT INTO account VALUES('admin','Admin','Member','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',0,0,1,0);
INSERT INTO account VALUES('faculty','Faculty','Bob','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',0,0,0,1);
INSERT INTO account VALUES('faculty2','Faculty','Admin','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',0,0,1,1);
INSERT INTO account VALUES('arangl','Andres','Rangel','$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O',0,0,1,0);


INSERT INTO course VALUES('CS:1110','Intro to Computer Science');
INSERT INTO course VALUES('CS:1210','Computer Science I: Fundamentals');
INSERT INTO course VALUES('CS:2110','Programming for Informatics');
    
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(1,'1:00 PM','2018-05-10','tutor','CS:1110');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(2,'2:00 PM','2018-05-05','tutor2','CS:1210');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(3,'3:00 PM','2018-06-07','tutor3','CS:1110');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(4,'4:40 PM','2018-06-05','tutor2','CS:1110');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(5,'2:20 PM','2018-06-06','tutor','CS:2110');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(6,'1:00 PM','2018-06-07','tutor','CS:1210');
INSERT INTO sessions(sessionid, sessiontime, sessiondate, tutorid, courseid) VALUES(7,'2:00 PM','2018-05-05','tutor','CS:1110');

INSERT INTO scourselist VALUES('student','CS:1110',4,3);
INSERT INTO scourselist VALUES('student','CS:1210',4,3);
INSERT INTO scourselist VALUES('student2','CS:1110',4,3);
INSERT INTO scourselist VALUES('student3','CS:2110',4,4);
INSERT INTO scourselist VALUES('student4','CS:1210',4,4);

INSERT INTO tcourselist VALUES('tutor','CS:1110',20,19);
INSERT INTO tcourselist VALUES('tutor','CS:1210',20,20);
INSERT INTO tcourselist VALUES('tutor2','CS:1110',20,20);
INSERT INTO tcourselist VALUES('tutor2','CS:2110',20,19);
INSERT INTO tcourselist VALUES('tutor3','CS:1110',20,19);
INSERT INTO tcourselist VALUES('tutor3','CS:2110',20,20);


INSERT INTO fcourselist VALUES('faculty','CS:1110');
INSERT INTO fcourselist VALUES('faculty','CS:2110');
INSERT INTO fcourselist VALUES('facultyadmin','CS:1210');
INSERT INTO fcourselist VALUES('faculty','CS:1210');
INSERT INTO fcourselist VALUES('faculty2','CS:1210');


INSERT INTO reservation(sessionid,studentid) VALUES(1,'student');
INSERT INTO reservation(sessionid,studentid) VALUES(2,'student');
INSERT INTO reservation(sessionid,studentid) VALUES(3,'student2');
INSERT INTO reservation(sessionid,studentid) VALUES(7,'student2');

INSERT INTO problemset(filename,courseid,problemnotes) VALUES('ch1.pdf','CS:1110','Chapter 1 deals with Database Modelling, here we are introduced to Dia. Follow this tutorial to download the application and get framiliar with basic tasks.');
INSERT INTO problemset(filename,courseid) VALUES('ch2.pdf','CS:1110');
INSERT INTO problemset(filename,courseid) VALUES('ch3.pdf','CS:1110');
INSERT INTO problemset(filename,courseid) VALUES('Week1.pdf','CS:1210');
INSERT INTO problemset(filename,courseid) VALUES('Week2.pdf','CS:1210');
INSERT INTO problemset(filename,courseid) VALUES('Week4.pdf','CS:1210');
INSERT INTO problemset(filename,courseid) VALUES('finalevaluation.pdf','CS:2110');
INSERT INTO problemset(filename,courseid) VALUES('project.pdf','CS:2110');