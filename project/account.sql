DROP TABLE IF EXISTS account;

-- This a table to hold user accounts
CREATE TABLE account (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  hashedpass VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);
--password: movies
INSERT INTO account (username, hashedpass) VALUES ('LRP', '$2a$12$f5t5UQZToCPUKNEF/KmtQek/B8M3u4GMe9kvnOxRALl4GNtDC3lSS');