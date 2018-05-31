/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : 127.0.0.1:3306
 Source Schema         : schedule

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : 65001

 Date: 31/05/2018 09:31:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('QuartzScheduler', '22', '1', '0/3 * * * * ? ', 'China Standard Time');
INSERT INTO `qrtz_cron_triggers` VALUES ('QuartzScheduler', '测试', '测试', '0/5 * * * * ? ', 'China Standard Time');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(140) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(19) NOT NULL,
  `SCHED_TIME` bigint(19) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` tinyint(1) NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
INSERT INTO `qrtz_fired_triggers` VALUES ('QuartzScheduler', 'NON_CLUSTERED636561593011685307', '测试', '测试', 'NON_CLUSTERED', 636561593016685591, 636561593014475464, 5, 'EXECUTING', '测试', '测试', 0, 0);
INSERT INTO `qrtz_fired_triggers` VALUES ('QuartzScheduler', 'NON_CLUSTERED636561593011685308', '测试', '测试', 'NON_CLUSTERED', 636561593059838059, 636561593050000000, 5, 'EXECUTING', '测试', '测试', 0, 0);

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` tinyint(1) NOT NULL,
  `IS_NONCONCURRENT` tinyint(1) NOT NULL,
  `IS_UPDATE_DATA` tinyint(1) NOT NULL,
  `REQUESTS_RECOVERY` tinyint(1) NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('QuartzScheduler', '22', '1', NULL, 'Five.QuartzNetJob.ExecuteJobTask.Service.SubmitJobTask, Five.QuartzNetJob.ExecuteJobTask.Service', 0, 0, 0, 0, NULL);
INSERT INTO `qrtz_job_details` VALUES ('QuartzScheduler', '测试', '测试', NULL, 'Five.QuartzNetJob.ExecuteJobTask.Service.HttpJobTask, Five.QuartzNetJob.ExecuteJobTask.Service', 0, 0, 0, 0, NULL);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_operatelog
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_operatelog`;
CREATE TABLE `qrtz_operatelog`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `TableName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作表名称',
  `Describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `Type` int(11) NULL DEFAULT NULL COMMENT '日志类型(0：正常，1：异常)',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_operatelog
-- ----------------------------
INSERT INTO `qrtz_operatelog` VALUES (1, 'Schedule', '编号为：114任务删除成功', NULL, '2018-02-09 17:32:16', '2018-02-09 17:32:16');
INSERT INTO `qrtz_operatelog` VALUES (2, 'Schedule', '停止任务测试任务成功', NULL, '2018-02-11 10:07:52', '2018-02-11 10:07:52');
INSERT INTO `qrtz_operatelog` VALUES (3, 'Schedule', '执行任务测试任务成功', NULL, '2018-02-11 10:09:34', '2018-02-11 10:09:34');
INSERT INTO `qrtz_operatelog` VALUES (4, 'Schedule', '停止任务测试任务成功', NULL, '2018-02-11 10:09:41', '2018-02-11 10:09:41');
INSERT INTO `qrtz_operatelog` VALUES (5, 'Schedule', '执行任务测试任务成功', NULL, '2018-02-11 10:09:54', '2018-02-11 10:09:54');
INSERT INTO `qrtz_operatelog` VALUES (6, 'Schedule', '停止任务测试任务成功', NULL, '2018-02-11 10:10:50', '2018-02-11 10:10:50');
INSERT INTO `qrtz_operatelog` VALUES (7, 'Schedule', '执行任务测试任务成功', NULL, '2018-02-11 10:19:11', '2018-02-11 10:19:11');
INSERT INTO `qrtz_operatelog` VALUES (8, 'Schedule', '停止任务测试任务成功', 0, '2018-02-11 14:00:37', '2018-02-11 14:00:37');
INSERT INTO `qrtz_operatelog` VALUES (9, 'Schedule', '执行任务测试任务成功', 0, '2018-02-11 14:09:26', '2018-02-11 14:09:26');
INSERT INTO `qrtz_operatelog` VALUES (10, 'Schedule', '停止任务测试任务成功', 0, '2018-02-11 14:12:35', '2018-02-11 14:12:35');
INSERT INTO `qrtz_operatelog` VALUES (11, 'Schedule', '执行任务测试任务成功', 0, '2018-02-11 14:13:34', '2018-02-11 14:13:34');
INSERT INTO `qrtz_operatelog` VALUES (12, 'Schedule', '停止任务测试任务成功', 0, '2018-02-11 14:14:12', '2018-02-11 14:14:12');
INSERT INTO `qrtz_operatelog` VALUES (13, 'Schedule', '执行任务测试任务成功', 0, '2018-02-11 14:14:30', '2018-02-11 14:14:30');
INSERT INTO `qrtz_operatelog` VALUES (14, 'Schedule', '停止任务测试任务成功', 0, '2018-02-11 14:19:30', '2018-02-11 14:19:30');
INSERT INTO `qrtz_operatelog` VALUES (15, 'Schedule', '执行任务测试任务成功', 0, '2018-02-11 14:19:33', '2018-02-11 14:19:33');
INSERT INTO `qrtz_operatelog` VALUES (16, 'Schedule', '编号为：111任务删除成功', 0, '2018-02-11 14:21:49', '2018-02-11 14:21:49');
INSERT INTO `qrtz_operatelog` VALUES (17, 'Schedule', '编号为：123任务删除成功', 0, '2018-02-11 14:40:33', '2018-02-11 14:40:33');
INSERT INTO `qrtz_operatelog` VALUES (18, 'Schedule', '编号为：122任务删除成功', 0, '2018-02-11 14:41:42', '2018-02-11 14:41:42');
INSERT INTO `qrtz_operatelog` VALUES (19, 'Schedule', '编号为：121任务删除成功', 0, '2018-02-11 14:42:04', '2018-02-11 14:42:04');
INSERT INTO `qrtz_operatelog` VALUES (20, 'Schedule', '编号为：120任务删除成功', 0, '2018-02-11 14:42:52', '2018-02-11 14:42:52');
INSERT INTO `qrtz_operatelog` VALUES (21, 'Schedule', '执行任务22成功', 0, '2018-02-11 15:25:43', '2018-02-11 15:25:43');
INSERT INTO `qrtz_operatelog` VALUES (22, 'Schedule', '停止任务22成功', 0, '2018-02-11 15:27:30', '2018-02-11 15:27:30');
INSERT INTO `qrtz_operatelog` VALUES (23, 'Schedule', '执行任务22成功', 0, '2018-02-11 15:27:31', '2018-02-11 15:27:31');
INSERT INTO `qrtz_operatelog` VALUES (24, 'Schedule', '停止任务22成功', 0, '2018-02-11 17:11:31', '2018-02-11 17:11:31');
INSERT INTO `qrtz_operatelog` VALUES (25, 'Schedule', '执行任务22成功', 0, '2018-02-11 17:11:35', '2018-02-11 17:11:35');
INSERT INTO `qrtz_operatelog` VALUES (26, 'Schedule', '停止任务22成功', 0, '2018-02-11 17:13:30', '2018-02-11 17:13:30');
INSERT INTO `qrtz_operatelog` VALUES (27, 'Schedule', '执行任务测试成功', 0, '2018-02-11 17:13:31', '2018-02-11 17:13:31');
INSERT INTO `qrtz_operatelog` VALUES (28, 'Schedule', '修改任务调度信息', 0, '2018-02-11 17:13:40', '2018-02-11 17:13:40');
INSERT INTO `qrtz_operatelog` VALUES (29, 'Schedule', '执行任务测试成功', 0, '2018-02-11 17:13:44', '2018-02-11 17:13:44');
INSERT INTO `qrtz_operatelog` VALUES (30, 'Schedule', '修改任务调度信息', 0, '2018-02-11 17:15:03', '2018-02-11 17:15:03');
INSERT INTO `qrtz_operatelog` VALUES (31, 'Schedule', '执行任务测试成功', 0, '2018-02-11 17:15:06', '2018-02-11 17:15:06');
INSERT INTO `qrtz_operatelog` VALUES (32, 'Schedule', '停止任务测试成功', 0, '2018-02-11 17:15:37', '2018-02-11 17:15:37');
INSERT INTO `qrtz_operatelog` VALUES (33, 'Schedule', '执行任务测试成功', 0, '2018-02-11 17:16:23', '2018-02-11 17:16:23');
INSERT INTO `qrtz_operatelog` VALUES (34, 'Schedule', '修改任务调度信息', 0, '2018-02-11 17:21:17', '2018-02-11 17:21:17');
INSERT INTO `qrtz_operatelog` VALUES (35, 'Schedule', '停止任务测试成功', 0, '2018-02-12 14:06:49', '2018-02-12 14:06:49');
INSERT INTO `qrtz_operatelog` VALUES (36, 'Schedule', '执行任务测试成功', 0, '2018-02-12 14:06:50', '2018-02-12 14:06:50');
INSERT INTO `qrtz_operatelog` VALUES (37, 'Schedule', '停止任务测试成功', 0, '2018-02-12 14:07:22', '2018-02-12 14:07:22');
INSERT INTO `qrtz_operatelog` VALUES (38, 'Schedule', '执行任务22成功', 0, '2018-02-26 16:41:58', '2018-02-26 16:41:58');
INSERT INTO `qrtz_operatelog` VALUES (39, 'Schedule', '停止任务22成功', 0, '2018-02-26 16:43:30', '2018-02-26 16:43:30');
INSERT INTO `qrtz_operatelog` VALUES (40, 'Schedule', '执行任务22成功', 0, '2018-02-26 17:07:34', '2018-02-26 17:07:34');
INSERT INTO `qrtz_operatelog` VALUES (41, 'Schedule', '停止任务22成功', 0, '2018-02-26 17:08:43', '2018-02-26 17:08:43');
INSERT INTO `qrtz_operatelog` VALUES (42, 'Schedule', '执行任务22成功', 0, '2018-02-26 17:09:47', '2018-02-26 17:09:47');
INSERT INTO `qrtz_operatelog` VALUES (43, 'Schedule', '停止任务22成功', 0, '2018-02-26 17:10:22', '2018-02-26 17:10:22');
INSERT INTO `qrtz_operatelog` VALUES (44, 'Schedule', '执行任务22成功', 0, '2018-02-26 17:12:03', '2018-02-26 17:12:03');
INSERT INTO `qrtz_operatelog` VALUES (45, 'Schedule', '停止任务22成功', 0, '2018-02-26 17:14:14', '2018-02-26 17:14:14');
INSERT INTO `qrtz_operatelog` VALUES (46, 'Schedule', '执行任务22成功', 0, '2018-02-26 17:25:22', '2018-02-26 17:25:22');
INSERT INTO `qrtz_operatelog` VALUES (47, 'Schedule', '停止任务22成功', 0, '2018-02-26 17:29:43', '2018-02-26 17:29:43');
INSERT INTO `qrtz_operatelog` VALUES (48, 'Schedule', '执行任务22成功', 0, '2018-02-26 17:40:09', '2018-02-26 17:40:09');
INSERT INTO `qrtz_operatelog` VALUES (49, 'Schedule', '停止任务22成功', 0, '2018-02-27 10:14:39', '2018-02-27 10:14:39');
INSERT INTO `qrtz_operatelog` VALUES (50, 'Schedule', '执行任务22成功', 0, '2018-02-27 10:16:56', '2018-02-27 10:16:56');
INSERT INTO `qrtz_operatelog` VALUES (51, 'Schedule', '停止任务测试成功', 0, '2018-02-27 11:36:54', '2018-02-27 11:36:54');
INSERT INTO `qrtz_operatelog` VALUES (52, 'Schedule', '添加任务test成功', 0, '2018-02-28 10:51:42', '2018-02-28 10:51:42');
INSERT INTO `qrtz_operatelog` VALUES (53, 'Schedule', '执行任务测试成功', 0, '2018-03-08 14:28:39', '2018-03-08 14:28:39');
INSERT INTO `qrtz_operatelog` VALUES (54, 'Schedule', '执行任务测试成功', 0, '2018-03-08 14:33:11', '2018-03-08 14:33:11');
INSERT INTO `qrtz_operatelog` VALUES (55, 'Schedule', '执行任务22成功', 0, '2018-03-09 10:20:30', '2018-03-09 10:20:30');
INSERT INTO `qrtz_operatelog` VALUES (56, 'Schedule', '执行任务22成功', 0, '2018-03-09 10:20:31', '2018-03-09 10:20:31');
INSERT INTO `qrtz_operatelog` VALUES (57, 'Schedule', '停止任务22成功', 0, '2018-03-09 10:20:35', '2018-03-09 10:20:35');
INSERT INTO `qrtz_operatelog` VALUES (58, 'Schedule', '停止任务测试成功', 0, '2018-03-09 10:20:37', '2018-03-09 10:20:37');
INSERT INTO `qrtz_operatelog` VALUES (59, 'Schedule', '执行任务测试成功', 0, '2018-03-09 10:20:39', '2018-03-09 10:20:39');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(19) NOT NULL,
  `CHECKIN_INTERVAL` bigint(19) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` tinyint(1) NULL DEFAULT NULL,
  `BOOL_PROP_2` tinyint(1) NULL DEFAULT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(19) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(19) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(19) NOT NULL,
  `END_TIME` bigint(19) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('QuartzScheduler', '22', '1', '22', '1', NULL, 636561588360000000, 636561588330000000, 5, 'PAUSED', 'CRON', 636535677000000000, NULL, NULL, 0, NULL);
INSERT INTO `qrtz_triggers` VALUES ('QuartzScheduler', '测试', '测试', '测试', '测试', NULL, 636561593100000000, 636561593050000000, 5, 'WAITING', 'CRON', 636528240000000000, NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule`  (
  `JobId` int(50) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `JobName` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `JobGroup` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务分组',
  `JobStatus` int(45) NULL DEFAULT NULL COMMENT '状态， 0 停止；1 启用',
  `Cron` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行周期表达式',
  `AssemblyName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务所在DLL对应的程序集名称',
  `ClassName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务所在类',
  `Remark` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务描述',
  `RunTimes` int(11) NULL DEFAULT NULL COMMENT '执行次数',
  `BeginTime` timestamp(0) NULL DEFAULT NULL COMMENT '开始时间',
  `EndTime` timestamp(0) NULL DEFAULT NULL COMMENT '结束时间',
  `TriggerType` int(1) NULL DEFAULT NULL COMMENT '触发器类型（0、simple 1、cron）',
  `IntervalSecond` int(11) NULL DEFAULT NULL COMMENT '执行间隔时间, 秒为单位',
  `Url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调用外部的url',
  `CreateTime` datetime(0) NULL DEFAULT NULL COMMENT '添加时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`JobId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES (112, '22', '1', 0, '0/3 * * * * ? ', 'Five.QuartzNetJob.ExecuteJobTask.Service', 'SubmitJobTask', NULL, 0, '2018-02-07 10:35:00', NULL, 1, 0, NULL, '0001-01-01 00:00:00', '2018-03-09 10:20:35');
INSERT INTO `schedule` VALUES (115, '测试', '测试', 1, '0/5 * * * * ? ', 'Five.QuartzNetJob.ExecuteJobTask.Service', 'HttpJobTask', 'aa', 0, '2018-01-29 20:00:00', NULL, 1, 0, '1d', '0001-01-01 00:00:00', '2018-03-09 10:20:39');
INSERT INTO `schedule` VALUES (116, '测试', '测试', 0, '0 0 12 * * ?', NULL, NULL, '11', 0, '2018-01-29 22:50:00', NULL, 1, 0, 'dd', '2018-01-29 17:14:09', NULL);
INSERT INTO `schedule` VALUES (117, '2', '测试', 0, '0 0 12 * * ?', NULL, NULL, '1111', 0, '2018-01-29 16:50:00', NULL, 1, 0, 'dd', '2018-01-29 17:16:55', NULL);
INSERT INTO `schedule` VALUES (118, '2', '测试', 0, '0 0 12 * * ?', NULL, NULL, 'aa', 0, '2018-01-29 16:50:00', NULL, 1, 0, 'dd', '2018-01-29 17:18:17', NULL);
INSERT INTO `schedule` VALUES (119, '1', '1', 0, '1', NULL, NULL, '1', 0, '2018-01-29 17:22:00', NULL, 1, 0, '1', '2018-01-29 17:22:36', NULL);
INSERT INTO `schedule` VALUES (120, 'test', 'test', 0, NULL, '1', '1', NULL, 0, '2018-02-28 10:51:00', NULL, 0, 0, NULL, '0001-01-01 00:00:00', NULL);

SET FOREIGN_KEY_CHECKS = 1;
