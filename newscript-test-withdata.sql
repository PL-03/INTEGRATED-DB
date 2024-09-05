SET TIME_ZONE = '+00:00';
CREATE DATABASE  IF NOT EXISTS `integrated` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `integrated`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: integrated
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `boardId` varchar(10) NOT NULL,
  `name` varchar(120) NOT NULL,
  `oid` varchar(36) NOT NULL,
  PRIMARY KEY (`boardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES ('test','test','test');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `statusId` int NOT NULL AUTO_INCREMENT,
  `statusName` varchar(50) NOT NULL,
  `statusDescription` varchar(200) DEFAULT NULL,
  `board_boardId` varchar(10) NOT NULL,
  PRIMARY KEY (`statusId`),
  UNIQUE KEY `statusName_UNIQUE` (`statusName`),
  KEY `fk_status_board1_idx` (`board_boardId`),
  CONSTRAINT `fk_status_board1` FOREIGN KEY (`board_boardId`) REFERENCES `board` (`boardId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'No Status','A status has not been assigned','test'),(2,'To Do','The task is included in the project','test'),(3,'Doing','The task is being worked on','test'),(4,'Done','The task has been completed','test');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskv2`
--

DROP TABLE IF EXISTS `taskv2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskv2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taskTitle` varchar(100) NOT NULL,
  `taskDescription` varchar(500) DEFAULT NULL,
  `taskAssignees` varchar(30) DEFAULT NULL,
  `taskStatusId` int NOT NULL DEFAULT '1',
  `createdOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `board_boardId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_taskv2_taskStatus_idx` (`taskStatusId`),
  KEY `fk_taskv2_board1_idx` (`board_boardId`),
  CONSTRAINT `fk_taskv2_board1` FOREIGN KEY (`board_boardId`) REFERENCES `board` (`boardId`),
  CONSTRAINT `fk_taskv2_taskStatus` FOREIGN KEY (`taskStatusId`) REFERENCES `status` (`statusId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskv2`
--

LOCK TABLES `taskv2` WRITE;
/*!40000 ALTER TABLE `taskv2` DISABLE KEYS */;
INSERT INTO `taskv2` VALUES (1,'test','test','test',1,'2024-09-05 16:25:51','2024-09-05 16:25:51','test');
/*!40000 ALTER TABLE `taskv2` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-05 23:27:27
