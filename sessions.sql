DROP TABLE IF EXISTS sessions;
-- for all the columns/varibles that will ve eventually sent to the web app, use exactly the same words --
CREATE TABLE sessions
    sessionid INT NOT NULL AUTO_INCREMENT,
    timeofsession VARCHAR(120) NOT NULL,
    dateofsession VARCHAR(255) NOT NULL,
    placeofsession VARCHAR(255) NOT NULL,
    PRIMARY KEY(sessionid)
                  );