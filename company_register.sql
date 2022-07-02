/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.3.240
 Source Server Type    : MySQL
 Source Server Version : 50562
 Source Host           : 192.168.3.240:3306
 Source Schema         : qp

 Target Server Type    : MySQL
 Target Server Version : 50562
 File Encoding         : 65001

 Date: 16/05/2019 10:42:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for company_register
-- ----------------------------
DROP TABLE IF EXISTS `company_register`;
CREATE TABLE `company_register`  (
  `id` int(11) NOT NULL,
  `company_id` int(11) NULL DEFAULT NULL,
  `device_type_id` int(11) NULL DEFAULT NULL,
  `register_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记类别',
  `device_model` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备品种',
  `device_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `device_num` int(11) NULL DEFAULT NULL COMMENT '设备数量',
  `form_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '填表人员',
  `manger_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理人员',
  `user_date` datetime NULL DEFAULT NULL COMMENT '填表时间',
  `manger_date` datetime NULL DEFAULT NULL COMMENT '管理人员日期',
  `number` int(11) NULL DEFAULT NULL COMMENT '使用登记证编号',
  `register_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记人员',
  `init_date` datetime NULL DEFAULT NULL,
  `init_user` int(11) NULL DEFAULT NULL,
  `init_addr` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_com_seal` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否盖章（单位）',
  `is_reg_seal` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否盖章（登记机关）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
