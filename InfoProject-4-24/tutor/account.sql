DROP TABLE IF EXISTS account;

-- This a table to hold user accounts
CREATE TABLE account (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  hashedpass VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);
--password: movies
INSERT INTO account (username, hashedpass) VALUES ('sniebuhr', '$2a$12$umfcjVx85WehNxCL2NH80OqymgskQPyfIkeTGiEj.8S6UNjiEQo66');