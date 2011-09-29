-- MySQL dump 10.13  Distrib 5.1.58, for redhat-linux-gnu (i386)
--
-- Host: russelllab.org    Database: aca
-- ------------------------------------------------------
-- Server version	5.1.58-community-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `complex`
--

DROP TABLE IF EXISTS `complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model` int(2) unsigned zerofill NOT NULL,
  `network_id` int(10) unsigned NOT NULL,
  `score` float DEFAULT NULL,
  `nreplaced` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`,`network_id`),
  KEY `fk_complex_network1` (`network_id`),
  CONSTRAINT `fk_complex_network1` FOREIGN KEY (`network_id`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4081 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `id` int(11) NOT NULL,
  `complex_id` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `acc` varchar(45) DEFAULT NULL,
  `template` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`complex_id`),
  KEY `fk_domain_complex` (`complex_id`),
  CONSTRAINT `fk_domain_complex` FOREIGN KEY (`complex_id`) REFERENCES `complex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiment`
--

DROP TABLE IF EXISTS `experiment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(128) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `user` varchar(128) DEFAULT NULL COMMENT 'Creator user id, e.g. email address',
  PRIMARY KEY (`id`),
  KEY `idx_label` (`label`),
  KEY `idx_user` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interaction`
--

DROP TABLE IF EXISTS `interaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interaction` (
  `id` int(11) NOT NULL,
  `complex_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`complex_id`),
  KEY `fk_interaction_complex` (`complex_id`),
  CONSTRAINT `fk_interaction_complex` FOREIGN KEY (`complex_id`) REFERENCES `complex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interaction_domain`
--

DROP TABLE IF EXISTS `interaction_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interaction_domain` (
  `interaction_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `complex_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`interaction_id`,`domain_id`,`complex_id`),
  KEY `fk_interaction` (`interaction_id`),
  KEY `fk_domain` (`domain_id`,`complex_id`),
  CONSTRAINT `fk_domain` FOREIGN KEY (`domain_id`, `complex_id`) REFERENCES `domain` (`id`, `complex_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_interaction` FOREIGN KEY (`interaction_id`) REFERENCES `interaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `network`
--

DROP TABLE IF EXISTS `network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `target_id` int(10) unsigned NOT NULL,
  `partition` int(2) unsigned zerofill NOT NULL,
  `nnodes` int(10) unsigned DEFAULT NULL,
  `ninteractions` int(10) unsigned DEFAULT NULL,
  `nedges` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`target_id`),
  KEY `fk_network_target` (`target_id`),
  CONSTRAINT `fk_network_target` FOREIGN KEY (`target_id`) REFERENCES `target` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(128) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `experiment_id` int(10) unsigned NOT NULL,
  `ndomains` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`experiment_id`),
  KEY `fk_target_experiment` (`experiment_id`),
  CONSTRAINT `fk_target_experiment` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1281 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-29 18:35:29
