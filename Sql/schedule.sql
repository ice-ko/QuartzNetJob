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

 Date: 11/09/2018 14:41:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule`  (
  `JobId` int(50) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `JobName` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `JobGroup` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务分组',
  `JobStatus` int(45) NULL DEFAULT NULL COMMENT '状态， 0 暂停任务；1 启用任务',
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
  `Valid` bit(1) NULL DEFAULT b'1' COMMENT '该字段表示是否被删除(0-删除,1-未删除)，默认为1',
  PRIMARY KEY (`JobId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
