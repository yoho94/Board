CREATE TABLE `board_tbl` (
  `bno` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `writer` varchar(45) NOT NULL,
  `regdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `viewcnt` int(11) DEFAULT '0',
  `re_group` int(11) DEFAULT '0',
  `re_sorts` int(11) DEFAULT '0',
  `re_depth` int(11) DEFAULT '0',
  `isDelete` tinyint(4) DEFAULT '0',
  `isNotice` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=617 DEFAULT CHARSET=utf8;

CREATE TABLE `member` (
  `userId` varchar(50) NOT NULL,
  `userPass` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
