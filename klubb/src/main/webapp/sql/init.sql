/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : pool

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2016-11-29 10:02:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for c_user
-- ----------------------------
DROP TABLE IF EXISTS `c_user`;
CREATE TABLE `c_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_NAME` varchar(10) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(64) NOT NULL COMMENT '密码',
  `STATUS` tinyint(2) NOT NULL COMMENT '状态，0可用，1不可用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='后台用户';

-- ----------------------------
-- Records of c_user
-- ----------------------------
INSERT INTO `c_user` VALUES ('1', 'admin', '111111', '0');

-- ----------------------------
-- Table structure for sys_access_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_access_log`;
CREATE TABLE `sys_access_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
  `IP` varchar(20) DEFAULT NULL COMMENT '源IP',
  `URL` varchar(100) DEFAULT NULL COMMENT '访问URL',
  `FUNC_CODE` varchar(30) DEFAULT NULL COMMENT '功能编码',
  `DESCRIPTION` varchar(100) DEFAULT NULL COMMENT '描述',
  `CREATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '访问时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接触日志';

-- ----------------------------
-- Records of sys_access_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TITLE` varchar(50) DEFAULT NULL COMMENT '活动名称',
  `IMG` varchar(100) DEFAULT NULL COMMENT '图片描述',
  `ABSTRACT` varchar(255) DEFAULT NULL COMMENT '摘要',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '活动内容',
  `ACT_TIME` datetime DEFAULT NULL COMMENT '活动时间',
  `STATUS` tinyint(2) DEFAULT NULL COMMENT '状态，0：草稿，1：正常',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER_ID` int(11) DEFAULT NULL COMMENT '创建人',
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `UPDATE_USER_ID` int(11) DEFAULT NULL COMMENT '修改用户ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动';

-- ----------------------------
-- Records of t_activity
-- ----------------------------

-- ----------------------------
-- Table structure for t_act_user
-- ----------------------------
DROP TABLE IF EXISTS `t_act_user`;
CREATE TABLE `t_act_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ACT_ID` int(11) DEFAULT NULL COMMENT '活动ID',
  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '报名时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参与活动登记';

-- ----------------------------
-- Records of t_act_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_config
-- ----------------------------
DROP TABLE IF EXISTS `t_config`;
CREATE TABLE `t_config` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(100) DEFAULT NULL COMMENT '台球厅名称',
  `BUSINESS_TIME` varchar(100) DEFAULT NULL COMMENT '营业时间',
  `PHONE` varchar(50) DEFAULT NULL COMMENT '联系电话',
  `PLACE_ID` varchar(100) DEFAULT NULL COMMENT 'google地图PLACEID',
  `ADDRESS` varchar(200) DEFAULT NULL COMMENT '地址',
  `MAP_URL` varchar(200) DEFAULT NULL COMMENT '地图链接',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='台球厅配置';

-- ----------------------------
-- Records of t_config
-- ----------------------------
INSERT INTO `t_config` VALUES ('1', 'Sundsvalls BiljardKlubb', '周六：早上10点\r\n周日：晚上20点', '+86 13711111111', 'ChIJ49WQXmCdX0YR9-T8Pz7wB9A', 'Klarabergsviadukten Stockholm', 'https://maps.google.com/?q=Klarabergsviadukten,+Stockholm,+%E7%91%9E%E5%85%B8&ftid=0x465f9d605e90d5e3:0xd007f03e3ffce4f7');

-- ----------------------------
-- Table structure for t_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_contact`;
CREATE TABLE `t_contact` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '手机号',
  `CONTENT` varchar(500) DEFAULT NULL COMMENT '内容',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `STATUS` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态：0：未读，1：已读',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='联系我们';

-- ----------------------------
-- Records of t_contact
-- ----------------------------
INSERT INTO `t_contact` VALUES ('1', '测试', '13711111111', '阿里斯顿附件为io\r\n王府井欧文', '2016-11-22 13:58:45', '1');
INSERT INTO `t_contact` VALUES ('2', '测试', '13721111111', '阿里斯顿附件为io\r\n王府井欧文', '2016-11-22 13:51:50', '0');

-- ----------------------------
-- Table structure for t_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation`;
CREATE TABLE `t_evaluation` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OBJ_ID` int(11) DEFAULT NULL COMMENT '评价对象ID',
  `OBJ_TYPE` tinyint(2) DEFAULT NULL COMMENT '操作对象类型，1：happytimes，2：活动',
  `CONTENT` varchar(300) DEFAULT NULL COMMENT '评价留言',
  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `P_ID` int(11) NOT NULL COMMENT '回复那条评论',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评价';

-- ----------------------------
-- Records of t_evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for t_introduce
-- ----------------------------
DROP TABLE IF EXISTS `t_introduce`;
CREATE TABLE `t_introduce` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TYPE` tinyint(2) DEFAULT NULL COMMENT '类型，1：台球厅介绍，2：人员介绍',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER_ID` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='介绍';

-- ----------------------------
-- Records of t_introduce
-- ----------------------------
INSERT INTO `t_introduce` VALUES ('1', '1', '<p>阿法士大夫</p>', '2016-11-10 21:54:22', null);
INSERT INTO `t_introduce` VALUES ('2', '2', '<p>asolgjqwgj</p>', '2016-11-10 21:55:53', null);
INSERT INTO `t_introduce` VALUES ('3', '0', '<p>阿法士大夫</p>', '2016-11-10 21:54:22', '0');
INSERT INTO `t_introduce` VALUES ('4', '0', '<p>asolgjqwgj</p>', '2016-11-10 21:55:53', '0');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONTENT` varchar(100) DEFAULT NULL COMMENT '通知内容',
  `STATUS` tinyint(2) DEFAULT NULL COMMENT '状态，0：可用，1：不可用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='通知';

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '通知', '0');

-- ----------------------------
-- Table structure for t_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_picture`;
CREATE TABLE `t_picture` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `URL` varchar(100) DEFAULT NULL COMMENT '访问url',
  `DESCRIPTION` varchar(200) DEFAULT NULL COMMENT '描述',
  `USER_ID` int(11) DEFAULT NULL COMMENT '归属用户ID',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `IS_RECOMMEND` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否推荐：0，不推荐，1，推荐',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='happytimes';

-- ----------------------------
-- Records of t_picture
-- ----------------------------

-- ----------------------------
-- Table structure for t_reset_rec
-- ----------------------------
DROP TABLE IF EXISTS `t_reset_rec`;
CREATE TABLE `t_reset_rec` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `EMAIL` varchar(50) NOT NULL COMMENT '邮箱',
  `UUID` varchar(64) NOT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reset_rec
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `EMAIL` varchar(50) NOT NULL COMMENT '邮箱',
  `PASSWORD` varchar(64) NOT NULL COMMENT '密码',
  `ID_NUMBER` varchar(50) DEFAULT NULL COMMENT '人口号',
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `NICKNAME` varchar(50) DEFAULT NULL COMMENT '昵称',
  `GENDER` tinyint(2) DEFAULT NULL COMMENT '性别，0：女，1：男',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '手机号',
  `STATUS` tinyint(2) NOT NULL COMMENT '状态，0可用，1不可用',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='前台用户';

-- ----------------------------
-- Records of t_user
-- ----------------------------
