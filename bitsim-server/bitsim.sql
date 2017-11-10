DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键',
  `username` VARCHAR(32) UNIQUE NOT NULL DEFAULT '' COMMENT '用户名',
  `password` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` VARCHAR(16) DEFAULT '' COMMENT '昵称',
  `realname` VARCHAR(16) DEFAULT '' COMMENT '真实姓名',
  `gender` TINYINT(4) DEFAULT 0 COMMENT '性别（0：未知，1：男，2：女）',
  `phone` VARCHAR(11) DEFAULT '' COMMENT '手机号码',
  `email` VARCHAR(100) DEFAULT '' COMMENT '邮箱地址',
  `iconimg` VARCHAR(120) DEFAULT '' COMMENT '头像url地址',
  `info` VARCHAR(255) DEFAULT '' COMMENT '个人简介',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账号创建时间',
  `last_login_time` TIMESTAMP NOT NULL DEFAULT '1970-01-02 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '账号最近登录时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='用户表';

DROP TABLE IF EXISTS `friendship`;
CREATE TABLE `friendship` (
  `friendship_id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键，好友关系关联ID',
  `user_id` INT(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `friend_id` INT(11) UNSIGNED NOT NULL COMMENT '好友ID',
  `user_pass` TINYINT(4) DEFAULT 1 COMMENT '用户1是否同意好友申请，默认由user_id发出申请即=1',
  `friend_pass` TINYINT(4) DEFAULT 0 COMMENT '用户2是否同意好友申请，默认为0，必须该用户同意申请后设为1',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '好友关系建立时间',
  CONSTRAINT `FK_UUID` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_GUID` FOREIGN KEY (`friend_id`) REFERENCES `user` (`user_id`),
  UNIQUE KEY (user_id, friend_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='好友关系关联表';

DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `message_id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键，消息ID',
  `from_id` INT(11) UNSIGNED NOT NULL COMMENT '消息发送方ID',
  `to_id` INT(11) UNSIGNED NOT NULL COMMENT '消息接收方ID',
  `type` TINYINT(4) NOT NULL COMMENT '消息类型（1:私聊, 2:群聊）',
  `content` varchar(2000) NOT NULL COMMENT '消息内容',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息发送时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='消息表';

DROP TABLE IF EXISTS `offline_message`;
CREATE TABLE `offline_message` (
  `offline_message_id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键，离线消息ID',
  `user_id` varchar(40) not null COMMENT '',
  `message_id` varchar(40) not null COMMENT '',
  `status` varchar(20) not null COMMENT '',
  `create_time` datetime not null COMMENT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='离线消息表';
CREATE INDEX idx_uid_status_on_offline_message on offline_message(user_id, status);

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `group_id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键，聊天群组ID',
  `group_name` VARCHAR(32) UNIQUE NOT NULL DEFAULT '' COMMENT '聊天群组名',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '群组创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='聊天群组表';

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `id` INT(11) UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键，用户群组关联ID',
  `user_id` VARCHAR(32) UNIQUE NOT NULL DEFAULT '' COMMENT '聊天群组名',
  `group_id` VARCHAR(32) UNIQUE NOT NULL DEFAULT '' COMMENT '聊天群组名',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入群时间',
  CONSTRAINT `FK_UID` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_GID` FOREIGN KEY (`group_id`) REFERENCES `group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10000 COMMENT='用户群组关联表';