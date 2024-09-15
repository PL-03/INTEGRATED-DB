-- Set Time Zone
SET TIME_ZONE = '+00:00';

-- Create Database if not exists
CREATE DATABASE IF NOT EXISTS integrated /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE integrated;

-- Disable foreign key checks for now
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- Drop existing board table if exists
DROP TABLE IF EXISTS board;

-- Create the board table
CREATE TABLE board (
  boardId varchar(10) NOT NULL,
  name varchar(120) NOT NULL,
  oid varchar(36) NOT NULL,
  createdOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (boardId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Drop existing statusv3 table if exists
DROP TABLE IF EXISTS statusv3;

-- Create the statusv3 table
CREATE TABLE statusv3 (
  statusId int NOT NULL AUTO_INCREMENT,
  statusName varchar(50) NOT NULL,
  statusDescription varchar(200) DEFAULT NULL,
  boardId varchar(10) NOT NULL,
  createdOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedOn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (statusId),
  KEY fk_statusv3_board1_idx (boardId),
  CONSTRAINT fk_statusv3_board1 FOREIGN KEY (boardId) REFERENCES board (boardId)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Drop existing taskv3 table if exists
DROP TABLE IF EXISTS taskv3;

-- Create the taskv3 table
CREATE TABLE taskv3 (
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
  KEY fk_taskv3_taskStatus_idx (taskStatusId),
  KEY fk_taskv3_board1_idx (boardId),
  CONSTRAINT fk_taskv3_board1 FOREIGN KEY (boardId) REFERENCES board (boardId),
  CONSTRAINT fk_taskv3_taskStatus FOREIGN KEY (taskStatusId) REFERENCES statusv3 (statusId)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Enable foreign key checks again
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

-- Stored Procedure to delete board and associated tasks and statuses
DROP PROCEDURE IF EXISTS DeleteBoard;
DELIMITER //
CREATE PROCEDURE DeleteBoard(IN boardIdToDelete VARCHAR(10))
BEGIN
    -- First delete all tasks associated with the board
    DELETE FROM taskv3 WHERE boardId = boardIdToDelete;

    -- Then delete all statuses associated with the board
    DELETE FROM statusv3 WHERE boardId = boardIdToDelete;

    -- Finally delete the board
    DELETE FROM board WHERE boardId = boardIdToDelete;
END //
DELIMITER ;
