/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- DROP SCHEMA IF EXISTS `aca` ;
CREATE SCHEMA IF NOT EXISTS `aca` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `aca` ;

-- -----------------------------------------------------
-- Table `aca`.`experiment`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`experiment` ;

CREATE  TABLE IF NOT EXISTS `aca`.`experiment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(128) NULL ,
  `date` DATETIME NULL ,
  `user` VARCHAR(128) NULL COMMENT 'Creator user id, e.g. email address' ,
  PRIMARY KEY (`id`) ,
  INDEX `idx_label` (`label` ASC) ,
  INDEX `idx_user` (`user` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`target`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`target` ;

CREATE  TABLE IF NOT EXISTS `aca`.`target` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(128) NULL ,
  `description` VARCHAR(1024) NULL ,
  `experiment_id` INT UNSIGNED NOT NULL ,
  `ndomains` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`, `experiment_id`) ,
  INDEX `fk_target_experiment` (`experiment_id` ASC) ,
  CONSTRAINT `fk_target_experiment`
    FOREIGN KEY (`experiment_id` )
    REFERENCES `aca`.`experiment` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`network`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`network` ;

CREATE  TABLE IF NOT EXISTS `aca`.`network` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `target_id` INT UNSIGNED NOT NULL ,
  `partition` SMALLINT ZEROFILL UNSIGNED NOT NULL ,
  `nnodes` INT UNSIGNED NULL ,
  `ninteractions` INT UNSIGNED NULL ,
  `nedges` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`, `target_id`) ,
  INDEX `fk_network_target` (`target_id` ASC) ,
  CONSTRAINT `fk_network_target`
    FOREIGN KEY (`target_id` )
    REFERENCES `aca`.`target` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`complex`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`complex` ;

CREATE  TABLE IF NOT EXISTS `aca`.`complex` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `model` INT(2) ZEROFILL UNSIGNED NOT NULL ,
  `network_id` INT UNSIGNED NOT NULL ,
  `score` FLOAT NULL ,
  `nreplaced` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `path` VARCHAR(1024) NULL ,
  PRIMARY KEY (`id`, `network_id`) ,
  INDEX `fk_complex_network1` (`network_id` ASC) ,
  CONSTRAINT `fk_complex_network1`
    FOREIGN KEY (`network_id` )
    REFERENCES `aca`.`network` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`domain`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`domain` ;

CREATE  TABLE IF NOT EXISTS `aca`.`domain` (
  `id` INT NOT NULL ,
  `complex_id` INT UNSIGNED NOT NULL ,
  `name` VARCHAR(128) NULL ,
  `acc` VARCHAR(45) NULL ,
  `template` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`, `complex_id`) ,
  INDEX `fk_domain_complex` (`complex_id` ASC) ,
  CONSTRAINT `fk_domain_complex`
    FOREIGN KEY (`complex_id` )
    REFERENCES `aca`.`complex` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`interaction`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`interaction` ;

CREATE  TABLE IF NOT EXISTS `aca`.`interaction` (
  `id` INT NOT NULL ,
  `complex_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`, `complex_id`) ,
  INDEX `fk_interaction_complex` (`complex_id` ASC) ,
  CONSTRAINT `fk_interaction_complex`
    FOREIGN KEY (`complex_id` )
    REFERENCES `aca`.`complex` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aca`.`interaction_domain`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `aca`.`interaction_domain` ;

CREATE  TABLE IF NOT EXISTS `aca`.`interaction_domain` (
  `interaction_id` INT NOT NULL ,
  `domain_id` INT NOT NULL ,
  `complex_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`interaction_id`, `domain_id`, `complex_id`) ,
  INDEX `fk_interaction` (`interaction_id` ASC) ,
  INDEX `fk_domain` (`domain_id` ASC, `complex_id` ASC) ,
  CONSTRAINT `fk_interaction`
    FOREIGN KEY (`interaction_id` )
    REFERENCES `aca`.`interaction` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_domain`
    FOREIGN KEY (`domain_id` , `complex_id` )
    REFERENCES `aca`.`domain` (`id` , `complex_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

