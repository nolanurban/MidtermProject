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
  `state` VARCHAR(250) NULL,
  `city` VARCHAR(250) NULL,
  `zip_code` VARCHAR(20) NOT NULL,
  `street` VARCHAR(250) NULL,
  `unit` VARCHAR(250) NULL,
  `state_abbr` CHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(250) NOT NULL,
  `last_name` VARCHAR(250) NOT NULL,
  `username` VARCHAR(250) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(250) NULL,
  `location_id` INT NULL,
  `profile_url` TEXT NULL,
  `about_me` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_name_UNIQUE` (`username` ASC),
  INDEX `fk_user_location1_idx` (`location_id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  CONSTRAINT `fk_user_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `isbn` VARCHAR(30) NOT NULL,
  `publish_year` INT NOT NULL,
  `pages` INT NULL,
  `title` VARCHAR(500) NOT NULL,
  `language_id` INT NOT NULL,
  `description` TEXT NOT NULL,
  `cover_url` TEXT NULL,
  PRIMARY KEY (`isbn`),
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
  `first_name` VARCHAR(250) NOT NULL,
  `last_name` VARCHAR(250) NOT NULL,
  `biography` TEXT NULL,
  `websiter_url` TEXT NULL,
  `headshot_url` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre` ;

CREATE TABLE IF NOT EXISTS `genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club` ;

CREATE TABLE IF NOT EXISTS `book_club` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `max_members` INT NULL,
  `create_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `digital` TINYINT NOT NULL,
  `owner_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  `profile_url` TEXT NULL,
  `about_club` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_club_user1_idx` (`owner_id` ASC),
  INDEX `fk_book_club_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_book_club_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_club_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reading_list` ;

CREATE TABLE IF NOT EXISTS `reading_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `user_id` INT NOT NULL,
  `book_club_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reading_list_user1_idx` (`user_id` ASC),
  INDEX `fk_reading_list_book_club1_idx` (`book_club_id` ASC),
  CONSTRAINT `fk_reading_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reading_list_book_club1`
    FOREIGN KEY (`book_club_id`)
    REFERENCES `book_club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author_book` ;

CREATE TABLE IF NOT EXISTS `author_book` (
  `author_id` INT NOT NULL,
  `book_isbn` VARCHAR(30) NOT NULL,
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
-- Table `book_club_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_club_genre` ;

CREATE TABLE IF NOT EXISTS `book_club_genre` (
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


-- -----------------------------------------------------
-- Table `book_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_genre` ;

CREATE TABLE IF NOT EXISTS `book_genre` (
  `book_isbn` VARCHAR(30) NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_isbn`, `genre_id`),
  INDEX `fk_book_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_book_has_genre_book1_idx` (`book_isbn` ASC),
  CONSTRAINT `fk_book_has_genre_book1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `review` TEXT NULL,
  `rating` INT(1) NOT NULL,
  `user_id` INT NOT NULL,
  `book_isbn` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  INDEX `fk_review_book1_idx` (`book_isbn` ASC),
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_book1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_list` ;

CREATE TABLE IF NOT EXISTS `book_list` (
  `book_isbn` VARCHAR(30) NOT NULL,
  `reading_list_id` INT NOT NULL,
  PRIMARY KEY (`book_isbn`, `reading_list_id`),
  INDEX `fk_book_has_reading_list_reading_list1_idx` (`reading_list_id` ASC),
  INDEX `fk_book_has_reading_list_book1_idx` (`book_isbn` ASC),
  CONSTRAINT `fk_book_has_reading_list_book1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_reading_list_reading_list1`
    FOREIGN KEY (`reading_list_id`)
    REFERENCES `reading_list` (`id`)
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
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (1, 'Texas', 'aledo', '76008', NULL, NULL, 'TX');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (1, 'ash', 'ozz', 'ashozz', 'ashley@abc.com', 'abc', NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `language` (`id`, `name`) VALUES (1, 'English');
INSERT INTO `language` (`id`, `name`) VALUES (2, 'French');
INSERT INTO `language` (`id`, `name`) VALUES (3, 'Spanish');
INSERT INTO `language` (`id`, `name`) VALUES (4, 'Japanese');
INSERT INTO `language` (`id`, `name`) VALUES (5, 'German');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0312932081', 1985, 324, 'Ender\'s Game', 1, 'Book about a game thats actually the fate of world.', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (1, 'Orson', 'Card', 'A guy', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (1, 'Science-Fiction', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`) VALUES (1, 35, '2022-10-21 11:34:10', 1, 1, 1, NULL, 'Scifi nerds');

COMMIT;


-- -----------------------------------------------------
-- Data for table `reading_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `reading_list` (`id`, `name`, `user_id`, `book_club_id`) VALUES (1, 'scifi', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0312932081', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (1, 'Great book. Socially did not age well.', 4, 1, '0312932081');

COMMIT;

