CREATE TABLE `board_article` (
  `boardId` int(11) DEFAULT NULL COMMENT '게시판의 아이디',
  `bno` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시물의 아이디',
  `title` varchar(200) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '본문',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '생성(작성) 일',
  `writer` varchar(45) NOT NULL COMMENT '작성자 아이디',
  `modDate` datetime DEFAULT NULL COMMENT '수정일',
  `modWriter` varchar(45) DEFAULT NULL COMMENT '수정자의 아이디',
  `password` varchar(500) DEFAULT NULL COMMENT '게시글 비밀번호',
  `viewCnt` int(11) DEFAULT '0',
  `re_group` int(11) DEFAULT '0',
  `re_sorts` int(11) DEFAULT '0',
  `re_depth` int(11) DEFAULT '0',
  `isDelete` char(1) DEFAULT 'N',
  `isNotice` char(1) DEFAULT 'N',
  `isSecret` char(1) DEFAULT 'N',
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=667 DEFAULT CHARSET=utf8 COMMENT='게시물의 테이블'

CREATE TABLE `board_board` (
  `boardId` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판의 아이디',
  `boardType` varchar(45) DEFAULT 'basic' COMMENT '게시판의 타입 (일반, 설문, 알림 등)',
  `note` text COMMENT '게시판설명',
  `name` varchar(100) DEFAULT NULL COMMENT '게시판 이름',
  `order` int(11) DEFAULT NULL COMMENT '게시판 노출 순서',
  `isRpy` char(1) DEFAULT 'N' COMMENT '게시판 답글 사용여부',
  `isComment` char(1) DEFAULT 'N' COMMENT '게시판 덧글 사용여부',
  `isSecret` char(1) DEFAULT 'N' COMMENT '게시판 비밀글 사용여부',
  `isNotice` char(1) DEFAULT 'N' COMMENT '게시판 공지 사용여부',
  `isUse` char(1) DEFAULT 'N' COMMENT '게시판 사용여부',
  `url` varchar(100) NOT NULL COMMENT '게시판의 URL',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `regId` varchar(100) DEFAULT NULL,
  `modDate` datetime DEFAULT NULL,
  `modId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`boardId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='게시판의 테이블'

CREATE TABLE `board_read_tbl` (
  `userId` varchar(50) NOT NULL,
  `bno` int(11) NOT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `regId` varchar(100) DEFAULT NULL,
  `modDate` datetime DEFAULT NULL,
  `modId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userId`,`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='유저 별 읽음, 안읽음 표시'

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8

CREATE TABLE `member` (
  `userId` varchar(50) NOT NULL,
  `userPass` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  `isUsing` varchar(1) DEFAULT 'Y',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `menu` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `isUse` char(1) DEFAULT 'N',
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8

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
  `score` int(11) DEFAULT '0',
  PRIMARY KEY (`rno`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8

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

CREATE TABLE `reply` (
  `bno` int(11) NOT NULL,
  `rno` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `writer` varchar(45) NOT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `parent` int(11) DEFAULT '0',
  `isDelete` int(11) DEFAULT '0',
  `good_score` int(11) DEFAULT '0',
  `bad_score` int(11) DEFAULT '0',
  PRIMARY KEY (`rno`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8

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
) ENGINE=InnoDB AUTO_INCREMENT=17535 DEFAULT CHARSET=utf8

CREATE DEFINER=`root`@`localhost` PROCEDURE `uaInsert`(size int)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE ipaddr varchar(45) default concat(Floor( Rand() * 255 ),'.',Floor( Rand() * 255 ),'.',Floor( Rand() * 255 ),'.',Floor( Rand() * 255 ));  
    
    WHILE i <= size DO		
        INSERT INTO `useragent`
        (`ip`,`date`, `id`,`osName`,`osVersion`,`browserName`,
        `browserVersion`,`deviceBrand`,`deviceModel`,`referer`,`path`)
          VALUES
          (ipaddr, FROM_UNIXTIME(FLOOR(unix_timestamp('2000-01-01 00:00:00')+(RAND()*(unix_timestamp('2019-11-16 00:00:00')-unix_timestamp('2000-01-01 00:00:00'))))), NULL, 'Windows 10', '', 'Chrome', '78.0', NULL, NULL, NULL, '/');
        SET i = i + 1;
    END WHILE;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `loopInsert`()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 500 DO
        INSERT INTO BOARD_TBL(title , content, writer)
          VALUES(concat('제목',i), concat('내용',i), concat('작성자',i));
        SET i = i + 1;
    END WHILE;
END

CREATE DEFINER=`root`@`localhost` FUNCTION `get_reply_list_new`(searchBno INT) RETURNS int(11)
    READS SQL DATA
BEGIN
	DECLARE _parent INT;
    DECLARE _rank INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

    SET _parent = @id;
    SET _rank = 0;

    IF @id IS NULL THEN
            RETURN NULL;
    END IF;

    LOOP
        SET @innerrank = 0;
        SELECT p.id 
        INTO   @id
        FROM   (
                SELECT   rno as id, @innerrank := @innerrank+1 AS rank 
                FROM     reply 
                WHERE    COALESCE(parent, 0) = _parent AND bno = searchBno
                ORDER BY                 
                COALESCE(parent, rno) DESC, regDate ASC
                ) p 
        WHERE   p.rank > _rank LIMIT 0, 1;
        IF @id IS NOT NULL OR _parent = @start_with THEN
                SET @level = @level + 1;
                RETURN @id;
        END IF;
        SET @level := @level - 1;
        SET @innerrank = 0;
        SELECT COALESCE(p.parent, 0), p.rank
        INTO   _parent, _rank
        FROM   (
                SELECT rno as id, parent as parent, @innerrank := @innerrank+1 AS rank
                FROM    reply
                WHERE   COALESCE(parent, 0) = (
                    SELECT COALESCE(parent, 0) FROM reply WHERE rno = _parent
                    )  AND bno = searchBno
                ORDER BY COALESCE(parent, rno) DESC, regDate ASC
               ) p
        WHERE p.id = _parent;
    END LOOP;
END

CREATE DEFINER=`root`@`localhost` FUNCTION `get_reply_list_old`(searchBno INT) RETURNS int(11)
    READS SQL DATA
BEGIN
	DECLARE _parent INT;
    DECLARE _rank INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

    SET _parent = @id;
    SET _rank = 0;

    IF @id IS NULL THEN
            RETURN NULL;
    END IF;

    LOOP
        SET @innerrank = 0;
        SELECT p.id 
        INTO   @id
        FROM   (
                SELECT   rno as id, @innerrank := @innerrank+1 AS rank 
                FROM     reply 
                WHERE    COALESCE(parent, 0) = _parent AND bno = searchBno
                ORDER BY                 
                COALESCE(parent, rno) ASC, regDate DESC
                ) p 
        WHERE   p.rank > _rank LIMIT 0, 1;
        IF @id IS NOT NULL OR _parent = @start_with THEN
                SET @level = @level + 1;
                RETURN @id;
        END IF;
        SET @level := @level - 1;
        SET @innerrank = 0;
        SELECT COALESCE(p.parent, 0), p.rank
        INTO   _parent, _rank
        FROM   (
                SELECT rno as id, parent as parent, @innerrank := @innerrank+1 AS rank
                FROM    reply
                WHERE   COALESCE(parent, 0) = (
                    SELECT COALESCE(parent, 0) FROM reply WHERE rno = _parent
                    )  AND bno = searchBno
                ORDER BY COALESCE(parent, rno) ASC, regDate DESC
               ) p
        WHERE p.id = _parent;
    END LOOP;
END

CREATE DEFINER=`root`@`localhost` FUNCTION `get_reply_list_score`(searchBno INT) RETURNS int(11)
    READS SQL DATA
BEGIN
	DECLARE _parent INT;
    DECLARE _rank INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

    SET _parent = @id;
    SET _rank = 0;

    IF @id IS NULL THEN
            RETURN NULL;
    END IF;

    LOOP
        SET @innerrank = 0;
        SELECT p.id 
        INTO   @id
        FROM   (
                SELECT   rno as id, @innerrank := @innerrank+1 AS rank , (good_score - bad_score) as score
                FROM     reply 
                WHERE    COALESCE(parent, 0) = _parent AND bno = searchBno
                ORDER BY                 
                COALESCE(parent, rno) ASC, score DESC
                ) p 
        WHERE   p.rank > _rank LIMIT 0, 1;
        IF @id IS NOT NULL OR _parent = @start_with THEN
                SET @level = @level + 1;
                RETURN @id;
        END IF;
        SET @level := @level - 1;
        SET @innerrank = 0;
        SELECT COALESCE(p.parent, 0), p.rank
        INTO   _parent, _rank
        FROM   (
                SELECT rno as id, parent as parent, @innerrank := @innerrank+1 AS rank , (good_score - bad_score) as score
                FROM    reply
                WHERE   COALESCE(parent, 0) = (
                    SELECT COALESCE(parent, 0) FROM reply WHERE rno = _parent
                    )  AND bno = searchBno
                ORDER BY COALESCE(parent, rno) ASC, score DESC
               ) p
        WHERE p.id = _parent;
    END LOOP;
END

