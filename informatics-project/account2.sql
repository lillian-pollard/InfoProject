DROP TABLE IF EXISTS account;

-- This a table to hold user accounts
CREATE TABLE account (
  id INT NOT NULL AUTO_INCREMENT,
  isadmin BOOLEAN NOT NULL,
  username VARCHAR(50) NOT NULL,
  hashedpass VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

-- username: 123456/arangl pass: 123456
INSERT INTO account (isadmin, username, hashedpass) VALUES (1,'123456', '$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O');
INSERT INTO account (isadmin, username, hashedpass) VALUES (0,'arangl', '$2a$12$NFWuIEO2J8sS/5tJz7.sEe895Do9IZ9I7RzcCeILTUlHHdO8Vhi2O');
© 2018 GitHub, Inc.
