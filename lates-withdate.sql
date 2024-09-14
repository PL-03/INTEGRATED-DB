SET TIME_ZONE = '+00:00';
CREATE DATABASE IF NOT EXISTS integrated /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE integrated;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS taskv2;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS board;

-- Create board table
CREATE TABLE board (
  boardId varchar(10) NOT NULL,
  name varchar(120) NOT NULL,
  oid varchar(36) NOT NULL,
  createdOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (boardId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create status table
CREATE TABLE status (
  statusId int NOT NULL AUTO_INCREMENT,
  statusName varchar(50) NOT NULL,
  statusDescription varchar(200) DEFAULT NULL,
  boardId varchar(10) NOT NULL,
  createdOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (statusId),
  KEY fk_status_board1_idx (boardId),
  CONSTRAINT fk_status_board1 FOREIGN KEY (boardId) REFERENCES board (boardId) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create taskv2 table
CREATE TABLE taskv2 (
  id int NOT NULL AUTO_INCREMENT,
  taskTitle varchar(100) NOT NULL,
  taskDescription varchar(500) DEFAULT NULL,
  taskAssignees varchar(30) DEFAULT NULL,
  taskStatusId int NOT NULL DEFAULT '1',
  createdOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  boardId varchar(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id_UNIQUE (id),
  KEY fk_taskv2_taskStatus_idx (taskStatusId),
  KEY fk_taskv2_board1_idx (boardId),
  CONSTRAINT fk_taskv2_board1 FOREIGN KEY (boardId) REFERENCES board (boardId) ON DELETE CASCADE,
  CONSTRAINT fk_taskv2_taskStatus FOREIGN KEY (taskStatusId) REFERENCES status (statusId) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create a stored procedure for deleting a board
DELIMITER //

CREATE PROCEDURE DeleteBoard(IN boardIdParam VARCHAR(10))
BEGIN
    -- First, delete tasks associated with the board
    DELETE FROM taskv2 WHERE boardId = boardIdParam;

    -- Then, delete statuses associated with the board
    DELETE FROM status WHERE boardId = boardIdParam;

    -- Finally, delete the board itself
    DELETE FROM board WHERE boardId = boardIdParam;
END //

DELIMITER ;
