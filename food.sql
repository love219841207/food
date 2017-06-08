/*
Navicat MySQL Data Transfer

Source Server         : 10.48.194.162
Source Server Version : 50709
Source Host           : 10.48.194.162:3306
Source Database       : food

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-05-22 18:09:05
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of coupon_info
-- ----------------------------
INSERT INTO `coupon_info` VALUES ('1', '10', '80.00', '2017-02-22 16:04:21', '2017-03-09 16:22:49', '1', null, null);
INSERT INTO `coupon_info` VALUES ('2', '16', '50.01', '2017-02-20 16:46:09', '2017-05-16 15:58:48', '2', null, null);
INSERT INTO `coupon_info` VALUES ('3', '11', '50.00', '2017-05-03 11:18:25', null, '1', null, null);
INSERT INTO `coupon_info` VALUES ('4', '16', '50.00', '2017-05-03 12:37:57', '2017-05-16 15:59:27', '2', null, null);
INSERT INTO `coupon_info` VALUES ('5', '13', '50.00', '2017-05-03 12:43:50', null, '1', null, null);
INSERT INTO `coupon_info` VALUES ('6', '14', '50.00', '2017-05-03 14:04:09', null, '1', null, null);
INSERT INTO `coupon_info` VALUES ('7', '15', '50.00', '2017-05-03 14:10:05', '2017-05-03 14:29:38', '1', null, null);
INSERT INTO `coupon_info` VALUES ('8', '16', '50.00', '2017-05-03 14:46:47', '2017-05-16 15:34:38', '2', null, null);
INSERT INTO `coupon_info` VALUES ('9', '17', '50.00', '2017-05-16 18:20:13', '2017-05-17 12:45:15', '2', null, null);

-- ----------------------------
-- Table structure for `healthy_info`
-- ----------------------------
DROP TABLE IF EXISTS `healthy_info`;
CREATE TABLE `healthy_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `activity` int(11) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of healthy_info
-- ----------------------------
INSERT INTO `healthy_info` VALUES ('7', '16', '0', '1983-01-01', '172', '53.5', '1', '1', '2017-05-11 10:04:07');
INSERT INTO `healthy_info` VALUES ('8', '17', '0', '2007-05-17', '165', '48', '0', '0', '2017-05-17 12:19:27');

-- ----------------------------
-- Table structure for `order_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `id` varchar(50) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4;

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
INSERT INTO `order_wechat_payment` VALUES ('20', '8ab042cb5bcc452f015bcc497d2d0000', '3229cbd18a1044eb9db3dbe8e197bfae', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503111017b1742ca2b50970650091', '2017-05-03 11:10:20', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('21', '8ab042cb5bcc452f015bcc4a6f500001', 'b3725aa97147435fa61df10b441c4d4b', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503111119716aed12650112881652', '2017-05-03 11:11:22', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('22', '8ab042cb5bcc5485015bcc9105020000', 'd0e39839b6164ad7a31ba9cb636328e0', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031228253cd088d0580749098890', '2017-05-03 12:28:28', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('23', '8ab042cb5bcc985d015bcc9a5f990000', '2f7ecc689c604e189560eb2e2a1f049c', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503123837f01ed215030385635336', '2017-05-03 12:38:41', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('24', '8ab042cb5bcc985d015bcc9a5f990000', '99b2399c9e8440d6b8df9955f5a1219b', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031241336f7dfe3d060850690435', '2017-05-03 12:41:37', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('25', '8ab042cb5bcc985d015bcc9fc1870002', 'f42404111ff744db8b75bf305fded222', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050312443043eb1f90320171686250', '2017-05-03 12:44:34', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('26', '8ab042cb5bccae51015bccd16b5e0000', '1abcaa6151a449a6a81f6269f4575c60', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503133845fd5a4097cb0339727414', '2017-05-03 13:38:49', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[047ad40769f24ba097509a29d265aae0]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[1abcaa6151a449a6a81f6269f4575c60]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[8A30BABC7FAE76219716AEEADFE2CD1B]]></sign>\n<time_end><![CDATA[20170503133850]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039378830135]]></transaction_id>\n</xml>\n', '2', '2017-05-03 13:38:55');
INSERT INTO `order_wechat_payment` VALUES ('27', '8ab042cb5bcce5f5015bccee55140000', '604181dafd51481b9f036a3171183aaa', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503141020ef17679ca90544782503', '2017-05-03 14:10:23', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[1579d1fb2ce94aacbf4d1595a1d512db]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[604181dafd51481b9f036a3171183aaa]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[3A614F460FC43164D396499B834207D0]]></sign>\n<time_end><![CDATA[20170503141025]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039379834518]]></transaction_id>\n</xml>\n', '2', '2017-05-03 14:10:29');
INSERT INTO `order_wechat_payment` VALUES ('28', '8ab042cb5bccf447015bccf4c62a0000', '60be9171d4a64cf1ab8e0d8452f45e02', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031417223c6c4a70280064252273', '2017-05-03 14:17:26', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[c8c77e55d0814dd7bdf5a4a49559c256]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[60be9171d4a64cf1ab8e0d8452f45e02]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[D9C4E22AF86EF61FBF6B4A5F8AA6F3B5]]></sign>\n<time_end><![CDATA[20170503141727]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039382939485]]></transaction_id>\n</xml>\n', '2', '2017-05-03 14:17:31');
INSERT INTO `order_wechat_payment` VALUES ('29', '8ab042cb5bccf447015bcd014a620002', 'a54d399197464bda8e457c12ed05ac58', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031431024ab940a9b80037967609', '2017-05-03 14:31:06', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[83128b6766e24e629d1f6ee7cd463650]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[a54d399197464bda8e457c12ed05ac58]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[01E58915501495E482945C1A56EA2B25]]></sign>\n<time_end><![CDATA[20170503143108]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039384900473]]></transaction_id>\n</xml>\n', '2', '2017-05-03 14:31:12');
INSERT INTO `order_wechat_payment` VALUES ('30', '8ab042cb5bcd0c8a015bcd0fccee0000', '8e5fa1333fcd43c9af3c8f49134194a6', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503144653f8f8a27bcc0425519808', '2017-05-03 14:46:57', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('31', '8ab042cb5bcd109b015bcd10d5900000', 'f61b9e386fc544f6be92c23e53eec039', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503144801b39c18c2100337658589', '2017-05-03 14:48:05', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('32', '8ab042cb5bcd1207015bcd1241830000', '6d70ae3c7ea94578bdc13c6318008847', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503144934727eee87b40969991727', '2017-05-03 14:49:38', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('33', '8ab042cb5bcd1638015bcd16fc8a0000', 'ec0d9641eec647bfa3b795e9134ccff0', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503145444dabd326a010952306498', '2017-05-03 14:54:48', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('34', '8ab042cb5bcd191f015bcd193f0d0000', 'e1ab7993af3c4b3c928bc6464f559de5', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503145712d7fcba890c0946384539', '2017-05-03 14:57:16', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('35', '8ab042cb5bcd1c23015bcd1c48c80000', 'b527ac60864941339bf9086a19acdb0f', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050315004794219809870650338527', '2017-05-03 15:00:51', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('36', '8ab042cb5bcd33db015bcd358e9d0000', '23ef02fa1b43456c9f18e667b3cd4d65', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503152817e0b2ceb30e0388906780', '2017-05-03 15:28:21', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('37', '8ab042cb5bcd33db015bcd3740c90001', '05faf8fecb574c508845b8dc92b2a0f4', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031530067c707ca81d0783398738', '2017-05-03 15:30:10', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('38', '8ab042cb5bcd4d54015bcd4d8f2c0000', 'b03f69977230408cbce6b0e768b3f5b8', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031554269a1dfc884e0375757840', '2017-05-03 15:54:30', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('39', '8ab042cb5bcd4d54015bcd4db3800001', '7179ae74b3a04f14a17f24490f62a1ae', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031554312a8c8058d10453192287', '2017-05-03 15:54:35', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('40', '8ab042cb5bcd4d54015bcd4e67c40002', '8cba54355cca4e8bb51117c61e7ba260', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050315551679311585d10613565369', '2017-05-03 15:55:20', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[9401394b53c34968a8c1af7309a603a9]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[8cba54355cca4e8bb51117c61e7ba260]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[94DAB4F51C5407A1C2854BC0C3AD0F59]]></sign>\n<time_end><![CDATA[20170503155522]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039395081512]]></transaction_id>\n</xml>\n', '2', '2017-05-03 15:55:26');
INSERT INTO `order_wechat_payment` VALUES ('41', '8ab042cb5bcd4d54015bcd752db50003', '925c21c4109e41bfb465137f62820000', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050316373712146761b40459801423', '2017-05-03 16:37:41', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[afddc2b084cf494e984d2cc7ec7d304b]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[925c21c4109e41bfb465137f62820000]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[3B2CAE0FBCAB07FC79E5A990C3825AB9]]></sign>\n<time_end><![CDATA[20170503163743]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039400756706]]></transaction_id>\n</xml>\n', '2', '2017-05-03 16:37:47');
INSERT INTO `order_wechat_payment` VALUES ('42', '8ab042cb5bcd779c015bcd7884f80001', '059a602f120144f781c570f1c3358c55', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503164116ee0c5628bc0328239122', '2017-05-03 16:41:20', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[6d8af3d90cc245408a6e54f99e291e22]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[059a602f120144f781c570f1c3358c55]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[8B5649023581B9276B364E1C9B898EC2]]></sign>\n<time_end><![CDATA[20170503164121]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039400871525]]></transaction_id>\n</xml>\n', '2', '2017-05-03 16:41:25');
INSERT INTO `order_wechat_payment` VALUES ('43', '8ab042cb5bcd779c015bcd7ac1aa0002', 'aa9da35bc2ca49408603c7f9c52852ab', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031643427d4f294aa50403986771', '2017-05-03 16:43:46', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[80d5795ab0ce432fa72709a9b5ead938]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[aa9da35bc2ca49408603c7f9c52852ab]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[2DAE8CC715F8C0ECE308841390E9B8CC]]></sign>\n<time_end><![CDATA[20170503164349]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039399370315]]></transaction_id>\n</xml>\n', '2', '2017-05-03 16:43:54');
INSERT INTO `order_wechat_payment` VALUES ('44', '8ab042cb5bcd853b015bcd8588200000', '4c131048ac804508ab2bef44817247b5', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050316552968d19f566f0029660467', '2017-05-03 16:55:33', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[d1e79687a688483682062af75009273c]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[4c131048ac804508ab2bef44817247b5]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[5455B37A95006CD964A0ADF2A46D4C0B]]></sign>\n<time_end><![CDATA[20170503165534]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039399774457]]></transaction_id>\n</xml>\n', '2', '2017-05-03 16:55:54');
INSERT INTO `order_wechat_payment` VALUES ('45', '8ab042cb5bcd8f62015bcd8fd7550000', '1a8e33cb7c1d4099bc038cb5566a0ffc', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503170644aff511634f0509758580', '2017-05-03 17:06:48', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[ff6df45324a14927869713c5d667a141]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[1a8e33cb7c1d4099bc038cb5566a0ffc]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[A58AF7CC5E080A5813ECBF212433111D]]></sign>\n<time_end><![CDATA[20170503170650]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039401800415]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:06:55');
INSERT INTO `order_wechat_payment` VALUES ('46', '8ab042cb5bcd930a015bcd933c260000', '5c5306da40184880aae8a07967350be9', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503171027e3b7c69c3b0695403340', '2017-05-03 17:10:31', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[349bdb5ae66c4e339e344b63767ec68f]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[5c5306da40184880aae8a07967350be9]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[EBB1407E2EE31B29A26F5DB10C453D80]]></sign>\n<time_end><![CDATA[20170503171032]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039401886703]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:10:37');
INSERT INTO `order_wechat_payment` VALUES ('47', '8ab042cb5bcd9cab015bcd9d51d60000', '6a2d04ebe1ad421c899d3f8d43d40aed', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503172128f55e134d920632474057', '2017-05-03 17:21:31', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[d8686e6ac5294123b032abbe748dafb9]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[6a2d04ebe1ad421c899d3f8d43d40aed]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[A72EE62A28B2FC194E7541827A570E1F]]></sign>\n<time_end><![CDATA[20170503172135]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039408342403]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:21:40');
INSERT INTO `order_wechat_payment` VALUES ('48', '8ab042cb5bcd9cab015bcda75a6a0001', '1abdd7d30cbf4c97b760eb199bdf824f', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503173225a56ce882100976459300', '2017-05-03 17:32:29', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[8821681f78274d9289c68db8cfd20968]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[1abdd7d30cbf4c97b760eb199bdf824f]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[5DED61F89EA2D5D794BA52846F7F73B8]]></sign>\n<time_end><![CDATA[20170503173231]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039406949368]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:32:35');
INSERT INTO `order_wechat_payment` VALUES ('49', '8ab042cb5bcd9cab015bcda75a6a0001', 'b2b2c30d1a2040c8ac851d74b1224be2', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050317341802091f26e60395097779', '2017-05-03 17:34:22', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[c3eea5b229ea4c108a01483c23d11e77]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[b2b2c30d1a2040c8ac851d74b1224be2]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[FF24F4B09230F42993CE61672A28FB3F]]></sign>\n<time_end><![CDATA[20170503173444]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039408788283]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:34:49');
INSERT INTO `order_wechat_payment` VALUES ('50', '8ab042cb5bcdaa6c015bcdaaf5a20000', '5d83896d4b1243dcaa4637113b3d62e9', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503173621333d32bef60243432928', '2017-05-03 17:36:25', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[b8145255683c4ece920833f3e0eb3ab7]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[5d83896d4b1243dcaa4637113b3d62e9]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[FB86215AE04DE74B54DEB64FA755BA6A]]></sign>\n<time_end><![CDATA[20170503173627]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039410393517]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:36:31');
INSERT INTO `order_wechat_payment` VALUES ('51', '8ab042cb5bcdbd7c015bcdbdc0770000', 'd7972683c2814d06948a45b74004e602', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503175653e5cdea0fd10463944519', '2017-05-03 17:56:57', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[cf833b4258694304929e34f2f3da5eb3]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[d7972683c2814d06948a45b74004e602]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[620ADB83F030941212B7C1A7578E95C5]]></sign>\n<time_end><![CDATA[20170503175700]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039409636731]]></transaction_id>\n</xml>\n', '2', '2017-05-03 17:57:04');
INSERT INTO `order_wechat_payment` VALUES ('52', '8ab042cb5bcdc7dd015bcdc8d5130000', '2e0958531cb545a6a4ce34c88f53337b', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503180859419e60c5d50697708999', '2017-05-03 18:09:03', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[36999609bef2472f8a50fc1fd56d42f5]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[2e0958531cb545a6a4ce34c88f53337b]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[88C68324DD1628435F4D857D2816322C]]></sign>\n<time_end><![CDATA[20170503180914]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039411577279]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:09:18');
INSERT INTO `order_wechat_payment` VALUES ('53', '8ab042cb5bcdcd6f015bcdcda7fd0000', 'bc101e5cbac14043b2db9807372572a9', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503181415b8ac7639ac0821308093', '2017-05-03 18:14:19', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[0443e2fd96bc4e409080f5fd2132e2d8]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[bc101e5cbac14043b2db9807372572a9]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[3E6AF73A70A4B1369B34EC1E19AB6641]]></sign>\n<time_end><![CDATA[20170503181423]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039412647299]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:14:27');
INSERT INTO `order_wechat_payment` VALUES ('54', '8ab042cb5bcdcfde015bcdd026670000', 'e5647324dbc54206b162789ac20da3dd', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503181659a5c7d5dfee0328542986', '2017-05-03 18:17:03', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[8f7875d55e93401a9b106f055656cca5]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[e5647324dbc54206b162789ac20da3dd]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[56F53DAACBF0ABBA088221E061521B74]]></sign>\n<time_end><![CDATA[20170503181704]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039412791674]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:17:08');
INSERT INTO `order_wechat_payment` VALUES ('55', '8ab042cb5bcdcfde015bcdd260750001', '5ab64a07ee954c2b963a630ead94b14c', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031819258adf0bf6420155840186', '2017-05-03 18:19:29', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('56', '8ab042cb5bcdcfde015bcdd260750001', '1034309f49f3487a9cb8bcfc6f13f779', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031819381bb685db930948445317', '2017-05-03 18:19:42', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[51664722e0fb4f21a94c38d6d312dbc3]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[1034309f49f3487a9cb8bcfc6f13f779]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[A303A8D6252F2A611658D129540DE6C0]]></sign>\n<time_end><![CDATA[20170503181946]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039414712696]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:19:50');
INSERT INTO `order_wechat_payment` VALUES ('57', '8ab042cb5bcdcfde015bcdd90d870002', '800f0c8455784fe696a5401434838b52', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503182642b7023d3f950091408252', '2017-05-03 18:26:46', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[e21dd7ca66b34d5f861a8cfffe25837e]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[800f0c8455784fe696a5401434838b52]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[FDFB8F505B20267CADF0927B8B430835]]></sign>\n<time_end><![CDATA[20170503182649]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039413155960]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:26:53');
INSERT INTO `order_wechat_payment` VALUES ('58', '8ab042cb5bcde0c2015bcde314630000', '2bc7de24d45748be9d242c6d2904094e', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050318373993ebba66e60581280077', '2017-05-03 18:37:43', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[87371d7ebdf6422991c338c7dc50b019]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[2bc7de24d45748be9d242c6d2904094e]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[B3B8110C7FFBE936D2BEEC43A27A4E5B]]></sign>\n<time_end><![CDATA[20170503183745]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039418734865]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:37:49');
INSERT INTO `order_wechat_payment` VALUES ('59', '8ab042cb5bcde0c2015bcde4c99a0001', '652ebe827cbd4b99b6153d5ef22cfc9c', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705031839311768d0c8f90966917195', '2017-05-03 18:39:35', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[49cc7349ff8c4d76a9d52643702dd879]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[652ebe827cbd4b99b6153d5ef22cfc9c]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[0678F5AFDCD8C77EF5B3F7A2DF9AFD4B]]></sign>\n<time_end><![CDATA[20170503183936]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039415395585]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:39:41');
INSERT INTO `order_wechat_payment` VALUES ('60', '8ab042cb5bcde0c2015bcde66fa10002', 'e8186f411063462e86d60dec64e9d44a', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050318411913bf2597b80892068510', '2017-05-03 18:41:23', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[1b8b8652ea2b4bd8b99445ad92d59a49]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[e8186f411063462e86d60dec64e9d44a]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[3F159BAF6C82AC279CBFE4463E14851A]]></sign>\n<time_end><![CDATA[20170503184125]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039418881052]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:41:30');
INSERT INTO `order_wechat_payment` VALUES ('61', '8ab042cb5bcdf2b7015bcdf5fd2a0000', '9524683d320947fdb2c45b0dc7c253c3', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503185819a16780322d0461308136', '2017-05-03 18:58:22', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[36421ddcb9d549318c8b07d23ddac715]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[9524683d320947fdb2c45b0dc7c253c3]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[0882D2A0EE5680136DBF0F46EA575521]]></sign>\n<time_end><![CDATA[20170503185824]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039418114005]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:58:28');
INSERT INTO `order_wechat_payment` VALUES ('62', '8ab042cb5bcdf2b7015bcdf6ca020001', 'b785ee642dff4c478540c065d558f57b', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050318591176fbe42f450006514546', '2017-05-03 18:59:15', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[02966dfaa4be41b99eabb6d2618b6039]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[b785ee642dff4c478540c065d558f57b]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[A0645BAB20A91BA4D68344D60944E2B8]]></sign>\n<time_end><![CDATA[20170503185921]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039418082732]]></transaction_id>\n</xml>\n', '2', '2017-05-03 18:59:25');
INSERT INTO `order_wechat_payment` VALUES ('63', '8ab042cb5bcdf2b7015bcdf81e730002', '4aa21f2efbc54858a847b73b833fd133', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503190038598e084b770060606630', '2017-05-03 19:00:42', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[419a2efbbe524fe09e1408556e115147]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[4aa21f2efbc54858a847b73b833fd133]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[5CCB328E1A12520C569BF48844E5110B]]></sign>\n<time_end><![CDATA[20170503190043]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039418179830]]></transaction_id>\n</xml>\n', '2', '2017-05-03 19:00:47');
INSERT INTO `order_wechat_payment` VALUES ('64', '8ab042cb5bcdf2b7015bcdf8e26e0003', '5e0ea16e32454fb1ba7d3d3c2342ba05', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170503190128b732f445990210763973', '2017-05-03 19:01:32', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[29ee0e6630874c3ebe4076b2865de1b7]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[5e0ea16e32454fb1ba7d3d3c2342ba05]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[625054FAC10E35240B413DEAA3701FB8]]></sign>\n<time_end><![CDATA[20170503190133]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039420616689]]></transaction_id>\n</xml>\n', '2', '2017-05-03 19:01:37');
INSERT INTO `order_wechat_payment` VALUES ('65', '8ab042cb5bcdf2b7015bcdf996a50004', 'a6b2670911be4f64b67913bce136a087', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050319021456ee8dd5fe0005684120', '2017-05-03 19:02:18', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[fd7a9454abb44dc88219ffa6a2dd6bd3]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[a6b2670911be4f64b67913bce136a087]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[E6281B7023EFB3787728332E1B3975CD]]></sign>\n<time_end><![CDATA[20170503190219]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705039419585364]]></transaction_id>\n</xml>\n', '2', '2017-05-03 19:02:23');
INSERT INTO `order_wechat_payment` VALUES ('66', '8ab042cb5bd14383015bd144789f0000', '651cd5a4fbf04af5b212e023e910a0c8', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041022539b08ee17900706293538', '2017-05-04 10:22:58', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[02f36040960e417aa247fe8afcc2346e]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[651cd5a4fbf04af5b212e023e910a0c8]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[BFD382697C880813FEC2BAE42A5A9CF0]]></sign>\n<time_end><![CDATA[20170504102259]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049485630045]]></transaction_id>\n</xml>\n', '2', '2017-05-04 10:23:04');
INSERT INTO `order_wechat_payment` VALUES ('67', '8ab042cb5bd15862015bd158a65f0000', '7ec7cce315ec4f7c8a182867ceafd691', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041044561c6c1d79ee0667948167', '2017-05-04 10:45:00', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[e6364017417e43339fdb7bedf6f2283c]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[7ec7cce315ec4f7c8a182867ceafd691]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[BEE4410CD9490224152D9D1095D50ADB]]></sign>\n<time_end><![CDATA[20170504104503]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049491333259]]></transaction_id>\n</xml>\n', '2', '2017-05-04 10:45:08');
INSERT INTO `order_wechat_payment` VALUES ('68', '8ab042cb5bd16763015bd169872d0000', '477b496b6ee3440587c003700935dd79', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041103222e392c21460343084679', '2017-05-04 11:03:26', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[67f703762f924b2192eb77798f0e6854]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[477b496b6ee3440587c003700935dd79]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[1568B0BB1894D5E0E7F6A09D632603B6]]></sign>\n<time_end><![CDATA[20170504110335]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049491930826]]></transaction_id>\n</xml>\n', '2', '2017-05-04 11:03:40');
INSERT INTO `order_wechat_payment` VALUES ('69', '8ab042cb5bd18454015bd18516930000', '710d14d7cc3746eaa2118886fc72851f', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx201705041133284af4cce4940332522384', '2017-05-04 11:33:32', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('70', '8ab042cb5bd18454015bd18516930000', '621f6e36669e448f9d4a914efa45dec3', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx20170504113342eb8d6299df0968459121', '2017-05-04 11:33:46', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('71', '8ab042cb5bd18454015bd18516930000', '14f0a4c95210454f8e051760f73f97c9', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx201705041133525ab68a112e0610935052', '2017-05-04 11:33:56', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('72', '8ab042cb5bd18454015bd18516930000', '6f24a1afec4f456a999d48891646ae99', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx20170504113359dff5b60f5e0790658134', '2017-05-04 11:34:03', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('73', '8ab042cb5bd18454015bd18516930000', '21096daf15074762a0aba904ad2b634c', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx2017050411343332322789950403610881', '2017-05-04 11:34:37', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('74', '8ab042cb5bd186f7015bd18719970000', '498c7840fc9340e8b0fc9572ce3ae83f', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx2017050411354016dec447390255577265', '2017-05-04 11:35:44', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('75', '8ab042cb5bd186f7015bd187e16d0001', 'ee3a1ae1e87042699014e3a5f4abf09b', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx2017050411363199374a4bc90469902785', '2017-05-04 11:36:35', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('76', '8ab042cb5bd186f7015bd188e1c30002', '86bde9a3f40e42f1bc9cbab916308ddd', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx2017050411373760f088d60b0070916862', '2017-05-04 11:37:41', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CFT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[N]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[d47d9a1c7d854a0496793fef5110a742]]></nonce_str>\n<openid><![CDATA[oPBel0oQ--hoRmVx7dYqJLHg2y78]]></openid>\n<out_trade_no><![CDATA[86bde9a3f40e42f1bc9cbab916308ddd]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[8F92E6C2CFFD44D247EB3367A0D2F591]]></sign>\n<time_end><![CDATA[20170504113751]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4003702001201705049497852611]]></transaction_id>\n</xml>\n', '2', '2017-05-04 11:37:55');
INSERT INTO `order_wechat_payment` VALUES ('77', '8ab042cb5bd18b5d015bd18ba4d90000', '4da29aef49a14d47849c2246145e8dab', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx201705041140389fe137c01c0209618967', '2017-05-04 11:40:42', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('78', '8ab042225bc8685b015bc86b44280000', '452a1d4e8dd948f186f35e070a1b85ee', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', 'wx2017050413185936d3aa59090037265884', '2017-05-02 05:08:45', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CFT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[N]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[2c938028aa154561812086159dbe8127]]></nonce_str>\n<openid><![CDATA[oPBel0oQ--hoRmVx7dYqJLHg2y78]]></openid>\n<out_trade_no><![CDATA[452a1d4e8dd948f186f35e070a1b85ee]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[6A2AAF8AA8B0EA85FFE22CEF5B111897]]></sign>\n<time_end><![CDATA[20170504131909]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4003702001201705049514964475]]></transaction_id>\n</xml>\n', '2', '2017-05-02 05:08:56');
INSERT INTO `order_wechat_payment` VALUES ('79', '8ab042225bc8685b015bc891d0f90001', 'abf2b65bea5a4633a188dd91400d6e6e', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504140300c0a8d555100038801329', '2017-05-02 05:50:55', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('80', '8ab042225bc8685b015bc89232650002', '4e5824a571184fa489d61f9b40754ae1', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041403227bc36b75a00927905301', '2017-05-02 05:51:16', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('81', '8ab042cb5bd20fce015bd21038900000', '3365562435e44df99c388682797c5620', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041405267346146e280440100925', '2017-05-04 14:05:30', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('82', '8ab042cb5bd20fce015bd211f4380001', '936f7d5d11c84f368caa0b5b262c4a73', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504140720a40dbfaa5e0385466421', '2017-05-04 14:07:24', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('83', '8ab042cb5bd214cd015bd2151fe10000', 'c2e08a2e8d9749d09cda5c076d8916b8', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050414104807871501730067733263', '2017-05-04 14:10:52', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('84', '8ab042cb5bd214cd015bd21569d00001', 'e492d8cd36b24003b58840c9a72c94d1', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041411060620d059a80857887919', '2017-05-04 14:11:11', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('85', '8ab042cb5bd217a4015bd218b5550000', '5e4335ab8c6e457caef81f3e1fffe320', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050414144209aec916c40115514550', '2017-05-04 14:14:47', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('86', '8ab042cb5bd217a4015bd218f0d50001', '2cdd876560844c3280e3fb0e05318ebb', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041414581dd3420ebf0401506250', '2017-05-04 14:15:02', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('87', '8ab042cb5bd217a4015bd21e6c550002', 'aebfa939498f427fb68075e35d5c4e9d', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041420578aa26ba1870182238106', '2017-05-04 14:21:01', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[c37721dee6ec424fae81f5824a4fa1f4]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[aebfa939498f427fb68075e35d5c4e9d]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[A94B7C3FD4A3A04D9B9ED96184EBC243]]></sign>\n<time_end><![CDATA[20170504142106]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049517791317]]></transaction_id>\n</xml>\n', '2', '2017-05-04 14:21:10');
INSERT INTO `order_wechat_payment` VALUES ('88', '8ab042cb5bd22a2c015bd22c1ffb0000', '2d01fdd1f72c4dbbabae7f05f254b37f', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504143555844553c7330577004298', '2017-05-04 14:35:59', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[22d21cb94ef84acb8c52bf263b151500]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[2d01fdd1f72c4dbbabae7f05f254b37f]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[FFA39B82EBDACE2C87143E667D047B73]]></sign>\n<time_end><![CDATA[20170504143604]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049521740999]]></transaction_id>\n</xml>\n', '2', '2017-05-04 14:36:08');
INSERT INTO `order_wechat_payment` VALUES ('89', '8ab042cb5bd22a2c015bd239f3c80001', '8cd2abfb2327477e99dc79c0731488da', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504145101433f349c500202536440', '2017-05-04 14:51:05', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[85344bcd9ce442d1a9a947227093a5f7]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[8cd2abfb2327477e99dc79c0731488da]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[73A50293710319B1360803472A584F5F]]></sign>\n<time_end><![CDATA[20170504145109]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049524648912]]></transaction_id>\n</xml>\n', '2', '2017-05-04 14:51:14');
INSERT INTO `order_wechat_payment` VALUES ('90', '8ab042cb5bd23f64015bd23fd4510000', 'c6d1e9205e9749cbb4893d8146a946d9', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504145726ef8337aac40443239997', '2017-05-04 14:57:31', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[32c8005a63aa43ca96a7bece9d0c4c30]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[c6d1e9205e9749cbb4893d8146a946d9]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[BF836D853B8EA6962A0C5AD707CEF12E]]></sign>\n<time_end><![CDATA[20170504145737]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049524847053]]></transaction_id>\n</xml>\n', '2', '2017-05-04 14:57:41');
INSERT INTO `order_wechat_payment` VALUES ('91', '8ab042cb5bd2465f015bd246aecf0000', 'c58198b20eb8412b818d3b9ef8254b7f', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504150455af2652eddd0849698138', '2017-05-04 15:05:00', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[5b790e817d244f88be898aabb886f839]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[c58198b20eb8412b818d3b9ef8254b7f]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[2FD3452C3FC0AE17889A8405B62A0522]]></sign>\n<time_end><![CDATA[20170504150503]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049524096851]]></transaction_id>\n</xml>\n', '2', '2017-05-04 15:05:07');
INSERT INTO `order_wechat_payment` VALUES ('92', '8ab042cb5bd2fdfb015bd2fecb9a0000', '869c0b94390141d58d465ab8387366a6', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504182601c47884fce80011728922', '2017-05-04 18:26:06', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('93', '8ab042cb5bd2fdfb015bd3021f490001', '00d06e88d222465b8ef6b0dceccf3a34', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504182939cdfc0c54eb0940995315', '2017-05-04 18:29:44', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[aa54e278ff804281b5bd78d129246b14]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[00d06e88d222465b8ef6b0dceccf3a34]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[C45F0111EECEF00CD2606229F5C53A84]]></sign>\n<time_end><![CDATA[20170504182945]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049551052989]]></transaction_id>\n</xml>\n', '2', '2017-05-04 18:29:50');
INSERT INTO `order_wechat_payment` VALUES ('94', '8ab042cb5bd312e7015bd3136ae30000', '0df5ecce4e7049769573b11f1f846037', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504184833b19cd61ecf0101753674', '2017-05-04 18:48:37', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[3de466e0d4214c42827de476a2bddb15]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[0df5ecce4e7049769573b11f1f846037]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[B3D255752C8EB0E74476590577CBBCF1]]></sign>\n<time_end><![CDATA[20170504184839]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049550271852]]></transaction_id>\n</xml>\n', '2', '2017-05-04 18:48:43');
INSERT INTO `order_wechat_payment` VALUES ('95', '8ab042cb5bd31460015bd3149e900000', '0e9cc77d853a4db787b8cfd7a9e8ec88', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050418495241c9db9f780375597007', '2017-05-04 18:49:56', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[5200a9a91e46459b81d53a36d58bcded]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[0e9cc77d853a4db787b8cfd7a9e8ec88]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[0AF8B9652C359CF3E6F9A5C052FD2171]]></sign>\n<time_end><![CDATA[20170504184957]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049556337403]]></transaction_id>\n</xml>\n', '2', '2017-05-04 18:50:02');
INSERT INTO `order_wechat_payment` VALUES ('96', '8ab042cb5bd316db015bd31740840000', '87bcb2b92ac64cc38727d933a8c3b3fb', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705041852446d7da885b70933831565', '2017-05-04 18:52:48', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('97', '8ab042cb5bd316db015bd3193f100001', '364cd3a1c0bb429c9abc5f873459ecfc', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017050418545564b03006fc0870984594', '2017-05-04 18:54:59', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[8209156980cc46d7a123d668d82e1ce6]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[364cd3a1c0bb429c9abc5f873459ecfc]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[B45A0D2ADB8B0EF3D8D4872E95E4BFCB]]></sign>\n<time_end><![CDATA[20170504185500]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049556495831]]></transaction_id>\n</xml>\n', '2', '2017-05-04 18:55:05');
INSERT INTO `order_wechat_payment` VALUES ('98', '8ab042cb5bd316db015bd31cd3eb0002', '8db5bea761f04375ba75c8deab9a0c7e', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx20170504185850f34cdad3b20965312886', '2017-05-04 18:58:54', '<xml><appid><![CDATA[wx318d096662fd9938]]></appid>\n<attach><![CDATA[test]]></attach>\n<bank_type><![CDATA[CEB_DEBIT]]></bank_type>\n<cash_fee><![CDATA[1]]></cash_fee>\n<fee_type><![CDATA[CNY]]></fee_type>\n<is_subscribe><![CDATA[Y]]></is_subscribe>\n<mch_id><![CDATA[1464601202]]></mch_id>\n<nonce_str><![CDATA[6c53a99cc4e24a4abcc5d871e4abea76]]></nonce_str>\n<openid><![CDATA[oPBel0ujdWqEf3oIy4bTlHGMqt5c]]></openid>\n<out_trade_no><![CDATA[8db5bea761f04375ba75c8deab9a0c7e]]></out_trade_no>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<return_code><![CDATA[SUCCESS]]></return_code>\n<sign><![CDATA[27E30CFE7EDD17AEF7CD43AF9A4B28B1]]></sign>\n<time_end><![CDATA[20170504185855]]></time_end>\n<total_fee>1</total_fee>\n<trade_type><![CDATA[JSAPI]]></trade_type>\n<transaction_id><![CDATA[4005762001201705049552122648]]></transaction_id>\n</xml>\n', '2', '2017-05-04 18:59:00');
INSERT INTO `order_wechat_payment` VALUES ('99', '8ab042935c10c4cc015c10c69a0e0000', 'a9beeb9cb444453ea2d3d5f48b0f7d2d', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', 'wx20170516182110594fc1fb010604202874', '2017-05-16 18:21:10', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('100', '8ab042935c10c4cc015c10dfe7290001', '3f2fb7a7df934eee8ee12e9b99a4be44', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', 'wx2017051618484869dc1da23e0324245093', '2017-05-16 18:48:48', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('101', '864702134292054016', 'ffd2a4ecc3de4657b1377fbbb9eedb39', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', 'wx2017051712402955a7727c890174863339', '2017-05-17 12:40:29', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('102', '864764484005134336', 'f8935867d87b41a49cf929e20923b8f9', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx201705171648159d412d4d7b0974417133', '2017-05-17 16:48:15', null, '1', null);
INSERT INTO `order_wechat_payment` VALUES ('103', '864764484005134336', 'dd94051fc3b44c6087f008722d9a2347', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', 'wx2017051716491053b0029add0079525075', '2017-05-17 16:49:10', null, '1', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pkg_menu
-- ----------------------------
INSERT INTO `pkg_menu` VALUES ('277', '1', '1', '午餐：瘦身1日', '1', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('278', '1', '1', '午餐：瘦身7日', '7', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('279', '1', '1', '午餐：瘦身30日', '30', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('280', '1', '2', '晚餐：瘦身1日', '1', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('281', '1', '2', '晚餐：瘦身7日', '7', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('282', '1', '2', '晚餐：瘦身30日', '30', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('283', '2', '1', '午餐：纤体1日', '1', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('284', '2', '1', '午餐：纤体7日', '7', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('285', '2', '1', '午餐：纤体30日', '30', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('286', '2', '2', '晚餐：纤体1日', '1', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('287', '2', '2', '晚餐：纤体7日', '7', '40.00', '0.01', '2017-05-22 15:49:54');
INSERT INTO `pkg_menu` VALUES ('288', '2', '2', '晚餐：纤体30日', '30', '40.00', '0.01', '2017-05-22 15:49:54');

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
  `main_img_paths` varchar(1000) DEFAULT NULL,
  `aa` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_time_type_index` (`schedule_day`,`type_menu`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of schedule_menu_info
-- ----------------------------
INSERT INTO `schedule_menu_info` VALUES ('145', '2017-05-20', '1', '1', '百里柠香龙利鱼', '三丝百合牛肉丝 黑椒烤香菇 翡翠黄瓜花', '南瓜', '胡萝卜松仁杂粮饭', '清火丽颜茶', '', '435.0', '2017-05-22 15:49:54', 'jizhi007.jpg', 'jizhi007.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('146', '2017-05-20', '1', '2', '秋葵裹虾', '小炒皇 香卤鸡蛋干 蒜香奶白菜', '小芋头', '蔓越莓杏仁片杂粮饭', '椰香大麦青汁', '', '415.0', '2017-05-22 15:49:54', 'jizhi008.jpg', 'jizhi008.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('147', '2017-05-20', '2', '1', '黑椒三文鱼', '甜豆炒鸡胸 烧汁杏鲍菇 日式小菜心', '马蹄', '大根秋耳杂粮饭', '美颜淡斑茶', '果仁燕麦棒', '534.0', '2017-05-22 15:49:54', 'junheng007.jpg', 'junheng007.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('148', '2017-05-20', '2', '2', '墨西哥牛肉饼', '鱼籽鸡蓉酿口蘑 菠菜豆腐 日式小菜心', '马蹄', '蔓越莓杏仁片杂粮饭', '气血双补茶', '大麦若叶饼干', '510.0', '2017-05-22 15:49:54', 'junheng008.jpg', 'junheng008.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('153', '2017-05-21', '1', '1', '深蓝秋刀鱼', '菇香冬瓜虾仁 菠菜豆腐 日式小菜心', '马蹄', '蔓越莓杏仁片杂粮饭', '气血双补茶', '大麦若叶饼干', '415.0', '2017-05-22 15:49:54', 'jizhi009.jpg', 'jizhi009.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('154', '2017-05-21', '1', '2', '墨西哥牛肉饼', '欧芹虾仁 烧汁杏鲍菇 日式小菜心', '马蹄', '大根秋耳杂粮饭', '美颜淡斑茶', '果仁燕麦棒', '431.0', '2017-05-22 15:49:54', 'jizhi010.jpg', 'jizhi010.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('158', '2017-05-21', '2', '2', '莲蓬鱼饼', '云耳鸡胸 枸杞蒸豆腐 口蘑菜心', '紫薯', '蔓越莓杏仁片杂粮饭', '石竹杞菊茶', '意大利饼干', '510.0', '2017-05-22 15:49:54', 'junheng010.jpg', 'junheng010.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('159', '2017-05-21', '2', '1', '金汤美极虾', '五彩桃仁鸡肉丸 五彩黑豆皮 清炒快菜', '紫薯', '大根秋耳杂粮饭', '雪梨薄荷茶', '杏仁紫薯饼', '497.0', '2017-05-22 15:49:54', 'junheng009.jpg', 'junheng009.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('160', '2017-02-23', '2', '2', '清蒸鱼柳', '三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜', '杂粮饭（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '446.0', '2017-05-09 22:00:02', 'img2.jpg,img2.jpg', null, null);
INSERT INTO `schedule_menu_info` VALUES ('161', '2017-05-19', '1', '1', '芦笋炒虾', '鱼籽鸡蓉酿口蘑 清炒豆嘴 荷兰豆百合炒木耳', '山药段', '大根秋耳杂粮饭', '冰桔四季春', '法式玉米片脆', '420.0', '2017-05-22 15:49:54', 'jizhi005.jpg', 'jizhi005.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('162', '2017-05-19', '1', '2', '黑椒煎鸡胸', '玉米笋炒虾仁 鲍汁冬瓜 清炒西蓝花', '山药段', '胡萝卜松仁杂粮饭', '洛神康仙饮', '', '427.0', '2017-05-22 15:49:54', 'jizhi006.jpg', 'jizhi006.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('163', '2017-05-19', '2', '1', '黑橄榄双鲜饼', '菇香冬瓜虾仁 香卤鸡蛋干 蒜香奶白菜', '小芋头', '蔓越莓杏仁片杂粮饭', '椰香大麦青汁', '时令水果沙拉', '511.0', '2017-05-22 15:49:54', 'junheng005.jpg', 'junheng005.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('164', '2017-05-19', '2', '2', '翡翠鱼丸', '小炒皇 鲍汁冬瓜 白灼油菜', '小芋头', '半边梅百合杏仁片杂粮饭', '生津青梅饮', '迷你全麦包', '514.0', '2017-05-22 15:49:54', 'junheng006.jpg', 'junheng006.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('165', '2017-02-21', '2', '1', '蛋黄南瓜百花1', '1虫草杏鲍菇拌鸡丝 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '', '1446.0', '2017-05-09 22:00:02', 'img2.jpg,img2.jpg', null, null);
INSERT INTO `schedule_menu_info` VALUES ('166', '2017-02-21', '2', '2', '清蒸鱼柳1', '1三鲜玉子豆腐 清炒快菜（M） 蚝油双菇（M）', '南瓜1', '杂粮饭1（S）', '柠檬兰香清体茶', '香蕉燕麦能量棒', '1446.0', '2017-05-09 22:00:02', '', null, null);
INSERT INTO `schedule_menu_info` VALUES ('167', '2017-05-17', '1', '1', '迷迭香三文鱼', '冬笋炒鸡胸 菠菜豆腐 金汤娃娃菜', '紫薯', '蔓越莓杏仁片杂粮饭', '生津青梅饮', '大麦若叶饼干', '417.0', '2017-05-22 15:49:54', 'jizhi001.jpg', 'jizhi001.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('168', '2017-05-17', '1', '2', '灌汤玉虾球', '云耳鸡胸 鲍汁冬瓜 白灼油菜', '紫薯', '半边梅百合杏仁片杂粮饭', '椰香大麦青汁', '迷你全麦包', '422.0', '2017-05-22 15:49:54', 'jizhi002.jpg', 'jizhi002.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('169', '2017-05-17', '2', '1', '黄金鸡卷', '三丝百合牛肉丝 鲍汁冬瓜 清炒西兰花', '山药段', '胡萝卜松仁杂粮饭', '洛神康仙饮', '', '521.0', '2017-05-22 15:49:54', 'junheng001.jpg', 'junheng001.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('170', '2017-05-17', '2', '2', '香露鸡胸', '虾仁酿冬瓜 清炒豆嘴 荷兰豆百合炒木耳', '山药段', '大根秋耳杂粮饭', '冰桔四季春', '法式玉米片脆', '515.0', '2017-05-22 15:49:54', 'junheng002.jpg', 'junheng002.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('171', '2017-05-18', '1', '1', '安格斯牛肉粒', '翡翠白果鲜虾仁 枸杞蒸豆腐 口蘑菜心', '紫薯', '蔓越莓杏仁片杂粮饭', '石竹杞菊茶', '意大利饼干', '417.0', '2017-05-22 15:49:54', 'jizhi003.jpg', 'jizhi003.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('172', '2017-05-18', '1', '2', '黄金抹虾', '甜豆炒鸡胸 五彩黑豆皮 清炒快菜', '紫薯', '大根秋耳杂粮饭', '雪梨薄荷茶', '杏仁紫薯饼', '424.0', '2017-05-22 15:49:54', 'jizhi004.jpg', 'jizhi004.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('173', '2017-05-18', '2', '1', '麒麟鱼', '青瓜虾蓉 菠菜豆腐 金汤娃娃菜', '南瓜', '半边梅百合杏仁片杂粮饭', '西柚玄米茶', 'kitty玉米饼', '528.0', '2017-05-22 15:49:54', 'junheng003.jpg', 'junheng003.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('174', '2017-05-18', '2', '2', '秘制仔乌', '天罗鱼丁 黑椒烤香菇 翡翠黄瓜花', '南瓜', '胡萝卜松仁杂粮饭', '清火丽颜茶', '', '510.0', '2017-05-22 15:49:54', 'junheng004.jpg', 'junheng004.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('175', '2017-05-22', '1', '1', '迷迭香三文鱼', '冬笋炒鸡胸 菠菜豆腐 金汤娃娃菜', '紫薯', '蔓越莓杏仁片杂粮饭', '生津青梅饮', '大麦若叶饼干', '417.0', '2017-05-22 15:49:54', 'jizhi001.jpg', 'jizhi001.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('176', '2017-05-22', '1', '2', '灌汤玉虾球', '云耳鸡胸 鲍汁冬瓜 白灼油菜', '紫薯', '半边梅百合杏仁片杂粮饭', '椰香大麦青汁', '迷你全麦包', '422.0', '2017-05-22 15:49:54', 'jizhi002.jpg', 'jizhi002.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('177', '2017-05-22', '2', '1', '黄金鸡卷', '三丝百合牛肉丝 鲍汁冬瓜 清炒西兰花', '山药段', '胡萝卜松仁杂粮饭', '洛神康仙饮', '', '521.0', '2017-05-22 15:49:54', 'junheng001.jpg', 'junheng001.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('178', '2017-05-22', '2', '2', '香露鸡胸', '虾仁酿冬瓜 清炒豆嘴 荷兰豆百合炒木耳', '山药段', '大根秋耳杂粮饭', '冰桔四季春', '法式玉米片脆', '515.0', '2017-05-22 15:49:54', 'junheng002.jpg', 'junheng002.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('179', '2017-05-23', '1', '1', '安格斯牛肉粒', '翡翠白果鲜虾仁 枸杞蒸豆腐 口蘑菜心', '紫薯', '蔓越莓杏仁片杂粮饭', '石竹杞菊茶', '意大利饼干', '417.0', '2017-05-22 15:49:54', 'img1.jpg,img1.jpg', 'img1.jpg,img1.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('180', '2017-05-23', '1', '2', '黄金抹虾', '甜豆炒鸡胸 五彩黑豆皮 清炒快菜', '紫薯', '大根秋耳杂粮饭', '雪梨薄荷茶', '杏仁紫薯饼', '424.0', '2017-05-22 15:49:54', 'img2.jpg,img2.jpg', 'img2.jpg,img2.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('181', '2017-05-23', '2', '1', '麒麟鱼', '青瓜虾蓉 菠菜豆腐 金汤娃娃菜', '南瓜', '半边梅百合杏仁片杂粮饭', '西柚玄米茶', 'kitty玉米饼', '528.0', '2017-05-22 15:49:54', 'junheng003.jpg', 'junheng003.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('182', '2017-05-23', '2', '2', '秘制仔乌', '天罗鱼丁 黑椒烤香菇 翡翠黄瓜花', '南瓜', '胡萝卜松仁杂粮饭', '清火丽颜茶', '', '510.0', '2017-05-22 15:49:54', 'junheng004.jpg', 'junheng004.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('183', '2017-05-24', '1', '1', '芦笋炒虾', '鱼籽鸡蓉酿口蘑 清炒豆嘴 荷兰豆百合炒木耳', '山药段', '大根秋耳杂粮饭', '冰桔四季春', '法式玉米片脆', '420.0', '2017-05-22 15:49:54', 'img1.jpg,img1.jpg', 'img1.jpg,img1.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('184', '2017-05-24', '1', '2', '黑椒煎鸡胸', '玉米笋炒虾仁 鲍汁冬瓜 清炒西蓝花', '山药段', '胡萝卜松仁杂粮饭', '洛神康仙饮', '', '427.0', '2017-05-22 15:49:54', 'img2.jpg,img2.jpg', 'img2.jpg,img2.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('185', '2017-05-24', '2', '1', '黑橄榄双鲜饼', '菇香冬瓜虾仁 香卤鸡蛋干 蒜香奶白菜', '小芋头', '蔓越莓杏仁片杂粮饭', '椰香大麦青汁', '时令水果沙拉', '511.0', '2017-05-22 15:49:54', 'junheng005.jpg', 'junheng0015.jpg', null);
INSERT INTO `schedule_menu_info` VALUES ('186', '2017-05-24', '2', '2', '翡翠鱼丸', '小炒皇 鲍汁冬瓜 白灼油菜', '小芋头', '半边梅百合杏仁片杂粮饭', '生津青梅饮', '迷你全麦包', '514.0', '2017-05-22 15:49:54', 'junheng006.jpg,junheng008.jpg', 'junheng0016.jpg,junheng0018.jpg', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sms_record
-- ----------------------------
INSERT INTO `sms_record` VALUES ('38', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"2153\"}', null, '00', '1', '2017-02-09 15:51:25', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105858115798^1107948830909\",\"success\":true},\"request_id\":\"3jlj66w0wbqn\"}}');
INSERT INTO `sms_record` VALUES ('39', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"2699\"}', null, '00', '1', '2017-02-09 15:52:47', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105857993589^1107948653583\",\"success\":true},\"request_id\":\"sjq38cum6t9d\"}}');
INSERT INTO `sms_record` VALUES ('40', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750504', 'SMS_44310094', '{\"code\":\"8329\"}', null, '00', '1', '2017-02-13 14:09:54', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895068967^1108004245650\",\"success\":true},\"request_id\":\"11ifi7qq4nl4t\"}}');
INSERT INTO `sms_record` VALUES ('41', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"7834\"}', null, '00', '1', '2017-02-13 14:10:11', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895245462^1108004137562\",\"success\":true},\"request_id\":\"2is8cntk7xu5\"}}');
INSERT INTO `sms_record` VALUES ('42', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"5926\"}', null, '00', '1', '2017-02-13 14:13:58', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"105895208118^1108004405380\",\"success\":true},\"request_id\":\"13yslkp6hso6v\"}}');
INSERT INTO `sms_record` VALUES ('43', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', '15026750804', 'SMS_44310094', '{\"code\":\"8479\"}', null, '00', '1', '2017-02-23 18:26:38', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"106054610001^1108210319950\",\"success\":true},\"request_id\":\"z28no0o3g48j\"}}');
INSERT INTO `sms_record` VALUES ('44', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '15026750804', 'SMS_44310094', '{\"code\":\"1935\"}', null, '00', '1', '2017-04-26 17:29:04', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107173736635^1109681977491\",\"success\":true},\"request_id\":\"3jloobh4vw8j\"}}');
INSERT INTO `sms_record` VALUES ('45', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_44310094', '{\"code\":\"6900\"}', null, '00', '1', '2017-05-03 11:03:03', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107280842667^1109809224288\",\"success\":true},\"request_id\":\"z26aio981bna\"}}');
INSERT INTO `sms_record` VALUES ('46', 'oPBel0rdgd-OEI-BGlSC7PPmu8oU', '18516200561', 'SMS_44310094', '{\"code\":\"8592\"}', null, '00', '1', '2017-05-03 11:18:11', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107281148184^1109809985285\",\"success\":true},\"request_id\":\"2mslc672agq0\"}}');
INSERT INTO `sms_record` VALUES ('47', 'oPBel0tQtn5rW5eepsdVyj49XVXw', '18616819077', 'SMS_44310094', '{\"code\":\"7957\"}', null, '00', '1', '2017-05-03 11:33:48', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107281625383^1109810431060\",\"success\":true},\"request_id\":\"3bsq8psbpszo\"}}');
INSERT INTO `sms_record` VALUES ('48', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_63855852', '{\"code\":\"1960\"}', null, '00', '1', '2017-05-03 12:37:46', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107282748268^1109811837725\",\"success\":true},\"request_id\":\"ztatgkugd84u\"}}');
INSERT INTO `sms_record` VALUES ('49', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_63855852', '{\"code\":\"6208\"}', null, '00', '1', '2017-05-03 12:43:42', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107282853164^1109811967743\",\"success\":true},\"request_id\":\"1475dl7wonmc3\"}}');
INSERT INTO `sms_record` VALUES ('50', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_63855852', '{\"code\":\"1332\"}', null, '00', '1', '2017-05-03 14:04:02', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107284154404^1109813516600\",\"success\":true},\"request_id\":\"44nscjm3pzex\"}}');
INSERT INTO `sms_record` VALUES ('51', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_63855852', '{\"code\":\"1701\"}', null, '00', '1', '2017-05-03 14:09:54', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107284372063^1109813614565\",\"success\":true},\"request_id\":\"usxzc2zupki\"}}');
INSERT INTO `sms_record` VALUES ('52', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '15026750804', 'SMS_63855852', '{\"code\":\"2959\"}', null, '00', '1', '2017-05-03 14:45:55', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107285008449^1109814379020\",\"success\":true},\"request_id\":\"10u2ka7lo4j7l\"}}');
INSERT INTO `sms_record` VALUES ('53', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', '15026750804', 'SMS_63855852', '{\"code\":\"6382\"}', null, '00', '1', '2017-05-04 11:33:02', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107298005526^1109830534207\",\"success\":true},\"request_id\":\"zddzc5s9te6i\"}}');
INSERT INTO `sms_record` VALUES ('54', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', '18917117266', 'SMS_63855852', '{\"code\":\"4126\"}', null, '00', '1', '2017-05-16 18:20:00', '{\"alibaba_aliqin_fc_sms_num_send_response\":{\"result\":{\"err_code\":\"0\",\"model\":\"107530629916^1110127422579\",\"success\":true},\"request_id\":\"ektic8mkjluh\"}}');

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
  `delivery_name` varchar(40) DEFAULT NULL,
  `delivery_phone` varchar(20) DEFAULT NULL,
  `delivery_add` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_detail_user` (`user_id`),
  KEY `index_detail_order` (`order_id`),
  KEY `index_detail_fix` (`fix_date`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_account_detail
-- ----------------------------
INSERT INTO `user_account_detail` VALUES ('147', '16', '2017-05-16 15:34:38', '1', '864383574533472256', null, '1', '1', '1', null, null, null, null);
INSERT INTO `user_account_detail` VALUES ('148', '16', '2017-05-16 15:58:48', '1', '864389655288610816', null, '1', '1', '2', null, null, null, null);
INSERT INTO `user_account_detail` VALUES ('149', '16', '2017-05-16 15:59:27', '1', '864389817100664832', null, '1', '2', '1', null, null, null, null);
INSERT INTO `user_account_detail` VALUES ('154', '17', '2017-05-17 12:45:15', '1', '864703332936056832', null, '7', '1', '1', null, null, null, null);
INSERT INTO `user_account_detail` VALUES ('156', '16', '2017-05-17 18:19:35', '2', null, null, '-1', '1', '1', '2017-05-18', '啦啦', '15026750804', '上海市黄浦区5号-。啊');
INSERT INTO `user_account_detail` VALUES ('157', '16', '2017-05-17 18:19:35', '2', null, null, '-1', '1', '2', '2017-05-19', '啦啦', '15026750804', '上海市黄浦区5号-。啊');

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_delivery_address
-- ----------------------------
INSERT INTO `user_delivery_address` VALUES ('19', '16', '15026968585', '5', '爸爸', '11', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('16', null, null, '15026750804', null, null, null, '2017-05-03 14:46:47', '2017-05-03 14:46:47');
INSERT INTO `user_info` VALUES ('17', null, null, '18917117266', null, null, null, '2017-05-16 18:20:13', '2017-05-16 18:20:13');

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_regedit_code
-- ----------------------------
INSERT INTO `user_regedit_code` VALUES ('40', '15026750804', '2153', '2017-02-09 15:51:24', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('41', '15026750804', '2699', '2017-02-09 15:52:47', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('42', '15026750504', '8329', '2017-02-13 14:09:54', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('43', '15026750804', '7834', '2017-02-13 14:10:10', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('44', '15026750804', '5926', '2017-02-13 14:13:57', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('45', '15026750804', '8479', '2017-02-23 18:26:38', 'oR6mewQ8GPvyXqGd0J3mUg7U7CYk', '1');
INSERT INTO `user_regedit_code` VALUES ('46', '15026750804', '1935', '2017-04-26 17:29:04', 'oOg1SuGmPGLT82U6Et8zQV5cQlx8', '1');
INSERT INTO `user_regedit_code` VALUES ('47', '15026750804', '6900', '2017-05-03 11:03:02', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('48', '18516200561', '8592', '2017-05-03 11:18:11', 'oPBel0rdgd-OEI-BGlSC7PPmu8oU', '1');
INSERT INTO `user_regedit_code` VALUES ('49', '18616819077', '7957', '2017-05-03 11:33:47', 'oPBel0tQtn5rW5eepsdVyj49XVXw', '1');
INSERT INTO `user_regedit_code` VALUES ('50', '15026750804', '1960', '2017-05-03 12:37:45', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('51', '15026750804', '6208', '2017-05-03 12:43:42', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('52', '15026750804', '1332', '2017-05-03 14:04:02', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('53', '15026750804', '1701', '2017-05-03 14:09:54', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('54', '15026750804', '2959', '2017-05-03 14:45:55', 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '1');
INSERT INTO `user_regedit_code` VALUES ('55', '15026750804', '6382', '2017-05-04 11:33:02', 'oPBel0oQ--hoRmVx7dYqJLHg2y78', '1');
INSERT INTO `user_regedit_code` VALUES ('56', '18917117266', '4126', '2017-05-16 18:19:59', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', '1');

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
INSERT INTO `wechat_api_token` VALUES ('1', '-WPp1XBujaI1VRxijUo5gcRgp4EuY0riSczr7bEgmS0ZN2NbRdqaWgNdIOKqXRHJXUTlwAlPqH__LGWPfN8JG-2axqkiDSOFgIlHBQMasz70UgHTKzcMkgmmXWcMfUmJEATiAGALHA', '2017-05-17 18:57:47');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of wechat_info
-- ----------------------------
INSERT INTO `wechat_info` VALUES ('35', null, null, 'oPBel0ujdWqEf3oIy4bTlHGMqt5c', '2017-05-03 14:45:47', '2017-05-03 14:45:47', '16');
INSERT INTO `wechat_info` VALUES ('36', null, null, 'oPBel0oQ--hoRmVx7dYqJLHg2y78', '2017-05-04 11:32:48', '2017-05-04 11:32:48', '16');
INSERT INTO `wechat_info` VALUES ('37', 'http://wx.qlogo.cn/mmopen/hibyd0QfYDuiayV5zY56dcJt2UpuurMSBW3rrhkI2Pic9UxeiaeNHNDVADHvLFNzYGNE1ySvAOrzLZxOVE4sTzwBVqb6ibNcfyUVH/0', '叶子?', 'oPBel0o4oOxDFVh1Z_WS1IjEBvPk', '2017-05-16 15:02:17', '2017-05-16 15:02:17', '17');
INSERT INTO `wechat_info` VALUES ('38', 'http://wx.qlogo.cn/mmopen/ibv9w35juu1EPvmreDxVN3dhxh4krUgXjArdwroUj9uQVyIkJDWacq0Q5KqmvcCdNcNiaSaraplicR4nqmOHg1mxg/0', '成功叶', 'oPBel0rdgd-OEI-BGlSC7PPmu8oU', '2017-05-17 11:19:33', '2017-05-17 11:19:33', null);


alter table pkg_menu add COLUMN  logistics_price decimal(10,2);

alter table book_group_info add COLUMN  update_time datetime;
alter table book_group_info add COLUMN  status  int(11);
alter table book_group_info add COLUMN  wechat_id bigint(20);
-- ----------------------------
-- Table structure for `group_user_info`
-- ----------------------------
-- ----------------------------
DROP TABLE IF EXISTS `group_order`;
CREATE TABLE `group_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_user_id` bigint(20) NOT NULL,
  `av` int(11) NOT NULL,
  `book_day` date NOT NULL,
  `bv` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_book_day_cid` (`group_user_id`,`book_day`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of group_order
-- ----------------------------
INSERT INTO `group_order` VALUES ('73', '85', '1', '2017-06-20', '0', '2017-06-07 16:09:04', '2017-06-07 16:09:04');

-- ----------------------------
-- Table structure for `group_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `group_user_info`;
CREATE TABLE `group_user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wechat_id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `cid` bigint(20) NOT NULL,
  `dep` varchar(200) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_group_id_cid` (`wechat_id`,`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4;

alter table schedule_menu_info add unique index index_sc_uni(schedule_day,type_menu,time_menu);
