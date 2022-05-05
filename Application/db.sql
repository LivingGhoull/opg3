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
  `userID` int(11) DEFAULT NULL,
  `taskID` int(11) DEFAULT NULL,
  KEY `userID` (`userID`),
  KEY `taskID` (`taskID`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`taskID`) REFERENCES `tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.project: ~0 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`userID`, `taskID`) VALUES
	(6, 12);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;

-- Dumping structure for tabel opg3.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(255) NOT NULL,
  `beginTime` date NOT NULL,
  `endTime` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.tasks: ~4 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`, `taskName`, `beginTime`, `endTime`) VALUES
	(12, 'plan', '2022-05-02', '2022-05-04'),
	(13, 'product', '2022-05-04', '2022-05-06'),
	(14, 'process', '2022-05-06', '2022-05-10'),
	(15, 'Delivery', '2022-05-10', '2022-05-11');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Dumping structure for tabel opg3.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Dumping data for table opg3.users: ~5 rows (tilnærmelsesvis)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `fname`, `lname`) VALUES
	(5, 'danniel', 'gaard'),
	(6, 'Bob', 'Tom'),
	(12, 'John', 'Snow'),
	(13, 'Margrid', 'Tomas'),
	(14, 'Kim', 'komm'),
	(15, 'Billy', 'domm');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
