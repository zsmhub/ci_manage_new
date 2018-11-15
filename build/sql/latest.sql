# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: mini_program_course
# Generation Time: 2017-10-17 08:44:59 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(32) NOT NULL DEFAULT '',
  `value` longtext NOT NULL,
  `time` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='配置表';



# Dump of table sys_email_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_email_log`;

CREATE TABLE `sys_email_log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `To` varchar(50) NOT NULL,
  `Content` text NOT NULL COMMENT '邮件内容',
  `Status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否发送标识[0为未发送，1为已发送]',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时发邮件日志表';



# Dump of table sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ParentId` mediumint(9) NOT NULL DEFAULT '0',
  `Title` varchar(155) NOT NULL DEFAULT '',
  `Sort` smallint(6) NOT NULL DEFAULT '0',
  `LinkInfo` varchar(255) NOT NULL DEFAULT '',
  `Status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `icon` varchar(55) NOT NULL DEFAULT '' COMMENT '分类小图标',
  `Deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理后台菜单';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`Id`, `ParentId`, `Title`, `Sort`, `LinkInfo`, `Status`, `icon`, `Deleted`)
VALUES
  (1,0,'系统管理',-1,'',1,'',0),
  (2,0,'开发模块',-2,'',1,'',0),
  (5,2,'控制器管理',0,'a:3:{s:1:\"d\";s:5:\"admin\";s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:8:\"ctrllist\";}',1,'',0),
  (6,1,'菜单管理',0,'a:3:{s:1:\"d\";s:5:\"admin\";s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:8:\"menulist\";}',1,'',0),
  (7,1,'角色管理',2,'a:3:{s:1:\"d\";s:5:\"admin\";s:1:\"c\";s:4:\"Role\";s:1:\"a\";s:8:\"rolelist\";}',1,'',0),
  (9,2,'模型管理',0,'a:3:{s:1:\"d\";s:5:\"admin\";s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:7:\"modlist\";}',1,'',1),
  (10,1,'用户管理',3,'a:3:{s:1:\"d\";s:5:\"admin\";s:1:\"c\";s:4:\"User\";s:1:\"a\";s:8:\"userlist\";}',1,'',0);

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `Id` smallint(6) NOT NULL AUTO_INCREMENT,
  `Name` char(50) NOT NULL DEFAULT '' COMMENT '角色名',
  `Intro` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `Status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '角色状态 0:禁用,1:正常',
  `Permissions` text NOT NULL COMMENT '权限',
  `Deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`),
  KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`Id`, `Name`, `Intro`, `Status`, `Permissions`, `Deleted`)
VALUES
  (1,'系统管理员','系统管理员用户组',1,'a:7:{s:4:\"Ctrl\";a:7:{s:13:\"addcontroller\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:13:\"addcontroller\";s:1:\"d\";s:5:\"admin\";}s:9:\"addaction\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:9:\"addaction\";s:1:\"d\";s:5:\"admin\";}s:8:\"ctrllist\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:8:\"ctrllist\";s:1:\"d\";s:5:\"admin\";}s:8:\"funclist\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:8:\"funclist\";s:1:\"d\";s:5:\"admin\";}s:7:\"add_dir\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:7:\"add_dir\";s:1:\"d\";s:5:\"admin\";}s:8:\"editctrl\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:8:\"editctrl\";s:1:\"d\";s:5:\"admin\";}s:8:\"editfunc\";a:3:{s:1:\"c\";s:4:\"Ctrl\";s:1:\"a\";s:8:\"editfunc\";s:1:\"d\";s:5:\"admin\";}}s:3:\"Mod\";a:5:{s:7:\"modlist\";a:3:{s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:7:\"modlist\";s:1:\"d\";s:5:\"admin\";}s:8:\"addmodel\";a:3:{s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:8:\"addmodel\";s:1:\"d\";s:5:\"admin\";}s:7:\"addfunc\";a:3:{s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:7:\"addfunc\";s:1:\"d\";s:5:\"admin\";}s:7:\"methods\";a:3:{s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:7:\"methods\";s:1:\"d\";s:5:\"admin\";}s:7:\"add_dir\";a:3:{s:1:\"c\";s:3:\"Mod\";s:1:\"a\";s:7:\"add_dir\";s:1:\"d\";s:5:\"admin\";}}s:4:\"Menu\";a:6:{s:8:\"add_menu\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:8:\"add_menu\";s:1:\"d\";s:5:\"admin\";}s:9:\"edit_menu\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:9:\"edit_menu\";s:1:\"d\";s:5:\"admin\";}s:7:\"add_cat\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:7:\"add_cat\";s:1:\"d\";s:5:\"admin\";}s:8:\"edit_cat\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:8:\"edit_cat\";s:1:\"d\";s:5:\"admin\";}s:8:\"menulist\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:8:\"menulist\";s:1:\"d\";s:5:\"admin\";}s:6:\"delete\";a:3:{s:1:\"c\";s:4:\"Menu\";s:1:\"a\";s:6:\"delete\";s:1:\"d\";s:5:\"admin\";}}s:4:\"User\";a:4:{s:8:\"userlist\";a:3:{s:1:\"c\";s:4:\"User\";s:1:\"a\";s:8:\"userlist\";s:1:\"d\";s:5:\"admin\";}s:7:\"adduser\";a:3:{s:1:\"c\";s:4:\"User\";s:1:\"a\";s:7:\"adduser\";s:1:\"d\";s:5:\"admin\";}s:9:\"edit_user\";a:3:{s:1:\"c\";s:4:\"User\";s:1:\"a\";s:9:\"edit_user\";s:1:\"d\";s:5:\"admin\";}s:6:\"delete\";a:3:{s:1:\"c\";s:4:\"User\";s:1:\"a\";s:6:\"delete\";s:1:\"d\";s:5:\"admin\";}}s:4:\"Role\";a:4:{s:8:\"rolelist\";a:3:{s:1:\"c\";s:4:\"Role\";s:1:\"a\";s:8:\"rolelist\";s:1:\"d\";s:5:\"admin\";}s:7:\"addrole\";a:3:{s:1:\"c\";s:4:\"Role\";s:1:\"a\";s:7:\"addrole\";s:1:\"d\";s:5:\"admin\";}s:8:\"editrole\";a:3:{s:1:\"c\";s:4:\"Role\";s:1:\"a\";s:8:\"editrole\";s:1:\"d\";s:5:\"admin\";}s:6:\"delete\";a:3:{s:1:\"c\";s:4:\"Role\";s:1:\"a\";s:6:\"delete\";s:1:\"d\";s:5:\"admin\";}}s:4:\"Home\";a:1:{s:5:\"index\";a:3:{s:1:\"c\";s:4:\"Home\";s:1:\"a\";s:5:\"index\";s:1:\"d\";s:5:\"admin\";}}s:3:\"Api\";a:1:{s:7:\"ueditor\";a:3:{s:1:\"c\";s:3:\"Api\";s:1:\"a\";s:7:\"ueditor\";s:1:\"d\";s:5:\"admin\";}}}',0);

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `Id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `UserName` char(32) NOT NULL DEFAULT '' COMMENT '用户登录id',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `NickName` char(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `RoleId` smallint(6) NOT NULL DEFAULT '0' COMMENT '角色组ID',
  `Email` char(50) NOT NULL COMMENT '邮箱',
  `Status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态 0:禁用,1:正常',
  `LastLogTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最近登录时间',
  `LastLogIP` char(15) NOT NULL DEFAULT '' COMMENT '最近登录IP',
  `LogFaild` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '登陆失败次数',
  `Deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`),
  KEY `sys_user_ibfk_2` (`RoleId`),
  CONSTRAINT `sys_user_ibfk_2` FOREIGN KEY (`RoleId`) REFERENCES `sys_role` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`Id`, `UserName`, `Password`, `NickName`, `RoleId`, `Email`, `Status`, `LastLogTime`, `LastLogIP`, `LogFaild`, `Deleted`)
VALUES
  (2,'zhangshimian','25f9e794323b453885f5181f1b624d0b','zsm',1,'your email',1,1508229531,'172.17.0.1',0,0);

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
