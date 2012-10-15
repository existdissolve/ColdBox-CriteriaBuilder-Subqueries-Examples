# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.9)
# Database: Cars
# Generation Time: 2012-10-14 22:46:17 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Car
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Car`;

CREATE TABLE `Car` (
  `CarID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Make` varchar(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Model` varchar(11) DEFAULT NULL,
  `Mileage` int(11) DEFAULT NULL,
  PRIMARY KEY (`CarID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Car` WRITE;
/*!40000 ALTER TABLE `Car` DISABLE KEYS */;

INSERT INTO `Car` (`CarID`, `Make`, `Year`, `Model`, `Mileage`)
VALUES
	(1,'Ford',2005,'Focus',50000),
	(2,'Saturn',2011,'Aura',75000),
	(3,'Dodge',2012,'Ram',45000),
	(4,'Ford',2006,'Prizm',120000),
	(5,'Dodge',2010,'Charger',99000),
	(6,'Dodge',2008,'Caravan',55000),
	(7,'Ford',2001,'Focus',66000);

/*!40000 ALTER TABLE `Car` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Driver
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Driver`;

CREATE TABLE `Driver` (
  `DriverID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(11) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  PRIMARY KEY (`DriverID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Driver` WRITE;
/*!40000 ALTER TABLE `Driver` DISABLE KEYS */;

INSERT INTO `Driver` (`DriverID`, `Name`, `Age`)
VALUES
	(1,'Joel',31),
	(2,'Brooke',32),
	(4,'Jason',25),
	(5,'Jared',21);

/*!40000 ALTER TABLE `Driver` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Insured
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Insured`;

CREATE TABLE `Insured` (
  `InsuredID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CarID` int(11) DEFAULT NULL,
  `DriverID` int(11) DEFAULT NULL,
  PRIMARY KEY (`InsuredID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Insured` WRITE;
/*!40000 ALTER TABLE `Insured` DISABLE KEYS */;

INSERT INTO `Insured` (`InsuredID`, `CarID`, `DriverID`)
VALUES
	(1,1,1),
	(2,2,1),
	(3,2,2),
	(4,1,4),
	(5,2,4),
	(6,1,5),
	(7,7,1);

/*!40000 ALTER TABLE `Insured` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
