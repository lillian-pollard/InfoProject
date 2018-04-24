DROP TABLE IF EXISTS reservation;
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE reservation(
    reservationid INT NOT NULL AUTO_INCREMENT,
    notes VARCHAR(3000) NOT NULL,
    cancel BOOLEAN yes or no?
    sessionid INT NOT NULL,
    problemid INT NOT NULL,
    PRIMARY KEY(reservationid)
    FOREIGN KEY(sessionid) NOT NULL,
    FOREIGN KEY(problemid) NULL,    
                  );
