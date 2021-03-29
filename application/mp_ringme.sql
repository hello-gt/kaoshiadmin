/*
Navicat MySQL Data Transfer

Source Server         : domob
Source Server Version : 50634
Source Host           : dbm.office.domob-inc.cn:3306
Source Database       : mp_ringme

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2021-03-11 13:47:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `rules` text COMMENT '规则介绍',
  `introduction` text NOT NULL COMMENT '简介',
  `img_introduction` varchar(2048) NOT NULL DEFAULT '[""]' COMMENT '图片简介',
  `poster` varchar(255) NOT NULL DEFAULT '' COMMENT '活动海报',
  `welfare_poster` varchar(255) NOT NULL DEFAULT '' COMMENT '榜单福利海报',
  `share_card` varchar(255) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '列表卡片图',
  `share_title` varchar(2048) NOT NULL DEFAULT '' COMMENT '分享文案',
  `support_min_limit` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '单次应援最低数量',
  `support_target_num` bigint(20) NOT NULL DEFAULT '0' COMMENT '目标应援数量，-1表示不限',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `shade_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '结榜遮罩状态(0: 开启; 1: 关闭)',
  `platform` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '平台(0: 微信; 1: QQ)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='活动表';

-- ----------------------------
-- Table structure for activity_image_collection_tag_type
-- ----------------------------
DROP TABLE IF EXISTS `activity_image_collection_tag_type`;
CREATE TABLE `activity_image_collection_tag_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '0' COMMENT '标签分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8 COMMENT='活动套图标签库类型';

-- ----------------------------
-- Table structure for activity_media_collection
-- ----------------------------
DROP TABLE IF EXISTS `activity_media_collection`;
CREATE TABLE `activity_media_collection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '活动名称',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动日期Ymd',
  `cover_image` varchar(256) NOT NULL DEFAULT '' COMMENT '封面图片URL',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '套图创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '套图最后更新时间',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态,0:未删除，1:已删除',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '上线状态,1:上线,2:下线',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频数量',
  PRIMARY KEY (`id`),
  KEY `idx_idol` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1053 DEFAULT CHARSET=utf8 COMMENT='活动套图';

-- ----------------------------
-- Table structure for activity_media_collection_tag
-- ----------------------------
DROP TABLE IF EXISTS `activity_media_collection_tag`;
CREATE TABLE `activity_media_collection_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID,为0时为公用',
  `idol_name` varchar(128) NOT NULL DEFAULT '' COMMENT '爱豆名称',
  `text` varchar(128) NOT NULL DEFAULT '' COMMENT '标签内容',
  `type` bigint(20) unsigned NOT NULL DEFAULT '1000' COMMENT '标签类型',
  `type_name` varchar(128) NOT NULL DEFAULT '' COMMENT '标签类型名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_idol_text` (`idol_id`,`text`)
) ENGINE=InnoDB AUTO_INCREMENT=1317 DEFAULT CHARSET=utf8 COMMENT='活动套图标签库';

-- ----------------------------
-- Table structure for activity_media_collection_tag_rel
-- ----------------------------
DROP TABLE IF EXISTS `activity_media_collection_tag_rel`;
CREATE TABLE `activity_media_collection_tag_rel` (
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID',
  `collection_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '套图ID',
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签ID',
  `tag_text` varchar(128) NOT NULL DEFAULT '' COMMENT '标签内容',
  `tag_type_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签类型ID',
  `tag_type_name` varchar(128) NOT NULL DEFAULT '' COMMENT '标签类型名称',
  PRIMARY KEY (`collection_id`,`tag_id`),
  KEY `idx_idol_tag_id` (`idol_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动套图标签关系表';

-- ----------------------------
-- Table structure for activity_media_collection_tag_type
-- ----------------------------
DROP TABLE IF EXISTS `activity_media_collection_tag_type`;
CREATE TABLE `activity_media_collection_tag_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '0' COMMENT '标签分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8 COMMENT='活动套图标签库类型';

-- ----------------------------
-- Table structure for activity_support_record
-- ----------------------------
DROP TABLE IF EXISTS `activity_support_record`;
CREATE TABLE `activity_support_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `aid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '应援的明星ID',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支持数量',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态, 0 正常应援 1 应援失败',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `consume_record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分消费记录ID',
  `ip` char(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `activity_idol` (`aid`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37161 DEFAULT CHARSET=utf8 COMMENT='用户在活动下支持记录';

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名为邮箱',
  `password` varchar(128) NOT NULL DEFAULT '',
  `salt` varchar(5) NOT NULL DEFAULT '' COMMENT '密码生成所需salt',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型：0 普通管理员，1 超级管理员',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT '账户状态：0 正常， 1 封禁',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后修改时间',
  `last_login` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上次登陆时间时间戳',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

-- ----------------------------
-- Table structure for ai_clockin_activity
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity`;
CREATE TABLE `ai_clockin_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动表';

-- ----------------------------
-- Table structure for ai_clockin_activity_20201218
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity_20201218`;
CREATE TABLE `ai_clockin_activity_20201218` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动表';

-- ----------------------------
-- Table structure for ai_clockin_activity_mark
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity_mark`;
CREATE TABLE `ai_clockin_activity_mark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_date` (`user_id`,`date`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动标记表';

-- ----------------------------
-- Table structure for ai_clockin_activity_record
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity_record`;
CREATE TABLE `ai_clockin_activity_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '日期',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `uk_aid_user_date` (`aid`,`user_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动记录表';

-- ----------------------------
-- Table structure for ai_clockin_activity_schedule
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity_schedule`;
CREATE TABLE `ai_clockin_activity_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_date` (`aid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动日程表';

-- ----------------------------
-- Table structure for ai_clockin_activity_schedule_20201218
-- ----------------------------
DROP TABLE IF EXISTS `ai_clockin_activity_schedule_20201218`;
CREATE TABLE `ai_clockin_activity_schedule_20201218` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_date` (`aid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动日程表';

-- ----------------------------
-- Table structure for ai_custom_result
-- ----------------------------
DROP TABLE IF EXISTS `ai_custom_result`;
CREATE TABLE `ai_custom_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idol_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态:1未处理, 2已处理',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '文字内容',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间\n',
  `task_timeout` bigint(20) NOT NULL DEFAULT '0' COMMENT '任务超时时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=625 DEFAULT CHARSET=utf8 COMMENT='文字结果页';

-- ----------------------------
-- Table structure for ai_custom_voice
-- ----------------------------
DROP TABLE IF EXISTS `ai_custom_voice`;
CREATE TABLE `ai_custom_voice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL DEFAULT '0' COMMENT '结果id',
  `idol_id` int(11) NOT NULL DEFAULT '0' COMMENT '明星id\r\n',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音url',
  `status` tinyint(4) DEFAULT NULL COMMENT '语音状态: 1:未处理, 2:已处理',
  `score` tinyint(4) NOT NULL DEFAULT '0' COMMENT '语音评价\r\n',
  `create_time` bigint(20) NOT NULL DEFAULT '0',
  `last_update` bigint(20) NOT NULL DEFAULT '0',
  `delete_at` bigint(20) NOT NULL DEFAULT '0',
  `duration` int(11) DEFAULT '0' COMMENT '语音长度',
  `size` int(11) DEFAULT '0' COMMENT '语音大小',
  PRIMARY KEY (`id`),
  KEY `ai_custom_voice_user_id_status_rid_index` (`user_id`,`status`,`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=1766 DEFAULT CHARSET=utf8 COMMENT='用户定制语音';

-- ----------------------------
-- Table structure for ai_pray_record
-- ----------------------------
DROP TABLE IF EXISTS `ai_pray_record`;
CREATE TABLE `ai_pray_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援的明星ID',
  `date` bigint(20) NOT NULL COMMENT '投票日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_pray` (`user_id`,`idol_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='AI祈愿记录表';

-- ----------------------------
-- Table structure for ai_vote_activity
-- ----------------------------
DROP TABLE IF EXISTS `ai_vote_activity`;
CREATE TABLE `ai_vote_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `rules` text COMMENT '规则介绍',
  `introduction` text NOT NULL COMMENT '简介',
  `poster` varchar(255) NOT NULL DEFAULT '' COMMENT '活动海报',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8 COMMENT='AI投票活动表';

-- ----------------------------
-- Table structure for ai_vote_activity_idol_rel
-- ----------------------------
DROP TABLE IF EXISTS `ai_vote_activity_idol_rel`;
CREATE TABLE `ai_vote_activity_idol_rel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援的明星ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 正常 1: 已取消',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_idol` (`aid`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1926 DEFAULT CHARSET=utf8 COMMENT='AI投票活动明星关联表';

-- ----------------------------
-- Table structure for ai_vote_activity_record
-- ----------------------------
DROP TABLE IF EXISTS `ai_vote_activity_record`;
CREATE TABLE `ai_vote_activity_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '投票日期',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援的明星ID',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `ip` char(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_date` (`user_id`,`date`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8 COMMENT='AI投票活动用户记录表';

-- ----------------------------
-- Table structure for app_page_stat_daily
-- ----------------------------
DROP TABLE IF EXISTS `app_page_stat_daily`;
CREATE TABLE `app_page_stat_daily` (
  `date` mediumint(9) NOT NULL DEFAULT '0' COMMENT '日期格式yyyymmdd',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '前端功能的路径',
  `pv` int(11) DEFAULT '0' COMMENT '发布动态的去重人数',
  `uv` int(11) DEFAULT '0' COMMENT '指进入到话题详情动态详情的去重uv',
  `time` int(11) DEFAULT '0' COMMENT '停留页面总时长,单位秒',
  PRIMARY KEY (`date`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_cas
-- ----------------------------
DROP TABLE IF EXISTS `auth_cas`;
CREATE TABLE `auth_cas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `service` varchar(512) DEFAULT NULL,
  `ticket` varchar(512) DEFAULT NULL,
  `renew` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_cas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_event
-- ----------------------------
DROP TABLE IF EXISTS `auth_event`;
CREATE TABLE `auth_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_stamp` datetime DEFAULT NULL,
  `client_ip` varchar(512) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `origin` varchar(512) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_event_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(512) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_membership
-- ----------------------------
DROP TABLE IF EXISTS `auth_membership`;
CREATE TABLE `auth_membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_membership_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_membership_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `name` varchar(512) DEFAULT NULL,
  `table_name` varchar(512) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_permission_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `registration_key` varchar(512) DEFAULT NULL,
  `reset_password_key` varchar(512) DEFAULT NULL,
  `registration_id` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'type：2 云剪辑id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `blog_topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星话题id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_date` int(10) NOT NULL DEFAULT '0' COMMENT '创建日期(yyyymm)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `image_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '图片快照列表，eg: url1,url2...',
  `video_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '视频快照列表，eg: url1,url2...',
  `share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态分享数量',
  `like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态点赞数量',
  `opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态评论数量',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片素材数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频素材数量',
  `last_opinion_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后评论时间',
  `share_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光链id',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '动态类型(0:常规动态; 1:时光链动态; 2: 云剪辑发送动态)',
  `distinct_like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量(去重)',
  `distinct_opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量(去重)',
  `distinct_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享数量(去重)',
  `recommend_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为推荐位(0:否；1：是)',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶 0:否 1:是',
  `pv` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看动态详情的pv',
  `obj_id` bigint(20) NOT NULL COMMENT 'type：2 云剪辑id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idol_id` (`idol_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `topic_id` (`blog_topic_id`),
  KEY `idx_idol_hot_score` (`idol_id`,`hot_score`,`create_time`),
  KEY `idx_idol_last_opinion` (`idol_id`,`last_opinion_time`,`create_time`),
  KEY `idx_topic_hot_score` (`blog_topic_id`,`hot_score`,`create_time`),
  KEY `idx_topic_last_opinion` (`blog_topic_id`,`last_opinion_time`,`create_time`),
  KEY `idx_idol_create_time` (`idol_id`,`create_time`),
  KEY `idx_blog_create_time` (`blog_topic_id`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=81620 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户blog表';

-- ----------------------------
-- Table structure for blog_like
-- ----------------------------
DROP TABLE IF EXISTS `blog_like`;
CREATE TABLE `blog_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户圈子动态id',
  `attitude` tinyint(1) NOT NULL DEFAULT '0' COMMENT '态度(0:无; 1:赞; 2:踩)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_like` (`user_id`,`blog_id`),
  KEY `idx_blog_id` (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=480423 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户blog点赞表';

-- ----------------------------
-- Table structure for blog_material
-- ----------------------------
DROP TABLE IF EXISTS `blog_material`;
CREATE TABLE `blog_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户圈子动态id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `desc` varchar(64) NOT NULL DEFAULT '' COMMENT '素材描述',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `visible` tinyint(4) NOT NULL DEFAULT '1' COMMENT '判断素材是否对外可见的依据 0:不可见, 1:可见, 默认可见',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_blog_id` (`blog_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95298 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户blog素材';

-- ----------------------------
-- Table structure for blog_opinion
-- ----------------------------
DROP TABLE IF EXISTS `blog_opinion`;
CREATE TABLE `blog_opinion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户圈子动态id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `root_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根级id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `target_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复用户id',
  `content` text NOT NULL COMMENT '评论内容',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `child_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `child_snap` varchar(2000) DEFAULT '' COMMENT '回复快照',
  `idol_id` bigint(20) unsigned NOT NULL COMMENT '明星id',
  PRIMARY KEY (`id`),
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_root_id` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169531 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户blog评论表';

-- ----------------------------
-- Table structure for blog_share
-- ----------------------------
DROP TABLE IF EXISTS `blog_share`;
CREATE TABLE `blog_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_blog` (`user_id`,`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111915 DEFAULT CHARSET=utf8 COMMENT='blog分享表';

-- ----------------------------
-- Table structure for blog_topic
-- ----------------------------
DROP TABLE IF EXISTS `blog_topic`;
CREATE TABLE `blog_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `cover` varchar(3000) NOT NULL DEFAULT '' COMMENT '话题图，eg: url1,url2...',
  `background` varchar(3000) NOT NULL DEFAULT '' COMMENT '背景图，eg: url1,url2...',
  `read_nums` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '阅读数量',
  `content_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容数量',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度',
  `distinct_like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题下动态总点赞数量(去重)',
  `distinct_opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题下动态总评论数量(去重)',
  `distinct_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题下动态总分享数量(去重)',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1：未冻结 2：已冻结',
  `start_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动开始时间\n',
  `idol_status` tinyint(2) DEFAULT '0' COMMENT '明星状态 1:全部明星 2:部分明星',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '权重, 倒序 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='话题表';

-- ----------------------------
-- Table structure for blog_topic_stats
-- ----------------------------
DROP TABLE IF EXISTS `blog_topic_stats`;
CREATE TABLE `blog_topic_stats` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'blog_topic_id',
  `blog_num` bigint(20) DEFAULT NULL COMMENT '动态数量',
  `published_user_num` bigint(20) DEFAULT NULL COMMENT '发布过的user',
  `page_view` bigint(20) DEFAULT NULL COMMENT '浏览pv',
  `unique_view` bigint(20) DEFAULT NULL COMMENT '浏览用户uv',
  `share` bigint(20) DEFAULT NULL COMMENT '分享次数',
  `unique_share` bigint(20) DEFAULT NULL COMMENT '分享人数',
  `detail_view` bigint(20) DEFAULT NULL COMMENT '动态详情pv',
  `unique_detail_view` bigint(20) DEFAULT NULL COMMENT '动态详情uv',
  `interact` bigint(20) DEFAULT NULL COMMENT '转赞评pv',
  `unique_interact` bigint(20) DEFAULT NULL COMMENT '转赞评的用户uv',
  `detail_share` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态详情下的分享数',
  `detail_unique_share` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态详情里的分享人数\r\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bot_blog_like_task
-- ----------------------------
DROP TABLE IF EXISTS `bot_blog_like_task`;
CREATE TABLE `bot_blog_like_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.idol_id',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.topic_id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'user(bot) id',
  `published` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'unpublished:0, published:1',
  `admin_uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mis operator uid',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞任务创建的时间',
  `published_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞发布的时间,执行发布的时候填写',
  `allowed_publish_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最早可以发布的时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`blog_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94792 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bot_blog_opinion_task
-- ----------------------------
DROP TABLE IF EXISTS `bot_blog_opinion_task`;
CREATE TABLE `bot_blog_opinion_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.idol_id',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.topic_id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'user(bot) id',
  `content` text COMMENT '评论内容',
  `published` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'unpublished:0, published:1',
  `admin_uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mis operator uid',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞任务创建的时间',
  `published_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞发布的时间,执行发布的时候填写',
  `allowed_publish_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最早可以发布的时间',
  PRIMARY KEY (`id`),
  KEY `idx` (`blog_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1450 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bot_blog_share_task
-- ----------------------------
DROP TABLE IF EXISTS `bot_blog_share_task`;
CREATE TABLE `bot_blog_share_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.idol_id',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.topic_id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'user(bot) id',
  `published` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'unpublished:0, published:1',
  `admin_uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mis operator uid',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分享任务创建的时间',
  `published_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分享发布的时间,执行发布的时候填写',
  `allowed_publish_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最早可以发布的时间',
  PRIMARY KEY (`id`),
  KEY `idx` (`blog_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51628 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bot_blog_task
-- ----------------------------
DROP TABLE IF EXISTS `bot_blog_task`;
CREATE TABLE `bot_blog_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog.id 发布成功后回填',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol_id',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'topic_id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'user(bot) id',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `content_md5` varchar(64) NOT NULL DEFAULT '' COMMENT '内容md5',
  `image_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '图片列表，eg: url1,url2...',
  `video_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '视频列表，eg: url1,url2...',
  `published` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'unpublished:0, published:1',
  `admin_uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mis operator uid',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务创建的时间',
  `published_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发布的时间,执行发布的时候填写',
  `allowed_publish_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最早可以发布的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1645 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bot_blogs
-- ----------------------------
DROP TABLE IF EXISTS `bot_blogs`;
CREATE TABLE `bot_blogs` (
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'idol名称',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `content_md5` varchar(64) NOT NULL DEFAULT '' COMMENT '内容md5',
  `image_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '图片列表，eg: url1,url2...',
  `video_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '视频列表，eg: url1,url2...',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已发布',
  UNIQUE KEY `uk` (`name`,`content_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car818_idol_activity_collector
-- ----------------------------
DROP TABLE IF EXISTS `car818_idol_activity_collector`;
CREATE TABLE `car818_idol_activity_collector` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idol_id` bigint(20) NOT NULL DEFAULT '0',
  `idol_pick_nums` bigint(20) DEFAULT '0',
  `idol_event_nums` bigint(20) DEFAULT '0',
  `idol_event_material_nums` bigint(20) DEFAULT '0',
  `club_event_nums` bigint(20) DEFAULT '0',
  `like_nums` bigint(20) DEFAULT '0',
  `last_update` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for car818_idol_activity_collector_copy1
-- ----------------------------
DROP TABLE IF EXISTS `car818_idol_activity_collector_copy1`;
CREATE TABLE `car818_idol_activity_collector_copy1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idol_id` bigint(20) NOT NULL DEFAULT '0',
  `idol_pick_nums` bigint(20) DEFAULT '0',
  `idol_event_nums` bigint(20) DEFAULT '0',
  `idol_event_material_nums` bigint(20) DEFAULT '0',
  `club_event_nums` bigint(20) DEFAULT '0',
  `like_nums` bigint(20) DEFAULT '0',
  `last_update` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1108 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for citys
-- ----------------------------
DROP TABLE IF EXISTS `citys`;
CREATE TABLE `citys` (
  `id` smallint(5) unsigned NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` smallint(5) NOT NULL COMMENT '上级',
  `gps_lat` decimal(10,6) DEFAULT NULL COMMENT '纬度',
  `gps_lng` decimal(10,6) DEFAULT NULL COMMENT '经度',
  `short` varchar(3) DEFAULT NULL,
  `pinyin` varchar(50) DEFAULT NULL COMMENT '拼音',
  `simple_name` varchar(30) DEFAULT NULL COMMENT '简称',
  `code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信geo id',
  `area_code` varchar(5) DEFAULT NULL COMMENT '电话区号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='城市列表';

-- ----------------------------
-- Table structure for club_event
-- ----------------------------
DROP TABLE IF EXISTS `club_event`;
CREATE TABLE `club_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝站id',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '简介',
  `ic_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联的明星卡片id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `event_date` int(10) NOT NULL DEFAULT '0' COMMENT '动态日期(yyyymm)',
  `event_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '动态时间',
  `create_date` int(10) NOT NULL DEFAULT '0' COMMENT '创建日期(yyyymm)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `image_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '图片快照列表，eg: url1,url2...',
  `video_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '视频快照列表，eg: url1,url2...',
  `share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态分享数量',
  `like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态点赞数量',
  `opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态评论数量',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片素材数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频素材数量',
  PRIMARY KEY (`id`),
  KEY `idol_club_date` (`idol_id`,`club_id`,`event_date`)
) ENGINE=InnoDB AUTO_INCREMENT=697 DEFAULT CHARSET=utf8 COMMENT='应援轴动态表';

-- ----------------------------
-- Table structure for club_event_like
-- ----------------------------
DROP TABLE IF EXISTS `club_event_like`;
CREATE TABLE `club_event_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `ce_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态件id',
  `attitude` tinyint(1) NOT NULL DEFAULT '0' COMMENT '态度(0:无; 1:赞; 2:踩)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_ce` (`user_id`,`ce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25267 DEFAULT CHARSET=utf8 COMMENT='应援轴动态点赞表';

-- ----------------------------
-- Table structure for club_event_material
-- ----------------------------
DROP TABLE IF EXISTS `club_event_material`;
CREATE TABLE `club_event_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ce_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝站id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `desc` varchar(64) NOT NULL DEFAULT '' COMMENT '素材描述',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  PRIMARY KEY (`id`),
  KEY `ce_id` (`ce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1411 DEFAULT CHARSET=utf8 COMMENT='应援轴动态素材';

-- ----------------------------
-- Table structure for club_event_opinion
-- ----------------------------
DROP TABLE IF EXISTS `club_event_opinion`;
CREATE TABLE `club_event_opinion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ce_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `root_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根级id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `target_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复用户id',
  `content` text NOT NULL COMMENT '评论内容',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `child_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `child_snap` varchar(2000) DEFAULT '' COMMENT '回复快照',
  PRIMARY KEY (`id`),
  KEY `ce_id` (`ce_id`),
  KEY `root_id` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3159 DEFAULT CHARSET=utf8 COMMENT='应援轴动态评论表';

-- ----------------------------
-- Table structure for customer_message
-- ----------------------------
DROP TABLE IF EXISTS `customer_message`;
CREATE TABLE `customer_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_open_id` char(28) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'open_id',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '内容',
  `message_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类别',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32659 DEFAULT CHARSET=utf8 COMMENT='客服消息';

-- ----------------------------
-- Table structure for dirty_words
-- ----------------------------
DROP TABLE IF EXISTS `dirty_words`;
CREATE TABLE `dirty_words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL DEFAULT '' COMMENT '敏感词',
  `category` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类别: 0其他, 1色情, 2反动, 3暴恐, 4民生, 5贪腐',
  `create_time` bigint(20) NOT NULL DEFAULT '0',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '上次更新时间',
  `disable` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否跳过审核(0否, 1是)',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否移除(0: 不移除; 1: 移除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=535 DEFAULT CHARSET=utf8 COMMENT='敏感词词库';

-- ----------------------------
-- Table structure for fan_club
-- ----------------------------
DROP TABLE IF EXISTS `fan_club`;
CREATE TABLE `fan_club` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '后援会名称',
  `logo` varchar(1024) NOT NULL DEFAULT '' COMMENT 'logo',
  `weibo` varchar(64) NOT NULL DEFAULT '' COMMENT '微博ID',
  `weibo_logo` varchar(256) NOT NULL DEFAULT '' COMMENT '微博截图',
  `phone_number` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号',
  `wechat` varchar(64) NOT NULL DEFAULT '' COMMENT '微信号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '认证状态(0: 已认证; 1:认证解除)',
  `members` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '成员数量',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idol_id` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8 COMMENT='后援会表';

-- ----------------------------
-- Table structure for fan_club_auth_form
-- ----------------------------
DROP TABLE IF EXISTS `fan_club_auth_form`;
CREATE TABLE `fan_club_auth_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fan_club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '后援会id(创建后援会时默认为0)',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '申请者用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '(1: 创建后援会;2:关联后援会)',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '后援会名称',
  `logo` varchar(1024) NOT NULL DEFAULT '' COMMENT 'logo',
  `weibo` varchar(64) NOT NULL DEFAULT '' COMMENT '微博ID',
  `weibo_logo` varchar(256) NOT NULL DEFAULT '' COMMENT '微博截图',
  `phone_number` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号',
  `wechat` varchar(64) NOT NULL DEFAULT '' COMMENT '微信号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT '职务',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未审核; 1:审核失败; 2:审核通过)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=829 DEFAULT CHARSET=utf8 COMMENT='后援会认证申请表';

-- ----------------------------
-- Table structure for fan_club_member
-- ----------------------------
DROP TABLE IF EXISTS `fan_club_member`;
CREATE TABLE `fan_club_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fan_club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '后援会id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `weibo` varchar(64) NOT NULL DEFAULT '' COMMENT '微博ID',
  `weibo_logo` varchar(256) NOT NULL DEFAULT '' COMMENT '微博截图',
  `phone_number` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号',
  `wechat` varchar(64) NOT NULL DEFAULT '' COMMENT '微信号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '认证状态(0: 已认证; 1:认证解除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idol_user` (`idol_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=531 DEFAULT CHARSET=utf8 COMMENT='后援会成员表';

-- ----------------------------
-- Table structure for fan_club_summary
-- ----------------------------
DROP TABLE IF EXISTS `fan_club_summary`;
CREATE TABLE `fan_club_summary` (
  `club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝站id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态数量',
  `like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态点赞数量',
  `collect_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态收藏数量',
  `distinct_opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态评论数量(去重后)',
  `opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态评论数量',
  `distinct_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态分享数量(去重后)',
  `share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态分享数量',
  `rank_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序分数',
  PRIMARY KEY (`club_id`),
  KEY `idol_score` (`idol_id`,`rank_score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='粉丝站汇总数据';

-- ----------------------------
-- Table structure for fan_club_urge
-- ----------------------------
DROP TABLE IF EXISTS `fan_club_urge`;
CREATE TABLE `fan_club_urge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝站id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '日期(yyyymm)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_club_date` (`club_id`,`user_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8 COMMENT='粉丝站催更记录表';

-- ----------------------------
-- Table structure for feed
-- ----------------------------
DROP TABLE IF EXISTS `feed`;
CREATE TABLE `feed` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'feed id',
  `category` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed数据类型,0:unknown,1:blog,2:card event',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed归属类型，0:unknown,1:话题feed,2:picked feed,3:推荐feed',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '源数据ID(blog.id/idol_event.id)',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值:1*点赞+2*分享+3*评论',
  `rank_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐指数，经时间衰减后的热度值，直接体现排序',
  `obj_create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源数据的创建（发布）时间戳',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'feed创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `category_obj_id` (`category`,`obj_id`) USING BTREE,
  KEY `rs` (`rank_score`) USING BTREE,
  KEY `oct` (`obj_create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=384862 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广场推荐feed表';

-- ----------------------------
-- Table structure for feed_20201013
-- ----------------------------
DROP TABLE IF EXISTS `feed_20201013`;
CREATE TABLE `feed_20201013` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'feed id',
  `category` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed数据类型,0:unknown,1:blog,2:card event',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed归属类型，0:unknown,1:话题feed,2:picked feed,3:推荐feed',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '源数据ID(blog.id/idol_event.id)',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值:1*点赞+2*分享+3*评论',
  `rank_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐指数，经时间衰减后的热度值，直接体现排序',
  `obj_create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源数据的创建（发布）时间戳',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'feed创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `category_obj_id` (`category`,`obj_id`) USING BTREE,
  KEY `rs` (`rank_score`) USING BTREE,
  KEY `oct` (`obj_create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9994 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广场推荐feed表';

-- ----------------------------
-- Table structure for feed_config
-- ----------------------------
DROP TABLE IF EXISTS `feed_config`;
CREATE TABLE `feed_config` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(512) NOT NULL DEFAULT '' COMMENT '配置内容',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广场推荐feed配置表';

-- ----------------------------
-- Table structure for global_stat_daily
-- ----------------------------
DROP TABLE IF EXISTS `global_stat_daily`;
CREATE TABLE `global_stat_daily` (
  `date` mediumint(9) NOT NULL DEFAULT '0' COMMENT '日期格式yyyymmdd',
  `ugc_user_num` int(11) DEFAULT '0' COMMENT '发布动态的去重人数',
  `blog_detail_user_num` int(11) DEFAULT '0' COMMENT '指进入到话题详情动态详情的去重uv',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hot_feed
-- ----------------------------
DROP TABLE IF EXISTS `hot_feed`;
CREATE TABLE `hot_feed` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'feed id',
  `category` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed数据类型,0:unknown,1:blog,2:card event',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed归属类型，0:unknown,1:话题feed,2:picked feed,3:推荐feed',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '源数据ID(blog.id/idol_event.id)',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值:1*点赞+2*分享+3*评论',
  `rank_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐指数，经时间衰减后的热度值，直接体现排序',
  `obj_create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源数据的创建（发布）时间戳',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'feed创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `category_obj_id` (`category`,`obj_id`) USING BTREE,
  KEY `rs` (`rank_score`) USING BTREE,
  KEY `oct` (`obj_create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广场高热推荐feed表';

-- ----------------------------
-- Table structure for hot_feed_20201013
-- ----------------------------
DROP TABLE IF EXISTS `hot_feed_20201013`;
CREATE TABLE `hot_feed_20201013` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'feed id',
  `category` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed数据类型,0:unknown,1:blog,2:card event',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'feed归属类型，0:unknown,1:话题feed,2:picked feed,3:推荐feed',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '源数据ID(blog.id/idol_event.id)',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值:1*点赞+2*分享+3*评论',
  `rank_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推荐指数，经时间衰减后的热度值，直接体现排序',
  `obj_create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '源数据的创建（发布）时间戳',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'feed创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `category_obj_id` (`category`,`obj_id`) USING BTREE,
  KEY `rs` (`rank_score`) USING BTREE,
  KEY `oct` (`obj_create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广场高热推荐feed表';

-- ----------------------------
-- Table structure for idol
-- ----------------------------
DROP TABLE IF EXISTS `idol`;
CREATE TABLE `idol` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `rectangle_logo` varchar(255) NOT NULL DEFAULT '' COMMENT '长方形头像',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `birthday` date NOT NULL DEFAULT '0001-01-01' COMMENT '生日',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:上线; 2:下线; 3:删除)',
  `pinyin` varchar(255) NOT NULL DEFAULT '' COMMENT '首字母缩写',
  `material_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '时光轴素材数量',
  `media_lib_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '图库素材数据',
  `achievement_grade_name` varchar(255) NOT NULL DEFAULT '' COMMENT '成就等级名称',
  `achievement_grade_icon` varchar(255) NOT NULL DEFAULT '' COMMENT '成就等级icon',
  `achievement_grade_frame` varchar(255) NOT NULL DEFAULT '' COMMENT '成就等级头像框',
  `achievement_grade_color` varchar(255) NOT NULL DEFAULT '' COMMENT '成就等级颜色',
  `achievement_grade_square_frame` varchar(255) NOT NULL DEFAULT '' COMMENT '方成就等级头像框',
  `achievement_idx` tinyint(3) NOT NULL DEFAULT '0' COMMENT '当前等级idx',
  `media_lib_image_nums` bigint(20) NOT NULL COMMENT '图库图片数量',
  `media_lib_video_nums` bigint(20) NOT NULL COMMENT '图库视频数量',
  `card_nums` bigint(20) NOT NULL COMMENT '卡片数量',
  `challenge_status` bigint(20) NOT NULL DEFAULT '0' COMMENT '眼力挑战(0: 未开始, 1: 开始)',
  `challenge_media_lib_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '眼力挑战 图库图片数量',
  `challenge_upload_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '眼力挑战上传 图片数量',
  `challenge_total_people_unms` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '眼力值挑战赛总人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1962 DEFAULT CHARSET=utf8 COMMENT='爱豆表';

-- ----------------------------
-- Table structure for idol_20200923
-- ----------------------------
DROP TABLE IF EXISTS `idol_20200923`;
CREATE TABLE `idol_20200923` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `rectangle_logo` varchar(255) NOT NULL DEFAULT '' COMMENT '长方形头像',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `birthday` date NOT NULL DEFAULT '0001-01-01' COMMENT '生日',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:上线; 2:下线; 3:删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1823 DEFAULT CHARSET=utf8 COMMENT='爱豆表';

-- ----------------------------
-- Table structure for idol_achievement_grade
-- ----------------------------
DROP TABLE IF EXISTS `idol_achievement_grade`;
CREATE TABLE `idol_achievement_grade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '等级名称',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT '权重（按照权重倒叙排）',
  `media_lib_nums` int(11) NOT NULL DEFAULT '0' COMMENT '图库分数',
  `material_nums` int(11) NOT NULL DEFAULT '0' COMMENT '时光轴分数',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '等级的icon',
  `avatar_frame` varchar(255) NOT NULL DEFAULT '' COMMENT '等级头像框',
  `color` varchar(255) NOT NULL DEFAULT '' COMMENT '对应等级颜色',
  `square_avatar_frame` varchar(255) DEFAULT '' COMMENT '方等级头像框',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8 COMMENT='明星成就等级设置表';

-- ----------------------------
-- Table structure for idol_ai
-- ----------------------------
DROP TABLE IF EXISTS `idol_ai`;
CREATE TABLE `idol_ai` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `greeting_content` varchar(5000) NOT NULL DEFAULT '[]' COMMENT '问候内容 使用json存储问候语',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条状态(0: 启用 1: 不启用)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `custom_notice` varchar(30) NOT NULL DEFAULT '' COMMENT '明星定制语音提示语',
  `enhance_id` int(11) NOT NULL DEFAULT '0' COMMENT '增强明星id\n',
  `voice_num` int(11) NOT NULL DEFAULT '0' COMMENT '语句数量',
  `chat_uv` int(11) NOT NULL DEFAULT '0' COMMENT '聊天人数',
  `user_send_pv` int(11) NOT NULL DEFAULT '0' COMMENT '用户发送条数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_ai_20210204
-- ----------------------------
DROP TABLE IF EXISTS `idol_ai_20210204`;
CREATE TABLE `idol_ai_20210204` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `greeting_content` varchar(5000) NOT NULL DEFAULT '[]' COMMENT '问候内容 使用json存储问候语',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条状态(0: 启用 1: 不启用)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `custom_notice` varchar(30) NOT NULL DEFAULT '' COMMENT '明星定制语音提示语',
  `enhance_id` int(11) NOT NULL DEFAULT '0' COMMENT '增强明星id\n',
  `voice_num` int(11) NOT NULL DEFAULT '0' COMMENT '语句数量',
  `chat_uv` int(11) NOT NULL DEFAULT '0' COMMENT '聊天人数',
  `user_send_pv` int(11) NOT NULL DEFAULT '0' COMMENT '用户发送条数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_card
-- ----------------------------
DROP TABLE IF EXISTS `idol_card`;
CREATE TABLE `idol_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '日期(yyyymm)',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '卡片标题',
  `cover` varchar(1024) NOT NULL DEFAULT '' COMMENT '卡片封面',
  `lock_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定卡片的用户id',
  `lock_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '锁定状态(0: 未锁定; 1:已锁定)',
  `fan_club_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定用户关联的后援会id',
  `last_update_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后编辑卡片的用户id',
  `event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴事件数量',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片素材数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频素材数量',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '后台自动审核状态 0未审核, 1审核成功, 2审核失败\n',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  PRIMARY KEY (`id`),
  KEY `date_idol` (`date`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9832 DEFAULT CHARSET=utf8 COMMENT='爱豆卡片表';

-- ----------------------------
-- Table structure for idol_card_form
-- ----------------------------
DROP TABLE IF EXISTS `idol_card_form`;
CREATE TABLE `idol_card_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ic_id` int(10) unsigned NOT NULL COMMENT 'ic_id',
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '日期(yyyymm)',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '卡片标题',
  `cover` varchar(1024) NOT NULL DEFAULT '' COMMENT '卡片封面',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '(1: 发布;2:编辑)',
  `audit_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态(0:未知; 1:审核中; 2:审核通过; 3:审核拒绝)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12570 DEFAULT CHARSET=utf8 COMMENT='爱豆卡片申请表';

-- ----------------------------
-- Table structure for idol_circle
-- ----------------------------
DROP TABLE IF EXISTS `idol_circle`;
CREATE TABLE `idol_circle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `cover` varchar(512) NOT NULL DEFAULT '' COMMENT '封面',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `content_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态数',
  `read_nums` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '阅读数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_idol_id` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2036 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='明星圈子';

-- ----------------------------
-- Table structure for idol_event
-- ----------------------------
DROP TABLE IF EXISTS `idol_event`;
CREATE TABLE `idol_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `event_time` int(10) NOT NULL DEFAULT '0' COMMENT '事件关联的时间(时间戳: 精确到分钟)',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(1024) NOT NULL DEFAULT '' COMMENT '简介',
  `last_update_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后编辑事件的用户id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器审核状态  0:未审核 1:审核成功 2:审核失败',
  `distinct_like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量(去重)',
  `distinct_opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量(去重)',
  `distinct_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享数量(去重)',
  `hot_score` int(10) NOT NULL COMMENT '热度值',
  `material_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材量',
  PRIMARY KEY (`id`),
  KEY `ic_id` (`ic_id`,`event_time`)
) ENGINE=InnoDB AUTO_INCREMENT=15782 DEFAULT CHARSET=utf8 COMMENT='爱豆事件表';

-- ----------------------------
-- Table structure for idol_event_category
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_category`;
CREATE TABLE `idol_event_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(128) NOT NULL DEFAULT '' COMMENT 'icon',
  `weight` tinyint(4) NOT NULL COMMENT '排序权重',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8 COMMENT='爱豆事件类型枚举表';

-- ----------------------------
-- Table structure for idol_event_form
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_form`;
CREATE TABLE `idol_event_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `event_time` int(10) NOT NULL DEFAULT '0' COMMENT '事件关联的时间(时间戳: 精确到分钟)',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(1024) NOT NULL DEFAULT '' COMMENT '简介',
  `audit_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态(0:未知; 1:审核中; 2:审核通过; 3:审核拒绝)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `ic_form_id` int(10) NOT NULL DEFAULT '0' COMMENT '待审卡片id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1242 DEFAULT CHARSET=utf8 COMMENT='爱豆事件申请表';

-- ----------------------------
-- Table structure for idol_event_like
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_like`;
CREATE TABLE `idol_event_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `attitude` tinyint(1) NOT NULL DEFAULT '0' COMMENT '态度(0:无; 1:赞; 2:踩)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_ie` (`user_id`,`ie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=180559 DEFAULT CHARSET=utf8 COMMENT='爱豆事件点赞表';

-- ----------------------------
-- Table structure for idol_event_material
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_material`;
CREATE TABLE `idol_event_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `desc` varchar(64) NOT NULL DEFAULT '' COMMENT '素材描述',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否审核 0否, 1是',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '视频时间长度',
  `tags` varchar(255) NOT NULL DEFAULT '[]' COMMENT '标签名称（以json存储）',
  `ie_category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `hash` varchar(255) NOT NULL DEFAULT '' COMMENT '图片hash 值',
  `hash_crc32` bigint(20) NOT NULL DEFAULT '0' COMMENT '图片hash的crc32值',
  `tail` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `material_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `is_gif` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为gif',
  `video_bit_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频码率',
  `is_hd` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为高清',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频高',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频宽',
  PRIMARY KEY (`id`),
  KEY `ie_id` (`ie_id`),
  KEY `ic_id` (`ic_id`),
  KEY `idx_idol_id_create_time` (`idol_id`,`create_time`) USING BTREE,
  KEY `idx_hash_crc32` (`hash_crc32`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58100 DEFAULT CHARSET=utf8 COMMENT='爱豆事件素材表';

-- ----------------------------
-- Table structure for idol_event_material_form
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_material_form`;
CREATE TABLE `idol_event_material_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ie_material_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件素材id',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材申请记录id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `desc` varchar(64) NOT NULL DEFAULT '' COMMENT '素材描述',
  `audit_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态(0:未知; 1:审核中; 2:审核通过; 3:审核拒绝)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '视频时间长度',
  `tags` varchar(255) NOT NULL DEFAULT '[]' COMMENT '标签名称（以json存储）',
  `ie_category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `hash` varchar(255) NOT NULL DEFAULT '' COMMENT '图片hash 值',
  `hash_crc32` bigint(20) NOT NULL DEFAULT '0' COMMENT '图片hash的crc32值',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `tail` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `material_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `is_gif` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为gif',
  `video_bit_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频码率',
  `is_hd` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为高清',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频高',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频宽',
  PRIMARY KEY (`id`),
  KEY `idx_ie_material_id` (`ie_material_id`),
  KEY `idx_hash_crc32` (`hash_crc32`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6485 DEFAULT CHARSET=utf8 COMMENT='爱豆事件素材表';

-- ----------------------------
-- Table structure for idol_event_material_record
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_material_record`;
CREATE TABLE `idol_event_material_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `ie_form_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件申请id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:待审核; 2:已完成)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2842 DEFAULT CHARSET=utf8 COMMENT='爱豆事件素材申请记录表';

-- ----------------------------
-- Table structure for idol_event_opinion
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_opinion`;
CREATE TABLE `idol_event_opinion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `root_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根级id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `target_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复用户id',
  `content` text NOT NULL COMMENT '评论内容',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 0未审核, 1审核成功, 2审核失败',
  `child_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `child_snap` varchar(2000) DEFAULT '' COMMENT '回复快照',
  PRIMARY KEY (`id`),
  KEY `root_id` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22635 DEFAULT CHARSET=utf8 COMMENT='爱豆事件评论表';

-- ----------------------------
-- Table structure for idol_event_share
-- ----------------------------
DROP TABLE IF EXISTS `idol_event_share`;
CREATE TABLE `idol_event_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='爱豆事件分享表';

-- ----------------------------
-- Table structure for idol_media_lib
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib`;
CREATE TABLE `idol_media_lib` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ie_material_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件素材id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `mode` tinyint(3) NOT NULL DEFAULT '0' COMMENT '上传方式(0:其他; 1:时光轴, 2:直接上传, 3:眼力挑战上传)',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '素材描述',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频时间',
  `ie_category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `idol_name` varchar(64) NOT NULL DEFAULT '' COMMENT 'idol名',
  `tags` varchar(255) NOT NULL DEFAULT '[]' COMMENT '标签名称（以json存储）',
  `ie_title` varchar(128) NOT NULL DEFAULT '' COMMENT '事件名称',
  `ie_category_name` varchar(128) NOT NULL DEFAULT '' COMMENT '事件类型名称',
  `ie_desc` varchar(1024) NOT NULL DEFAULT '' COMMENT '事件介绍',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否审核 0否, 1是',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `hash` varchar(255) NOT NULL DEFAULT '' COMMENT '图片hash 值',
  `hash_crc32` bigint(20) NOT NULL DEFAULT '0' COMMENT '图片hash的crc32值',
  `visible` tinyint(4) NOT NULL DEFAULT '1' COMMENT '判断图是否可见的依据, 0:不可见, 1:可见, 默认可见',
  `ie_time` bigint(20) NOT NULL COMMENT '事件时间',
  `ie_date` bigint(20) NOT NULL COMMENT '事件日期',
  `tail` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `is_gif` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为gif',
  `media_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `video_bit_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频码率',
  `is_hd` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为高清',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频高',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频宽',
  `activity_media_collection_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '套图ID',
  `is_hot` tinyint(3) NOT NULL COMMENT '是否为人气图',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_ic_id` (`idol_id`) USING BTREE,
  KEY `idx_idol_date` (`idol_id`,`date`),
  KEY `idx_ie_material_id` (`ie_material_id`) USING BTREE,
  KEY `idx_idol_id_hash_crc32` (`idol_id`,`hash_crc32`) USING BTREE,
  KEY `idx_idol_ie_date` (`idol_id`,`ie_date`) USING BTREE,
  KEY `idx_idol_id_tail` (`idol_id`,`tail`) USING BTREE,
  KEY `idx_idol_id_media_size` (`idol_id`,`media_size`) USING BTREE,
  KEY `idx_idol_mode_iecat_type` (`idol_id`,`mode`,`ie_category`,`type`),
  KEY `idx_activity_media_collection_id` (`activity_media_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=979249 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='爱豆图库表';

-- ----------------------------
-- Table structure for idol_media_lib_20201230
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_20201230`;
CREATE TABLE `idol_media_lib_20201230` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `ie_material_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件素材id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `source` varchar(32) NOT NULL DEFAULT '' COMMENT '素材来源',
  `mode` tinyint(3) NOT NULL DEFAULT '0' COMMENT '上传方式(0:其他; 1:时光轴, 2:直接上传)',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '素材描述',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频时间',
  `ie_category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型ID',
  `idol_name` varchar(64) NOT NULL DEFAULT '' COMMENT 'idol名',
  `tags` varchar(255) NOT NULL DEFAULT '[]' COMMENT '标签名称（以json存储）',
  `ie_title` varchar(128) NOT NULL DEFAULT '' COMMENT '事件名称',
  `ie_category_name` varchar(128) NOT NULL DEFAULT '' COMMENT '事件类型名称',
  `ie_desc` varchar(1024) NOT NULL DEFAULT '' COMMENT '事件介绍',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否审核 0否, 1是',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `hash` varchar(255) NOT NULL DEFAULT '' COMMENT '图片hash 值',
  `hash_crc32` bigint(20) NOT NULL DEFAULT '0' COMMENT '图片hash的crc32值',
  `visible` tinyint(4) NOT NULL DEFAULT '1' COMMENT '判断图是否可见的依据, 0:不可见, 1:可见, 默认可见',
  `ie_time` bigint(20) NOT NULL COMMENT '事件时间',
  `ie_date` bigint(20) NOT NULL COMMENT '事件日期',
  `tail` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `is_gif` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为gif',
  `media_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `video_bit_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频码率',
  `is_hd` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为高清',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频高',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频宽',
  `activity_media_collection_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '套图ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_media_lib_category
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_category`;
CREATE TABLE `idol_media_lib_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ct_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类类型 1高清,2活动,3gif,4日常,5作品,6饭制,7套图',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频数量',
  `image` varchar(128) NOT NULL DEFAULT '' COMMENT '图频分类封面图',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idol_type` (`idol_id`,`ct_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1984 DEFAULT CHARSET=utf8 COMMENT='图频分类表,此数据由snap_collector聚合而来,用于idol图频分类展示';

-- ----------------------------
-- Table structure for idol_media_lib_category_type
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_category_type`;
CREATE TABLE `idol_media_lib_category_type` (
  `id` tinyint(3) unsigned NOT NULL COMMENT '图频分类ID',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '图频分类展示名称',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重，降序',
  `color` varchar(32) NOT NULL DEFAULT '0' COMMENT '色号',
  `image` varchar(512) NOT NULL DEFAULT '' COMMENT '默认封面图',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态,0:正常，1:已删除',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '描述',
  `is_top` tinyint(3) NOT NULL COMMENT '是否为精选 0: 非精选 1: 精选',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图频分类 类型定义';

-- ----------------------------
-- Table structure for idol_media_lib_challenge
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge`;
CREATE TABLE `idol_media_lib_challenge` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `media_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '图库id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上传用户id',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `disply_nums` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示次数',
  `pick_nums` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '选择次数',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `img_source` tinyint(3) NOT NULL DEFAULT '0' COMMENT '图片来源(0:图库; 1:挑战上传)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片宽',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片高',
  `aspect_ratio` float(5,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '宽高比',
  `pick_uv` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '喜欢uv',
  `pick_ratio` float(5,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '喜欢率 （喜欢pv/曝光次数）',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_media_id` (`media_id`) USING BTREE,
  KEY `idx_idol_id_date_source` (`idol_id`,`date`,`img_source`) USING BTREE,
  KEY `idx_idol_id_img_source_createtime_delete_status` (`idol_id`,`img_source`,`create_time`,`delete_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34889 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='眼力挑战候选表';

-- ----------------------------
-- Table structure for idol_media_lib_challenge_activity
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge_activity`;
CREATE TABLE `idol_media_lib_challenge_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `platform` varchar(30) NOT NULL DEFAULT '' COMMENT '活动所属平台, 空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"',
  `activity_url` varchar(512) NOT NULL DEFAULT '' COMMENT '活动跳转url',
  `target_days` int(10) NOT NULL COMMENT '目标天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='眼力挑战打卡活动表';

-- ----------------------------
-- Table structure for idol_media_lib_challenge_activity_mark
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge_activity_mark`;
CREATE TABLE `idol_media_lib_challenge_activity_mark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `status` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任务完成状况(0: 未开始 1: 完成第一个任务 2: 完成第二个任务 3: 打开完成)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_user_id_date` (`user_id`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='眼力挑战打卡活动标记表';

-- ----------------------------
-- Table structure for idol_media_lib_challenge_activity_schedule
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge_activity_schedule`;
CREATE TABLE `idol_media_lib_challenge_activity_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  `tag` varchar(256) NOT NULL DEFAULT '' COMMENT '主题tag',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_aid_date` (`aid`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='眼力挑战打卡活动日程表';

-- ----------------------------
-- Table structure for idol_media_lib_challenge_pick
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge_pick`;
CREATE TABLE `idol_media_lib_challenge_pick` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `media_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '图库id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_media_id` (`media_id`) USING BTREE,
  KEY `idx_idol_id_user_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='眼力挑战图片pick表';

-- ----------------------------
-- Table structure for idol_media_lib_challenge_record
-- ----------------------------
DROP TABLE IF EXISTS `idol_media_lib_challenge_record`;
CREATE TABLE `idol_media_lib_challenge_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_score` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户眼力值',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `image_data` varchar(2000) NOT NULL DEFAULT '[]' COMMENT 'json存用户最终选择的数据的url和media_id',
  `opera_data` varchar(2000) NOT NULL DEFAULT '{}' COMMENT '操作数据，每次吐出的mediaIds和每次pick的mediaIds',
  `rank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分数排名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_idol_id_date_user_score` (`idol_id`,`date`,`user_score`) USING BTREE,
  KEY `idx_idol_id_date_user_date` (`idol_id`,`user_id`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户挑战表';

-- ----------------------------
-- Table structure for idol_pick
-- ----------------------------
DROP TABLE IF EXISTS `idol_pick`;
CREATE TABLE `idol_pick` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `delete_status` tinyint(3) unsigned zerofill NOT NULL DEFAULT '000' COMMENT '0 未删除 1 已经删除',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`user_id`,`idol_id`),
  KEY `idol_id` (`idol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户爱豆pick表';

-- ----------------------------
-- Table structure for idol_summary
-- ----------------------------
DROP TABLE IF EXISTS `idol_summary`;
CREATE TABLE `idol_summary` (
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `card_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴卡片数量',
  `event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴事件数量',
  `material_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材数量',
  `image_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片素材数量',
  `video_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频素材数量',
  PRIMARY KEY (`idol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='爱豆时光轴汇总数据';

-- ----------------------------
-- Table structure for idol_task_config
-- ----------------------------
DROP TABLE IF EXISTS `idol_task_config`;
CREATE TABLE `idol_task_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '任务名称',
  `limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务上限',
  `type` int(10) unsigned NOT NULL DEFAULT '3' COMMENT '任务类型 1. 签到任务 2. 安利任务 3. 每日任务',
  `logo` varchar(255) NOT NULL COMMENT '任务图标',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '任务状态 0 上线 1 下线',
  `increment_score` int(11) DEFAULT '0' COMMENT '单次增加分值',
  `score_level` varchar(2000) DEFAULT NULL COMMENT '分值列表',
  `desc` varchar(255) NOT NULL COMMENT '任务描述',
  `weight` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8 COMMENT='idol任务大厅配置';

-- ----------------------------
-- Table structure for idol_task_record
-- ----------------------------
DROP TABLE IF EXISTS `idol_task_record`;
CREATE TABLE `idol_task_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `process` int(11) NOT NULL DEFAULT '0' COMMENT '当前任务完成进度',
  `score` bigint(20) NOT NULL COMMENT '已领取积分',
  `score_stage` int(11) NOT NULL DEFAULT '0' COMMENT '未领取积分',
  `date` bigint(20) NOT NULL COMMENT '任务日期',
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=882664 DEFAULT CHARSET=utf8 COMMENT='idol任务记录表';

-- ----------------------------
-- Table structure for idol_topic_relation
-- ----------------------------
DROP TABLE IF EXISTS `idol_topic_relation`;
CREATE TABLE `idol_topic_relation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `blog_topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'blog话题id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_idol_topic` (`idol_id`,`blog_topic_id`),
  KEY `idx_idol_topic_id` (`blog_topic_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='话题与明星关系表';

-- ----------------------------
-- Table structure for idol_unlock_activity
-- ----------------------------
DROP TABLE IF EXISTS `idol_unlock_activity`;
CREATE TABLE `idol_unlock_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `display_start` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动入口显示时间',
  `display_end` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动入口显示结束时间',
  `activity_start` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `activity_end` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动结束时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '活动状态 0.活动上线 1. 活动下线',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '活动入口图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='解锁活动表';

-- ----------------------------
-- Table structure for idol_unlock_activity_collector
-- ----------------------------
DROP TABLE IF EXISTS `idol_unlock_activity_collector`;
CREATE TABLE `idol_unlock_activity_collector` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动id',
  `idol_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'idol id',
  `idol_pick_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '新增关注数',
  `idol_wx_pick_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '微信关注数',
  `idol_event_material_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '时光轴新增素材数',
  `idol_media_lib_nums` bigint(20) NOT NULL DEFAULT '0' COMMENT '图库新增素材数',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity_id_idol_id` (`idol_id`,`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1961 DEFAULT CHARSET=utf8 COMMENT='解锁活动流水表';

-- ----------------------------
-- Table structure for idol_unlock_activity_grade
-- ----------------------------
DROP TABLE IF EXISTS `idol_unlock_activity_grade`;
CREATE TABLE `idol_unlock_activity_grade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `activity_id` varchar(255) NOT NULL DEFAULT '' COMMENT '活动入口图片',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '等级分数类型， 0.其他 1. 新增关注数 2. 微信关注数 3. 时光轴新增素材数 4. 图库新增素材数',
  `a` int(11) NOT NULL DEFAULT '0' COMMENT 'a等级分数',
  `b` int(11) NOT NULL DEFAULT '0' COMMENT 'b等级分数',
  `c` int(11) NOT NULL DEFAULT '0' COMMENT 'c等级分数',
  `d` int(11) NOT NULL DEFAULT '0' COMMENT 'd等级分数',
  `e` int(11) NOT NULL DEFAULT '0' COMMENT 'e等级分数',
  `s` int(11) NOT NULL DEFAULT '0' COMMENT 's等级分数',
  `ss` int(11) NOT NULL DEFAULT '0' COMMENT 'ss等级分数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COMMENT='解锁活动分数配置表';

-- ----------------------------
-- Table structure for idol_user_score
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score`;
CREATE TABLE `idol_user_score` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `max_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大签到天数',
  `max_consective_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大连续签到天数',
  `invite_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请人数',
  `invite_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请积分暂存',
  `image_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加图片数',
  `video_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加视频数',
  `material_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '物料填充积分暂存',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77464 DEFAULT CHARSET=utf8 COMMENT='idol任务积分表';

-- ----------------------------
-- Table structure for idol_user_score_20201103
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score_20201103`;
CREATE TABLE `idol_user_score_20201103` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `max_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大签到天数',
  `max_consective_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大连续签到天数',
  `invite_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请人数',
  `invite_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请积分暂存',
  `image_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加图片数',
  `video_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加视频数',
  `material_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '物料填充积分暂存',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46561 DEFAULT CHARSET=utf8 COMMENT='idol任务积分表';

-- ----------------------------
-- Table structure for idol_user_score_20201104
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score_20201104`;
CREATE TABLE `idol_user_score_20201104` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `max_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大签到天数',
  `max_consective_checkin` bigint(20) NOT NULL DEFAULT '0' COMMENT '最大连续签到天数',
  `invite_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请人数',
  `invite_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '邀请积分暂存',
  `image_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加图片数',
  `video_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '添加视频数',
  `material_score_stage` bigint(20) NOT NULL DEFAULT '0' COMMENT '物料填充积分暂存',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62684 DEFAULT CHARSET=utf8 COMMENT='idol任务积分表';

-- ----------------------------
-- Table structure for idol_user_score_record
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score_record`;
CREATE TABLE `idol_user_score_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '获得或消费积分',
  `score_type` int(11) NOT NULL COMMENT '积分流水类型(1: 签到; 2: 填充物料; 3: 邀请; 4: 点赞; 5: 评论; 6: 分享; 7: 发布动态; 8: 分享时光链; 9: 浏览; 13:打榜应援; 14:活动积分清空; 15:集结; 16: 活动补偿; 17: 活动奖励)',
  `datetime` bigint(20) NOT NULL COMMENT '时间',
  `score_desc` varchar(125) NOT NULL DEFAULT '' COMMENT '积分备注信息',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`),
  KEY `idx_idol_id` (`idol_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=387313 DEFAULT CHARSET=utf8 COMMENT='idol任务积分流水表';

-- ----------------------------
-- Table structure for idol_user_score_record_20201103
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score_record_20201103`;
CREATE TABLE `idol_user_score_record_20201103` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '获得或消费积分',
  `score_type` int(11) NOT NULL COMMENT '积分流水类型(1: 签到; 2: 填充物料; 3: 邀请; 4: 点赞; 5: 评论; 6: 分享; 7: 发布动态; 8: 分享时光链; 9: 浏览; 13:打榜应援)',
  `datetime` bigint(20) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82948 DEFAULT CHARSET=utf8 COMMENT='idol任务积分流水表';

-- ----------------------------
-- Table structure for idol_user_score_record_20201104
-- ----------------------------
DROP TABLE IF EXISTS `idol_user_score_record_20201104`;
CREATE TABLE `idol_user_score_record_20201104` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idol_id` bigint(20) NOT NULL COMMENT 'idol id',
  `user_id` bigint(20) NOT NULL COMMENT 'user id',
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '获得或消费积分',
  `score_type` int(11) NOT NULL COMMENT '积分流水类型(1: 签到; 2: 填充物料; 3: 邀请; 4: 点赞; 5: 评论; 6: 分享; 7: 发布动态; 8: 分享时光链; 9: 浏览; 13:打榜应援)',
  `datetime` bigint(20) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122324 DEFAULT CHARSET=utf8 COMMENT='idol任务积分流水表';

-- ----------------------------
-- Table structure for idol_voice
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice`;
CREATE TABLE `idol_voice` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `recommend_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标识(0: 普通 1: 精选)',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_voice_20201223
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_20201223`;
CREATE TABLE `idol_voice_20201223` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `recommend_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标识(0: 普通 1: 精选)',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5069 DEFAULT CHARSET=utf8 COMMENT='ai物料表';

-- ----------------------------
-- Table structure for idol_voice_20210204
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_20210204`;
CREATE TABLE `idol_voice_20210204` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `recommend_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标识(0: 普通 1: 精选)',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_voice_conversation
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_conversation`;
CREATE TABLE `idol_voice_conversation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `conversation_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他， 1:用户发送 2: ai回复 3:时间分割)',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `read_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '阅读状态(0:未读 1:已读)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `entrance_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '入口类型(0: ai语音对话，1: 定制语音)',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入日期',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `idol_voice_id` bigint(20) unsigned NOT NULL COMMENT 'ai物料ID',
  `column_17` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`) USING BTREE,
  KEY `idx_user_id_date` (`user_id`,`date`) USING BTREE,
  KEY `idol_voice_conversation_idol_id_index` (`idol_id`),
  KEY `idol_voice_conversation_idol_id_conversation_type_index` (`idol_id`,`conversation_type`),
  KEY `idol_voice_conversation_idol_scene_category_id_index` (`idol_id`,`scene_id`,`ivs_category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3309 DEFAULT CHARSET=utf8 COMMENT='会话表';

-- ----------------------------
-- Table structure for idol_voice_conversation_test
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_conversation_test`;
CREATE TABLE `idol_voice_conversation_test` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `conversation_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他， 1:用户发送 2: ai回复 3:时间分割)',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `read_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '阅读状态(0:未读 1:已读)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `entrance_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '入口类型(0: ai语音对话，1: 定制语音)',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入日期',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `idol_voice_id` bigint(20) unsigned NOT NULL COMMENT 'ai物料ID',
  `column_17` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`) USING BTREE,
  KEY `idx_user_id_date` (`user_id`,`date`) USING BTREE,
  KEY `idol_voice_conversation_idol_id_index` (`idol_id`),
  KEY `idol_voice_conversation_idol_id_conversation_type_index` (`idol_id`,`conversation_type`),
  KEY `idol_voice_conversation_idol_scene_category_id_index` (`idol_id`,`scene_id`,`ivs_category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='会话表'
/*!50100 PARTITION BY HASH (user_id)
PARTITIONS 10 */;

-- ----------------------------
-- Table structure for idol_voice_daily_popup
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_daily_popup`;
CREATE TABLE `idol_voice_daily_popup` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '语音内容',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '弹出日期',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id_date` (`idol_id`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='idol语音弹窗表';

-- ----------------------------
-- Table structure for idol_voice_form
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_form`;
CREATE TABLE `idol_voice_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `ivs_category_id` int(10) unsigned NOT NULL COMMENT '场景分类id',
  `sence_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='AI语料收集表';

-- ----------------------------
-- Table structure for idol_voice_scene
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_scene`;
CREATE TABLE `idol_voice_scene` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '场景名称',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `parent_id` bigint(20) unsigned NOT NULL COMMENT '上级',
  `content` varchar(255) NOT NULL COMMENT '对话内容',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '场景图片',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '场景状态(0: 其他 1:场景可见 2:场景不可见)',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重（倒叙）',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1047 DEFAULT CHARSET=utf8 COMMENT='场景列表';

-- ----------------------------
-- Table structure for idol_voice_scene_category
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_scene_category`;
CREATE TABLE `idol_voice_scene_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '场景名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '场景状态(0: 其他 1:场景可见 2:场景不可见)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重（倒叙）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8 COMMENT='场景分类表';

-- ----------------------------
-- Table structure for idol_voice_scene_content
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_scene_content`;
CREATE TABLE `idol_voice_scene_content` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id(当值为0的时候，为通用内容)',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `scene_id` bigint(20) unsigned NOT NULL COMMENT '场景id',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_voice_scene_content_20210204
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_scene_content_20210204`;
CREATE TABLE `idol_voice_scene_content_20210204` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id(当值为0的时候，为通用内容)',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `scene_id` bigint(20) unsigned NOT NULL COMMENT '场景id',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_voice_scene_rel
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_scene_rel`;
CREATE TABLE `idol_voice_scene_rel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `send_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发出语句数',
  `revert_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复语句数',
  `untreated_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '待操作数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆场景状态 1:上线 2:下线 3：删除',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1576 DEFAULT CHARSET=utf8 COMMENT='爱豆场景关系表';

-- ----------------------------
-- Table structure for idol_voice_task
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_task`;
CREATE TABLE `idol_voice_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线 3：删除',
  `task_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务状态 0:待处理 1:已完成 2：进行中',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='ai物料任务表';

-- ----------------------------
-- Table structure for idol_voice_task_result
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_task_result`;
CREATE TABLE `idol_voice_task_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `voice_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数 试听评分0-5',
  `ref_path` varchar(512) NOT NULL DEFAULT '' COMMENT '副本源',
  `output_filename` varchar(128) NOT NULL DEFAULT '' COMMENT '产出语音文件名',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0:待定,1:采用,2:废弃',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `ope_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '操作状态 0:待处理 1:已完成 2：进行中',
  `ali_url` varchar(512) DEFAULT NULL COMMENT '阿里链接',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=617 DEFAULT CHARSET=utf8 COMMENT='ai物料任务结果表';

-- ----------------------------
-- Table structure for idol_voice_user_content_template
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_user_content_template`;
CREATE TABLE `idol_voice_user_content_template` (
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `scene_id` bigint(20) unsigned NOT NULL COMMENT '场景id',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idol_voice_wuyifan
-- ----------------------------
DROP TABLE IF EXISTS `idol_voice_wuyifan`;
CREATE TABLE `idol_voice_wuyifan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `recommend_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标识(0: 普通 1: 精选)',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id` (`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=utf8 COMMENT='ai物料表';

-- ----------------------------
-- Table structure for message_center
-- ----------------------------
DROP TABLE IF EXISTS `message_center`;
CREATE TABLE `message_center` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未读; 1:已读)',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '消息内容',
  `sender_user_id` int(10) DEFAULT '0' COMMENT '发送的用户id',
  `idol_id` int(11) NOT NULL DEFAULT '0' COMMENT '发送idol_id, 默认为0(全局发送)',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '定时任务id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=726737 DEFAULT CHARSET=utf8 COMMENT='站内信表';

-- ----------------------------
-- Table structure for message_center_task
-- ----------------------------
DROP TABLE IF EXISTS `message_center_task`;
CREATE TABLE `message_center_task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '消息内容',
  `sender_user_id` int(10) DEFAULT '0' COMMENT '发送的用户id',
  `idol_id` int(11) NOT NULL DEFAULT '0' COMMENT '发送idol_id, 默认为0(全局发送)',
  `task_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务状态 0:待处理 1:已完成 2：进行中',
  `send_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='站内信表任务表';

-- ----------------------------
-- Table structure for mp_config
-- ----------------------------
DROP TABLE IF EXISTS `mp_config`;
CREATE TABLE `mp_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主健ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '配置KEY',
  `value` varchar(1024) NOT NULL DEFAULT '' COMMENT '配置值',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1031 DEFAULT CHARSET=utf8 COMMENT='小程序全局线上配置信息';

-- ----------------------------
-- Table structure for new_year_act_user_invite
-- ----------------------------
DROP TABLE IF EXISTS `new_year_act_user_invite`;
CREATE TABLE `new_year_act_user_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '被邀请人',
  `parent_id` int(10) unsigned NOT NULL COMMENT '邀请人id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型  1：邀请 2：助力',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2667 DEFAULT CHARSET=utf8 COMMENT='2021年新春活动用户邀请表';

-- ----------------------------
-- Table structure for new_year_activity_blog
-- ----------------------------
DROP TABLE IF EXISTS `new_year_activity_blog`;
CREATE TABLE `new_year_activity_blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '动态id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `hot_score` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '热度',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未删除 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `record_id` bigint(20) NOT NULL COMMENT '云剪辑记录 id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_id` (`blog_id`),
  KEY `idx_idol_id_hot_score` (`idol_id`,`hot_score`),
  KEY `idx_idol_id_create_time` (`idol_id`,`create_time`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='blog春节活动表';

-- ----------------------------
-- Table structure for official_activity
-- ----------------------------
DROP TABLE IF EXISTS `official_activity`;
CREATE TABLE `official_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `page_path` varchar(128) NOT NULL DEFAULT '' COMMENT '页面跳转地址',
  `banner_image` varchar(128) NOT NULL DEFAULT '' COMMENT 'bannar 图',
  `is_hot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否显示在广场(0:不显示; 1:显示在广场)',
  `params` varchar(512) NOT NULL DEFAULT '' COMMENT '其他跳转参数',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `activity_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `banner_start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'banner上线时间',
  `banner_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '标题',
  `rank` int(10) NOT NULL DEFAULT '0' COMMENT '权重排序',
  `delete_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '删除状态: 0未删除 1已删除',
  `detail_image` varchar(128) NOT NULL DEFAULT '' COMMENT '详情图',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='官方活动';

-- ----------------------------
-- Table structure for offline_voice_task
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task`;
CREATE TABLE `offline_voice_task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `service_idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'voice service侧的idol id',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语料文本',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务状态，0:未完成,1:已完成',
  PRIMARY KEY (`id`),
  KEY `idol` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36909 DEFAULT CHARSET=utf8 COMMENT='爱豆AI语音离线任务表';

-- ----------------------------
-- Table structure for offline_voice_task_result
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_result`;
CREATE TABLE `offline_voice_task_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'offline_voice_task.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语音文本',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建(完成)时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0:待定,1:采用,2:废弃',
  `rank_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营试听评分0-5',
  `ref_path` varchar(512) NOT NULL DEFAULT '' COMMENT '副本源',
  `ref_score` varchar(128) NOT NULL DEFAULT '' COMMENT '副本评分',
  `output_filename` varchar(128) NOT NULL DEFAULT '' COMMENT '产出语音文件名',
  `output_file_live` varchar(512) NOT NULL DEFAULT '' COMMENT '离线语音文件地址',
  `qiniu_url` varchar(512) NOT NULL DEFAULT '' COMMENT '七牛链接',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长',
  PRIMARY KEY (`id`),
  KEY `idol` (`idol_id`),
  KEY `task` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169141 DEFAULT CHARSET=utf8 COMMENT='爱豆AI语音离线任务结果表';

-- ----------------------------
-- Table structure for offline_voice_task_result_back
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_result_back`;
CREATE TABLE `offline_voice_task_result_back` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'offline_voice_task.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语音文本',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建(完成)时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0:待定,1:采用,2:废弃',
  `rank_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营试听评分0-5',
  `ref_path` varchar(512) NOT NULL DEFAULT '' COMMENT '副本源',
  `ref_score` varchar(128) NOT NULL DEFAULT '' COMMENT '副本评分',
  `output_filename` varchar(128) NOT NULL DEFAULT '' COMMENT '产出语音文件名',
  `output_file_live` varchar(512) NOT NULL DEFAULT '' COMMENT '离线语音文件地址',
  `qiniu_url` varchar(512) NOT NULL DEFAULT '' COMMENT '七牛链接',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for offline_voice_task_result_backup
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_result_backup`;
CREATE TABLE `offline_voice_task_result_backup` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'offline_voice_task.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语音文本',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建(完成)时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0:待定,1:采用,2:废弃',
  `rank_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营试听评分0-5',
  `ref_path` varchar(512) NOT NULL DEFAULT '' COMMENT '副本源',
  `ref_score` varchar(128) NOT NULL DEFAULT '' COMMENT '副本评分',
  `output_filename` varchar(128) NOT NULL DEFAULT '' COMMENT '产出语音文件名',
  `output_file_live` varchar(512) NOT NULL DEFAULT '' COMMENT '离线语音文件地址',
  `qiniu_url` varchar(512) NOT NULL DEFAULT '' COMMENT '七牛链接',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for offline_voice_task_result_diff
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_result_diff`;
CREATE TABLE `offline_voice_task_result_diff` (
  `id` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for offline_voice_task_result_zhuyilong
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_result_zhuyilong`;
CREATE TABLE `offline_voice_task_result_zhuyilong` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'offline_voice_task.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语音文本',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建(完成)时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0:待定,1:采用,2:废弃',
  `rank_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营试听评分0-5',
  `ref_path` varchar(512) NOT NULL DEFAULT '' COMMENT '副本源',
  `ref_score` varchar(128) NOT NULL DEFAULT '' COMMENT '副本评分',
  `output_filename` varchar(128) NOT NULL DEFAULT '' COMMENT '产出语音文件名',
  `output_file_live` varchar(512) NOT NULL DEFAULT '' COMMENT '离线语音文件地址',
  `qiniu_url` varchar(512) NOT NULL DEFAULT '' COMMENT '七牛链接',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长',
  PRIMARY KEY (`id`),
  KEY `idol` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110385 DEFAULT CHARSET=utf8 COMMENT='爱豆AI语音离线任务结果表';

-- ----------------------------
-- Table structure for offline_voice_task_zhuyilong
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_task_zhuyilong`;
CREATE TABLE `offline_voice_task_zhuyilong` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `service_idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'voice service侧的idol id',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语料文本',
  `category_name` varchar(64) NOT NULL DEFAULT '' COMMENT '分类',
  `sence_name` varchar(64) NOT NULL DEFAULT '' COMMENT '场景',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务状态，0:未完成,1:已完成',
  PRIMARY KEY (`id`),
  KEY `idol` (`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25081 DEFAULT CHARSET=utf8 COMMENT='爱豆AI语音离线任务表';

-- ----------------------------
-- Table structure for offline_voice_tmp
-- ----------------------------
DROP TABLE IF EXISTS `offline_voice_tmp`;
CREATE TABLE `offline_voice_tmp` (
  `c` bigint(21) NOT NULL DEFAULT '0',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'offline_voice_task.id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `text` varchar(512) NOT NULL DEFAULT '' COMMENT '语音文本',
  `ts_1` bigint(20) DEFAULT NULL COMMENT '创建(完成)时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for open_screen
-- ----------------------------
DROP TABLE IF EXISTS `open_screen`;
CREATE TABLE `open_screen` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '名称',
  `cover` varchar(2048) NOT NULL DEFAULT '' COMMENT '开屏图片',
  `cover_iphone` varchar(2048) NOT NULL DEFAULT '' COMMENT '开屏图片(适配iphone)',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `page` varchar(2048) NOT NULL DEFAULT '' COMMENT '跳转对应页面',
  `images` varchar(2048) NOT NULL DEFAULT '' COMMENT '详情页-图片列表',
  `introduction` text COMMENT '详情页-文案',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态（0：上线；1：下线）',
  `delete_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态（0：正常；1：删除）',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` int(11) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='open screen相关配置';

-- ----------------------------
-- Table structure for phone_auth
-- ----------------------------
DROP TABLE IF EXISTS `phone_auth`;
CREATE TABLE `phone_auth` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `phone` char(16) NOT NULL DEFAULT '' COMMENT 'phone',
  `secret` char(32) NOT NULL DEFAULT '' COMMENT 'token生成所需secret',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` char(32) NOT NULL DEFAULT '' COMMENT '密码生成所需salt',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机登录表';

-- ----------------------------
-- Table structure for qq_auth
-- ----------------------------
DROP TABLE IF EXISTS `qq_auth`;
CREATE TABLE `qq_auth` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `union_id` char(40) NOT NULL DEFAULT '' COMMENT 'union_id',
  `app_open_id` char(32) NOT NULL DEFAULT '' COMMENT 'app_qq_open_id',
  `mini_open_id` char(32) NOT NULL DEFAULT '' COMMENT 'mini_qq_open_id',
  `secret` char(32) NOT NULL DEFAULT '' COMMENT 'token生成所需secret',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `union_id` (`union_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='QQ登录表';

-- ----------------------------
-- Table structure for remind
-- ----------------------------
DROP TABLE IF EXISTS `remind`;
CREATE TABLE `remind` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型(1:时光轴事件评论收到回复; 2: 应援轴动态收到评论; 3: 应援轴动态评论收到回复; 4: 应援轴动态收到点赞; 5: 粉丝站收到催更，6:时光链收到评论，7：时光链收到点赞，8：时光连评论收到回复，9：时光链评论收到点赞，10：blog点赞 ，11：blog收到评论，12：blog评论收到回复)',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `ie_opinion_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复的评论id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未读; 1:已读)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `idol_id` int(11) DEFAULT '0' COMMENT '明星id, 用于区分idol信息, 默认为0(全局发送)\n',
  `club_id` int(11) DEFAULT '0' COMMENT '粉丝站id',
  `ce_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态ID',
  `ce_opinion_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态评论id',
  `ce_like_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态点赞id',
  `urge_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝站催更id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除标志位（0未删除，1已删除）',
  `us_id` int(10) NOT NULL DEFAULT '0' COMMENT '时光链id',
  `us_like_id` int(10) NOT NULL DEFAULT '0' COMMENT '时光链点赞id',
  `us_opinion_id` int(10) NOT NULL DEFAULT '0' COMMENT '时光链评论id',
  `us_opinion_like_id` int(10) NOT NULL DEFAULT '0' COMMENT '时光链评论点赞id',
  `blog_id` int(10) NOT NULL COMMENT '圈子动态id',
  `blog_like_id` int(10) NOT NULL COMMENT '圈子动态点赞id',
  `blog_opinion_id` int(10) NOT NULL COMMENT '圈子动态评论id',
  PRIMARY KEY (`id`),
  KEY `idx_uid_type` (`user_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=615378 DEFAULT CHARSET=utf8 COMMENT='动态消息表';

-- ----------------------------
-- Table structure for ringme_module_idol_scene_user_access
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_idol_scene_user_access`;
CREATE TABLE `ringme_module_idol_scene_user_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID',
  `scene` bigint(20) NOT NULL DEFAULT '0' COMMENT '场景值',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `report_data` text COMMENT '原始report数据',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`module_id`,`idol_id`,`scene`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COMMENT='一环按模块爱豆和场景值进入小程序的每日用户数据';

-- ----------------------------
-- Table structure for ringme_module_idol_user_access
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_idol_user_access`;
CREATE TABLE `ringme_module_idol_user_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `quit_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '退出次数',
  `stay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '停留总时长 ms(由退出事件携带&汇总)',
  `share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享次数',
  `invite_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '召回其他用户次数(不一定是当天的分享带来的召回)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`module_id`,`idol_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8 COMMENT='一环按模块&爱豆划分的每日用户访问&使用数据';

-- ----------------------------
-- Table structure for ringme_module_idol_user_leave_record
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_idol_user_leave_record`;
CREATE TABLE `ringme_module_idol_user_leave_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '进入时间 unix ms',
  `leave_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '退出时间 unix ms',
  `page_stay_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '页面停留时间 ms',
  `count_stay_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '计算后的模块 爱豆 去重停留时间',
  `page_path` varchar(128) NOT NULL DEFAULT '' COMMENT '停留页面',
  PRIMARY KEY (`id`),
  KEY `idx` (`module_id`,`idol_id`,`user_id`,`date`,`access_time`,`leave_time`),
  KEY `idx2` (`module_id`,`idol_id`,`user_id`,`date`,`access_time`),
  KEY `idx3` (`module_id`,`idol_id`,`user_id`,`date`,`leave_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1033 DEFAULT CHARSET=utf8 COMMENT='一环用户在模块 爱豆下的 页面退出记录';

-- ----------------------------
-- Table structure for ringme_module_scene_user_access
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_scene_user_access`;
CREATE TABLE `ringme_module_scene_user_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `scene` bigint(20) NOT NULL DEFAULT '0' COMMENT '场景值',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `report_data` text COMMENT '原始report数据',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`module_id`,`scene`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COMMENT='一环按模块和场景值进入小程序的每日用户数据';

-- ----------------------------
-- Table structure for ringme_module_stat_daily
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_stat_daily`;
CREATE TABLE `ringme_module_stat_daily` (
  `date` mediumint(9) NOT NULL DEFAULT '0' COMMENT '日期格式yyyymmdd',
  `path` varchar(191) DEFAULT '' COMMENT '前端统计的路径值',
  `pv` int(11) DEFAULT '0' COMMENT '发布动态的去重人数',
  `uv` int(11) DEFAULT '0' COMMENT '指进入到话题详情动态详情的去重uv',
  `like` int(11) DEFAULT '0' COMMENT '点赞数',
  `opinion` int(11) DEFAULT '0' COMMENT '评论数',
  `share` int(11) DEFAULT '0' COMMENT '转发数',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ringme_module_user_access
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_user_access`;
CREATE TABLE `ringme_module_user_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `quit_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '退出次数',
  `stay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '停留总时长 ms(由退出事件携带&汇总)',
  `share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享次数',
  `invite_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '召回其他用户次数(不一定是当天的分享带来的召回)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`module_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COMMENT='一环按模块划分的每日用户访问&使用数据';

-- ----------------------------
-- Table structure for ringme_module_user_leave_record
-- ----------------------------
DROP TABLE IF EXISTS `ringme_module_user_leave_record`;
CREATE TABLE `ringme_module_user_leave_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `module_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一环模块ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'yyyymmdd格式的日期',
  `access_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '进入时间 unix ms',
  `leave_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '退出时间 unix ms',
  `page_stay_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '页面停留时间 ms',
  `count_stay_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '计算后的模块 爱豆 去重停留时间',
  `page_path` varchar(128) NOT NULL DEFAULT '' COMMENT '停留页面',
  PRIMARY KEY (`id`),
  KEY `idx` (`module_id`,`user_id`,`date`,`access_time`,`leave_time`),
  KEY `idx2` (`module_id`,`user_id`,`date`,`access_time`),
  KEY `idx3` (`module_id`,`user_id`,`date`,`leave_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1033 DEFAULT CHARSET=utf8 COMMENT='一环用户在模块 下的 页面退出记录';

-- ----------------------------
-- Table structure for ringme_stats_daily
-- ----------------------------
DROP TABLE IF EXISTS `ringme_stats_daily`;
CREATE TABLE `ringme_stats_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '当天日期',
  `update_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `material_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材总计',
  `fan_club_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '后援会总计',
  `card_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '卡片总计',
  `event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '事件总计',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ringme_stats_daily_date_uindex` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=4931 DEFAULT CHARSET=utf8 COMMENT='ringme全量天级汇总数据';

-- ----------------------------
-- Table structure for sms_code
-- ----------------------------
DROP TABLE IF EXISTS `sms_code`;
CREATE TABLE `sms_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` char(16) NOT NULL DEFAULT '0' COMMENT 'phone',
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '场景(100: 重置密码; 101: 绑定手机; 102: 验证码登录; 103: 注册账号)',
  `validate_code` char(6) NOT NULL DEFAULT '0' COMMENT '验证码',
  `content` varchar(128) NOT NULL DEFAULT '' COMMENT '短信内容',
  `expire_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `auth_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '验证状态(0: 未验证; 1: 已验证)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `phone_code` (`phone`,`validate_code`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='短信验证码表';

-- ----------------------------
-- Table structure for task_concentrate
-- ----------------------------
DROP TABLE IF EXISTS `task_concentrate`;
CREATE TABLE `task_concentrate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `create_date` int(10) NOT NULL COMMENT '日期(ymd eg.20201104)',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `expire_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间(时间戳 截止至当天23:59:59)',
  `user_list` varchar(128) NOT NULL DEFAULT '' COMMENT '集结用户列表(eg. uid1,uid2...)',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '集结次数(第n次集结)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:进行中; 1:已完成; 2:已取消)',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '选取的事件id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`idol_id`,`create_date`,`times`)
) ENGINE=InnoDB AUTO_INCREMENT=9321 DEFAULT CHARSET=utf8 COMMENT='用户每日集结记录';

-- ----------------------------
-- Table structure for task_weibo_record
-- ----------------------------
DROP TABLE IF EXISTS `task_weibo_record`;
CREATE TABLE `task_weibo_record` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '日期(yyyy-mm-dd)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '微博链接',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`user_id`,`idol_id`,`date`) USING BTREE,
  UNIQUE KEY `url` (`url`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微博任务记录';

-- ----------------------------
-- Table structure for temp_ai_content
-- ----------------------------
DROP TABLE IF EXISTS `temp_ai_content`;
CREATE TABLE `temp_ai_content` (
  `category` text,
  `scene` text,
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for temp_idol_user_0205
-- ----------------------------
DROP TABLE IF EXISTS `temp_idol_user_0205`;
CREATE TABLE `temp_idol_user_0205` (
  `id` bigint(20) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `daily_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for temp_idol_voice_addition
-- ----------------------------
DROP TABLE IF EXISTS `temp_idol_voice_addition`;
CREATE TABLE `temp_idol_voice_addition` (
  `category` text,
  `scene` text,
  `content` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for template_idol_voice_scene_content
-- ----------------------------
DROP TABLE IF EXISTS `template_idol_voice_scene_content`;
CREATE TABLE `template_idol_voice_scene_content` (
  `category` varchar(30) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `scene` varchar(30) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `vc` varchar(50) NOT NULL DEFAULT '',
  `vb` varbinary(50) NOT NULL DEFAULT '',
  `t` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_b_blog
-- ----------------------------
DROP TABLE IF EXISTS `test_b_blog`;
CREATE TABLE `test_b_blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'type：2 云剪辑id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ttt
-- ----------------------------
DROP TABLE IF EXISTS `ttt`;
CREATE TABLE `ttt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '场景名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '场景状态(0: 其他 1:场景可见 2:场景不可见)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重（倒叙）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='场景分类表';

-- ----------------------------
-- Table structure for tv_idol_voice
-- ----------------------------
DROP TABLE IF EXISTS `tv_idol_voice`;
CREATE TABLE `tv_idol_voice` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `voice_url` varchar(255) NOT NULL DEFAULT '' COMMENT '语音地址',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `scene_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '场景id',
  `scene_parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前场景得父级id',
  `content_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '对话类型(0:其他 1:文字 2: 语音)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条语音状态 1:上线 2:下线',
  `voice_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '语音时长',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `recommend_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '推荐标识(0: 普通 1: 精选)',
  `rank_score` int(11) NOT NULL DEFAULT '0' COMMENT '评价分数',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tv_idol_voice_scene_content
-- ----------------------------
DROP TABLE IF EXISTS `tv_idol_voice_scene_content`;
CREATE TABLE `tv_idol_voice_scene_content` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id(当值为0的时候，为通用内容)',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `scene_id` bigint(20) unsigned NOT NULL COMMENT '场景id',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tv_idol_voice_scene_content_template
-- ----------------------------
DROP TABLE IF EXISTS `tv_idol_voice_scene_content_template`;
CREATE TABLE `tv_idol_voice_scene_content_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id(当值为0的时候，为通用内容)',
  `ivs_category_id` bigint(20) unsigned NOT NULL COMMENT '场景分类id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '对话内容',
  `scene_id` bigint(20) unsigned NOT NULL COMMENT '场景id',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0: 其他 1:场景删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id_scene_id` (`idol_id`,`scene_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=155293 DEFAULT CHARSET=utf8 COMMENT='场景用户对话内容';

-- ----------------------------
-- Table structure for tv_idols
-- ----------------------------
DROP TABLE IF EXISTS `tv_idols`;
CREATE TABLE `tv_idols` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `greeting_content` varchar(5000) NOT NULL DEFAULT '[]' COMMENT '问候内容 使用json存储问候语',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '词条状态(0: 启用 1: 不启用)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  `custom_notice` varchar(30) NOT NULL DEFAULT '' COMMENT '明星定制语音提示语',
  `enhance_id` int(11) NOT NULL DEFAULT '0' COMMENT '增强明星id\n',
  `voice_num` int(11) NOT NULL DEFAULT '0' COMMENT '语句数量',
  `chat_uv` int(11) NOT NULL DEFAULT '0' COMMENT '聊天人数',
  `user_send_pv` int(11) NOT NULL DEFAULT '0' COMMENT '用户发送条数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_open_id` char(32) NOT NULL DEFAULT '' COMMENT 'open_id',
  `union_id` varchar(40) DEFAULT NULL,
  `nickname` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `avatar_url` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别(0:未知; 1:男; 2:女)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未授权; 1:已授权; 2:封禁)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '名称头像审核状态, 0未审核, 1审核完毕. 审核未通过讲替换用户名或昵称为普通',
  `set_avatar_url` varchar(255) NOT NULL DEFAULT '' COMMENT '自定义头像',
  `set_nickname` varchar(32) NOT NULL DEFAULT '' COMMENT '自定义昵称',
  `guide_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '引导状态(0:未引导; 1:已引导)',
  `is_bot` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为bot',
  `bot_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'BOT类型，仅当is_bot=1时有效,1:idol专属BOT,2:通用BOT',
  `is_anonymous` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为匿名用户(0: 否; 1: 是)',
  PRIMARY KEY (`id`),
  KEY `idx_open_id` (`user_open_id`),
  KEY `audit_status` (`audit_status`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=88843 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for user_blog_collection
-- ----------------------------
DROP TABLE IF EXISTS `user_blog_collection`;
CREATE TABLE `user_blog_collection` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '圈子动态id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_blog_id` (`user_id`,`blog_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3676 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户收藏圈子动态';

-- ----------------------------
-- Table structure for user_collection
-- ----------------------------
DROP TABLE IF EXISTS `user_collection`;
CREATE TABLE `user_collection` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `name` char(64) NOT NULL DEFAULT '' COMMENT '收藏夹名称',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏内容数量',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `user_idol` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5801 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Table structure for user_collection_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_collection_detail`;
CREATE TABLE `user_collection_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏夹id',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型(1:时光轴事件; 2:个人轴动态; 3: 应援轴动态)',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏对象id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `collection_id` (`collection_id`,`type`,`obj_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17614 DEFAULT CHARSET=utf8 COMMENT='用户收藏详情表';

-- ----------------------------
-- Table structure for user_dynamic
-- ----------------------------
DROP TABLE IF EXISTS `user_dynamic`;
CREATE TABLE `user_dynamic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(11) NOT NULL DEFAULT '0' COMMENT '明星id',
  `date` int(10) NOT NULL DEFAULT '0' COMMENT '日期(yyyymm)',
  `type_desc` char(255) NOT NULL DEFAULT '' COMMENT '类型描述',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型(1:点赞时光轴事件; 2:评论时光轴事件; 3:收藏时光轴事件; 4: 收藏多个动态; 5: 发表个人动态; 6: 点赞应援轴动态; 7: 评论应援轴动态; 8:收藏应援轴动态; 9: 分享时光链)',
  `collection_name` char(255) NOT NULL DEFAULT '' COMMENT '收藏夹名称',
  `img_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '图片快照',
  `video_snap` varchar(3000) NOT NULL DEFAULT '' COMMENT '视频快照',
  `desc` char(255) NOT NULL DEFAULT '' COMMENT '简介',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `ie_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆事件id',
  `user_topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户话题id',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `collection_num` int(11) NOT NULL DEFAULT '0' COMMENT '收藏操作的收藏数量',
  `collection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏夹id',
  `publish_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '自定义的发布时间',
  `ce_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴动态ID',
  `obj_id` bigint(20) NOT NULL COMMENT '动态对应的id(2:评论时光轴事件-时光轴id 7: 评论应援轴动态---应援轴事件id; )',
  `dynamic_content` varchar(2000) DEFAULT '' COMMENT '2:评论时光轴事件-评论内容; 7: 评论应援轴动态-评论内容; 9: 分享时光链-时光链简介',
  `ie_category_icon` varchar(2000) DEFAULT '' COMMENT '爱豆卡片的类型icon',
  `idol_event_content` varchar(2000) DEFAULT '' COMMENT '爱豆事件内容',
  `share_out_id` char(64) NOT NULL DEFAULT '' COMMENT '分享链-外部分享ID',
  PRIMARY KEY (`id`),
  KEY `user_idol` (`user_id`,`idol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=474350 DEFAULT CHARSET=utf8 COMMENT='用户动态表';

-- ----------------------------
-- Table structure for user_idol_media_lib_collection
-- ----------------------------
DROP TABLE IF EXISTS `user_idol_media_lib_collection`;
CREATE TABLE `user_idol_media_lib_collection` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `media_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '图库id',
  `ie_material_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴素材id',
  `mode` tinyint(3) NOT NULL DEFAULT '0' COMMENT '上传方式(0:其他; 1:时光轴, 2:直接上传)',
  `media_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_status` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `ie_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '事件id',
  `ic_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '卡片id',
  PRIMARY KEY (`id`),
  KEY `idx_ie_material_id` (`ie_material_id`) USING BTREE,
  KEY `idx_ie_id` (`ie_id`) USING BTREE,
  KEY `idx_ic_id` (`ic_id`) USING BTREE,
  KEY `idx_user_id_media_type_idol_id` (`user_id`,`media_type`,`idol_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1319 DEFAULT CHARSET=utf8 COMMENT='图库收藏';

-- ----------------------------
-- Table structure for user_idol_voice_contact
-- ----------------------------
DROP TABLE IF EXISTS `user_idol_voice_contact`;
CREATE TABLE `user_idol_voice_contact` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '明星id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '明星头像',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '明星名称',
  `set_logo` varchar(255) NOT NULL DEFAULT '' COMMENT '明星设置头像',
  `set_name` varchar(255) NOT NULL DEFAULT '' COMMENT '明星设置名称',
  `set_background` varchar(255) NOT NULL DEFAULT '' COMMENT '设置明星聊天背景',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `conversation_create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `conversation_last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '会话更新时间',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示(0: 未删除 1: 删除)',
  PRIMARY KEY (`id`),
  KEY `idx_idol_id_user_id` (`idol_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='联系人列表';

-- ----------------------------
-- Table structure for user_share
-- ----------------------------
DROP TABLE IF EXISTS `user_share`;
CREATE TABLE `user_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_out_id` char(64) NOT NULL DEFAULT '' COMMENT '外部分享ID,前端生成，规则: md5(user_id,idol_id,name,stamp,rand)',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆id',
  `name` char(64) NOT NULL DEFAULT '' COMMENT '分享标题',
  `nickname` char(64) NOT NULL DEFAULT '' COMMENT '用户昵称快照',
  `avatar_url` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶（精选）： 0 未置顶， 1 置顶',
  `desc` char(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `idol_card_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴卡片数量',
  `idol_event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴事件数量',
  `user_dynamic_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '个人轴动态数量',
  `club_event_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应援轴轴动态数量',
  `share_mode` tinyint(3) NOT NULL DEFAULT '1' COMMENT '分享模式(0:非分享模式; 1:分享模式)',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `opinion_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量',
  `share_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享数量',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '分享链长图',
  `distinct_like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴总点赞数量(去重)',
  `distinct_opinion_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴总评论数量(去重)',
  `distinct_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光轴总分享数量(去重)',
  `read_nums` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '阅读数',
  `idol_name` varchar(32) NOT NULL DEFAULT '' COMMENT '明星名字',
  `hot_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '热度',
  `pv` int(11) NOT NULL DEFAULT '0' COMMENT '分享链pv\r\n',
  `uv` int(11) NOT NULL DEFAULT '0' COMMENT '分享链uv\r\n',
  `platform` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `share_out_id` (`share_out_id`)
) ENGINE=InnoDB AUTO_INCREMENT=246523 DEFAULT CHARSET=utf8 COMMENT='用户分享表';

-- ----------------------------
-- Table structure for user_share_cache
-- ----------------------------
DROP TABLE IF EXISTS `user_share_cache`;
CREATE TABLE `user_share_cache` (
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型(1:时光轴事件; 2:个人轴动态; 3: 应援轴动态)',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对象id',
  `data` text NOT NULL COMMENT '结构化的数据',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`type`,`obj_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享缓存';

-- ----------------------------
-- Table structure for user_share_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_share_detail`;
CREATE TABLE `user_share_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享记录id',
  `share_out_id` char(64) NOT NULL DEFAULT '' COMMENT '外部分享ID,前端生成，规则: md5(user_id,idol_id,name,stamp,rand)',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型(1:时光轴事件; 2:个人轴动态; 3: 应援轴动态; 4: 时光轴卡片; 5:云剪辑)',
  `obj_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏对象id',
  `ic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆卡片id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `share_id` (`share_id`),
  KEY `share_out_id` (`share_out_id`)
) ENGINE=InnoDB AUTO_INCREMENT=259399 DEFAULT CHARSET=utf8 COMMENT='用户分享详情表';

-- ----------------------------
-- Table structure for user_share_like
-- ----------------------------
DROP TABLE IF EXISTS `user_share_like`;
CREATE TABLE `user_share_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_share_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光链id',
  `attitude` tinyint(1) NOT NULL DEFAULT '0' COMMENT '态度(0:无; 1:赞; 2:踩)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_share` (`user_id`,`user_share_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2206 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='时光链点赞表';

-- ----------------------------
-- Table structure for user_share_opinion
-- ----------------------------
DROP TABLE IF EXISTS `user_share_opinion`;
CREATE TABLE `user_share_opinion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_share_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光链id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `root_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根级id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `target_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复用户id',
  `content` text NOT NULL COMMENT '评论内容',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态(0:未审核; 1:审核成功; 2:审核失败)',
  `child_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `child_snap` varchar(2000) DEFAULT '' COMMENT '回复快照',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `idol_id` bigint(20) unsigned NOT NULL COMMENT '明星id',
  PRIMARY KEY (`id`),
  KEY `user_share_id` (`user_share_id`),
  KEY `root_id` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1230 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='时光链评论表';

-- ----------------------------
-- Table structure for user_share_opinion_like
-- ----------------------------
DROP TABLE IF EXISTS `user_share_opinion_like`;
CREATE TABLE `user_share_opinion_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_share_opinion_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光链评论id',
  `attitude` tinyint(1) NOT NULL DEFAULT '0' COMMENT '态度(0:无; 1:赞; 2:踩)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_share` (`user_id`,`user_share_opinion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1105 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='时光链评论点赞表';

-- ----------------------------
-- Table structure for user_share_share
-- ----------------------------
DROP TABLE IF EXISTS `user_share_share`;
CREATE TABLE `user_share_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_share_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时光链id',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8 COMMENT='时光链分享表';

-- ----------------------------
-- Table structure for user_topic
-- ----------------------------
DROP TABLE IF EXISTS `user_topic`;
CREATE TABLE `user_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `idol_id` int(11) NOT NULL DEFAULT '0' COMMENT '明星id',
  `title` char(255) NOT NULL DEFAULT '' COMMENT '话题标题',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `topic_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '事件发生的时间 又用户填写\n',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `idol_card_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联的明星卡片id\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254972 DEFAULT CHARSET=utf8 COMMENT='用户话题表';

-- ----------------------------
-- Table structure for user_topic_material
-- ----------------------------
DROP TABLE IF EXISTS `user_topic_material`;
CREATE TABLE `user_topic_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户话题id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型(1:图片; 2:视频)',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材链接',
  `delete_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '删除状态(0:未删除; 1:已删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `audit_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 0未审核, 1成功, 2失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230407 DEFAULT CHARSET=utf8 COMMENT='用户话题素材表';

-- ----------------------------
-- Table structure for user_video_clip_record
-- ----------------------------
DROP TABLE IF EXISTS `user_video_clip_record`;
CREATE TABLE `user_video_clip_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(64) NOT NULL DEFAULT '' COMMENT '草稿名称',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频合成id',
  `idol_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'idol id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模板id',
  `video_url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材位',
  `draft` text COMMENT '草稿以json存储各个素材位信息',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:草稿; 2:保存中; 3:已保存(预览草稿) 4: 合成失败 5: 已保存)',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除标志(0:未删除 1:删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `next_fetch_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '拉取时间',
  `fetch_times` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT '拉取次数',
  `image_url` varchar(255) NOT NULL COMMENT '封面图',
  `height` bigint(10) NOT NULL COMMENT '视频高',
  `width` bigint(10) NOT NULL COMMENT '视频宽',
  `cover_url` varchar(255) DEFAULT NULL,
  `last_fetch_time` bigint(20) NOT NULL COMMENT '最新抓取时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_idol_id` (`user_id`,`idol_id`),
  KEY `idx_next_fetch_time` (`next_fetch_time`),
  KEY `idx_status_next_fetch_time` (`status`,`next_fetch_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5123 DEFAULT CHARSET=utf8 COMMENT='剪映记录表';

-- ----------------------------
-- Table structure for video_clip_activity
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_activity`;
CREATE TABLE `video_clip_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `platform` varchar(30) NOT NULL DEFAULT '' COMMENT '活动所属平台, 空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"',
  `activity_url` varchar(512) NOT NULL DEFAULT '' COMMENT '活动跳转url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019 DEFAULT CHARSET=utf8 COMMENT='云剪辑打卡活动表';

-- ----------------------------
-- Table structure for video_clip_activity_mark
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_activity_mark`;
CREATE TABLE `video_clip_activity_mark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `column_7` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_clip_activity_mark_user_id_date_uindex` (`user_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='云剪辑打卡活动标记表';

-- ----------------------------
-- Table structure for video_clip_activity_schedule
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_activity_schedule`;
CREATE TABLE `video_clip_activity_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_date` (`aid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动日程表';

-- ----------------------------
-- Table structure for video_clip_official_activity
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_official_activity`;
CREATE TABLE `video_clip_official_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `platform` varchar(30) NOT NULL DEFAULT '' COMMENT '活动所属平台, 空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"',
  `activity_url` varchar(512) NOT NULL DEFAULT '' COMMENT '活动跳转url',
  `tab_url` varchar(255) DEFAULT '' COMMENT '明星页图片\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=962 DEFAULT CHARSET=utf8 COMMENT='云剪辑打卡活动表';

-- ----------------------------
-- Table structure for video_clip_official_activity_backup
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_official_activity_backup`;
CREATE TABLE `video_clip_official_activity_backup` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `platform` varchar(30) NOT NULL DEFAULT '' COMMENT '活动所属平台, 空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"',
  `activity_url` varchar(512) NOT NULL DEFAULT '' COMMENT '活动跳转url',
  `tab_url` varchar(255) DEFAULT '' COMMENT '明星页图片\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for video_clip_official_activity_mark
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_official_activity_mark`;
CREATE TABLE `video_clip_official_activity_mark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_clip_activity_mark_user_id_date_uindex` (`user_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='云剪辑打卡活动标记表';

-- ----------------------------
-- Table structure for video_clip_official_activity_schedule
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_official_activity_schedule`;
CREATE TABLE `video_clip_official_activity_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_date` (`aid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=28831 DEFAULT CHARSET=utf8 COMMENT='AI打卡活动日程表';

-- ----------------------------
-- Table structure for video_clip_official_activity_schedule_backup
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_official_activity_schedule_backup`;
CREATE TABLE `video_clip_official_activity_schedule_backup` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for video_clip_template
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_template`;
CREATE TABLE `video_clip_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(64) NOT NULL DEFAULT '' COMMENT '模板名称',
  `cover_url` varchar(255) NOT NULL DEFAULT '' COMMENT '封面图',
  `template_url` varchar(255) NOT NULL DEFAULT '' COMMENT '模板上传',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '解析模板返回id',
  `template_view_url` varchar(255) NOT NULL DEFAULT '' COMMENT '模板预览',
  `seconds` int(11) NOT NULL DEFAULT '0' COMMENT '播放时长',
  `material_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材量',
  `use_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `material_uv` int(11) NOT NULL DEFAULT '0' COMMENT '选择素材Uv',
  `material_pv` int(11) NOT NULL DEFAULT '0' COMMENT '选择素材Pv',
  `video_uv` int(11) NOT NULL DEFAULT '0' COMMENT '导出视频Uv',
  `video_pv` int(11) NOT NULL DEFAULT '0' COMMENT '导出视频Pv',
  `friends_like_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朋友圈点赞数量(去重)',
  `applet_share_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小程序分享数量(去重)',
  `user_dynamic_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成功发布动态数量',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:上线; 2:下线; 3:删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `task_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '更新剪辑模板状态（0：未更新，1：已更新）',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重（倒叙）',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '类别id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='剪辑模板管理表';

-- ----------------------------
-- Table structure for video_clip_template_category
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_template_category`;
CREATE TABLE `video_clip_template_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(64) NOT NULL DEFAULT '' COMMENT '类别名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:上线; 2:下线; 3:删除)',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重（倒叙）',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='剪辑模板类别表';

-- ----------------------------
-- Table structure for video_clip_template_material
-- ----------------------------
DROP TABLE IF EXISTS `video_clip_template_material`;
CREATE TABLE `video_clip_template_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idx` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '素材位置index',
  `config_id` varchar(50) NOT NULL DEFAULT '0' COMMENT 'TRConfig id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模板id',
  `material_url` varchar(255) NOT NULL DEFAULT '' COMMENT '素材位',
  `material_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '素材类型  0文本, 1图片,2视频,4音频,3图片或视频',
  `continue_seconds` int(11) NOT NULL DEFAULT '0' COMMENT '持续时长（毫秒ms）',
  `show_seconds` int(11) NOT NULL DEFAULT '0' COMMENT '展示时长（毫秒ms）',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频高',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图像或者视频宽',
  `start_frame` int(11) NOT NULL DEFAULT '0' COMMENT '开始帧（毫秒ms）',
  `finish_frame` int(11) NOT NULL DEFAULT '0' COMMENT '结束帧（毫秒ms）',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '开始帧对应时间（毫秒ms）',
  `finish_time` int(11) NOT NULL DEFAULT '0' COMMENT '结束帧对应时间（毫秒ms）',
  `preview_url` varchar(255) NOT NULL DEFAULT '' COMMENT '预览url',
  `frame_index` int(11) NOT NULL DEFAULT '0' COMMENT '预览图片帧索引（毫秒ms）',
  `time_index` int(11) NOT NULL DEFAULT '0' COMMENT '预览图片帧时间索引 （毫秒ms）',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未知; 1:上线; 2:下线; 3:删除)',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COMMENT='剪辑模板素材(关键帧)配置表';

-- ----------------------------
-- Table structure for video_clockin_activity
-- ----------------------------
DROP TABLE IF EXISTS `video_clockin_activity`;
CREATE TABLE `video_clockin_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '明星ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '活动名称',
  `img_intro` varchar(2048) DEFAULT '[""]' COMMENT '规则介绍(图片)',
  `share_card` varchar(512) NOT NULL DEFAULT '' COMMENT '分享卡片',
  `share_title` varchar(256) NOT NULL DEFAULT '' COMMENT '分享文案',
  `target_days` int(10) NOT NULL DEFAULT '0' COMMENT '目标天数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: 初始创建未上线 1: 进行中',
  `start_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `display_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '展示结束时间',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1049 DEFAULT CHARSET=utf8 COMMENT='视频打卡活动表';

-- ----------------------------
-- Table structure for video_clockin_activity_record
-- ----------------------------
DROP TABLE IF EXISTS `video_clockin_activity_record`;
CREATE TABLE `video_clockin_activity_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `ip` char(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_date` (`user_id`,`date`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='视频打卡活动记录表';

-- ----------------------------
-- Table structure for video_clockin_activity_schedule
-- ----------------------------
DROP TABLE IF EXISTS `video_clockin_activity_schedule`;
CREATE TABLE `video_clockin_activity_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动 id',
  `date` bigint(20) NOT NULL COMMENT '打卡日期',
  `target_user` int(10) NOT NULL DEFAULT '0' COMMENT '目标人数',
  `participate_user` int(10) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  `media_lib_id` int(10) NOT NULL DEFAULT '0' COMMENT '图库素材id',
  `video` varchar(512) NOT NULL DEFAULT '' COMMENT '视频链接',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_aid_date` (`aid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=783 DEFAULT CHARSET=utf8 COMMENT='视频打卡活动日程表';

-- ----------------------------
-- Table structure for weibo_spider_result
-- ----------------------------
DROP TABLE IF EXISTS `weibo_spider_result`;
CREATE TABLE `weibo_spider_result` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '微博ID',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '微博用户ID',
  `username` varchar(256) NOT NULL DEFAULT '' COMMENT '微博用户昵称',
  `origin_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '原微博ID',
  `images` text COMMENT '图片urls,json',
  `videos` text COMMENT '图片urls,json',
  `content` text COMMENT '微博文字内容',
  `reposts_count` int(11) DEFAULT '0' COMMENT '微博reposts_count',
  `comments_count` int(11) DEFAULT '0' COMMENT '微博comments_count',
  `attitudes_count` int(11) DEFAULT '0' COMMENT '微博attitudes_count',
  `create_date` int(11) DEFAULT '0' COMMENT '创建日期ymd',
  `spider_time` bigint(20) DEFAULT '0' COMMENT '爬取时间',
  `ringme_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已用于一环素材',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '微博类型,1:原创，2:转发',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for weibo_spider_result_2020_12_31_13
-- ----------------------------
DROP TABLE IF EXISTS `weibo_spider_result_2020_12_31_13`;
CREATE TABLE `weibo_spider_result_2020_12_31_13` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '微博ID',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '微博用户ID',
  `username` varchar(256) NOT NULL DEFAULT '' COMMENT '微博用户昵称',
  `origin_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '原微博ID',
  `images` text COMMENT '图片urls,json',
  `videos` text COMMENT '图片urls,json',
  `content` text COMMENT '微博文字内容',
  `reposts_count` int(11) DEFAULT '0' COMMENT '微博reposts_count',
  `comments_count` int(11) DEFAULT '0' COMMENT '微博comments_count',
  `attitudes_count` int(11) DEFAULT '0' COMMENT '微博attitudes_count',
  `create_date` int(11) DEFAULT '0' COMMENT '创建日期ymd',
  `spider_time` bigint(20) DEFAULT '0' COMMENT '爬取时间',
  `ringme_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已用于一环素材',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '微博类型,1:原创，2:转发',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for weibo_spider_task
-- ----------------------------
DROP TABLE IF EXISTS `weibo_spider_task`;
CREATE TABLE `weibo_spider_task` (
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '微博用户UID',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '微博用户昵称',
  `avatar_url` varchar(256) NOT NULL DEFAULT '' COMMENT '头像url',
  `weibo_url` varchar(256) NOT NULL DEFAULT '微博移动端首页链接',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上次爬取数据的更新时间',
  `since_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上次获取的微博id(since_id),用于历史数据获取',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '任务状态,1:正常，2:暂停',
  `data_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '历史数据抓取状态,1:尚未抓取完成,2:已全部获取',
  `delete_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除状态,1:删除',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '任务类型，1:事件素材任务,2:图库活动套图任务',
  `idol_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '爱豆ID',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_auth
-- ----------------------------
DROP TABLE IF EXISTS `wx_auth`;
CREATE TABLE `wx_auth` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `union_id` char(32) NOT NULL DEFAULT '' COMMENT 'union_id',
  `app_open_id` char(32) NOT NULL DEFAULT '' COMMENT 'app_wx_open_id',
  `mini_open_id` char(32) NOT NULL DEFAULT '' COMMENT 'mini_wx_open_id',
  `secret` char(32) NOT NULL DEFAULT '' COMMENT 'token生成所需secret',
  `create_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `last_update` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `union_id` (`union_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信登录表';

-- ----------------------------
-- Procedure structure for InsertActivity
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertActivity`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` PROCEDURE `InsertActivity`(IN act_name varchar(255),
                             IN img_intro varchar(255),
                             IN share_card varchar(255),
                             IN share_title varchar(255),
                             IN target_days int(11),
                             IN daily_users int(11),
                             IN start_time varchar(255),
                             IN days varchar(255),
                             IN platform varchar(255),
                             IN url varchar(255))
BEGIN
    set @act_name = act_name ,
        @img_intro = img_intro,
        @share_card = share_card ,
        @share_title = share_title,
        @target_days = target_days,
        @daily_users = daily_users,
        @start_time = start_time,
        @days      = days,
        @platform = platform,
        @url = url;
    #空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"'

#插入活动, 每个明星一条 并设置id
    insert into video_clip_official_activity (idol_id, name, img_intro, share_card, share_title, target_days, status, start_time,
                                     end_time, display_end_time, create_time, last_update, platform, tab_url)
    select id, @act_name, @img_intro, @share_card, @share_title, @target_days, 1,
            unix_timestamp(@start_time), unix_timestamp(@start_time) + 86400 * @days, unix_timestamp(@start_time) + 86400 * @days, unix_timestamp(),
            unix_timestamp(), @platform, @url from idol;

#插入schedule, 按照天数 (借用 idol 表做 挂靠)
    insert into video_clip_official_activity_schedule (aid, date, target_user, participate_user)
    select v.id, d.datetime, @daily_users, 0
    from (
             select @ts := @ts + 86400, @rn := @rn + 1 as rn, date_format(FROM_UNIXTIME(@ts), '%Y%m%d') datetime
             from idol,
                  (select @ts := unix_timestamp(@start_time) - 86400) dum,
                  (select @rn := 0) r
         ) d, video_clip_official_activity v
    where d.rn <= @days;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertVCAct
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertVCAct`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` PROCEDURE `InsertVCAct`(IN idol_name varchar(255),
                             IN act_name varchar(255),
                             IN img_intro varchar(255),
                             IN share_card varchar(255),
                             IN share_title varchar(255),
                             IN target_days int(11),
                             IN daily_users int(11),
                             IN start_time varchar(255),
                             IN end_time varchar(255),
                             IN display_end_time varchar(255),
                             IN platform varchar(255),
                             IN url varchar(255),
                             OUT aid int(11))
BEGIN
    set @idol_name = idol_name,
        @act_name = act_name ,
        @img_intro = img_intro,
        @share_card = share_card ,
        @share_title = share_title,
        @target_days = target_days,
        @daily_users = daily_users,
        @start_time = start_time ,
        @end_time = end_time ,
        @display_end_time = display_end_time,
        @platform = platform,
        @url = url;
    #空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"'

#获取idol Id
    set @idol_id = (select id
                    from idol
                    where name = @idol_name);

#插入活动, 并设置id
    insert into video_clip_activity (idol_id, name, img_intro, share_card, share_title, target_days, status, start_time,
                                     end_time, display_end_time, create_time, last_update, platform, activity_url)
    VALUES (@idol_id, @act_name, @img_intro, @share_card, @share_title, @target_days, 1,
            unix_timestamp(@start_time), unix_timestamp(@end_time), unix_timestamp(@display_end_time), unix_timestamp(),
            unix_timestamp(), @platform, @url);

    set @aid = last_insert_id();

#插入schedule, 按照天数 (借用 idol 表做 挂靠)
    insert into video_clip_activity_schedule (aid, date, target_user, participate_user)
    select @aid, datetime, @daily_users, 0
    from (
             select @ts := @ts + 86400, @rn := @rn + 1 as rn, date_format(FROM_UNIXTIME(@ts), '%Y%m%d') datetime
             from idol,
                  (select @ts := unix_timestamp(@start_time) - 86400) dum,
                  (select @rn := 0) r
         ) d
    where rn <= @target_days;


    select @aid into aid;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for InsertVCOAct
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertVCOAct`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` PROCEDURE `InsertVCOAct`(IN idol_name varchar(255),
                             IN act_name varchar(255),
                             IN img_intro varchar(255),
                             IN share_card varchar(255),
                             IN share_title varchar(255),
                             IN target_days int(11),
                             IN daily_users int(11),
                             IN start_time varchar(255),
                             IN end_time varchar(255),
                             IN platform varchar(255),
                             IN url varchar(255),
                             OUT aid int(11))
BEGIN
    set @idol_name = idol_name,
        @act_name = act_name ,
        @img_intro = img_intro,
        @share_card = share_card ,
        @share_title = share_title,
        @target_days = target_days,
        @daily_users = daily_users,
        @start_time = start_time ,
        @end_time = end_time ,
        @platform = platform,
        @url = url;
    #空值为所有平台"mini_qq""mini_wx""app_qq""app_wx""phone"'

#获取idol Id
    set @idol_id = (select id
                    from idol
                    where name = @idol_name);

#插入活动, 并设置id
    insert into video_clip_official_activity (idol_id, name, img_intro, share_card, share_title, target_days, status, start_time,
                                     end_time, display_end_time, create_time, last_update, platform, activity_url)
    VALUES (@idol_id, @act_name, @img_intro, @share_card, @share_title, @target_days, 1,
            unix_timestamp(@start_time), unix_timestamp(@end_time), unix_timestamp(@end_time), unix_timestamp(),
            unix_timestamp(), @platform, @url);

    set @aid = last_insert_id();

#插入schedule, 按照天数 (借用 idol 表做 挂靠)
    insert into video_clip_official_activity_schedule (aid, date, target_user, participate_user)
    select @aid, datetime, @daily_users, 0
    from (
             select @ts := @ts + 86400, @rn := @rn + 1 as rn, date_format(FROM_UNIXTIME(@ts), '%Y%m%d') datetime
             from idol,
                  (select @ts := unix_timestamp(@start_time) - 86400) dum,
                  (select @rn := 0) r
         ) d
    where rn <= @target_days;


    select @aid into aid;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fristPinyin
-- ----------------------------
DROP FUNCTION IF EXISTS `fristPinyin`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` FUNCTION `fristPinyin`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE V_RETURN VARCHAR(255);
    SET V_RETURN = ELT(INTERVAL(CONV(HEX(left(CONVERT(P_NAME USING gbk),1)),16,10), 
        0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7, 
        0xBFA6,0xC0AC,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,
        0xC8F6,0xCBFA,0xCDDA,0xCEF4,0xD1B9,0xD4D1),    
    'A','B','C','D','E','F','G','H','J','K','L','M','N','O','P','Q','R','S','T','W','X','Y','Z');
    RETURN V_RETURN;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for pinyin
-- ----------------------------
DROP FUNCTION IF EXISTS `pinyin`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` FUNCTION `pinyin`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE V_COMPARE VARCHAR(255);
    DECLARE V_RETURN VARCHAR(255);
    DECLARE I INT;
    SET I = 1;
    SET V_RETURN = '';
    while I < LENGTH(P_NAME) do
        SET V_COMPARE = SUBSTR(P_NAME, I, 1);
        IF (V_COMPARE != '') THEN
            #SET V_RETURN = CONCAT(V_RETURN, ',', V_COMPARE);
            SET V_RETURN = CONCAT(V_RETURN, fristPinyin(V_COMPARE));
            #SET V_RETURN = fristPinyin(V_COMPARE);
        END IF;
        SET I = I + 1;
    end while;
    IF (ISNULL(V_RETURN) or V_RETURN = '') THEN
        SET V_RETURN = P_NAME;
    END IF;
    RETURN V_RETURN;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for pinyin2
-- ----------------------------
DROP FUNCTION IF EXISTS `pinyin2`;
DELIMITER ;;
CREATE DEFINER=`domob`@`%` FUNCTION `pinyin2`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
    DECLARE V_COMPARE VARCHAR(255);
    DECLARE V_RETURN VARCHAR(255);
    DECLARE I INT;
    SET I = 1;
    SET V_RETURN = '';
    while I < LENGTH(P_NAME) do
        SET V_COMPARE = SUBSTR(P_NAME, I, 1);
        IF (V_COMPARE != '') THEN
            #SET V_RETURN = CONCAT(V_RETURN, ',', V_COMPARE);
            SET V_RETURN = CONCAT(V_RETURN, fristPinyin(V_COMPARE));
            #SET V_RETURN = fristPinyin(V_COMPARE);
        END IF;
        SET I = I + 1;
    end while;
    IF (ISNULL(V_RETURN) or V_RETURN = '') THEN
        SET V_RETURN = P_NAME;
    END IF;
    RETURN V_RETURN;
END
;;
DELIMITER ;
