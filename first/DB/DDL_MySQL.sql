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
) ENGINE=InnoDB AUTO_INCREMENT=618 DEFAULT CHARSET=utf8

CREATE TABLE `category_code` (
  `category_code` int(11) NOT NULL AUTO_INCREMENT COMMENT '카테고리코드',
  `category_name` varchar(45) DEFAULT NULL COMMENT '카테고리이름',
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='카테고리 코드'

CREATE TABLE `dashboard` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `boardOrder` int(11) DEFAULT '0',
  `width` int(1) DEFAULT '1',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8

CREATE TABLE `member` (
  `userId` varchar(50) NOT NULL,
  `userPass` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  `isUsing` varchar(1) DEFAULT 'Y',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `myreply` (
  `bno` int(11) NOT NULL,
  `rno` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `writer` varchar(45) NOT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `re_group` int(11) DEFAULT '0',
  `re_sorts` int(11) DEFAULT '0',
  `re_depth` int(11) DEFAULT '0',
  `isDelete` int(11) DEFAULT '0',
  PRIMARY KEY (`rno`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8

CREATE TABLE `popup` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `title` text,
  `text` text,
  `image` text,
  `link` text,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `isUsing` varchar(1) DEFAULT 'N',
  `write_id` varchar(45) DEFAULT NULL,
  `mod_id` varchar(45) DEFAULT NULL,
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_date` datetime DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8

CREATE TABLE `question_code` (
  `question_code` int(11) NOT NULL AUTO_INCREMENT COMMENT '문항코드',
  `parent_code` int(11) DEFAULT NULL COMMENT '부모코드',
  `question_name` varchar(45) DEFAULT NULL COMMENT '문항이름',
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`question_code`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='문항 코드'

CREATE TABLE `survey_answer` (
  `survey_seq` int(11) NOT NULL COMMENT '기본키(순번)',
  `question_order` int(11) NOT NULL COMMENT '문항번호(순서)',
  `question_depth` int(11) NOT NULL COMMENT '문항세부번호(깊이)',
  `user_id` varchar(45) NOT NULL COMMENT '회원아이디',
  `subjective_answer` text COMMENT '주관식답',
  `choice_answer` varchar(45) DEFAULT NULL COMMENT '객관식답',
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`survey_seq`,`question_order`,`question_depth`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='문항답 정보'

CREATE TABLE `survey_info` (
  `survey_seq` int(11) NOT NULL AUTO_INCREMENT COMMENT '기본키(순번)',
  `admin_id` varchar(45) DEFAULT NULL COMMENT '아이디',
  `agency_name` varchar(45) DEFAULT NULL COMMENT '조사주관',
  `start_date` date DEFAULT NULL COMMENT '시작일',
  `end_date` date DEFAULT NULL COMMENT '종료일',
  `result_date` date DEFAULT NULL COMMENT '발표일',
  `survey_head` text COMMENT '설문헤더',
  `survey_content` text COMMENT '설문본문',
  `survey_foot` text COMMENT '설문푸터',
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  `isUsing` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`survey_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='설문조사 정보'

CREATE TABLE `survey_question` (
  `survey_seq` int(11) NOT NULL COMMENT '기본키(순번)',
  `question_order` int(11) NOT NULL COMMENT '문항번호(순서)',
  `question_depth` int(11) NOT NULL COMMENT '문항세부번호(깊이)',
  `category_code` int(11) DEFAULT NULL COMMENT '카테고리코드',
  `question_code` int(11) DEFAULT NULL COMMENT '문항코드',
  `title` text NOT NULL COMMENT '문항제목',
  `type` varchar(1) NOT NULL COMMENT '문항타입( a:객관식, b: 객관식+기타, c: 객관식+없음, d:객관식+기타+없음, 1 : 주관식, 2: 부모문항 )',
  `number` int(11) NOT NULL DEFAULT '1' COMMENT '문항선택개수',
  `reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  `is_free` varchar(1) DEFAULT NULL COMMENT 'NULL : 기본, Y : 자유, N : 필수',
  PRIMARY KEY (`survey_seq`,`question_order`,`question_depth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='문항 정보'

CREATE TABLE `useragent` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) DEFAULT NULL,
  `countryCode` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `id` varchar(50) DEFAULT NULL,
  `osName` varchar(45) DEFAULT NULL,
  `osVersion` varchar(45) DEFAULT NULL,
  `browserName` varchar(45) DEFAULT NULL,
  `browserVersion` varchar(45) DEFAULT NULL,
  `deviceBrand` varchar(45) DEFAULT NULL,
  `deviceModel` varchar(45) DEFAULT NULL,
  `referer` text,
  `path` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=8930 DEFAULT CHARSET=utf8