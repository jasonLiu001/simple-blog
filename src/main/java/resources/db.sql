CREATE TABLE `blog` (
  `id` CHAR(32) NOT NULL COMMENT '主键，UUID作为键值',
  `title` VARCHAR(255) NOT NULL COMMENT '标题',
  `author` VARCHAR(50) NOT NULL COMMENT '作者',
  `summary` TEXT NOT NULL COMMENT '摘要',
  `content` TEXT NOT NULL COMMENT 'markdown格式的内容，用于重新编辑',
  `commentNum` INT(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `heartNum` INT(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
  `readNum` INT(11) NOT NULL DEFAULT '0' COMMENT '阅读数',
  `publishTime` DATETIME NOT NULL COMMENT '文章创建时间',
  `url` VARCHAR(100) NOT NULL COMMENT '文章相对URL',
  `signature` CHAR(32) NOT NULL COMMENT '文章哈希签名，防止出现重复文章',
  `categoryID` CHAR(32) NOT NULL COMMENT '文章类别ID',
  `lastUpdateTime` DATETIME NOT NULL COMMENT '文章上次修改时间',
  `path` VARCHAR(100) NOT NULL COMMENT '静态化的文件磁盘路径',
  `coverURL` VARCHAR(255) DEFAULT NULL COMMENT '封面图片',
  `type` INT(11) NOT NULL DEFAULT '0' COMMENT '博文类型，0表示普通博文，1表示富博文(带封面图片)',
  `status` INT(11) NOT NULL DEFAULT '0' COMMENT '博文状态，0显示，1不显示，2草稿',
  `statusName` VARCHAR(20) DEFAULT NULL COMMENT '状态名称：显示，不显示，草稿',
  `html` TEXT NOT NULL COMMENT 'html格式的博文，主要用于重新静态化',
  `tags` VARCHAR(256) DEFAULT NULL COMMENT '博文标签',
  `shareNum` INT(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `blog_tags` (
  `tagID` CHAR(32) NOT NULL,
  `blogID` CHAR(32) NOT NULL,
  PRIMARY KEY (`tagID`,`blogID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `category` (
  `id` CHAR(32) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `cdate` DATETIME DEFAULT NULL,
  `typeID` INT(11) DEFAULT '1',
  `keywords` VARCHAR(50) DEFAULT '',
  `blogNum` INT(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `comment` (
  `id` CHAR(32) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `content` TEXT NOT NULL,
  `cdate` DATETIME NOT NULL,
  `likeNum` INT(11) NOT NULL DEFAULT '0',
  `hateNum` INT(11) NOT NULL DEFAULT '0',
  `parent` CHAR(32) DEFAULT NULL,
  `blogID` CHAR(32) NOT NULL,
  `shareNum` INT(11) NOT NULL DEFAULT '0',
  `replyNum` INT(11) NOT NULL DEFAULT '0',
  `headURL` VARCHAR(100) DEFAULT NULL,
  `check` INT(11) DEFAULT '0' COMMENT '是否审核，0表示未审核，1表示审核',
  `status` INT(11) DEFAULT '1' COMMENT '是否合法，0未通过，1通过',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `notice` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` MEDIUMTEXT NOT NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `visible` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '0,不可见，1可见',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tags` (
  `id` CHAR(32) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `cdate` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `timeline` (
  `id` VARCHAR(20) NOT NULL COMMENT '主键',
  `createdDate` DATETIME NOT NULL COMMENT '创建时间',
  `displayName` VARCHAR(30) NOT NULL COMMENT '显示名称',
  `displayDate` DATETIME DEFAULT NULL COMMENT '显示日期',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `type` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) DEFAULT NULL,
  `cdate` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `nickname` VARCHAR(30) DEFAULT '游客',
  `headurl` VARCHAR(100) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `youlian` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) DEFAULT NULL,
  `logo` VARCHAR(100) DEFAULT NULL,
  `url` VARCHAR(100) DEFAULT NULL,
  `cdate` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE VIEW `blog_display`
AS SELECT
   `category`.`name` AS `categoryName`,
   `blog`.`id` AS `id`,
   `blog`.`title` AS `title`,
   `blog`.`author` AS `author`,
   `blog`.`summary` AS `summary`,
   `blog`.`commentNum` AS `commentNum`,
   `blog`.`readNum` AS `readNum`,
   `blog`.`url` AS `url`,
   `blog`.`publishTime` AS `publishTime`,
   `blog`.`type` AS `type`,
   `blog`.`status` AS `status`,
   `blog`.`coverURL` AS `coverURL`,
   `blog`.`heartNum` AS `heartNum`,
   `blog`.`tags` AS `tags`,
   `type`.`name` AS `typeName`,
   `type`.`id` AS `typeID`,
   `category`.`id` AS `categoryID`,
   `blog`.`content` AS `content`
FROM ((`category` JOIN `blog`) JOIN `type`) WHERE ((`category`.`id` = `blog`.`categoryID`) AND (`category`.`typeID` = `type`.`id`));


CREATE VIEW `blog_back_display`
AS SELECT
   `category`.`name` AS `categoryName`,
   `blog`.`id` AS `id`,
   `blog`.`title` AS `title`,
   `blog`.`author` AS `author`,
   `blog`.`commentNum` AS `commentNum`,
   `blog`.`readNum` AS `readNum`,
   `blog`.`url` AS `url`,
   `blog`.`publishTime` AS `publishTime`,
   `blog`.`type` AS `type`,
   `blog`.`status` AS `status`,
   `blog`.`statusName` AS `statusName`,
   `blog`.`heartNum` AS `heartNum`
FROM (`category` JOIN `blog`) WHERE (`category`.`id` = `blog`.`categoryID`);



CREATE VIEW `blog_display_by_tag`
AS SELECT
   `category`.`name` AS `categoryName`,
   `blog`.`id` AS `id`,
   `blog`.`title` AS `title`,
   `blog`.`author` AS `author`,
   `blog`.`summary` AS `summary`,
   `blog`.`commentNum` AS `commentNum`,
   `blog`.`readNum` AS `readNum`,
   `blog`.`url` AS `url`,
   `blog`.`publishTime` AS `publishTime`,
   `blog`.`type` AS `type`,
   `blog`.`status` AS `status`,
   `blog`.`coverURL` AS `coverURL`,
   `blog`.`heartNum` AS `heartNum`,
   `blog`.`tags` AS `tags`,
   `type`.`name` AS `typeName`,
   `type`.`id` AS `typeID`,
   `category`.`id` AS `categoryID`,
   `tags`.`id` AS `tagID`,
   `tags`.`name` AS `tagName`
FROM ((((`category` JOIN `blog`) JOIN `type`) JOIN `blog_tags`) JOIN `tags`) WHERE ((`category`.`id` = `blog`.`categoryID`) AND (`category`.`typeID` = `type`.`id`) AND (`blog_tags`.`blogID` = `blog`.`id`) AND (`blog_tags`.`tagID` = `tags`.`id`));


---- 开始初始化数据
LOCK TABLES `user` WRITE;

INSERT INTO `user` (`id`, `username`, `password`, `nickname`, `headurl`)
VALUES
	(737,'admin','E10ADC3949BA59ABBE56E057F20F883E','hunter','n');

UNLOCK TABLES;

LOCK TABLES `type` WRITE;

INSERT INTO `type` (`id`, `name`, `cdate`)
VALUES
	(1,'技术','2017-02-13 15:41:25');

UNLOCK TABLES;

LOCK TABLES `category` WRITE;

INSERT INTO `category` (`id`, `name`, `cdate`, `typeID`, `keywords`, `blogNum`)
VALUES
	('0deaf97437264ce69eac4f70cf8cb8f1','默认分类','2017-02-13 23:32:29',1,'',0);

UNLOCK TABLES;

