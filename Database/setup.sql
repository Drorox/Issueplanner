DROP SCHEMA IF EXISTS issueplanner_db;
CREATE SCHEMA issueplanner_db DEFAULT CHARACTER SET utf16;
USE issueplanner_db;
GRANT INSERT, UPDATE, DELETE, SELECT ON issueplanner_db . * TO 'user'@'%';

DROP TABLE IF EXISTS issueplanner_db.linked_issues;
DROP TABLE IF EXISTS issueplanner_db.label_issue;

DROP TABLE IF EXISTS issueplanner_db.label;
DROP TABLE IF EXISTS issueplanner_db.issue;
DROP TABLE IF EXISTS issueplanner_db.users;

CREATE TABLE IF NOT EXISTS issueplanner_db.users(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    create_time DATETIME COMMENT 'Create Time',
    name VARCHAR(255),
    passhash VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS issueplanner_db.issue(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time' ,
    edit_time DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Edit Time',
    title VARCHAR(255),
    description VARCHAR(4095)
);


CREATE Table IF NOT EXISTS issueplanner_db.label(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    titel VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS issueplanner_db.label_issue(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    label_id int NOT NULL,
    issue_id int NOT NULL,
    CONSTRAINT label_issue_pk
        UNIQUE (label_id, issue_id),
    CONSTRAINT label_issue__fk__label_id
        FOREIGN KEY (label_id)
        REFERENCES issueplanner_db.label (id)
        ON DELETE CASCADE,
    CONSTRAINT label_issue__fk__issue_id
        FOREIGN KEY (issue_id)
        REFERENCES issueplanner_db.issue (id)
        ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS issueplanner_db.linked_issues(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    issue_id int NOT NULL,
    relate_issue_id int NOT NULL,
    blocks TINYINT DEFAULT 0,
    CONSTRAINT linked_issue_pk
        UNIQUE (issue_id, relate_issue_id),
    CONSTRAINT linked_issue__fk__issue_id
        FOREIGN KEY (issue_id)
        REFERENCES issueplanner_db.issue (id)
        ON DELETE CASCADE,
    CONSTRAINT linked_issue__fk__relate_issue_id
        FOREIGN KEY (relate_issue_id)
        REFERENCES issueplanner_db.issue (id)
        ON DELETE CASCADE
);