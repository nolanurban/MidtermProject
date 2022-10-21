-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clubindexdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clubindexdb` ;

-- -----------------------------------------------------
-- Schema clubindexdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clubindexdb` DEFAULT CHARACTER SET utf8 ;
USE `clubindexdb` ;

-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `zip_code` INT NOT NULL,
  `street` VARCHAR(45) NULL,
  `unit` VARCHAR(45) NULL,
  `state_abbr` CHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile_pic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile_pic` ;

CREATE TABLE IF NOT EXISTS `profile_pic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `URL` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `first_name` VARCHAR(45) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `location_id` INT NULL,
  `profile_pic_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_name_UNIQUE` (`username` ASC),
  INDEX `fk_user_location1_idx` (`location_id` ASC),
  INDEX `fk_user_profile_pic1_idx` (`profile_pic_id` ASC),
  CONSTRAINT `fk_user_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_profile_pic1`
    FOREIGN KEY (`profile_pic_id`)
    REFERENCES `profile_pic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `isbn` VARCHAR(20) NOT NULL,
  `publish_year` VARCHAR(45) NULL,
  `pages` INT NULL,
  `title` VARCHAR(45) NOT NULL,
  `language_id` INT NULL,
  PRIMARY KEY (`isbn`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC),
  INDEX `fk_book_language1_idx` (`language_id` ASC),
  CONSTRAINT `fk_book_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author` ;

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `biography` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre` ;

CREATE TABLE IF NOT EXISTS `genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reading_list` ;

CREATE TABLE IF NOT EXISTS `reading_list` (
  `id` INT NOT NULL,
  `rating` INT(1) NOT NULL,
  `review` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club` ;

CREATE TABLE IF NOT EXISTS `book_club` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner` VARCHAR(45) NOT NULL,
  `max_members` INT NULL,
  `create_date` DATE NULL,
  `digital` TINYINT NOT NULL,
  `profile_pic_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_club_profile_pic1_idx` (`profile_pic_id` ASC),
  CONSTRAINT `fk_book_club_profile_pic1`
    FOREIGN KEY (`profile_pic_id`)
    REFERENCES `profile_pic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author_genre` ;

CREATE TABLE IF NOT EXISTS `author_genre` (
  `author_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`author_id`, `genre_id`),
  INDEX `fk_author_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_author_has_genre_author_idx` (`author_id` ASC),
  CONSTRAINT `fk_author_has_genre_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_author_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author_book` ;

CREATE TABLE IF NOT EXISTS `author_book` (
  `author_id` INT NOT NULL,
  `book_isbn` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`author_id`, `book_isbn`),
  INDEX `fk_author_has_book_book1_idx` (`book_isbn` ASC),
  INDEX `fk_author_has_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_author_has_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_author_has_book_book1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_reading_list` ;

CREATE TABLE IF NOT EXISTS `user_reading_list` (
  `user_id` INT NOT NULL,
  `reading_list_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `reading_list_id`),
  INDEX `fk_user_has_reading_list_reading_list1_idx` (`reading_list_id` ASC),
  INDEX `fk_user_has_reading_list_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_reading_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_reading_list_reading_list1`
    FOREIGN KEY (`reading_list_id`)
    REFERENCES `reading_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_club_reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club_reading_list` ;

CREATE TABLE IF NOT EXISTS `book_club_reading_list` (
  `reading_list_id` INT NOT NULL,
  `book_club_id` INT NOT NULL,
  PRIMARY KEY (`reading_list_id`, `book_club_id`),
  INDEX `fk_reading_list_has_book_club_book_club1_idx` (`book_club_id` ASC),
  INDEX `fk_reading_list_has_book_club_reading_list1_idx` (`reading_list_id` ASC),
  CONSTRAINT `fk_reading_list_has_book_club_reading_list1`
    FOREIGN KEY (`reading_list_id`)
    REFERENCES `reading_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reading_list_has_book_club_book_club1`
    FOREIGN KEY (`book_club_id`)
    REFERENCES `book_club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_club_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club_members` ;

CREATE TABLE IF NOT EXISTS `book_club_members` (
  `book_club_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`book_club_id`, `user_id`),
  INDEX `fk_book_club_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_book_club_has_user_book_club1_idx` (`book_club_id` ASC),
  CONSTRAINT `fk_book_club_has_user_book_club1`
    FOREIGN KEY (`book_club_id`)
    REFERENCES `book_club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_club_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_club_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club_has_genre` ;

CREATE TABLE IF NOT EXISTS `book_club_has_genre` (
  `book_club_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_club_id`, `genre_id`),
  INDEX `fk_book_club_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_book_club_has_genre_book_club1_idx` (`book_club_id` ASC),
  CONSTRAINT `fk_book_club_has_genre_book_club1`
    FOREIGN KEY (`book_club_id`)
    REFERENCES `book_club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_club_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS clubindexdb@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'clubindexdb'@'localhost' IDENTIFIED BY 'clubindexdb';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'clubindexdb'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user` (`first_name`, `id`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_pic_id`) VALUES ('ash', 1, 'ozz', 'ashozz', 'ashley@abc.com', 'abc', NULL, NULL, NULL, NULL);

COMMIT;

