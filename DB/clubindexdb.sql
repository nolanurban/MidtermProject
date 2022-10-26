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
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (1, 'Texas', 'aledo', '76008', NULL, NULL, 'TX');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (2, 'Wisconsin', 'Pulaski', '54162', NULL, NULL, 'WI');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (3, 'Iowa', 'North Liberty', '52317', NULL, NULL, 'IA');
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (4, 'Texas', 'Fort Worth ', '76006', NULL, NULL, NULL);
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (5, 'Texas', 'Fort Worth ', '76008', NULL, NULL, NULL);
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (6, 'Wisconsin', 'Pulaski', '54162', NULL, NULL, NULL);
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (7, 'Wisconsin', 'Pulaski', '54162', NULL, NULL, NULL);
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (8, 'Iowa', 'North Liberty', '52317', NULL, NULL, NULL);
INSERT INTO `location` (`id`, `state`, `city`, `zip_code`, `street`, `unit`, `state_abbr`) VALUES (9, 'Iowa', 'North Liberty ', '52317', NULL, NULL, 'IA');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_reading_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (1, 'scifi', 1);
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (2, 'fantasy', 2);
INSERT INTO `user_reading_list` (`id`, `name`, `user_id`) VALUES (3, 'history', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (1, 35, '2022-10-21 11:34:10', 1, 1, 1, 'https://modelsua.com/images/product/MB35103.jpg', 'Scifi nerds', 'Pestilential Winter');
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (2, 5, '2022-10-21 17:34:10', 1, 2, 2, 'https://media.tenor.com/exClB_w3ICMAAAAi/villans.gif', 'Fantasy', 'Gamerz$Lyfe');
INSERT INTO `book_club` (`id`, `max_members`, `create_date`, `digital`, `owner_id`, `location_id`, `profile_url`, `about_club`, `name`) VALUES (3, 10, '2022-10-22 17:34:10', 1, 3, 3, 'https://carboncostume.com/wordpress/wp-content/uploads/2013/08/Mr.-T.jpg', 'Historical', 'BestTeach');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (1, 'Great book. Socially did not age well.', 4, 1, '0312932081');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (2, NULL, 5, 1, '9780008201487');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (3, NULL, 4, 2, '9780394800011');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (4, NULL, 3, 2, '0063081911');
INSERT INTO `review` (`id`, `review`, `rating`, `user_id`, `book_isbn`) VALUES (5, NULL, 3, 2, '0062371053');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookclub_reading_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `clubindexdb`;
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (1, 'Scifi books', 1);
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (2, 'fantasy books', 2);
INSERT INTO `bookclub_reading_list` (`id`, `name`, `book_club_id`) VALUES (3, 'history books', 3);

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

COMMIT;

