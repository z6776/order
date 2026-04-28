/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : 127.0.0.1:33060
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 28/04/2026 17:30:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
INSERT INTO `fa_admin` VALUES (1, 'root', 'Admin', '508fc2ad52e0d1c04d05b8089ba14e39', 'kPGe6W', '/assets/img/avatar.png', '2834322062@qq.com', '13343523161', 0, 1776994883, '127.0.0.1', 1491635035, 1776994883, '124a9d40-084d-4bc2-a1c9-5315c351c099', 'normal');

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------
INSERT INTO `fa_admin_log` VALUES (1, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"ue5a\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758701444);
INSERT INTO `fa_admin_log` VALUES (2, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"captcha\":\"spex\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758701476);
INSERT INTO `fa_admin_log` VALUES (3, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"captcha\":\"72on\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758725817);
INSERT INTO `fa_admin_log` VALUES (4, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"captcha\":\"72on\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758725817);
INSERT INTO `fa_admin_log` VALUES (5, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"captcha\":\"qmbc\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758725827);
INSERT INTO `fa_admin_log` VALUES (6, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"captcha\":\"5die\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1758725846);
INSERT INTO `fa_admin_log` VALUES (7, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"fntm\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762754855);
INSERT INTO `fa_admin_log` VALUES (8, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762754950);
INSERT INTO `fa_admin_log` VALUES (9, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762754955);
INSERT INTO `fa_admin_log` VALUES (10, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762755035);
INSERT INTO `fa_admin_log` VALUES (11, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762755038);
INSERT INTO `fa_admin_log` VALUES (12, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762758723);
INSERT INTO `fa_admin_log` VALUES (13, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762758731);
INSERT INTO `fa_admin_log` VALUES (14, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762758757);
INSERT INTO `fa_admin_log` VALUES (15, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762758831);
INSERT INTO `fa_admin_log` VALUES (16, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"keeplogin\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762758882);
INSERT INTO `fa_admin_log` VALUES (17, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762765855);
INSERT INTO `fa_admin_log` VALUES (18, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762765860);
INSERT INTO `fa_admin_log` VALUES (19, 1, 'root', '/sHScvZLPoV.php/auth/rule/del', '权限管理 / 菜单规则 / 删除', '{\"action\":\"del\",\"ids\":\"85\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762765954);
INSERT INTO `fa_admin_log` VALUES (20, 1, 'root', '/sHScvZLPoV.php/user/group/add?dialog=1', '会员管理 / 会员分组 / 添加', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"rules\":\"\",\"name\":\"\",\"status\":\"normal\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762767769);
INSERT INTO `fa_admin_log` VALUES (21, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/94?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"sclass\",\"title\":\"学生管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"94\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762768643);
INSERT INTO `fa_admin_log` VALUES (22, 1, 'root', '/sHScvZLPoV.php/auth/rule/add?dialog=1', '权限管理 / 菜单规则 / 添加', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"0\",\"pid\":\"0\",\"name\":\"student\",\"title\":\"选课管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762768717);
INSERT INTO `fa_admin_log` VALUES (23, 1, 'root', '/sHScvZLPoV.php/auth/rule/add?dialog=1', '权限管理 / 菜单规则 / 添加', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"student\",\"title\":\"选课管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762768726);
INSERT INTO `fa_admin_log` VALUES (24, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/94?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"sclass\",\"title\":\"学生管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"94\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762768742);
INSERT INTO `fa_admin_log` VALUES (25, 1, 'root', '/sHScvZLPoV.php/auth/rule/del', '权限管理 / 菜单规则 / 删除', '{\"action\":\"del\",\"ids\":\"94\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769219);
INSERT INTO `fa_admin_log` VALUES (26, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/101?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/sclass\",\"title\":\"学生管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"101\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769324);
INSERT INTO `fa_admin_log` VALUES (27, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/101?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/sclass\",\"title\":\"班级管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"101\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769558);
INSERT INTO `fa_admin_log` VALUES (28, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/107?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/teacher\",\"title\":\"教师管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"107\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769573);
INSERT INTO `fa_admin_log` VALUES (29, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/113?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/selectclass\",\"title\":\"选课管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"113\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769585);
INSERT INTO `fa_admin_log` VALUES (30, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/119?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/student\",\"title\":\"学生管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"119\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769599);
INSERT INTO `fa_admin_log` VALUES (31, 1, 'root', '/sHScvZLPoV.php/auth/rule/edit/ids/125?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"100\",\"name\":\"student\\/course\",\"title\":\"课程管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"125\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762769807);
INSERT INTO `fa_admin_log` VALUES (32, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762926527);
INSERT INTO `fa_admin_log` VALUES (33, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762926532);
INSERT INTO `fa_admin_log` VALUES (34, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762926545);
INSERT INTO `fa_admin_log` VALUES (35, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"0\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762935296);
INSERT INTO `fa_admin_log` VALUES (36, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/0?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s001\",\"courseid\":\"k001\",\"score\":\"30\"},\"ids\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762935304);
INSERT INTO `fa_admin_log` VALUES (37, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/0?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s0011\",\"courseid\":\"k001\",\"score\":\"30\"},\"ids\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762935308);
INSERT INTO `fa_admin_log` VALUES (38, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s0012\",\"courseid\":\"123\",\"score\":\"123\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762937583);
INSERT INTO `fa_admin_log` VALUES (39, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s0012\",\"courseid\":\"1\",\"score\":\"1\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762937621);
INSERT INTO `fa_admin_log` VALUES (40, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762938829);
INSERT INTO `fa_admin_log` VALUES (41, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762938837);
INSERT INTO `fa_admin_log` VALUES (42, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939630);
INSERT INTO `fa_admin_log` VALUES (43, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939687);
INSERT INTO `fa_admin_log` VALUES (44, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939723);
INSERT INTO `fa_admin_log` VALUES (45, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939770);
INSERT INTO `fa_admin_log` VALUES (46, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k004\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939783);
INSERT INTO `fa_admin_log` VALUES (47, 1, 'root', '/sHScvZLPoV.php/student/student/add?dialog=1', '选课管理 / 学生管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"测试名称\",\"sex\":\"213\",\"classnumber\":\"123\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762939836);
INSERT INTO `fa_admin_log` VALUES (48, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k002\",\"score\":\"1\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940212);
INSERT INTO `fa_admin_log` VALUES (49, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"1\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940942);
INSERT INTO `fa_admin_log` VALUES (50, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"4\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940944);
INSERT INTO `fa_admin_log` VALUES (51, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"3\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940945);
INSERT INTO `fa_admin_log` VALUES (52, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"2\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940949);
INSERT INTO `fa_admin_log` VALUES (53, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002\",\"courseid\":\"k002\",\"score\":\"1\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940956);
INSERT INTO `fa_admin_log` VALUES (54, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003\",\"courseid\":\"k005\",\"score\":\"1\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762940961);
INSERT INTO `fa_admin_log` VALUES (55, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762995807);
INSERT INTO `fa_admin_log` VALUES (56, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/6?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s001\",\"courseid\":\"k003\",\"score\":\"1\"},\"ids\":\"6\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762998976);
INSERT INTO `fa_admin_log` VALUES (57, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/6?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s004\",\"courseid\":\"k001\",\"score\":\"1\"},\"ids\":\"6\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762998985);
INSERT INTO `fa_admin_log` VALUES (58, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/6?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s004\",\"courseid\":\"k001\",\"score\":\"100\"},\"ids\":\"6\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762998994);
INSERT INTO `fa_admin_log` VALUES (59, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k002\",\"score\":\"123\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762999164);
INSERT INTO `fa_admin_log` VALUES (60, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001\",\"courseid\":\"k005\",\"score\":\"111\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762999511);
INSERT INTO `fa_admin_log` VALUES (61, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001\",\"courseid\":\"k005\",\"score\":\"111\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762999578);
INSERT INTO `fa_admin_log` VALUES (62, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001\",\"courseid\":\"k005\",\"score\":\"111\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1762999847);
INSERT INTO `fa_admin_log` VALUES (63, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001\",\"courseid\":\"k005\",\"score\":\"111\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763000147);
INSERT INTO `fa_admin_log` VALUES (64, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001\",\"courseid\":\"k005\",\"score\":\"111\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763000198);
INSERT INTO `fa_admin_log` VALUES (65, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003,s103\",\"courseid\":\"k004\",\"score\":\"123\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763000399);
INSERT INTO `fa_admin_log` VALUES (66, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"16\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004095);
INSERT INTO `fa_admin_log` VALUES (67, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"15\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004097);
INSERT INTO `fa_admin_log` VALUES (68, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"14\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004098);
INSERT INTO `fa_admin_log` VALUES (69, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"13\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004103);
INSERT INTO `fa_admin_log` VALUES (70, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"12\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004105);
INSERT INTO `fa_admin_log` VALUES (71, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"11\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004106);
INSERT INTO `fa_admin_log` VALUES (72, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"9\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004108);
INSERT INTO `fa_admin_log` VALUES (73, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"6\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004109);
INSERT INTO `fa_admin_log` VALUES (74, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"5\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004111);
INSERT INTO `fa_admin_log` VALUES (75, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"7\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004112);
INSERT INTO `fa_admin_log` VALUES (76, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"8\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004115);
INSERT INTO `fa_admin_log` VALUES (77, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"10\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004117);
INSERT INTO `fa_admin_log` VALUES (78, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k005\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004130);
INSERT INTO `fa_admin_log` VALUES (79, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k005\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004170);
INSERT INTO `fa_admin_log` VALUES (80, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"26,25,24,23,22,21,20,19,18,17\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004315);
INSERT INTO `fa_admin_log` VALUES (81, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k002\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004335);
INSERT INTO `fa_admin_log` VALUES (82, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k002\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004398);
INSERT INTO `fa_admin_log` VALUES (83, 1, 'root', '/sHScvZLPoV.php/student/selectclass/del', '选课管理 / 选课管理 / 删除', '{\"action\":\"del\",\"ids\":\"36,35,34,33,32,31,30,29,28,27\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004561);
INSERT INTO `fa_admin_log` VALUES (84, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k005\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004570);
INSERT INTO `fa_admin_log` VALUES (85, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002\",\"courseid\":\"k002\",\"score\":\"9\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763004589);
INSERT INTO `fa_admin_log` VALUES (86, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763088179);
INSERT INTO `fa_admin_log` VALUES (87, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763088182);
INSERT INTO `fa_admin_log` VALUES (88, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763088183);
INSERT INTO `fa_admin_log` VALUES (89, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763088191);
INSERT INTO `fa_admin_log` VALUES (90, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763088202);
INSERT INTO `fa_admin_log` VALUES (91, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763342180);
INSERT INTO `fa_admin_log` VALUES (92, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763344633);
INSERT INTO `fa_admin_log` VALUES (93, 0, 'Unknown', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763344644);
INSERT INTO `fa_admin_log` VALUES (94, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763344649);
INSERT INTO `fa_admin_log` VALUES (95, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763363321);
INSERT INTO `fa_admin_log` VALUES (96, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s003,s001,s103,s004,s002\",\"courseid\":\"k003\",\"score\":\"100\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763367795);
INSERT INTO `fa_admin_log` VALUES (97, 1, 'root', '/sHScvZLPoV.php/student/selectclass/add?dialog=1', '选课管理 / 选课管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s002,s003,s001,s103,s004\",\"courseid\":\"k004\",\"score\":\"900\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763367809);
INSERT INTO `fa_admin_log` VALUES (98, 1, 'root', '/sHScvZLPoV.php/general.config/edit', '常规管理 / 系统配置 / 编辑', '{\"__token__\":\"***\",\"row\":{\"name\":\"测试\",\"beian\":\"\",\"version\":\"1.0.49\",\"timezone\":\"Asia\\/Shanghai\",\"forbiddenip\":\"\",\"languages\":\"{&quot;backend&quot;:&quot;zh-cn&quot;,&quot;frontend&quot;:&quot;zh-cn&quot;}\",\"fixedpage\":\"dashboard\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763370946);
INSERT INTO `fa_admin_log` VALUES (99, 1, 'root', '/sHScvZLPoV.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763431155);
INSERT INTO `fa_admin_log` VALUES (100, 1, 'root', '/sHScvZLPoV.php/student/selectclass/edit/ids/52?dialog=1', '选课管理 / 选课管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"studentnumber\":\"s004\",\"courseid\":\"k003\",\"score\":\"900\"},\"ids\":\"52\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1763431173);
INSERT INTO `fa_admin_log` VALUES (101, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774840550);
INSERT INTO `fa_admin_log` VALUES (102, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774840604);
INSERT INTO `fa_admin_log` VALUES (103, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774840608);
INSERT INTO `fa_admin_log` VALUES (104, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774840615);
INSERT INTO `fa_admin_log` VALUES (105, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774855131);
INSERT INTO `fa_admin_log` VALUES (106, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774855448);
INSERT INTO `fa_admin_log` VALUES (107, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774856276);
INSERT INTO `fa_admin_log` VALUES (108, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774856294);
INSERT INTO `fa_admin_log` VALUES (109, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774856942);
INSERT INTO `fa_admin_log` VALUES (110, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774857016);
INSERT INTO `fa_admin_log` VALUES (111, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774857988);
INSERT INTO `fa_admin_log` VALUES (112, 1, 'root', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774858446);
INSERT INTO `fa_admin_log` VALUES (113, 0, 'Unknown', '/DNKEmLwBIW.php/index/logout', '', '{\"__token__\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774858460);
INSERT INTO `fa_admin_log` VALUES (114, 1, 'root', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\",\"keeplogin\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774858473);
INSERT INTO `fa_admin_log` VALUES (115, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/138?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"dish\",\"title\":\"菜品管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"138\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774949360);
INSERT INTO `fa_admin_log` VALUES (116, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/131?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"goods\",\"title\":\"商品管理\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"131\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774949395);
INSERT INTO `fa_admin_log` VALUES (117, 1, 'root', '/DNKEmLwBIW.php/auth/rule/del', '权限管理 / 菜单规则 / 删除', '{\"action\":\"del\",\"ids\":\"100\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774949405);
INSERT INTO `fa_admin_log` VALUES (118, 1, 'root', '/DNKEmLwBIW.php/goods/category/add?dialog=1', '商品管理 / 商品分类管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"小吃店\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:39:35\",\"update_time\":\"2026-03-31 17:39:35\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774949985);
INSERT INTO `fa_admin_log` VALUES (119, 1, 'root', '/DNKEmLwBIW.php/goods/category/edit/ids/1?dialog=1', '商品管理 / 商品分类管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"烤串\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:39:35\",\"update_time\":\"2026-03-31 17:39:35\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950005);
INSERT INTO `fa_admin_log` VALUES (120, 1, 'root', '/DNKEmLwBIW.php/goods/category/add?dialog=1', '商品管理 / 商品分类管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"小吃\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:40:07\",\"update_time\":\"2026-03-31 17:40:07\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950012);
INSERT INTO `fa_admin_log` VALUES (121, 1, 'root', '/DNKEmLwBIW.php/goods/category/edit/ids/1?dialog=1', '商品管理 / 商品分类管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"烤串\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:39:35\",\"update_time\":\"2026-03-31 17:40:05\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950034);
INSERT INTO `fa_admin_log` VALUES (122, 1, 'root', '/DNKEmLwBIW.php/goods/category/add?dialog=1', '商品管理 / 商品分类管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"素菜\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:40:36\",\"update_time\":\"2026-03-31 17:40:36\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950046);
INSERT INTO `fa_admin_log` VALUES (123, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/138?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"dish\",\"title\":\"菜品管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"138\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950882);
INSERT INTO `fa_admin_log` VALUES (124, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/138?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"dish\",\"title\":\"菜品管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"138\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774950896);
INSERT INTO `fa_admin_log` VALUES (125, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/132?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"goods\\/category\",\"title\":\"商品分类管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"132\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774951017);
INSERT INTO `fa_admin_log` VALUES (126, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/138?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"goods\\/category\",\"title\":\"菜品管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"138\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774951024);
INSERT INTO `fa_admin_log` VALUES (127, 1, 'root', '/DNKEmLwBIW.php/auth/rule/edit/ids/138?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"131\",\"name\":\"goods\\/dish\",\"title\":\"菜品管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"138\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1774951029);
INSERT INTO `fa_admin_log` VALUES (128, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940118);
INSERT INTO `fa_admin_log` VALUES (129, 0, 'Unknown', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"keeplogin\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940119);
INSERT INTO `fa_admin_log` VALUES (130, 1, 'root', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940213);
INSERT INTO `fa_admin_log` VALUES (131, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"1\",\"name\":\"肉串\",\"price\":\"1\",\"image\":\"\",\"description\":\"123123\",\"status\":\"1\",\"created_at\":\"2026-04-23 18:38:15\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940714);
INSERT INTO `fa_admin_log` VALUES (132, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"1\",\"name\":\"肉串\",\"price\":\"1\",\"image\":\"\",\"description\":\"123123\",\"status\":\"1\",\"created_at\":\"2026-04-23 18:38:15\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940720);
INSERT INTO `fa_admin_log` VALUES (133, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"1\",\"name\":\"肉串\",\"price\":\"1\",\"image\":\"\",\"description\":\"123123\",\"status\":\"1\",\"created_at\":\"2026-04-23 18:38:15\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776940764);
INSERT INTO `fa_admin_log` VALUES (134, 1, 'root', '/DNKEmLwBIW.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"root\",\"password\":\"***\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776994883);
INSERT INTO `fa_admin_log` VALUES (135, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"2\",\"name\":\"测试名称\",\"price\":\"1\",\"image\":\"1\",\"description\":\"1\",\"status\":\"1\",\"created_at\":\"2026-04-24 09:41:44\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776994947);
INSERT INTO `fa_admin_log` VALUES (136, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"1\",\"name\":\"测试名称\",\"price\":\"1\",\"image\":\"1\",\"description\":\"1212\",\"status\":\"1\",\"created_at\":\"2026-04-24 10:09:31\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776996579);
INSERT INTO `fa_admin_log` VALUES (137, 1, 'root', '/DNKEmLwBIW.php/ajax/upload', '', '{\"category\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776998343);
INSERT INTO `fa_admin_log` VALUES (138, 1, 'root', '/DNKEmLwBIW.php/ajax/upload', '', '{\"category\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776998462);
INSERT INTO `fa_admin_log` VALUES (139, 1, 'root', '/DNKEmLwBIW.php/goods/dish/edit/ids/5?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"2\",\"name\":\"测试名称\",\"price\":\"1.00\",\"image\":\"\\/uploads\\/20260424\\/74f792b9594f14859ec9ec9706b9f9e4.jpg\",\"description\":\"1212\",\"status\":\"1\",\"created_at\":\"2026-04-24 10:09:31\"},\"ids\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1776998463);
INSERT INTO `fa_admin_log` VALUES (140, 1, 'root', '/DNKEmLwBIW.php/ajax/upload', '', '{\"category\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777009015);
INSERT INTO `fa_admin_log` VALUES (141, 1, 'root', '/DNKEmLwBIW.php/goods/dish/add?dialog=1', '商品管理 / 菜品管理', '{\"dialog\":\"1\",\"row\":{\"category_id\":\"1\",\"name\":\"测试发型\",\"price\":\"123\",\"image\":\"\\/uploads\\/20260424\\/74f792b9594f14859ec9ec9706b9f9e4.jpg\",\"description\":\"我的描述\",\"status\":\"1\",\"created_at\":\"2026-04-24 13:36:40\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777009019);
INSERT INTO `fa_admin_log` VALUES (142, 1, 'root', '/DNKEmLwBIW.php/goods/category/edit/ids/3?dialog=1', '商品管理 / 商品分类管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"素菜\",\"sort\":\"0\",\"status\":\"0\",\"create_time\":\"2026-03-31 17:40:36\",\"update_time\":\"2026-03-31 17:40:36\"},\"ids\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777009033);
INSERT INTO `fa_admin_log` VALUES (143, 1, 'root', '/DNKEmLwBIW.php/goods/category/edit/ids/3?dialog=1', '商品管理 / 商品分类管理 / 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"素菜\",\"sort\":\"0\",\"status\":\"1\",\"create_time\":\"2026-03-31 17:40:36\",\"update_time\":\"2026-04-24 13:37:13\"},\"ids\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777009038);
INSERT INTO `fa_admin_log` VALUES (144, 1, 'root', '/DNKEmLwBIW.php/auth/rule/add?dialog=1', '权限管理 / 菜单规则 / 添加', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"order\",\"title\":\"订单管理\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777010177);
INSERT INTO `fa_admin_log` VALUES (145, 1, 'root', '/DNKEmLwBIW.php/auth/rule/add?dialog=1', '权限管理 / 菜单规则 / 添加', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"144\",\"name\":\"order\\/order\",\"title\":\"订单列表\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777010205);
INSERT INTO `fa_admin_log` VALUES (146, 1, 'root', '/DNKEmLwBIW.php/user/user/del', '会员管理 / 会员管理 / 删除', '{\"action\":\"del\",\"ids\":\"15\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777011123);
INSERT INTO `fa_admin_log` VALUES (147, 1, 'root', '/DNKEmLwBIW.php/user/user/del', '会员管理 / 会员管理 / 删除', '{\"action\":\"del\",\"ids\":\"15\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777011729);
INSERT INTO `fa_admin_log` VALUES (148, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777012129);
INSERT INTO `fa_admin_log` VALUES (149, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777012130);
INSERT INTO `fa_admin_log` VALUES (150, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777012213);
INSERT INTO `fa_admin_log` VALUES (151, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777012216);
INSERT INTO `fa_admin_log` VALUES (152, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777012217);
INSERT INTO `fa_admin_log` VALUES (153, 1, 'root', '/DNKEmLwBIW.php/order/order/add?dialog=1', '订单管理 / 订单列表', '{\"dialog\":\"1\",\"row\":{\"order_no\":\"123\",\"user_id\":\"15\",\"dining_type\":\"0\",\"table_no\":\"\",\"takeaway_code\":\"\",\"total_amount\":\"1\",\"pay_time\":\"2026-04-24 15:00:43\",\"remark\":\"\",\"created_at\":\"2026-04-24 15:00:43\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777014055);
INSERT INTO `fa_admin_log` VALUES (154, 1, 'root', '/DNKEmLwBIW.php/order/order/del', '订单管理 / 订单列表', '{\"action\":\"del\",\"ids\":\"1\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 1777014061);

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_area
-- ----------------------------

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '宽度',
  `imageheight` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
INSERT INTO `fa_attachment` VALUES (1, '', 1, 0, '/assets/img/qrcode.png', 150, 150, 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `fa_attachment` VALUES (2, '', 1, 0, '/uploads/20260424/74f792b9594f14859ec9ec9706b9f9e4.jpg', 781, 815, 'jpeg', 1, 'f66f38f33a87e950672f437156385343fbf2b466.jpg', 115650, 'image/jpeg', '', 1776998343, 1777009015, 1777009015, 'local', '55eaee962c7bd1e24583e655a817835ec372862c');

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
INSERT INTO `fa_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
INSERT INTO `fa_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
INSERT INTO `fa_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1491635035, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', 1, NULL, '', 'cjgl', 'chajianguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', 1, NULL, '', 'jsz', 'juesezu', 1491635035, 1491635035, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `fa_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `fa_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `fa_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `fa_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (131, 'file', 0, 'goods', '商品管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'spgl', 'shangpinguanli', 1774949239, 1774949395, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (132, 'file', 131, 'goods/category', '商品分类管理', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'spflgl', 'shangpinfenleiguanli', 1774949239, 1774951017, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (133, 'file', 132, 'goods/category/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1774949239, 1774949814, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (134, 'file', 132, 'goods/category/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1774949239, 1774949814, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (135, 'file', 132, 'goods/category/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1774949239, 1774949814, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (136, 'file', 132, 'goods/category/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1774949239, 1774949814, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (137, 'file', 132, 'goods/category/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1774949239, 1774949814, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (138, 'file', 131, 'goods/dish', '菜品管理', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'cpgl', 'caipinguanli', 1774949285, 1774951029, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (139, 'file', 138, 'dish/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1774949285, 1774950226, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (140, 'file', 138, 'dish/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1774949285, 1774950226, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (141, 'file', 138, 'dish/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1774949285, 1774950226, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (142, 'file', 138, 'dish/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1774949285, 1774950226, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (143, 'file', 138, 'dish/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1774949285, 1774950226, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (144, 'file', 0, 'order', '订单管理', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'ddgl', 'dingdanguanli', 1777010177, 1777010177, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (145, 'file', 144, 'order/order', '订单列表', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'ddlb', 'dingdanliebiao', 1777010205, 1777010205, 0, 'normal');

-- ----------------------------
-- Table structure for fa_cart
-- ----------------------------
DROP TABLE IF EXISTS `fa_cart`;
CREATE TABLE `fa_cart`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `dish_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `selected` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1-选中 0-未选中',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_user_dish`(`user_id`, `dish_id`) USING BTREE,
  INDEX `dish_id`(`dish_id`) USING BTREE,
  CONSTRAINT `fa_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `fa_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fa_cart_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `fa_dish` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cart
-- ----------------------------

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称，如“热菜”“凉菜”',
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT '排序，越小越靠前',
  `status` enum('1','0') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '1-启用 0-禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_category
-- ----------------------------

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '可见条件',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_config
-- ----------------------------
INSERT INTO `fa_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '测试', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.53', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `fa_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'password', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}', '', '', '', '');

-- ----------------------------
-- Table structure for fa_course
-- ----------------------------
DROP TABLE IF EXISTS `fa_course`;
CREATE TABLE `fa_course`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `coursename` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `coursescore` int(3) NULL DEFAULT NULL,
  `teacherid` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_teacherid`(`teacherid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_course
-- ----------------------------
INSERT INTO `fa_course` VALUES ('k001', '数据库', 100, 't001');
INSERT INTO `fa_course` VALUES ('k002', 'java', 100, 't002');
INSERT INTO `fa_course` VALUES ('k003', '数学', 100, 't003');
INSERT INTO `fa_course` VALUES ('k004', '英语', 100, 't004');
INSERT INTO `fa_course` VALUES ('k005', 'sql', 100, 't005');

-- ----------------------------
-- Table structure for fa_dish
-- ----------------------------
DROP TABLE IF EXISTS `fa_dish`;
CREATE TABLE `fa_dish`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜品名称',
  `price` decimal(8, 2) NOT NULL COMMENT '单价',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜品图片',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `status` enum('1','0') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '1-上架 0-下架',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category`(`category_id`) USING BTREE,
  CONSTRAINT `fa_dish_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `fa_goods_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_dish
-- ----------------------------
INSERT INTO `fa_dish` VALUES (5, 2, '测试名称', 1.00, '/uploads/20260424/74f792b9594f14859ec9ec9706b9f9e4.jpg', '1212', '1', '2026-04-24 10:09:31');
INSERT INTO `fa_dish` VALUES (6, 1, '测试发型', 123.00, '/uploads/20260424/74f792b9594f14859ec9ec9706b9f9e4.jpg', '我的描述', '1', '2026-04-24 13:36:40');

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_ems
-- ----------------------------

-- ----------------------------
-- Table structure for fa_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_goods_category`;
CREATE TABLE `fa_goods_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类ID（主键）',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序值，数字越小越靠前',
  `status` enum('1','0') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态 1=启用 0=禁用',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_goods_category
-- ----------------------------
INSERT INTO `fa_goods_category` VALUES (1, '烤串', 0, '1', '2026-03-31 17:39:35', '2026-03-31 17:40:05');
INSERT INTO `fa_goods_category` VALUES (2, '小吃', 0, '1', '2026-03-31 17:40:07', '2026-03-31 17:40:07');
INSERT INTO `fa_goods_category` VALUES (3, '素菜', 0, '1', '2026-03-31 17:40:36', '2026-04-24 13:37:18');

-- ----------------------------
-- Table structure for fa_message
-- ----------------------------
DROP TABLE IF EXISTS `fa_message`;
CREATE TABLE `fa_message`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `message` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '留言信息',
  `createtime` timestamp(6) NULL DEFAULT NULL COMMENT '创建时间',
  `delstatus` int(4) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_message
-- ----------------------------

-- ----------------------------
-- Table structure for fa_order
-- ----------------------------
DROP TABLE IF EXISTS `fa_order`;
CREATE TABLE `fa_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `user_id` int(10) UNSIGNED NOT NULL,
  `dining_type` tinyint(4) NOT NULL COMMENT '就餐方式：1-堂食 2-自取',
  `table_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '桌号（堂食时填写）',
  `takeaway_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取餐码（自取时生成）',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-待支付 1-已支付 2-制作中 3-已完成 4-已取消',
  `pay_time` datetime(0) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户备注',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_order_no`(`order_no`) USING BTREE,
  INDEX `idx_user`(`user_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  CONSTRAINT `fa_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `fa_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_order
-- ----------------------------

-- ----------------------------
-- Table structure for fa_order_item
-- ----------------------------
DROP TABLE IF EXISTS `fa_order_item`;
CREATE TABLE `fa_order_item`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(10) UNSIGNED NOT NULL,
  `dish_id` int(10) UNSIGNED NOT NULL,
  `dish_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '快照菜品名',
  `dish_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快照图片',
  `price` decimal(8, 2) NOT NULL COMMENT '下单时单价',
  `quantity` int(10) UNSIGNED NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL COMMENT '小计',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order`(`order_id`) USING BTREE,
  INDEX `dish_id`(`dish_id`) USING BTREE,
  CONSTRAINT `fa_order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `fa_order` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fa_order_item_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `fa_dish` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for fa_sclass
-- ----------------------------
DROP TABLE IF EXISTS `fa_sclass`;
CREATE TABLE `fa_sclass`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '班级id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '班级名称',
  `num` int(5) NULL DEFAULT NULL COMMENT '班级人数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_sclass
-- ----------------------------
INSERT INTO `fa_sclass` VALUES ('J001', '计一班', 40);
INSERT INTO `fa_sclass` VALUES ('J002', '计二班', 40);
INSERT INTO `fa_sclass` VALUES ('J003', '计三班', 40);
INSERT INTO `fa_sclass` VALUES ('J004', '计四班', 40);

-- ----------------------------
-- Table structure for fa_selectclass
-- ----------------------------
DROP TABLE IF EXISTS `fa_selectclass`;
CREATE TABLE `fa_selectclass`  (
  `studentnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `courseid` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `score` int(5) NOT NULL,
  `id` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_selectclass
-- ----------------------------
INSERT INTO `fa_selectclass` VALUES ('s004', 'k003', 100, 46);
INSERT INTO `fa_selectclass` VALUES ('s103', 'k003', 100, 45);
INSERT INTO `fa_selectclass` VALUES ('s001', 'k003', 100, 44);
INSERT INTO `fa_selectclass` VALUES ('s003', 'k003', 100, 43);
INSERT INTO `fa_selectclass` VALUES ('s002', 'k002', 9, 42);
INSERT INTO `fa_selectclass` VALUES ('s004', 'k005', 100, 41);
INSERT INTO `fa_selectclass` VALUES ('s103', 'k005', 100, 40);
INSERT INTO `fa_selectclass` VALUES ('s001', 'k005', 100, 39);
INSERT INTO `fa_selectclass` VALUES ('s003', 'k005', 100, 38);
INSERT INTO `fa_selectclass` VALUES ('s002', 'k005', 100, 37);
INSERT INTO `fa_selectclass` VALUES ('s002', 'k003', 100, 47);
INSERT INTO `fa_selectclass` VALUES ('s002', 'k004', 900, 48);
INSERT INTO `fa_selectclass` VALUES ('s003', 'k004', 900, 49);
INSERT INTO `fa_selectclass` VALUES ('s001', 'k004', 900, 50);
INSERT INTO `fa_selectclass` VALUES ('s103', 'k004', 900, 51);
INSERT INTO `fa_selectclass` VALUES ('s004', 'k003', 900, 52);

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_sms
-- ----------------------------

-- ----------------------------
-- Table structure for fa_student
-- ----------------------------
DROP TABLE IF EXISTS `fa_student`;
CREATE TABLE `fa_student`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sex` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `classnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`classnumber`) USING BTREE,
  CONSTRAINT `fk_student_class` FOREIGN KEY (`classnumber`) REFERENCES `fa_sclass` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_student
-- ----------------------------
INSERT INTO `fa_student` VALUES ('s001', 'zhangsan', '男', 'J001');
INSERT INTO `fa_student` VALUES ('s002', 'lisi', '女', 'J002');
INSERT INTO `fa_student` VALUES ('s003', 'wangwu', '女', 'J003');
INSERT INTO `fa_student` VALUES ('s004', 'zhaoliu', '女', 'J004');
INSERT INTO `fa_student` VALUES ('s103', 'zhangsi', '男', 'j003');

-- ----------------------------
-- Table structure for fa_teacher
-- ----------------------------
DROP TABLE IF EXISTS `fa_teacher`;
CREATE TABLE `fa_teacher`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `academictitle` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_teacher
-- ----------------------------
INSERT INTO `fa_teacher` VALUES ('t001', 'wuping', '教授');
INSERT INTO `fa_teacher` VALUES ('t002', 'zhangshuai', '讲师');
INSERT INTO `fa_teacher` VALUES ('t003', 'liguoqiang', '副教授');
INSERT INTO `fa_teacher` VALUES ('t004', 'wangni', '讲师');
INSERT INTO `fa_teacher` VALUES ('t005', 'liubo', '讲师');

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT 0 COMMENT '会员ID',
  `admin_id` int(10) NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '省市',
  `array` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数组:value=值',
  `json` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10, 2) UNSIGNED NULL COMMENT '价格',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击',
  `workrange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '时间区间',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime(0) NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time(0) NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) NULL DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '测试表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_test
-- ----------------------------
INSERT INTO `fa_test` VALUES (1, 1, 1, 12, '12,13', '互联网,计算机', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '我是一篇测试文章描述，内容过多时将自动隐藏', '广西壮族自治区/百色市/平果县', '[\"a\",\"b\"]', '{\"a\":\"1\",\"b\":\"2\"}', '[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]', 0.00, 0, '2020-10-01 00:00:00 - 2021-10-31 23:59:59', '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '余额',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` bigint(16) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '失败次数',
  `loginfailuretime` bigint(16) NULL DEFAULT NULL COMMENT '最后登录失败时间',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) NOT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关联用户微信id\r\n',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user
-- ----------------------------
INSERT INTO `fa_user` VALUES (15, '新用户1774943192', '新用户1774943192', '', 'Ju5gNp', '', '', '', 0, 0, NULL, 1, 1774943192, 1774943192, '127.0.0.1', 0, NULL, '127.0.0.1', 1774943192, 1774943192, 1774943192, '', 'normal', 'o-_Ca4iewbMJE67x-qXvwPIEGYoA');

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限节点',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
INSERT INTO `fa_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_user_group` VALUES (2, '', '', 1762767769, 1762767769, 'normal');

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
INSERT INTO `fa_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `token_type` tinyint(4) NOT NULL COMMENT '1-refresh_token 2-access_token（黑名单）',
  `token` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'token原文（若为refresh_token可存原文；若为黑名单则存access_token原文）',
  `expires_at` datetime(0) NOT NULL COMMENT '过期时间',
  `device_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备唯一标识',
  `device_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `client_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录IP',
  `is_revoked` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否撤销 1-已撤销 0-有效',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_user_device_type`(`user_id`, `device_id`, `token_type`) USING BTREE COMMENT '同一用户同一设备同一类型令牌唯一（可防止重复登录）',
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_expires_at`(`expires_at`) USING BTREE,
  INDEX `idx_token_value`(`token`(191)) USING BTREE COMMENT '若存储原文且需快速查找，加前缀索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户token管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------
INSERT INTO `fa_user_token` VALUES (1, 12, 1, 'e5448d44-4792-4278-918e-2e88a4a119c8', '2026-04-05 14:40:03', NULL, NULL, NULL, 0, '2026-03-31 14:40:03', '2026-03-31 14:40:03');
INSERT INTO `fa_user_token` VALUES (2, 13, 1, '4d0fd9ae-1234-469b-9f45-2c6370b88136', '2026-04-05 15:44:01', NULL, NULL, NULL, 0, '2026-03-31 15:44:01', '2026-03-31 15:44:01');
INSERT INTO `fa_user_token` VALUES (4, 15, 1, 'a6c07b9b-f72b-4246-a015-91e04f127b90', '2026-04-05 15:46:32', NULL, NULL, NULL, 0, '2026-03-31 15:46:32', '2026-03-31 15:46:32');

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_version
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
