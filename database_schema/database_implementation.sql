-- MySQL Script generated by MySQL Workbench
-- 11/18/15 10:49:19
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema txstexe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema txstexe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `txstexe` DEFAULT CHARACTER SET utf8 ;
USE `txstexe` ;

-- -----------------------------------------------------
-- Table `txstexe`.`Club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Club` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Club` (
  `club_name` VARCHAR(20) NOT NULL,
  `contact_email` VARCHAR(20) NULL DEFAULT NULL,
  `building` VARCHAR(20) NULL DEFAULT NULL,
  `room` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`club_name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `txstexe`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Member` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Member` (
  `member_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `fname` VARCHAR(25) NULL DEFAULT NULL,
  `mi` VARCHAR(1) NULL DEFAULT NULL,
  `lname` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `major` VARCHAR(25) NULL DEFAULT NULL,
  `class` VARCHAR(10) NULL DEFAULT NULL,
  `grad_date` DATE NULL DEFAULT NULL,
  `tshirt_size` VARCHAR(6) NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  CONSTRAINT `club_name`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Officer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Officer` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Officer` (
  `officer_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `date_elected` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`officer_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  INDEX `member_id_idx` (`member_id` ASC) ,
  CONSTRAINT `club_name_officer`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id_officer`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Donation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Donation` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Donation` (
  `donation_id` BIGINT(20) NOT NULL,
  `donor_id` BIGINT(20) NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`donation_id`) ,
  INDEX `donor_id_idx` (`donor_id` ASC) ,
  CONSTRAINT `donor_id`
    FOREIGN KEY (`donor_id`)
    REFERENCES `txstexe`.`Donor` (`donor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Donor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Donor` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Donor` (
  `donor_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `donation_id` BIGINT(20) NULL DEFAULT NULL,
  `fname` VARCHAR(25) NULL DEFAULT NULL,
  `mi` VARCHAR(1) NULL DEFAULT NULL,
  `lname` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`donor_id`) ,
  INDEX `donation_id_idx` (`donation_id` ASC) ,
  CONSTRAINT `donation_id_fk`
    FOREIGN KEY (`donation_id`)
    REFERENCES `txstexe`.`Donation` (`donation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Blog` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Blog` (
  `blog` VARCHAR(20) NOT NULL,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `officer_id` BIGINT(20) NULL DEFAULT NULL,
  `datetime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`blog`) ,
  INDEX `officer_id_idx` (`officer_id` ASC) ,
  UNIQUE INDEX `club_name_UNIQUE` (`club_name` ASC) ,
  CONSTRAINT `officer_id`
    FOREIGN KEY (`officer_id`)
    REFERENCES `txstexe`.`Officer` (`officer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `club_name_blog`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Officer` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`MailingList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`MailingList` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`MailingList` (
  `mail_list_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `mail_list_name` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`mail_list_id`) ,
  INDEX `member_id_idx` (`member_id` ASC) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  CONSTRAINT `club_name_ml`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id_ml`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Event` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Event` (
  `event_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `event_name` VARCHAR(50) NULL DEFAULT NULL,
  `event_type` VARCHAR(50) NULL DEFAULT NULL,
  `building` VARCHAR(25) NULL DEFAULT NULL,
  `room` VARCHAR(10) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `time` TIME NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  CONSTRAINT `club_name_oncampusevent`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Credential`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Credential` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Credential` (
  `credential_id` BIGINT(20) NOT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`credential_id`) ,
  INDEX `member` (`member_id` ASC) ,
  CONSTRAINT `member`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Signup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Signup` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Signup` (
  `signup_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `event_id` BIGINT(20) NULL DEFAULT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `points` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`signup_id`) ,
  INDEX `oncampusevent_id_idx` (`event_id` ASC) ,
  INDEX `member_id_idx` (`member_id` ASC) ,
  CONSTRAINT `event_id`
    FOREIGN KEY (`event_id`)
    REFERENCES `txstexe`.`Event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id_event`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`ProjectGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`ProjectGroup` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`ProjectGroup` (
  `proj_group_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `proj_lead_id` BIGINT(20) NULL DEFAULT NULL,
  `building` VARCHAR(25) NULL DEFAULT NULL,
  `room` VARCHAR(10) NULL DEFAULT NULL,
  `datetime` DATETIME NULL DEFAULT NULL,
  `description` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`proj_group_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  INDEX `member_id_idx` (`member_id` ASC) ,
  CONSTRAINT `club_name_projectgroup`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id_projectgroup`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Forum` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Forum` (
  `forum_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `forum_name` VARCHAR(25) NOT NULL,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`forum_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  CONSTRAINT `club_name_forum`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Topic` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Topic` (
  `topic_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `forum_id` BIGINT(20) NULL DEFAULT NULL,
  `topic_name` VARCHAR(45) NULL DEFAULT NULL,
  `topic_description` MEDIUMTEXT NULL DEFAULT NULL,
  `datetime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`topic_id`) ,
  INDEX `forum_name_idx` (`forum_id` ASC) ,
  CONSTRAINT `forum_id`
    FOREIGN KEY (`forum_id`)
    REFERENCES `txstexe`.`Forum` (`forum_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Thread`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Thread` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Thread` (
  `thread_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `thread_name` VARCHAR(45) NULL,
  `topic_id` BIGINT(20) NULL,
  `thread_op` VARCHAR(45) NULL,
  `datetime` DATETIME NULL,
  PRIMARY KEY (`thread_id`) ,
  INDEX `topic_name_idx` (`topic_id` ASC) ,
  CONSTRAINT `topic_id`
    FOREIGN KEY (`topic_id`)
    REFERENCES `txstexe`.`Topic` (`topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `txstexe`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Comment` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Comment` (
  `comment_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `thread_id` BIGINT(20) NULL DEFAULT NULL,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `comment` MEDIUMTEXT NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `time` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) ,
  INDEX `member_id_idx` (`member_id` ASC) ,
  INDEX `thread_id_idx` (`thread_id` ASC) ,
  CONSTRAINT `thread_id`
    FOREIGN KEY (`thread_id`)
    REFERENCES `txstexe`.`Thread` (`thread_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id_comment`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`News`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`News` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`News` (
  `news_item_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(20) NULL DEFAULT NULL,
  `news_item` MEDIUMTEXT NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `time` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`news_item_id`) ,
  INDEX `club_name_idx` (`club_name` ASC) ,
  CONSTRAINT `club_name_news`
    FOREIGN KEY (`club_name`)
    REFERENCES `txstexe`.`Club` (`club_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `txstexe`.`Points`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `txstexe`.`Points` ;

CREATE TABLE IF NOT EXISTS `txstexe`.`Points` (
  `points_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `member_id` BIGINT(20) NULL DEFAULT NULL,
  `points_earned` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`points_id`) ,
  INDEX `points_member_id_idx` (`member_id` ASC) ,
  CONSTRAINT `points_member_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `txstexe`.`Member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
