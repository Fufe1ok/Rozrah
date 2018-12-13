SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `kursach` ;

CREATE SCHEMA IF NOT EXISTS `kursach` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `kursach` ;

DROP TABLE IF EXISTS `kursach`.`sport_school` ;
CREATE TABLE IF NOT EXISTS `kursach`.`sport_school` (
  `idSport_school` INT(11) NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSport_school`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`circlet` ;
CREATE TABLE IF NOT EXISTS `kursach`.`circlet` (
  `idCirclet` INT(11) NOT NULL AUTO_INCREMENT,
  `circle_name` VARCHAR(45) NULL DEFAULT NULL,
  `street` VARCHAR(45) NULL DEFAULT NULL,
  `house_number` INT(11) NOT NULL,
  `max_child_number` INT(11) NOT NULL,
  `coach_idcoach` INT(11) NOT NULL,
  `sport_school_idSport_school` INT(11) NOT NULL,
  PRIMARY KEY (`idCirclet`, `coach_idcoach`, `sport_school_idSport_school`),
  INDEX `fk_circlet_sport_school1_idx` (`sport_school_idSport_school` ASC),
  CONSTRAINT `fk_circlet_sport_school1`
    FOREIGN KEY (`sport_school_idSport_school`)
    REFERENCES `kursach`.`sport_school` (`idSport_school`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`coach` ;
CREATE TABLE IF NOT EXISTS `kursach`.`coach` (
  `idcoach` INT(11) NOT NULL AUTO_INCREMENT,
  `coach_name` VARCHAR(45) NULL DEFAULT NULL,
  `coach_surname` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `sport_school_idSport_school` INT(11) NOT NULL,
  PRIMARY KEY (`idcoach`, `sport_school_idSport_school`),
  INDEX `fk_coach_sport_school1_idx` (`sport_school_idSport_school` ASC),
  CONSTRAINT `fk_coach_sport_school1`
    FOREIGN KEY (`sport_school_idSport_school`)
    REFERENCES `kursach`.`sport_school` (`idSport_school`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `kursach`.`schedule` ;
CREATE TABLE IF NOT EXISTS `kursach`.`schedule` (
  `idSchedule` INT(11) NOT NULL AUTO_INCREMENT,
  `schedule_content` VARCHAR(245) NULL DEFAULT NULL,
  PRIMARY KEY (`idSchedule`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`group` ;
CREATE TABLE IF NOT EXISTS `kursach`.`group` (
  `idGroup` INT(11) NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(45) NULL DEFAULT NULL,
  `start_date` DATETIME NULL DEFAULT NULL,
  `end_date` DATETIME NULL DEFAULT NULL,
  `circlet_idCirclet` INT(11) NOT NULL,
  `circlet_coach_idcoach` INT(11) NOT NULL,
  `circlet_sport_school_idSport_school` INT(11) NOT NULL,
  `schedule_idSchedule` INT(11) NOT NULL,
  PRIMARY KEY (`idGroup`, `circlet_idCirclet`, `circlet_coach_idcoach`, `circlet_sport_school_idSport_school`, `schedule_idSchedule`),
  INDEX `fk_group_circlet1_idx` (`circlet_idCirclet` ASC, `circlet_coach_idcoach` ASC, `circlet_sport_school_idSport_school` ASC),
  INDEX `fk_group_schedule1_idx` (`schedule_idSchedule` ASC),
  CONSTRAINT `fk_group_circlet1`
    FOREIGN KEY (`circlet_idCirclet` , `circlet_coach_idcoach` , `circlet_sport_school_idSport_school`)
    REFERENCES `kursach`.`circlet` (`idCirclet` , `coach_idcoach` , `sport_school_idSport_school`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_schedule1`
    FOREIGN KEY (`schedule_idSchedule`)
    REFERENCES `kursach`.`schedule` (`idSchedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`lesson` ;
CREATE TABLE IF NOT EXISTS `kursach`.`lesson` (
  `idLesson` INT(11) NOT NULL AUTO_INCREMENT,
  `circlet_id` INT(11) NULL DEFAULT NULL,
  `start_time` DATE NULL DEFAULT NULL,
  `duration` DATE NULL DEFAULT NULL,
  `schedule_idSchedule` INT(11) NOT NULL,
  PRIMARY KEY (`idLesson`, `schedule_idSchedule`),
  INDEX `fk_lesson_schedule1_idx` (`schedule_idSchedule` ASC),
  CONSTRAINT `fk_lesson_schedule1`
    FOREIGN KEY (`schedule_idSchedule`)
    REFERENCES `kursach`.`schedule` (`idSchedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`participant` ;
CREATE TABLE IF NOT EXISTS `kursach`.`participant` (
  `idParticipants` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `group_idGroup` INT(11) NOT NULL,
  `group_circlet_idCirclet` INT(11) NOT NULL,
  `group_circlet_coach_idcoach` INT(11) NOT NULL,
  `group_circlet_sport_school_idSport_school` INT(11) NOT NULL,
  `group_schedule_idSchedule` INT(11) NOT NULL,
  PRIMARY KEY (`idParticipants`, `group_idGroup`, `group_circlet_idCirclet`, `group_circlet_coach_idcoach`, `group_circlet_sport_school_idSport_school`, `group_schedule_idSchedule`),
  INDEX `fk_participant_group1_idx` (`group_idGroup` ASC, `group_circlet_idCirclet` ASC, `group_circlet_coach_idcoach` ASC, `group_circlet_sport_school_idSport_school` ASC, `group_schedule_idSchedule` ASC),
  CONSTRAINT `fk_participant_group1`
    FOREIGN KEY (`group_idGroup` , `group_circlet_idCirclet` , `group_circlet_coach_idcoach` , `group_circlet_sport_school_idSport_school` , `group_schedule_idSchedule`)
    REFERENCES `kursach`.`group` (`idGroup` , `circlet_idCirclet` , `circlet_coach_idcoach` , `circlet_sport_school_idSport_school` , `schedule_idSchedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `kursach`.`coach_has_circlet` ;

CREATE TABLE IF NOT EXISTS `kursach`.`coach_has_circlet` (
  `coach_idcoach` INT(11) NOT NULL,
  `circlet_idCirclet` INT(11) NOT NULL,
  `circlet_coach_idcoach` INT(11) NOT NULL,
  PRIMARY KEY (`coach_idcoach`, `circlet_idCirclet`, `circlet_coach_idcoach`),
  INDEX `fk_coach_has_circlet_circlet1_idx` (`circlet_idCirclet` ASC, `circlet_coach_idcoach` ASC),
  INDEX `fk_coach_has_circlet_coach_idx` (`coach_idcoach` ASC),
  CONSTRAINT `fk_coach_has_circlet_coach`
    FOREIGN KEY (`coach_idcoach`)
    REFERENCES `kursach`.`coach` (`idcoach`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coach_has_circlet_circlet1`
    FOREIGN KEY (`circlet_idCirclet` , `circlet_coach_idcoach`)
    REFERENCES `kursach`.`circlet` (`idCirclet` , `coach_idcoach`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
