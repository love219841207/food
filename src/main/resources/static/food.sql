/*
Navicat MySQL Data Transfer

Source Server         : 10.48.194.162
Source Server Version : 50709
Source Host           : 10.48.194.162:3306
Source Database       : food

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-03-09 16:53:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `address_info`
-- ----------------------------
DROP TABLE IF EXISTS `address_info`;
CREATE TABLE `address_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of address_info
-- ----------------------------
INSERT INTO `address_info` VALUES ('5', '上海市黄浦区5号');

-- ----------------------------
-- Table structure for `book_group_info`
-- ----------------------------
DROP TABLE IF EXISTS `book_group_info`;
CREATE TABLE `book_group_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `remark` varchar(400) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of book_group_info
-- ----------------------------
INSERT INTO `book_group_info` VALUES ('23', '默默', '咯', '15026750504', '莫', '2017-02-13 14:14:19');

-- ----------------------------
-- Table structure for `coupon_info`
-- ----------------------------
DROP TABLE IF EXISTS `coupon_info`;
CREATE TABLE `coupon_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `create_time` datetime NOT NULL,
  `use_time` datetime DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '1.新发可用。2。使用 。3 作废',
  `start_time` datetime DEFAULT NULL COMMENT '有效期开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '有效期结束时间',
  PRIMARY KEY (`id`),
  KEY `index_userid_status` (`user_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of coupon_info
-- ----------------------------
INSERT INTO `coupon_info` VALUES ('1', '10', '80.00', '2017-02-22 16:04:21', '2017-03-09 16:22:49', '2', null, null);
INSERT INTO `coupon_info` VALUES ('2', '10', '50.01', '2017-02-20 16:46:09', '2017-02-27 17:31:13', '1', null, null);

-- ----------------------------
-- Table structure for `data_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `data_dictionary`;
CREATE TABLE `data_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `val` varchar(40) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `remark` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of data_dictionary
-- ----------------------------
INSERT INTO `data_dictionary` VALUES ('1', '极致瘦身', '1', 'type_menu', '极致瘦身');
INSERT INTO `data_dictionary` VALUES ('2', '均衡纤体', '2', 'type_menu', '均衡纤体');
INSERT INTO `data_dictionary` VALUES ('3', 'OTHER', '1', 'type_other', 'OTHER');
INSERT INTO `data_dictionary` VALUES ('4', '午餐', '1', 'time_menu', '午餐');
INSERT INTO `data_dictionary` VALUES ('5', '晚餐', '2', 'time_menu', '晚餐');

-- ----------------------------
-- Table structure for `order_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `type_menu` varchar(255) NOT NULL,
  `time_menu` varchar(255) NOT NULL,
  `pkg_menu` varchar(255) DEFAULT NULL,
  `pkg_days` int(11) NOT NULL,
  `pkg_sale_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `logistics_price` decimal(10,2) DEFAULT NULL,
  `coupon_price` decimal(10,0) DEFAULT NULL,
  `coupon_id` bigint(20) DEFAULT NULL,
  `last_price` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1.待支付。2支付成功，未到账。3 到账。4.支付失败。9.作废',
  `remark` varchar(255) DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES ('8ab042cc5ab1ff14015ab211954e0000', '10', '2017-03-09 15:56:21', '1', '1', '午餐：瘦身1日', '1', '30.01', '30.01', null, '80', '1', '0.00', '5', '', null, null);
INSERT INTO `order_info` VALUES ('8ab042cc5ab2293d015ab229d0250000', '10', '2017-03-09 16:22:49', '1', '1', '午餐：瘦身7日', '7', '30.00', '30.00', null, '80', '1', '0.00', '5', '', null, null);

-- ----------------------------
-- Table structure for `order_wechat_payment`
-- ----------------------------
DROP TABLE IF EXISTS `order_wechat_payment`;
CREATE TABLE `order_wechat_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `out_trade` varchar(255) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `prepay_id` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `msg` varchar(2000) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `callback_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_wechat_trade` (`open_id`,`out_trade`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order_wechat_payment
-- ----------------------------
INSERT INTO `order_wechat_payment` VALUES ('11', '8ab042ae5a7e12ac015a7e135dbf0000', '9b9368117a1d4ea1b11594b563c7691a', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx20170227133806919dd059b00877847771', '2017-02-27 13:38:06', '<xml><appid><![CDATA[wx544c48febb55da52]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CFT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1355947402]]></mch_id>\n<nonce_str><![CDATA[806207edb154496284eb112ea89a1894]]></nonce_str>\n<openid><![CDATA[oR6mewQ8GPvyXqGd0J3mUg7U7CYk]]></openid>\n<out_trade_no><![CDATA[9b9368117a1d4ea1b11594b563c7691a]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[4621A3509F43854EBD4A00C525C71AC2]]></sign>\n<time_end><![CDATA[20170227133826]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201702271513747190]]></transaction_id>\n</xml>\n', '2', '2017-02-27 13:38:26');
INSERT INTO `order_wechat_payment` VALUES ('12', '8ab042ae5a7e534d015a7e54ded60000', 'fc20ad42395a49648734aeefa615ab91', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx20170227144936ee0b266a950172128823', '2017-02-27 14:49:36', '<xml><appid><![CDATA[wx544c48febb55da52]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CFT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1355947402]]></mch_id>\n<nonce_str><![CDATA[bb8ad0882439405b86669f60a07329b6]]></nonce_str>\n<openid><![CDATA[oR6mewQ8GPvyXqGd0J3mUg7U7CYk]]></openid>\n<out_trade_no><![CDATA[fc20ad42395a49648734aeefa615ab91]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[DDF5ED57F526F5C5A49261E706832504]]></sign>\n<time_end><![CDATA[20170227144941]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201702271523117908]]></transaction_id>\n</xml>\n', '2', '2017-02-27 14:49:41');
INSERT INTO `order_wechat_payment` VALUES ('13', '8ab042ae5a7e55f6015a7e5630d10000', 'ec3308a08c68449daf472087e7f21d47', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx2017022714510260041cbcb00397632771', '2017-02-27 14:51:03', '<xml><appid><![CDATA[wx544c48febb55da52]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CFT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1355947402]]></mch_id>\n<nonce_str><![CDATA[dd8391b88e0d42b39889ff282e876ef5]]></nonce_str>\n<openid><![CDATA[oR6mewQ8GPvyXqGd0J3mUg7U7CYk]]></openid>\n<out_trade_no><![CDATA[ec3308a08c68449daf472087e7f21d47]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[7E5819A7CF906D68F2C139877BF3EFE2]]></sign>\n<time_end><![CDATA[20170227145107]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201702271521742287]]></transaction_id>\n</xml>\n', '2', '2017-02-27 14:51:08');
INSERT INTO `order_wechat_payment` VALUES ('14', '8ab042ae5a7ebed9015a7ebf35740000', '8245d6bb421d487ea091ff99be3c8e16', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx201702271645455a42f15ae10030167289', '2017-02-27 16:45:45', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('15', '8ab042ae5a7ede66015a7edeace40000', 'ae45c8c60b8748a1bc26cfd6961ebd5f', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx2017022717200741a3c2db250212798551', '2017-02-27 17:20:07', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('16', '8ab042ae5a7ee591015a7ee90cff0002', '4310946a56754a3da952bfa99ab9efd3', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx2017022717312783086298420762442807', '2017-02-27 17:31:27', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('17', '8ab042ba5a9305e9015a930776640001', 'd7268a3b48384f25b9665e7db80d133b', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx2017030315170332b0d7745f0018935771', '2017-03-03 15:17:05', '<xml><appid><![CDATA[wx544c48febb55da52]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1355947402]]></mch_id>\n<nonce_str><![CDATA[6802e739560e4b5d9f33801b0995752d]]></nonce_str>\n<openid><![CDATA[oR6mewQ8GPvyXqGd0J3mUg7U7CYk]]></openid>\n<out_trade_no><![CDATA[d7268a3b48384f25b9665e7db80d133b]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[D43FDAAAF26DE43DA86050899B3F0946]]></sign>\n<time_end><![CDATA[20170303151709]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201703032061689697]]></transaction_id>\n</xml>\n', '2', '2017-03-03 15:17:13');
INSERT INTO `order_wechat_payment` VALUES ('18', '8ab042cc5aa1bed2015aa1c618e00001', 'a614567ec46b4d008e7d383b4e9fdd74', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx20170306115958535981b01b0544266936', '2017-03-06 11:59:59', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('19', '8ab042cc5aa1c8e8015aa1c9920c0001', '5140b2bb175249c7acfa9d669491fd4a', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', 'wx20170306120345f3140dad980074427507', '2017-03-06 12:03:47', null, '1', null);

-- ----------------------------
-- Table structure for `pkg_menu`
-- ----------------------------
DROP TABLE IF EXISTS `pkg_menu`;
CREATE TABLE `pkg_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_menu` varchar(1) DEFAULT NULL,
  `time_menu` varchar(1) DEFAULT NULL,
  `pkg_menu` varchar(40) DEFAULT NULL,
  `pkg_days` int(11) DEFAULT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pak_index` (`type_menu`,`time_menu`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pkg_menu
-- ----------------------------
INSERT INTO `pkg_menu` VALUES ('253', '1', '1', '午餐：瘦身1日', '1', '40.00', '30.01', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('254', '1', '1', '午餐：瘦身7日', '7', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('255', '1', '1', '午餐：瘦身30日', '30', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('256', '1', '2', '晚餐：瘦身1日', '1', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('257', '1', '2', '晚餐：瘦身7日', '7', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('258', '1', '2', '晚餐：瘦身30日', '30', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('259', '2', '1', '午餐：纤体1日', '1', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('260', '2', '1', '午餐：纤体7日', '7', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('261', '2', '1', '午餐：纤体30日', '30', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('262', '2', '2', '晚餐：纤体1日', '1', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('263', '2', '2', '晚餐：纤体7日', '7', '40.00', '30.00', '2017-03-07 22:00:13');
INSERT INTO `pkg_menu` VALUES ('264', '2', '2', '晚餐：纤体30日', '30', '40.00', '30.00', '2017-03-07 22:00:13');

-- ----------------------------
-- Table structure for `schedule_menu_info`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_menu_info`;
CREATE TABLE `schedule_menu_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `schedule_day` date DEFAULT NULL,
  `type_menu` varchar(1) DEFAULT NULL,
  `time_menu` varchar(1) DEFAULT NULL,
  `main_info` varchar(255) DEFAULT NULL,
  `minor` varchar(255) DEFAULT NULL,
  `coarse_grain` varchar(255) DEFAULT NULL,
  `staple_food` varchar(255) DEFAULT NULL,
  `drink` varchar(255) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  `kcal` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `img_paths` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_time_type_index` (`schedule_day`,`type_menu`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of schedule_menu_info
-- ----------------------------
INSERT INTO `schedule_menu_info` VALUES ('145', '2017-03-11', '1', '1', '蛋黄南瓜百花', '虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '', '446.0', '2017-02-23 09:31:48', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('146', '2017-03-11', '1', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-02-23 09:31:48', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('147', '2017-03-11', '2', '1', '蛋黄南瓜百花', '虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '', '446.0', '2017-02-23 09:31:48', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('148', '2017-03-11', '2', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-02-23 09:31:48', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('153', '2017-03-10', '1', '1', '蛋黄南瓜百花222', '虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '', '446.0', '2017-02-27 18:36:38', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('154', '2017-03-10', '1', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-02-27 18:36:38', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('157', '2017-02-23', '1', '1', '蛋黄南瓜百花222', '虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '', '446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('158', '2017-02-23', '1', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('159', '2017-02-23', '2', '1', '蛋黄南瓜百花', '虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '', '446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('160', '2017-02-23', '2', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('161', '2017-02-21', '1', '1', '蛋黄南瓜百花1', '1虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '', '1446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('162', '2017-02-21', '1', '2', '清蒸鱼柳1', '1三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '1446.0', '2017-03-07 22:00:13', 'img1.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('163', '2017-02-10', '2', '1', '蛋黄南瓜百花1', '1虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '', '1446.0', '2017-03-07 22:00:13', 'img2.jpg,img2.jpg');
INSERT INTO `schedule_menu_info` VALUES ('164', '2017-02-10', '2', '2', '清蒸鱼柳1', '1三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '1446.0', '2017-03-07 22:00:13', '');

-- ----------------------------
-- Table structure for `sms_record`
-- ----------------------------
DROP TABLE IF EXISTS `sms_record`;
CREATE TABLE `sms_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(40) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `template_code` varchar(100) DEFAULT NULL,
  `param_str` varchar(100) DEFAULT NULL,
  `error_msg` varchar(100) DEFAULT NULL,
  `state` varchar(4) NOT NULL,
  `scene` int(1) unsigned zerofill DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `sms_body` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sms_record
-- ----------------------------
INSERT INTO `sms_record` VALUES ('38', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"2153\"}', null, '00', '1', '2017-02-09 15:51:25', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105858115798^1107948830909\",\"success\":true},\"request_id\":\"3jlj66w0wbqn\"}}');
INSERT INTO `sms_record` VALUES ('39', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"2699\"}', null, '00', '1', '2017-02-09 15:52:47', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105857993589^1107948653583\",\"success\":true},\"request_id\":\"sjq38cum6t9d\"}}');
INSERT INTO `sms_record` VALUES ('40', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750504', 'SMS_44310094', '{\"code\":\"8329\"}', null, '00', '1', '2017-02-13 14:09:54', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895068967^1108004245650\",\"success\":true},\"request_id\":\"11ifi7qq4nl4t\"}}');
INSERT INTO `sms_record` VALUES ('41', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"7834\"}', null, '00', '1', '2017-02-13 14:10:11', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895245462^1108004137562\",\"success\":true},\"request_id\":\"2is8cntk7xu5\"}}');
INSERT INTO `sms_record` VALUES ('42', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"5926\"}', null, '00', '1', '2017-02-13 14:13:58', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895208118^1108004405380\",\"success\":true},\"request_id\":\"13yslkp6hso6v\"}}');
INSERT INTO `sms_record` VALUES ('43', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', '15026750804', 'SMS_44310094', '{\"code\":\"8479\"}', null, '00', '1', '2017-02-23 18:26:38', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"106054610001^1108210319950\",\"success\":true},\"request_id\":\"z28no0o3g48j\"}}');

-- ----------------------------
-- Table structure for `user_account_detail`
-- ----------------------------
DROP TABLE IF EXISTS `user_account_detail`;
CREATE TABLE `user_account_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `happen_time` datetime DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '1为购买增加，2为排餐',
  `order_id` varchar(255) DEFAULT NULL,
  `fix_id` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL COMMENT '份数',
  `time_menu` varchar(255) DEFAULT NULL,
  `type_menu` varchar(255) DEFAULT NULL,
  `fix_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_detail_user` (`user_id`),
  KEY `index_detail_order` (`order_id`),
  KEY `index_detail_fix` (`fix_date`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_account_detail
-- ----------------------------
INSERT INTO `user_account_detail` VALUES ('14', '10', '2017-03-09 16:22:49', '1', '8ab042cc5ab2293d015ab229d0250000', null, '7', '1', '1', null);
INSERT INTO `user_account_detail` VALUES ('36', '10', '2017-03-09 16:28:44', '2', null, null, '-1', '1', '1', '2017-03-10');
INSERT INTO `user_account_detail` VALUES ('37', '10', '2017-03-09 16:28:44', '2', null, null, '-1', '1', '1', '2017-03-11');

-- ----------------------------
-- Table structure for `user_delivery_address`
-- ----------------------------
DROP TABLE IF EXISTS `user_delivery_address`;
CREATE TABLE `user_delivery_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address_id` bigint(20) DEFAULT NULL,
  `address_extend` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dft` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_userid` (`user_id`),
  KEY `index_userid_id` (`id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_delivery_address
-- ----------------------------
INSERT INTO `user_delivery_address` VALUES ('1', '10', '15026750803', '5', 'ssss ofmo ', 'er', '1');
INSERT INTO `user_delivery_address` VALUES ('4', '10', '15026750804', '5', '吧啦啊', '徐东', null);

-- ----------------------------
-- Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(40) DEFAULT NULL,
  `pwd` varchar(40) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `user_name` varchar(40) DEFAULT NULL,
  `sex` int(1) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('10', null, null, '15026750804', null, null, null, '2017-02-13 14:14:06', '2017-02-13 14:14:06');

-- ----------------------------
-- Table structure for `user_regedit_code`
-- ----------------------------
DROP TABLE IF EXISTS `user_regedit_code`;
CREATE TABLE `user_regedit_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `phone` varchar(18) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `open_id` varchar(40) DEFAULT NULL,
  `scene` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_openid_scene` (`open_id`,`scene`),
  KEY `index_createtime` (`create_time`),
  KEY `index_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_regedit_code
-- ----------------------------
INSERT INTO `user_regedit_code` VALUES ('40', '15026750804', '2153', '2017-02-09 15:51:24', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('41', '15026750804', '2699', '2017-02-09 15:52:47', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('42', '15026750504', '8329', '2017-02-13 14:09:54', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('43', '15026750804', '7834', '2017-02-13 14:10:10', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('44', '15026750804', '5926', '2017-02-13 14:13:57', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('45', '15026750804', '8479', '2017-02-23 18:26:38', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', '1');

-- ----------------------------
-- Table structure for `wechat_api_token`
-- ----------------------------
DROP TABLE IF EXISTS `wechat_api_token`;
CREATE TABLE `wechat_api_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_token` varchar(400) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of wechat_api_token
-- ----------------------------
INSERT INTO `wechat_api_token` VALUES ('1', 'Yg3j7_jq9o71msedxA8oAh4XRKlr1zfZn0GzZIUecLjKogjU7-iUzUOeLZSs1QsFzSnofzWuOVgIn-84Xur00lNgJ_mmYxcg-aFsxEOZBJHF0895X3-sbnU46i8EEH1-BDAiACAEGD', '2017-03-09 16:28:05');

-- ----------------------------
-- Table structure for `wechat_info`
-- ----------------------------
DROP TABLE IF EXISTS `wechat_info`;
CREATE TABLE `wechat_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `head_img` varchar(300) DEFAULT NULL,
  `nick_name` varchar(40) DEFAULT NULL,
  `open_id` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wechat_info_openid_index` (`open_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of wechat_info
-- ----------------------------
INSERT INTO `wechat_info` VALUES ('24', 'http://wx.qlogo.cn/mmopen/Xewa2JUmZ1pwMpaUqPxTEuIicuphiaQlCMwKZwbDvCOeh2wcEibrM98iaYWTyCo6ObpOYbq3P96PfC4kQyYwFY4PPA/0', '徐东', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '2017-02-13 14:13:52', '2017-02-13 14:13:52', '10');
INSERT INTO `wechat_info` VALUES ('25', 'http://wx.qlogo.cn/mmopen/NoFChqEQomG1qibMmcyeMXTppkCpHZSsFhwhUZaicNvfnzRCWMhDvfSrhheTdkpNdTdDhkgyfrNAPOxIFveiaeyqA/0', '徐东', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', '2017-02-23 18:26:06', '2017-02-23 18:26:06', '10');
