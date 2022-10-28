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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_reading_list` ;

CREATE TABLE IF NOT EXISTS `user_reading_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reading_list_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_reading_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `name` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_club_user1_idx` (`owner_id` ASC),
  INDEX `fk_book_club_location1_idx` (`location_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
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
-- Table `user_book_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_book_list` ;

CREATE TABLE IF NOT EXISTS `user_book_list` (
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
    REFERENCES `user_reading_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookclub_reading_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookclub_reading_list` ;

CREATE TABLE IF NOT EXISTS `bookclub_reading_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `book_club_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookclub_reading_list_book_club1_idx` (`book_club_id` ASC),
  CONSTRAINT `fk_bookclub_reading_list_book_club1`
    FOREIGN KEY (`book_club_id`)
    REFERENCES `book_club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookclub_book_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookclub_book_list` ;

CREATE TABLE IF NOT EXISTS `bookclub_book_list` (
  `book_isbn` VARCHAR(30) NOT NULL,
  `bookclub_reading_list_id` INT NOT NULL,
  PRIMARY KEY (`book_isbn`, `bookclub_reading_list_id`),
  INDEX `fk_book_has_reading_list_book1_idx` (`book_isbn` ASC),
  INDEX `fk_bookclub_book_list_bookclub_reading_list1_idx` (`bookclub_reading_list_id` ASC),
  CONSTRAINT `fk_book_has_reading_list_book10`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookclub_book_list_bookclub_reading_list1`
    FOREIGN KEY (`bookclub_reading_list_id`)
    REFERENCES `bookclub_reading_list` (`id`)
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
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (1, 'Texas', 'aledo', '76008', '15 Golden Drive', '467', 'TX');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (2, 'Wisconsin', 'Pulaski', '54162', '8 Cold Blvd', '821', 'WI');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (3, 'Iowa', 'North Liberty', '52317', '52 Corn Way', '325', 'IA');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (4, 'Texas', 'Fort Worth ', '76006', '98 Cattle Drive', '67', 'TX');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (5, 'Texas', 'Fort Worth ', '76008', '123 Uptown Drive', NULL, 'TX');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (6, 'Wisconsin', 'Pulaski', '54162', '512 Cheese St.', '34', 'WI');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (7, 'Wisconsin', 'Pulaski', '54162', '8 Beer Blvd', '9', 'WI');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (8, 'Iowa', 'North Liberty', '52317', '9 HomeTown street', '1A', 'IA');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (9, 'Iowa', 'North Liberty ', '52317', '7 DeerSlope Drive', NULL, 'IA');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (10, 'Colorado', 'Denver', '80014', 'Main Street', '12', 'CO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (1, 'ash', 'ozz', 'ashozz', 'ashley@abc.com', 'abc', NULL, 'owner and member', 1, 'https://static.simpsonswiki.com/images/5/51/Google.png', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (2, 'tyler', 'tanner', 'dopeyboy', 'tylert123@abc.com', 'abc', NULL, 'owner and member', 2, 'https://img.women.com/images/images/000/019/251/large/Screen_Shot_2016-04-20_at_5.17.36_PM.png?1461198403', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (3, 'Nolan', 'Urban', 'dadjokes', 'dadjokes@abc.com', 'abc', NULL, 'owner and member', 3, 'https://ultimateactionmovies.com/wp-content/uploads/2018/09/Charles-Bronson.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (4, 'userA', 'userA', 'userA', 'userA@abc.com', 'abc', NULL, 'member ', 4, 'https://tvovermind.com/wp-content/uploads/2018/08/80s-Teens-12.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (5, 'userB', 'userB', 'userB', 'userB@abc.com', 'abc', NULL, 'member ', 5, 'https://tvovermind.com/wp-content/uploads/2018/08/80s-Teens-12.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (6, 'userC', 'userC', 'userC', 'userC@abc.com', 'abc', NULL, 'member ', 6, 'https://1.bp.blogspot.com/-Fu5vM2G8rvA/X6yxpI2WC0I/AAAAAAAD6tU/6dQFt9UsH3UEAjHMNAbjF9-74Po--uaNgCLcBGAsYHQ/s0/demi-moore-1980s-3.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (7, 'userD', 'userD', 'userD', 'userD@abc.com', 'abc', NULL, 'member ', 7, 'https://i.pinimg.com/originals/cd/62/e3/cd62e379d200f79bea96e131c7403aba.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (8, 'userE', 'userE', 'userE', 'userE@abc.com', 'abc', NULL, 'member ', 8, 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQynIAJReBEhr6FGTQHQkIo0jmfWLY07G0J7qMOUQow9hBHf-Ad', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (9, 'userF', 'userF', 'userF', 'userF@abc.com', 'abc', NULL, 'member ', 9, 'https://m.media-amazon.com/images/M/MV5BMTUwMDE2OTg5Ml5BMl5BanBnXkFtZTgwMTg0ODIwMjE@._V1_.jpg', NULL);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `role`, `location_id`, `profile_url`, `about_me`) VALUES (10, 'Josh', 'FlyBoy', 'Flyboy', 'flyboy@abc.com', 'abc', NULL, 'owner and member', 10, 'https://thumbs.dreamstime.com/z/toy-helicopter-2273926.jpg', NULL);

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
INSERT INTO `language` (`id`, `name`) VALUES (6, 'Chinese');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0312932081', 1985, 324, 'Ender\'s Game', 1, 'Book about a game thats actually the fate of world.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1408303130l/375802._SY475_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('9780008201487', 1990, 55, 'Oh, the Places You\'ll Go!', 1, 'From soaring to high heights and seeing great sights to being left in a Lurch on a prickle-ly perch, Dr. Seuss addresses life’s ups and downs with his trademark humorous verse and whimsical illustrations.\n\nThe inspiring and timeless message encourages readers to find the success that lies within, no matter what challenges they face. A perennial favorite and a perfect gift for anyone starting a new phase in their life!', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1630510695l/191139._SX318_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('9780394800011', 2005/1957, 61, 'The Cat in the Hat', 1, 'Poor Dick and Sally. It\'s cold and wet and they\'re stuck in the house with nothing to do . . . until a giant cat in a hat shows up, transforming the dull day into a madcap adventure and almost wrecking the place in the process! Written by Dr. Seuss in 1957 in response to the concern that \"pallid primers [with] abnormally courteous, unnaturally clean boys and girls\' were leading to growing illiteracy among children, The Cat in the Hat (the first Random House Beginner Book) changed the way our children learn how to read.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1468890477l/233093._SX318_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0375725601', 2004, 447, 'The Devil in the White City: Murder, Magic, and Madness at the Fair That Changed America', 1, 'Bringing Chicago circa 1893 to vivid life, Erik Larson\'s spellbinding bestseller intertwines the true tale of two men--the brilliant architect behind the legendary 1893 World\'s Fair, striving to secure America?s place in the world; and the cunning serial killer who used the fair to lure his victims to their death. Combining meticulous research with nail-biting storytelling, Erik Larson has crafted a narrative with all the wonder of newly discovered history and the thrills of the best fiction.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1583433024l/397483.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('9780375708275', 2000, 232, 'Isaac\'s Storm: A Man, a Time, and the Deadliest Hurricane in History', 1, 'September 8, 1900, began innocently in the seaside town of Galveston, Texas. Even Isaac Cline, resident meteorologist for the U.S. Weather Bureau failed to grasp the true meaning of the strange deep-sea swells and peculiar winds that greeted the city that morning. Mere hours later, Galveston found itself submerged in a monster hurricane that completely destroyed the town and killed over six thousand people in what remains the greatest natural disaster in American history--and Isaac Cline found himself the victim of a devastating personal tragedy.\n\nUsing Cline\'s own telegrams, letters, and reports, the testimony of scores of survivors, and our latest understanding of the science of hurricanes, Erik Larson builds a chronicle of one man\'s heroic struggle and fatal miscalculation in the face of a storm of unimaginable magnitude. Riveting, powerful, and unbearably suspenseful, Isaac\'s Storm is the story of what can happen when human arrogance meets the great uncontrollable force of nature.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1403179592l/239186.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0062371053', 1997, 336, 'Neverwhere', 1, 'The #1 New York Times bestselling author’s ultimate edition of his wildly successful first novel featuring his “preferred text”—and including the special “Neverwhere” tale “How the Marquis Got His Coat Back.”\n\nPublished in 1997, Neil Gaiman’s darkly hypnotic first novel, Neverwhere, heralded the arrival of this major talent and became a touchstone of urban fantasy. Over the years, a number of versions were produced both in the U.S. and the U.K. Now, this author’s preferred edition of his classic novel reconciles these versions and reinstates a number of scenes cut from the original published books.\n\nNeverwhere is the story of Richard Mayhew, a young London businessman with a good heart and an ordinary life, which is changed forever when he is plunged through the cracks of reality into a world of shadows and darkness—the Neverwhere. If he is ever to return to the London Above, Richard must join the battle to save this strange underworld kingdom from the malevolence that means to destroy it.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1348747943l/14497.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0063081911', 2021, 560, 'American Gods: A Novel', 1, 'Released from prison, Shadow finds his world turned upside down. His wife has been killed; a stranger offers him a job and Shadow, with nothing to lose, accepts. But a storm is coming. Beneath the placid surface of everyday life, a war is being fought – and the prize is the very soul of America.\n\nAn inspired combination of mythology, adventure, and illusion, American Gods is a dark and kaleidoscopic journey deep into myth and across an America at once eerily familiar and utterly alien. It is, quite simply, a contemporary masterpiece.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1462924585l/30165203.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('7514346406', 1973, 311, 'No Longer Human', 6, 'Portraying himself as a failure, the protagonist of Osamu Dazai\'s No Longer Human narrates a seemingly normal life even while he feels himself incapable of understanding human beings. Oba Yozo\'s attempts to reconcile himself to the world around him begin in early childhood, continue through high school, where he becomes a clown to mask his alienation, and eventually lead to a failed suicide attempt as an adult. Without sentimentality, he records the casual cruelties of life and its fleeting moments of human connection and tenderness. This description may be from another edition of this product.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1422638843l/194746.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1501142976', 1963, 1168, 'It: A Novel ', 1, 'Welcome to Derry, Maine. It’s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real.\n\nThey were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But the promise they made twenty-eight years ago calls them reunite in the same place where, as teenagers, they battled an evil creature that preyed on the city’s children. Now, children are being murdered again and their repressed memories of that terrifying summer return as they prepare to once again battle the monster lurking in Derry’s sewers.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1334416842l/830502.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0451933028', 1996, 592, 'The Green Mile', 1, 'At Cold Mountain Penitentiary, along the lonely stretch of cells known as the Green Mile, condemned killers such as \'Billy the Kid\' Wharton and the possessed Eduard Delacroix await death strapped in \'Old Sparky\'. But good or evil, innocent or guilty, prisoner or guard, none has ever seen the brutal likes of the new prisoner, John Coffey, sentenced to death for raping and murdering two young girls. Is Coffey a devil in human form? Or is he a far, far different kind of being?\n\nThere are more wonders in heaven and hell than anyone at Cold Mountain can imagine and one of those wonders might just have stepped in amongst them.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1373903563l/11566.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('9781405221', 2003, 25, 'Harold the Helicopter', 1, 'This is a story about Harold the Helicopter. He thought helicopters were faster than engines because they have propellers instead of wheels. But then Percy challenged him to a race...', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1503921284l/36138223._SX318_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0316159433', 2003, 464, 'Flyboys: A True Story of Courage', 1, 'Over the remote Pacific island of Chichi Jima, nine American flyers-Navy and Marine pilots sent to bomb Japanese communications towers there-were shot down. One of those nine was miraculously rescued by a U.S. Navy submarine. The others were captured by Japanese soldiers on Chichi Jima and held prisoner. Then they disappeared. When the war was over, the American government, along with the Japanese, covered up everything that had happened on Chichi Jima. The records of a top-secret military tribunal were sealed, the lives of the eight Flyboys were erased, and the parents, brothers, sisters, and sweethearts they left behind were left to wonder.\n\nFlyboys reveals for the first time ever the extraordinary story of those men. Bradley\'s quest for the truth took him from dusty attics in American small towns, to untapped government archives containing classified documents, to the heart of Japan, and finally to Chichi Jima itself. What he discovered was a mystery that dated back far before World War II-back 150 years, to America\'s westward expansion and Japan\'s first confrontation with the western world. Bradley brings into vivid focus these brave young men who went to war for their country, and through their lives he also tells the larger story of two nations in a hellish war.\n\nWith no easy moralizing, Bradley presents history in all its savage complexity, including the Japanese warrior mentality that fostered inhuman brutality and the U.S. military strategy that justified attacks on millions of civilians. And, after almost sixty years of mystery, Bradley finally reveals the fate of the eight American Flyboys, all of whom would ultimately face a moment and a decision that few of us can even imagine.\n\nFlyboys is a story of war and horror but also of friendship and honor. It is about how we die, and how we live-including the tale of the Flyboy who escaped capture, a young Navy pilot named George H. W. Bush who would one day become president of the United States. A masterpiece of historical narrative, Flyboys will change forever our understanding of the Pacific war and the very things we fight for.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1442195112l/202146._SY475_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1984806750 ', 2021, 373, 'People We Meet on Vacation', 1, 'Poppy and Alex. Alex and Poppy. They have nothing in common. She’s a wild child; he wears khakis. She has insatiable wanderlust; he prefers to stay home with a book. And somehow, ever since a fateful car share home from college many years ago, they are the very best of friends. For most of the year they live far apart—she’s in New York City, and he’s in their small hometown—but every summer, for a decade, they have taken one glorious week of vacation together.\n\nUntil two years ago, when they ruined everything. They haven’t spoken since.\n\nPoppy has everything she should want, but she’s stuck in a rut. When someone asks when she was last truly happy, she knows, without a doubt, it was on that ill-fated, final trip with Alex. And so, she decides to convince her best friend to take one more vacation together—lay everything on the table, make it all right. Miraculously, he agrees.\n\nNow she has a week to fix everything. If only she can get around the one big truth that has always stood quietly in the middle of their seemingly perfect relationship. What could possibly go wrong?', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618913179l/54985743.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0593336828', 2021, 356, 'The Love Hypothesis', 1, 'As a third-year Ph.D. candidate, Olive Smith doesn\'t believe in lasting romantic relationships--but her best friend does, and that\'s what got her into this situation. Convincing Anh that Olive is dating and well on her way to a happily ever after was always going to take more than hand-wavy Jedi mind tricks: Scientists require proof. So, like any self-respecting biologist, Olive panics and kisses the first man she sees.\n\nThat man is none other than Adam Carlsen, a young hotshot professor--and well-known ass. Which is why Olive is positively floored when Stanford\'s reigning lab tyrant agrees to keep her charade a secret and be her fake boyfriend. But when a big science conference goes haywire, putting Olive\'s career on the Bunsen burner, Adam surprises her again with his unyielding support and even more unyielding... six-pack abs.\n\nSuddenly their little experiment feels dangerously close to combustion. And Olive discovers that the only thing more complicated than a hypothesis on love is putting her own heart under the microscope. ', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1611937942l/56732449.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0593135202 ', 2021, 476, 'Project Hail Mary', 1, 'Ryland Grace is the sole survivor on a desperate, last-chance mission—and if he fails, humanity and the earth itself will perish.\n\nExcept that right now, he doesn’t know that. He can’t even remember his own name, let alone the nature of his assignment or how to complete it.\n\nAll he knows is that he’s been asleep for a very, very long time. And he’s just been awakened to find himself millions of miles from home, with nothing but two corpses for company.\n\nHis crewmates dead, his memories fuzzily returning, Ryland realizes that an impossible task now confronts him. Hurtling through space on this tiny ship, it’s up to him to puzzle out an impossible scientific mystery—and conquer an extinction-level threat to our species.\n\nAnd with the clock ticking down and the nearest human being light-years away, he’s got to do it all alone.\n\nOr does he?', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1597695864l/54493401.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1250305977', 2021, 224, 'Somebody\'s Daughter', 1, 'For as long as she could remember, Ashley has put her father on a pedestal. Despite having only vague memories of seeing him face-to-face, she believes he\'s the only person in the entire world who understands her. She thinks she understands him too. He\'s sensitive like her, an artist, and maybe even just as afraid of the dark. She\'s certain that one day they\'ll be reunited again, and she\'ll finally feel complete. There are just a few problems: he\'s in prison, and she doesn\'t know what he did to end up there.\n\nThrough poverty, puberty, and a fraught relationship with her mother, Ashley returns to her image of her father for hope and encouragement. She doesn\'t know how to deal with the incessant worries that keep her up at night, or how to handle the changes in her body that draw unwanted attention from men. In her search for unconditional love, Ashley begins dating a boy her mother hates; when the relationship turns sour, he assaults her. Still reeling from the rape, which she keeps secret from her family, Ashley finally finds out why her father is in prison. And that\'s where the story really begins.\n\nSomebody’s Daughter steps into the world of growing up a poor Black girl, exploring how isolating and complex such a childhood can be. As Ashley battles her body and her environment, she provides a poignant coming-of-age recollection that speaks to finding the threads between who you are and what you were born into, and the complicated familial love that often binds them.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1600787680l/54860610.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1982168439', 2021, 626, 'Cloud Cuckoo Land', 1, 'When everything is lost, it’s our stories that survive.\n\nHow do we weather the end of things? Cloud Cuckoo Land brings together an unforgettable cast of dreamers and outsiders from past, present and future to offer a vision of survival against all odds.\n\nConstantinople, 1453:\nAn orphaned seamstress and a cursed boy with a love for animals risk everything on opposite sides of a city wall to protect the people they love.\n\nIdaho, 2020:\nAn impoverished, idealistic kid seeks revenge on a world that’s crumbling around him. Can he go through with it when a gentle old man stands between him and his plans?\n\nUnknown, Sometime in the Future:\nWith her tiny community in peril, Konstance is the last hope for the human race. To find a way forward, she must look to the oldest stories of all for guidance.\n\nBound together by a single ancient text, these tales interweave to form a tapestry of solace and resilience and a celebration of storytelling itself. Like its predecessor All the Light We Cannot See, Anthony Doerr’s new novel is a tale of hope and of profound human connection. When everything is lost, it’s our stories that survive.\n\nHow do we weather the end of things? Cloud Cuckoo Land brings together an unforgettable cast of dreamers and outsiders from past, present and future to offer a vision of survival against all odds.\n\nConstantinople, 1453:\nAn orphaned seamstress and a cursed boy with a love for animals risk everything on opposite sides of a city wall to protect the people they love.\n\nIdaho, 2020:\nAn impoverished, idealistic kid seeks revenge on a world that’s crumbling around him. Can he go through with it when a gentle old man stands between him and his plans?\n\nUnknown, Sometime in the Future:\nWith her tiny community in peril, Konstance is the last hope for the human race. To find a way forward, she must look to the oldest stories of all for guidance.\n\nBound together by a single ancient text, these tales interweave to form a tapestry of solace and resilience and a celebration of storytelling itself. Like its predecessor All the Light We Cannot See, Anthony Doerr’s new novel is a tale of hope and of profound human connection. ', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1618589128l/56783258._SY475_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1501171348 ', 2021, 307, 'The Last Thing He Told Me', 1, 'Before Owen Michaels disappears, he manages to smuggle a note to his beloved wife of one year: Protect her. Despite her confusion and fear, Hannah Hall knows exactly to whom the note refers: Owen’s sixteen-year-old daughter, Bailey. Bailey, who lost her mother tragically as a child. Bailey, who wants absolutely nothing to do with her new stepmother.\n\nAs Hannah’s increasingly desperate calls to Owen go unanswered; as the FBI arrests Owen’s boss; as a US Marshal and FBI agents arrive at her Sausalito home unannounced, Hannah quickly realizes her husband isn’t who he said he was. And that Bailey just may hold the key to figuring out Owen’s true identity—and why he really disappeared.\n\nHannah and Bailey set out to discover the truth, together. But as they start putting together the pieces of Owen’s past, they soon realize they are also building a new future. One neither Hannah nor Bailey could have anticipated. ', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1628623381l/58744977._SY475_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0804139024 ', 2014, 384, 'The Martian', 1, 'Six days ago, astronaut Mark Watney became one of the first people to walk on Mars.\n\nNow, he’s sure he’ll be the first person to die there.\n\nAfter a dust storm nearly kills him and forces his crew to evacuate while thinking him dead, Mark finds himself stranded and completely alone with no way to even signal Earth that he’s alive—and even if he could get word out, his supplies would be gone long before a rescue could arrive.\n\nChances are, though, he won’t have time to starve to death. The damaged machinery, unforgiving environment, or plain-old “human error” are much more likely to kill him first.\n\nBut Mark isn’t ready to give up yet. Drawing on his ingenuity, his engineering skills — and a relentless, dogged refusal to quit — he steadfastly confronts one seemingly insurmountable obstacle after the next. Will his resourcefulness be enough to overcome the impossible odds against him?Six days ago, astronaut Mark Watney became one of the first people to walk on Mars.\n\nNow, he’s sure he’ll be the first person to die there.\n\nAfter a dust storm nearly kills him and forces his crew to evacuate while thinking him dead, Mark finds himself stranded and completely alone with no way to even signal Earth that he’s alive—and even if he could get word out, his supplies would be gone long before a rescue could arrive.\n\nChances are, though, he won’t have time to starve to death. The damaged machinery, unforgiving environment, or plain-old “human error” are much more likely to kill him first.\n\nBut Mark isn’t ready to give up yet. Drawing on his ingenuity, his engineering skills — and a relentless, dogged refusal to quit — he steadfastly confronts one seemingly insurmountable obstacle after the next. Will his resourcefulness be enough to overcome the impossible odds against him?', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1413706054l/18007564.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('1476746583', 2014, 531, 'All the Light We Cannot See', 1, 'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure’s reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museum’s most valuable and dangerous jewel.\n\nIn a mining town in Germany, Werner Pfennig, an orphan, grows up with his younger sister, enchanted by a crude radio they find that brings them news and stories from places they have never seen or imagined. Werner becomes an expert at building and fixing these crucial new instruments and is enlisted to use his talent to track down the resistance. Deftly interweaving the lives of Marie-Laure and Werner, Doerr illuminates the ways, against all odds, people try to be good to one another.\n\nFrom the highly acclaimed, multiple award-winning Anthony Doerr, the stunningly beautiful instant New York Times bestseller about a blind French girl and a German boy whose paths collide in occupied France as both try to survive the devastation of World War II.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1451445646l/18143977.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0312577222', 2015, 440, 'The Nightingale', 1, 'In the quiet village of Carriveau, Vianne Mauriac says good-bye to her husband, Antoine, as he heads for the Front. She doesn’t believe that the Nazis will invade France…but invade they do, in droves of marching soldiers, in caravans of trucks and tanks, in planes that fill the skies and drop bombs upon the innocent. When a German captain requisitions Vianne’s home, she and her daughter must live with the enemy or lose everything. Without food or money or hope, as danger escalates all around them, she is forced to make one impossible choice after another to keep her family alive.\n\nVianne’s sister, Isabelle, is a rebellious eighteen-year-old, searching for purpose with all the reckless passion of youth. While thousands of Parisians march into the unknown terrors of war, she meets Gaëtan, a partisan who believes the French can fight the Nazis from within France, and she falls in love as only the young can…completely. But when he betrays her, Isabelle joins the Resistance and never looks back, risking her life time and again to save others. ', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1598993363l/21853621._SY475_.jpg');
INSERT INTO `book` (`isbn`, `publish_year`, `pages`, `title`, `language_id`, `description`, `cover_url`) VALUES ('0312577230', 2018, 435, 'The Great Alone', 1, 'Ernt Allbright, a former POW, comes home from the Vietnam war a changed and volatile man. When he loses yet another job, he makes an impulsive decision: he will move his family north, to Alaska, where they will live off the grid in America’s last true frontierErnt Allbright, a former POW, comes home from the Vietnam war a changed and volatile man. When he loses yet another job, he makes an impulsive decision: he will move his family north, to Alaska, where they will live off the grid in America’s last true frontier.\n\nThirteen-year-old Leni, a girl coming of age in a tumultuous time, caught in the riptide of her parents’ passionate, stormy relationship, dares to hope that a new land will lead to a better future for her family. She is desperate for a place to belong. Her mother, Cora, will do anything and go anywhere for the man she loves, even if it means following him into the unknown.\n\nAt first, Alaska seems to be the answer to their prayers. In a wild, remote corner of the state, they find a fiercely independent community of strong men and even stronger women. The long, sunlit days and the generosity of the locals make up for the Allbrights’ lack of preparation and dwindling resources.\n\nThirteen-year-old Leni, a girl coming of age in a tumultuous time, caught in the riptide of her parents’ passionate, stormy relationship, dares to hope that a new land will lead to a better future for her family. She is desperate for a place to belong. Her mother, Cora, will do anything and go anywhere for the man she loves, even if it means following him into the unknown.\n\nAt first, Alaska seems to be the answer to their prayers. In a wild, remote corner of the state, they find a fiercely independent community of strong men and even stronger women. The long, sunlit days and the generosity of the locals make up for the Allbrights’ lack of preparation and dwindling resources.', 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1501852423l/34912895._SY475_.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (1, 'Orson', 'Card', 'A guy', NULL, 'https://greenvillejournal.com/wp-content/uploads/2019/09/Orson-Scott-Card-e1569536619341.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (2, 'Dr. Theodor', 'Seuss', 'Theodor Seuss Geisel—aka Dr. Seuss—is one of the most beloved children’s book authors of all time. From The Cat in the Hat to Oh, the Places You’ll Go!, his iconic characters, stories, and art style have been a lasting influence on generations of children and adults. The books he wrote and illustrated under the name Dr. Seuss (and others that he wrote but did not illustrate, including some under the pseudonyms Theo. LeSieg and Rosetta Stone) have been translated into 45 languages.', 'https://www.seussville.com/', 'https://upload.wikimedia.org/wikipedia/commons/1/18/Theodor_Seuss_Geisel_%2801037v%29.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (3, 'Erik ', 'Larson', '\nErik Larson is the author of five national bestsellers: Dead Wake, In the Garden of Beasts, Thunderstruck, The Devil in the White City, and Isaac’s Storm, which have collectively sold more than nine million copies. His books have been published in nearly twenty countries.', NULL, 'https://commons.wikimedia.org/wiki/Category:Erik_Larson_(author)#/media/File:Erik_Larson_03B.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (4, 'Neil', 'Gaiman', 'Neil Gaiman is the #1 New York Times bestselling author of more than twenty books, including Norse Mythology, Neverwhere, and The Graveyard Book. Among his numerous literary awards are the Newbery and Carnegie medals, and the Hugo, Nebula, World Fantasy, and Will Eisner awards. He is a Professor in the Arts at Bard College.', NULL, 'https://dwcp78yw3i6ob.cloudfront.net/wp-content/uploads/2016/12/13141004/neil-gaiman-author-photo-bw3.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (5, 'Osamu', 'Dazai', NULL, NULL, 'https://i.mydramalist.com/dJXp5_5c.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (6, 'Stephen ', 'King', 'Stephen King is the author of more than sixty books, all of them worldwide bestsellers. His recent work includes Fairy Tale, Billy Summers, If It Bleeds, The Institute, Elevation, The Outsider, Sleeping Beauties (cowritten with his son Owen King), and the Bill Hodges trilogy: End of Watch, Finders Keepers, and Mr. Mercedes (an Edgar Award winner for Best Novel and a television series streaming on Peacock). His novel 11/22/63 was named a top ten book of 2011 by The New York Times Book Review and won the Los Angeles Times Book Prize for Mystery/Thriller. His epic works The Dark Tower, It, Pet Sematary, Doctor Sleep, and Firestarter are the basis for major motion pictures, with It now the highest-grossing horror film of all time. He is the recipient of the 2020 Audio Publishers Association Lifetime Achievement Award, the 2018 PEN America Literary Service Award, the 2014 National Medal of Arts, and the 2003 National Book Foundation Medal for Distinguished Contribution to American Letters. He lives in Bangor, Maine, with his wife, novelist Tabitha King. ', NULL, 'https://images.gr-assets.com/authors/1362814142p8/3389.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (7, 'Wilbert', 'Awdry', 'Was an English Anglican minister, railway enthusiast, and children\'s author. He was best known for creating Thomas the Tank Engine. Thomas and several other characters he created appeared in his Railway Series.', NULL, 'https://m.media-amazon.com/images/M/MV5BMWNiYTk3ZGQtNDI4Mi00YWYzLWIyOGUtMGMzNTMzMmY1NjZkXkEyXkFqcGdeQXVyMTQ4NTcxNTI0._V1_UY216_CR7,0,148,216_AL_.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (8, 'James', 'Bradley', 'Is an American author from Antigo, Wisconsin, specializing in historical nonfiction chronicling the Pacific theatre of World War II. His father, John Bradley, was long thought to be one of the six men who was in the photograph raising the American flag on Mount Suribachi during the Battle of Iwo Jima in 1945. That photograph has gone on to be one of the most duplicated and reproduced photos ever taken', NULL, 'https://images-na.ssl-images-amazon.com/images/I/31lJKDyUa+L.__01_SX120_CR0,0,120,120__.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (9, 'Emily ', 'Henry', NULL, NULL, NULL);
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (10, 'Ali ', 'Hazelwood', 'Ali Hazelwood is the pseudonym for an Italian neuroscientist and writer of romance novels. Her main characters are women in STEM fields and in academia. Her debut novel, The Love Hypothesis, was a New York Times best seller. In 2022 she has published three novellas', NULL, NULL);
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (11, 'Andy', 'Weir', 'ANDY WEIR built a career as a software engineer until the success of his first published novel, THE MARTIAN, allowed him to live out his dream of writing fulltime. He is a lifelong space nerd and a devoted hobbyist of subjects such as relativistic physics, orbital mechanics, and the history of manned spaceflight. He also mixes a mean cocktail. He lives in California. Andy’s next book, ARTEMIS, is available now.', NULL, 'https://images.gr-assets.com/authors/1382592903p5/6540057.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (12, 'Ashley', 'Ford', 'Ford has written or guest-edited for The Guardian, ELLE, BuzzFeed, OUT Magazine, Slate, Teen Vogue, New York Magazine, Lenny Letter, INTO and various other web and print publications. She\'s taught creative nonfiction writing at The New School and Catapult.Co, and also had her work listed among Longform & Longread\'s Best of 2017. She also contributed to CupOfJo.Com & hosted Fortune Favors The Bold, a collaboration between Gimlet Creative and Mastercard.\n\nWhile working as a development executive for Matter Studios, Ford focused on web series and documentaries. She was also the host of the first season of Audible.Com\'s literary interview series, Authorized. She has been named among Forbes Magazine\'s 30 Under 30 in Media (2017), Brooklyn Magazine\'s Brooklyn 100 (2016), and Time Out New York\'s New Yorkers of The Year (2017). ', NULL, 'https://images.gr-assets.com/authors/1617551299p5/18765624.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (13, 'Anthony', 'Doerr', 'Anthony Doerr is the author of six books, The Shell Collector , About Grace , Memory Wall , Four Seasons in Rome , All the Light We Cannot See , and Cloud Cuckoo Land . Doerr is a two-time National Book Award finalist, and his fiction has won five O. Henry Prizes and won a number of prizes including the Pulitzer Prize and the Carnegie Medal. Become a fan on Facebook and stay up-to-date on his latest publications.', NULL, 'https://images.gr-assets.com/authors/1417812584p5/28186.jpg');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (14, 'Laura ', 'Dave', 'Laura Dave is the #1 New York Times bestselling author of several critically acclaimed novels including The Last Thing He Told Me, Eight Hundred Grapes and The First Husband. Her work has been published in thirty-two countries, and five of her novels, including The Last Thing he Told Me, have been optioned for film and television. She resides in Santa Monica, California.', NULL, 'https://www.goodreads.com/author/show/2672.Laura_Dave');
INSERT INTO `author` (`id`, `first_name`, `last_name`, `biography`, `websiter_url`, `headshot_url`) VALUES (15, 'Kristin ', 'Hannah', 'Kristin Hannah is the award-winning and bestselling author of more than 20 novels including the international blockbuster, The Nightingale, which was named Goodreads Best Historical fiction novel for 2015 and won the coveted People\'s Choice award for best fiction in the same year. Additionally, it was named a Best Book of the Year by Amazon, iTunes, Buzzfeed, the Wall Street Journal, Paste, and The Week. Her novel, The Great Alone, was also voted as Goodreads best historical novel of the year in 2018.\n\nKristin\'s highly anticipated new release, The Four Winds will be published on February 9, 2021 (St. Martin\'s Press). The novel is a sweeping, emotional story of love, family, and survival, set in Texas and California during the dark days of The Great Depression. It is a portrait of one indomitable woman who will do anything to keep her family together.\n\nThe Nightingale is currently in production at Tri Star, with award-winning director Melanie Laurent set to direct a cast led by Dakota and Elle Fanning.\n\nFirefly Lane, starring Katherine Heigl, Sarah Chalke and Ben Lawson, is set to premiere on Netflix in early 2021.', NULL, 'https://images.gr-assets.com/authors/1517255843p5/54493.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (1, 'Science-Fiction', 'A fictionalized story wherein the setting and plot are centered around technology, time travel, outer space, or scientific principles, with or without the presence of aliens. Story elements are not found in the known universe and explained by scientific means.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (2, 'Childrens Literature', 'Ages 0-10');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (3, 'Historical Fiction', 'Is set in a real place, during a culturally recognizable time. The details and the action in the story can be a mix of actual events and ones from the author\'s imagination as they fill in the gaps. Characters can be pure fiction or based on real people (often, it\'s both).');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (4, 'Romance', 'Defined by two aspects that can be found in every romance book or novel: a central love story between characters. an emotionally satisfying, happy ending.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (5, 'Mystery', 'Stories focus on a puzzling crime, situation, or circumstance that needs to be solved. ');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (6, 'Narrative', 'Any account of a series of related events or experiences, whether nonfictional or fictional. Narratives can be presented through a sequence of written or spoken words, through still or moving images, or through any combination of these.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (7, 'Biography', 'Commonly considered nonfictional, the subject of which is the life of an individual.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (8, 'Fantasy', ' Imaginative fiction dependent for effect on strangeness of setting (such as other worlds or times) and of characters (such as supernatural or unnatural beings).');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (9, 'Horror', 'The key focus of a horror novel, horror film, or horror TV show is to elicit a sense of dread in the reader through frightening images, themes, and situations.');
INSERT INTO `genre` (`id`, `name`, `description`) VALUES (10, 'Non-Fiction', 'Prose writing that is based on facts, real events, and real people, such as biography or history.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_reading_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (1, 'scifi', 1);
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (2, 'fantasy', 2);
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (3, 'history', 3);
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (4, 'page turners', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (1, 35, '2022-10-21 11:34:10', 1, 1, 1, 'https://modelsua.com/images/product/MB35103.jpg', 'Scifi nerds', 'Pestilential Winter');
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (2, 5, '2022-10-21 17:34:10', 1, 2, 2, 'https://media.tenor.com/exClB_w3ICMAAAAi/villans.gif', 'Fantasy', 'Gamerz$Lyfe');
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (3, 10, '2022-10-22 17:34:10', 1, 3, 3, 'https://carboncostume.com/wordpress/wp-content/uploads/2013/08/Mr.-T.jpg', 'Historical', 'BestTeach');
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (4, 4, '2022-10-25 18:34:10', 0, 10, 10, 'https://thumbs.dreamstime.com/z/miniature-toy-helicopter-isolated-white-background-34881700.jpg', 'Military', 'Pew Pew');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (1, '0312932081');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (2, '9780008201487');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (2, '9780394800011');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (3, '0375725601');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (3, '9780375708275');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (4, '0062371053');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (4, '0063081911');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (6, '1501142976');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (5, '7514346406');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (6, '0451933028');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (7, '9781405221');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (8, '0316159433');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (9, '1984806750 ');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (10, '0593336828');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (11, '0593135202');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (12, '1250305977');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (13, '1982168439');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (14, '1501171348 ');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (11, '0804139024');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (13, '1476746583');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (15, '0312577222');
INSERT INTO `author_book` (`author_id`, `book_isbn`) VALUES (15, '0312577230');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_club_members`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (1, 1);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (2, 2);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (3, 3);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (1, 4);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (1, 5);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (2, 6);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (2, 7);
INSERT INTO `book_club_members` (`book_club_id`, `user_id`) VALUES (3, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_club_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_club_genre` (`book_club_id`, `genre_id`) VALUES (1, 1);
INSERT INTO `book_club_genre` (`book_club_id`, `genre_id`) VALUES (2, 8);
INSERT INTO `book_club_genre` (`book_club_id`, `genre_id`) VALUES (3, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0312932081', 1);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('9780394800011', 2);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('9780008201487', 2);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0451933028 ', 5);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0375725601', 3);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('9780375708275', 3);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0062371053', 8);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0063081911', 8);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('7514346406', 6);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('1501142976', 9);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0451933028 ', 8);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('9781405221', 2);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0316159433', 3);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('1984806750 ', 4);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0593336828', 4);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0593135202 ', 1);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('1250305977', 7);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('1982168439', 10);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('1501171348 ', 5);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0804139024', 1);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0312577222', 10);
INSERT INTO `book_genre` (`book_isbn`, `genre_id`) VALUES ('0312577230', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (1, 'Great book. Socially did not age well.', 4, 1, '0312932081');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (2, 'LOVED THIS BOOK! Could not put it down.', 5, 1, '9780008201487');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (3, 'cool book', 4, 2, '9780394800011');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (4, NULL, 3, 2, '0063081911');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (5, NULL, 3, 2, '0062371053');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (6, 'captivating read', 5, 4, '9780394800011');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (7, 'well thought out content', 4, 6, '9780394800011');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (8, 'thumbs up', 4, 5, '0063081911');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (9, 'My favorite author', 5, 7, '0451933028');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_book_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('0312932081', 1);
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('0063081911', 2);
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('7514346406', 2);
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('9780008201487', 1);
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('0375725601', 3);
INSERT INTO `user_book_list` (`book_isbn`, `reading_list_id`) VALUES ('0451933028', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookclub_reading_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (1, 'Scifi books', 1);
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (2, 'fantasy books', 2);
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (3, 'history books', 3);
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (4, 'Our favorite not always scifi author', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookclub_book_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('0312932081', 1);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('0063081911', 2);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('0062371053', 2);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('0375725601', 3);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('9780375708275', 3);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('0451933028', 4);
INSERT INTO `bookclub_book_list` (`book_isbn`, `bookclub_reading_list_id`) VALUES ('1501142976', 4);

COMMIT;

