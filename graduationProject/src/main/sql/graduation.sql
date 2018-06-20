/*
Navicat MySQL Data Transfer

Source Server         : ypy
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : graduation

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2018-06-15 22:16:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `gp_admin`
-- ----------------------------
DROP TABLE IF EXISTS `gp_admin`;
CREATE TABLE `gp_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gp_admin
-- ----------------------------
INSERT INTO `gp_admin` VALUES ('1', '萨达姆', '222222', '666666');

-- ----------------------------
-- Table structure for `gp_document`
-- ----------------------------
DROP TABLE IF EXISTS `gp_document`;
CREATE TABLE `gp_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createTime` varchar(255) DEFAULT NULL COMMENT '文档创建时间',
  `updateTime` varchar(255) DEFAULT NULL COMMENT '文档修改时间',
  `dname` varchar(255) DEFAULT NULL COMMENT '文档名称',
  `sid` int(11) DEFAULT NULL COMMENT '学生学号',
  `dpath` varchar(255) DEFAULT NULL COMMENT '文档上传后的路径',
  `agree` varchar(255) DEFAULT NULL COMMENT '审批意见',
  `approveTime` varchar(255) DEFAULT NULL COMMENT '审批时间',
  `isApprove` varchar(255) DEFAULT NULL COMMENT '是否审批通过',
  `downloadTime` varchar(255) DEFAULT NULL COMMENT '最近一次下载时间',
  PRIMARY KEY (`id`),
  KEY `fk_student_document_sid` (`sid`),
  CONSTRAINT `fk_student_document_sid` FOREIGN KEY (`sid`) REFERENCES `gp_students` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='文档表';

-- ----------------------------
-- Records of gp_document
-- ----------------------------
INSERT INTO `gp_document` VALUES ('18', null, '2018-06-10 21:17:00', '毕业设计系统开题报告', '1414011319', 'E://study//git-graduation//graduationProject//src//main//webapp//fileUpload//毕业设计系统开题报告.doc', '无', '2018-06-10 21:20:54', '是', '2018-06-10 21:19:02');
INSERT INTO `gp_document` VALUES ('19', null, '2018-06-11 10:20:10', '毕业设计系统说明书', '1414011319', 'E://study//git-graduation//graduationProject//src//main//webapp//fileUpload//毕业设计系统说明书.doc', '无', '2018-06-11 10:21:32', '是', '2018-06-11 10:21:19');
INSERT INTO `gp_document` VALUES ('20', null, '2018-06-12 14:47:46', '彩票系统开题报告', '1414011322', 'E://study//git-graduation//graduationProject//src//main//webapp//fileUpload//彩票系统开题报告.doc', 'wu', '2018-06-12 14:49:57', '是', '2018-06-12 14:49:36');

-- ----------------------------
-- Table structure for `gp_students`
-- ----------------------------
DROP TABLE IF EXISTS `gp_students`;
CREATE TABLE `gp_students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `sname` varchar(255) DEFAULT NULL,
  `sclass` varchar(255) DEFAULT NULL,
  `ssex` varchar(2) DEFAULT NULL,
  `sphone` varchar(255) DEFAULT NULL,
  `spassword` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `score1` varchar(255) DEFAULT NULL,
  `score2` varchar(255) DEFAULT NULL,
  `score3` varchar(255) DEFAULT NULL,
  `score4` varchar(255) DEFAULT NULL,
  `totalScore` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_cid` (`cid`),
  KEY `fk_student_teacher_tid` (`tid`),
  KEY `sid` (`sid`),
  CONSTRAINT `fk_student_course_cid` FOREIGN KEY (`cid`) REFERENCES `gp_title` (`cid`),
  CONSTRAINT `fk_student_teacher_tid` FOREIGN KEY (`tid`) REFERENCES `gp_teacher` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gp_students
-- ----------------------------
INSERT INTO `gp_students` VALUES ('1', '1414011319', 'joker', '14140X04', '男', '13191061576', '111111', '1', '109617', 'B', '', 'A', '', '未全部评完');
INSERT INTO `gp_students` VALUES ('2', '1414011322', 'ypy', '14140A01', '男', '13122222222', '111111', '37', '109617', 'C', '', '', '', '未全部评完');
INSERT INTO `gp_students` VALUES ('3', '1414011319', 'aaaa', '14140Y02', '男', '13855555555', '123456', '35', '100001', '', '', '', '', '');
INSERT INTO `gp_students` VALUES ('4', '1111111111', 'bbb', '14140A01', '男', '13811111111', '333333', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('5', '1222222222', 'ccc', '14140A01', '男', '13833333333', '222222', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('6', '1122222222', 'ddd', '14140A01', '男', '13522222222', '222111', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('7', '1223333333', 'eee', '14140A01', '女', '15522222222', '555555', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('8', '1122222222', 'fff', '14140A01', '男', '13542222111', '666666', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('9', '1521111111', 'ggg', '14140A01', '男', '13155555555', '555555', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('10', '1212121212', 'hhh', '14140A01', '男', '13911111111', '444444', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('11', '1211111111', 'iii', '14140A01', '女', '13154444444', '566666', null, null, null, null, null, null, null);
INSERT INTO `gp_students` VALUES ('12', '2111111111', 'jjj', '14140A01', '女', '15555555555', '668888', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `gp_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `gp_teacher`;
CREATE TABLE `gp_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `tname` varchar(255) DEFAULT NULL,
  `tphone` varchar(255) DEFAULT NULL,
  `tpassword` varchar(255) DEFAULT NULL,
  `tcount` int(11) DEFAULT NULL COMMENT '对该教师负责题目数进行计数',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gp_teacher
-- ----------------------------
INSERT INTO `gp_teacher` VALUES ('1', '109617', 'Michael', '13111111111', '666666', '2');
INSERT INTO `gp_teacher` VALUES ('2', '100001', 'Tom', '15555555555', '123456', '2');

-- ----------------------------
-- Table structure for `gp_title`
-- ----------------------------
DROP TABLE IF EXISTS `gp_title`;
CREATE TABLE `gp_title` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '题目编号',
  `cname` varchar(255) DEFAULT NULL COMMENT '题目名称',
  `cselected` varchar(255) DEFAULT NULL COMMENT '课题成绩',
  `required` varchar(255) DEFAULT NULL COMMENT '课题要求',
  `task` varchar(255) DEFAULT NULL COMMENT '课题任务',
  `tid` int(11) DEFAULT NULL,
  `updateTime` varchar(255) DEFAULT NULL COMMENT '创建或修改时间',
  `updateName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `fk_title_teacher_tid` (`tid`),
  CONSTRAINT `fk_title_teacher_tid` FOREIGN KEY (`tid`) REFERENCES `gp_teacher` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gp_title
-- ----------------------------
INSERT INTO `gp_title` VALUES ('1', '毕业设计系统', '是', '该设计基于Java语言、Mysql数据库、Apache服务器作为开发平台，系统采用B/S结构进行开发，完成一个学生毕设信息管理系统。', '其主要开发包括后台数据库的建立和维护以及前端应用程序两个方面。系统的内容涵盖学生毕设信息管理系统的主要业务，由学生/老师登录管理、毕设题目管理、毕设选题管理和毕设详细信息管理等模块组成。在模块设计时，对不同权限应该有不同的功能和特殊的限制。设计要合理，内容要丰富，要考虑与各模块间的兼容情况。', '109617', '2018-04-11 15:44:05', '萨达姆');
INSERT INTO `gp_title` VALUES ('35', '考勤系统', '是', '该设计基于Java语言、Mysql数据库、Apache服务器作为开发平台，系统采用B/S结构进行开发，完成一个学生毕设信息管理系统。', '其主要开发包括后台数据库的建立和维护以及前端应用程序两个方面。系统的内容涵盖学生毕设信息管理系统的主要业务，由学生/老师登录管理、毕设题目管理、毕设选题管理和毕设详细信息管理等模块组成。在模块设计时，对不同权限应该有不同的功能和特殊的限制。设计要合理，内容要丰富，要考虑与各模块间的兼容情况。', '100001', '2018-04-12 16:25:21', '萨达姆');
INSERT INTO `gp_title` VALUES ('36', '医疗系统', '否', '该设计基于Java语言、Mysql数据库、Apache服务器作为开发平台，系统采用B/S结构进行开发，完成一个学生毕设信息管理系统。', '其主要开发包括后台数据库的建立和维护以及前端应用程序两个方面。系统的内容涵盖学生毕设信息管理系统的主要业务，由学生/老师登录管理、毕设题目管理、毕设选题管理和毕设详细信息管理等模块组成。在模块设计时，对不同权限应该有不同的功能和特殊的限制。设计要合理，内容要丰富，要考虑与各模块间的兼容情况。', '100001', '2018-04-17 11:19:41', '萨达姆');
INSERT INTO `gp_title` VALUES ('37', '彩票系统', '是', '该设计基于Java语言、Mysql数据库、Apache服务器作为开发平台，系统采用B/S结构进行开发，完成一个学生毕设信息管理系统。', '其主要开发包括后台数据库的建立和维护以及前端应用程序两个方面。系统的内容涵盖学生毕设信息管理系统的主要业务，由学生/老师登录管理、毕设题目管理、毕设选题管理和毕设详细信息管理等模块组成。在模块设计时，对不同权限应该有不同的功能和特殊的限制。设计要合理，内容要丰富，要考虑与各模块间的兼容情况。', '109617', '2018-04-17 14:17:48', '萨达姆');
