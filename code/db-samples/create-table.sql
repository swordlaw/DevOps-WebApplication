-- Creates a small table with three values

USE `helloworld`;

-- Dumping structure for table helloworld.admin user/expert
--CREATE TABLE IF NOT EXISTS `adminUser/expert` (
--  `Username` char(50) DEFAULT NULL,
--  `AnsweredQuestions` char(50) DEFAULT NULL,
--  `PostID` int(11) DEFAULT NULL,
--  `CommentID` int(11) DEFAULT NULL,
--  `IsAdmin` set('False','True') NOT NULL DEFAULT 'True',
--  `AnswerID` int(11) DEFAULT NULL,
--  PRIMARY KEY (`IsAdmin`),
--  KEY `FK_adminUser/expert_answers` (`AnswerID`),
--  CONSTRAINT `FK_adminUser/expert_answers` FOREIGN KEY (`AnswerID`) REFERENCES `answers` (`AnswerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
--) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table helloworld.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `PostID` int(11) NOT NULL AUTO_INCREMENT,
  `Comments` text NULL,
  `Title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`PostID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping structure for table helloworld.answers
CREATE TABLE IF NOT EXISTS `answers` (
  `AnswerID` int(11) NOT NULL AUTO_INCREMENT,
  `PostID` int(11) DEFAULT NULL,
  `TitleA` varchar(255) NOT NULL,
  `contentA` text NOT NULL,
  `Likes` int(11) DEFAULT NULL,
  `verifiedByExpert` set('F','T') DEFAULT NULL,
  PRIMARY KEY (`AnswerID`),
  KEY `FK_answers_posts` (`PostID`),
  CONSTRAINT `FK_answers_posts` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table helloworld.login
--CREATE TABLE IF NOT EXISTS `login` (
--  `Username` char(50) DEFAULT NULL,
--  `Password` char(50) DEFAULT NULL,
--  KEY `FK_login_regular user` (`Username`),
--  KEY `FK_login_regular user_2` (`Password`),
--  CONSTRAINT `FK_login_regular user` FOREIGN KEY (`Username`) REFERENCES `regular user` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
--  CONSTRAINT `FK_login_regular user_2` FOREIGN KEY (`Password`) REFERENCES `regular user` (`Password`) ON DELETE NO ACTION ON UPDATE NO ACTION
--) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Data exporting was unselected.

-- Dumping structure for table helloworld.regular user
--CREATE TABLE IF NOT EXISTS `regular user` (
--  `Username` char(50) NOT NULL,
--  `Password` char(50) DEFAULT NULL,
--  `PostID` int(11) DEFAULT NULL,
--  `IsAdmin` set('False','True') NOT NULL DEFAULT 'False',
--  PRIMARY KEY (`Username`),
--  KEY `Password` (`Password`),
--  KEY `FK_regular user_posts` (`PostID`),
--  KEY `FK_regular user_admin user/expert` (`IsAdmin`),
--  CONSTRAINT `FK_regular user_admin user/expert` FOREIGN KEY (`IsAdmin`) REFERENCES `admin user/expert` (`IsAdmin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
--  CONSTRAINT `FK_regular user_posts` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`) ON DELETE NO ACTION ON UPDATE NO ACTION
--) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
