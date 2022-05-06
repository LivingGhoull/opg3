-- --------------------------------------------------------
-- Vært:                         127.0.0.1
-- Server-version:               5.7.33 - MySQL Community Server (GPL)
-- ServerOS:                     Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for opg3
CREATE DATABASE IF NOT EXISTS `opg3` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `opg3`;

-- Dumping structure for tabel opg3.project
CREATE TABLE IF NOT EXISTS `project` (
  `pUserID` int(11) DEFAULT NULL,
  `pTaskID` int(11) DEFAULT NULL,
  KEY `pUserID` (`pUserID`),
  KEY `pTaskID` (`pTaskID`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`pUserID`) REFERENCES `users` (`userID`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`pTaskID`) REFERENCES `tasks` (`taskID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.project: ~10 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`pUserID`, `pTaskID`) VALUES
	(3, 1),
	(4, 1),
	(3, 2),
	(6, 2),
	(5, 2),
	(2, 3),
	(3, 3),
	(1, 4),
	(6, 4),
	(2, 4);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;

-- Dumping structure for tabel opg3.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `taskID` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(255) NOT NULL,
  `beginTime` date NOT NULL,
  `endTime` date NOT NULL,
  PRIMARY KEY (`taskID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.tasks: ~4 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`taskID`, `taskName`, `beginTime`, `endTime`) VALUES
	(1, 'Plan', '2022-05-01', '2022-05-06'),
	(2, 'Product', '2022-05-06', '2022-05-12'),
	(3, 'Process', '2022-05-12', '2022-05-17'),
	(4, 'Delivery', '2022-05-17', '2022-05-19');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Dumping structure for tabel opg3.users
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.users: ~6 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`userID`, `fname`, `lname`) VALUES
	(1, 'Bob', 'Tom'),
	(2, 'Tommas', 'Job'),
	(3, 'Lars', 'Gaard'),
	(4, 'Kim', 'Possible'),
	(5, 'Hank', 'Cruser'),
	(6, 'Brian', 'Grifen');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
