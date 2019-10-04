Use ApolloPortalDB;

CREATE TABLE IF NOT EXISTS `Attempts` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `IP` varchar(64) NOT NULL,
  `FingerPrint` varchar(128),
  `Username` varchar(64),
  `Count` int(11),
  `OutTime` int(11),
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


DROP PROCEDURE IF EXISTS `TableUpdate`;

CREATE PROCEDURE `TableUpdate`()
BEGIN
    -- 添加IP字段
    IF NOT EXISTS (SELECT * FROM information_schema.`COLUMNS` WHERE table_schema ='ApolloPortalDB' AND table_name='users'AND column_name='IPS')THEN
        ALTER TABLE `ApolloPortalDB`.`users` 
        ADD COLUMN `IPS` VARCHAR(1024) NOT NULL DEFAULT '' AFTER `Enabled`;
    END IF;
    -- 添加FP字段
    IF NOT EXISTS (SELECT * FROM information_schema.`COLUMNS` WHERE table_schema='ApolloPortalDB' AND table_name='users' AND column_name='FPS')THEN
        ALTER TABLE `ApolloPortalDB`.`users` 
        ADD COLUMN `FPS` VARCHAR(1024) NOT NULL DEFAULT '' AFTER `IPS`;
    END IF;
END

-- 执行更新
CALL TableUpdate();
-- 移除更新存储过程
DROP PROCEDURE IF EXISTS TableUpdate;