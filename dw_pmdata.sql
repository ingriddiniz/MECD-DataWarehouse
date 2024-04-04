-- MySQL Script generated by MySQL Workbench
-- Wed Mar 27 21:38:13 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dw_pmdata
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dw_pmdata
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_pmdata` DEFAULT CHARACTER SET utf8 ;
USE `dw_pmdata` ;

-- -----------------------------------------------------
-- Table `dw_pmdata`.`participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`participant` (
  `participant_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(5) NULL,
  `age` INT NULL,
  `height` FLOAT NULL,
  `gender` VARCHAR(20) NULL,
  `group` VARCHAR(1) NULL,
  PRIMARY KEY (`participant_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`date` (
  `day_id` INT NOT NULL AUTO_INCREMENT,
  `date` VARCHAR(20) NULL,  
  `day` INT NULL,
  `month_id` INT NULL,
  `month` INT NULL,
  `month_name` VARCHAR(20) NULL,
  `year_id` INT NULL,
  `year` INT NULL,
  PRIMARY KEY (`day_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`daily`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`daily` (
  `participant_id` INT NOT NULL,
  `day_id` INT NOT NULL,
  `sedentary_minutes` INT NULL,
  `light_active_minutes` VARCHAR(45) NULL,
  `mod_active_minutes` VARCHAR(45) NULL,
  `very_active_minutes` VARCHAR(45) NULL,
  `fluid_glasses` VARCHAR(45) NULL,
  `weight` FLOAT NULL,
  `steps` INT NULL,
  `calories` FLOAT NULL,
  `consumed_alcohol` TINYINT NULL,
  INDEX `fk_daily_participant_idx` (`participant_id` ASC) VISIBLE,
  PRIMARY KEY (`participant_id`, `day_id`),
  INDEX `fk_daily_date_idx` (`day_id` ASC) INVISIBLE,
  CONSTRAINT `fk_daily_participant`
    FOREIGN KEY (`participant_id`)
    REFERENCES `dw_pmdata`.`participant` (`participant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_daily_date`
    FOREIGN KEY (`day_id`)
    REFERENCES `dw_pmdata`.`date` (`day_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`activity` (
  `activity_id` INT NOT NULL AUTO_INCREMENT,
  `code` INT NULL,
  `name` VARCHAR(20) NULL,
  `level` VARCHAR(20) NULL,
  PRIMARY KEY (`activity_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`heart_rate_zone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`heart_rate_zone` (
  `heart_rate_zone_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL,
  PRIMARY KEY (`heart_rate_zone_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`sleep_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`sleep_type` (
  `sleep_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL,
  `level` VARCHAR(20) NULL,
  PRIMARY KEY (`sleep_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`sleep_bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`sleep_bridge` (
  `sleep_bridge_id` INT NOT NULL,
  `sleep_type_id` INT NOT NULL,
  `weight` FLOAT NULL,
  INDEX `fk_sleep_bridge_sleep_type_idx` (`sleep_type_id` ASC) VISIBLE,
  PRIMARY KEY (`sleep_bridge_id`, `sleep_type_id`),
  CONSTRAINT `fk_sleep_bridge_sleep_type`
    FOREIGN KEY (`sleep_type_id`)
    REFERENCES `dw_pmdata`.`sleep_type` (`sleep_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`instant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`instant` (
  `minute_id` INT NOT NULL AUTO_INCREMENT,
  `minute` INT NULL,
  `hour_id` INT NULL,
  `hour` INT NULL,
  `period` VARCHAR(20) NULL,
  PRIMARY KEY (`minute_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`sleep`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`sleep` (
  `participant_id` INT NOT NULL,
  `minute_id` INT NOT NULL,
  `day_id` INT NOT NULL,
  `sleep_bridge_id` INT NOT NULL,
  `duration` INT NULL,
  `min_to_fall_asleep` INT NULL,
  `min_awake` INT NULL,
  `min_asleep` INT NULL,
  `efficiency` INT NULL,
  `is_main` TINYINT NULL,
  INDEX `fk_sleep_participant_idx` (`participant_id` ASC) VISIBLE,
  PRIMARY KEY (`participant_id`, `minute_id`, `day_id`, `sleep_bridge_id`),
  INDEX `fk_sleep_sleep_bridge_idx` (`sleep_bridge_id` ASC) VISIBLE,
  INDEX `fk_sleep_instant_idx` (`minute_id` ASC) VISIBLE,
  INDEX `fk_sleep_date_idx` (`day_id` ASC) VISIBLE,
  CONSTRAINT `fk_sleep_participant`
    FOREIGN KEY (`participant_id`)
    REFERENCES `dw_pmdata`.`participant` (`participant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sleep_sleep_bridge`
    FOREIGN KEY (`sleep_bridge_id`)
    REFERENCES `dw_pmdata`.`sleep_bridge` (`sleep_bridge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sleep_instant`
    FOREIGN KEY (`minute_id`)
    REFERENCES `dw_pmdata`.`instant` (`minute_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sleep_date`
    FOREIGN KEY (`day_id`)
    REFERENCES `dw_pmdata`.`date` (`day_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`activity_bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`activity_bridge` (
  `activity_bridge_id` INT NOT NULL,
  `activity_id` INT NOT NULL,
  `weight` FLOAT NULL,
  PRIMARY KEY (`activity_bridge_id`, `activity_id`),
  INDEX `fk_activity_bridge_activity_idx` (`activity_id` ASC) VISIBLE,
  CONSTRAINT `fk_activity_bridge_activity`
    FOREIGN KEY (`activity_id`)
    REFERENCES `dw_pmdata`.`activity` (`activity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`heart_rate_zone_bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`heart_rate_zone_bridge` (
  `heart_rate_zone_bridge_id` INT NOT NULL,
  `heart_rate_zone_id` INT NOT NULL,
  `weight` FLOAT NULL,
  PRIMARY KEY (`heart_rate_zone_bridge_id`, `heart_rate_zone_id`),
  INDEX `fk_heart_rate_zone_bridge_heart_rate_zone_idx` (`heart_rate_zone_id` ASC) VISIBLE,
  CONSTRAINT `fk_heart_rate_zone_bridge_heart_rate_zone`
    FOREIGN KEY (`heart_rate_zone_id`)
    REFERENCES `dw_pmdata`.`heart_rate_zone` (`heart_rate_zone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_pmdata`.`exercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_pmdata`.`exercise` (
  `exercise_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `participant_id` INT NOT NULL,
  `heart_rate_zone_bridge_id` INT,
  `day_id` INT,
  `minute_id` INT,
  `activity_bridge_id` INT,
  `duration` INT NULL,
  `calories` FLOAT NULL,
  `steps` INT NULL,
  `elevation_gain` FLOAT NULL,
  `avg_heart_rate` FLOAT NULL,
  INDEX `fk_exercise_participant_idx` (`participant_id` ASC) VISIBLE,
  INDEX `fk_exercise_activity_bridge_idx` (`activity_bridge_id` ASC) VISIBLE,
  INDEX `fk_exercise_heart_rate_zone_bridge_idx` (`heart_rate_zone_bridge_id` ASC) VISIBLE,
  INDEX `fk_exercise_instant_idx` (`minute_id` ASC) VISIBLE,
  INDEX `fk_exercise_date_idx` (`day_id` ASC) VISIBLE,
  CONSTRAINT `fk_exercise_participant`
    FOREIGN KEY (`participant_id`)
    REFERENCES `dw_pmdata`.`participant` (`participant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exercise_activity_bridge`
    FOREIGN KEY (`activity_bridge_id`)
    REFERENCES `dw_pmdata`.`activity_bridge` (`activity_bridge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exercise_heart_rate_zone_bridge`
    FOREIGN KEY (`heart_rate_zone_bridge_id`)
    REFERENCES `dw_pmdata`.`heart_rate_zone_bridge` (`heart_rate_zone_bridge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exercise_instant`
    FOREIGN KEY (`minute_id`)
    REFERENCES `dw_pmdata`.`instant` (`minute_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exercise_date`
    FOREIGN KEY (`day_id`)
    REFERENCES `dw_pmdata`.`date` (`day_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
