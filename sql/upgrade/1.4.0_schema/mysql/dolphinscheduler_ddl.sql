/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- uc_dolphin_T_t_ds_user_A_state
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_user_A_state;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_user_A_state()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_user'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='state')
   THEN
         ALTER TABLE t_ds_user ADD `state` int(1) DEFAULT 1 COMMENT 'state 0:disable 1:enable';
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_user_A_state;
DROP PROCEDURE uc_dolphin_T_t_ds_user_A_state;

-- uc_dolphin_T_t_ds_tenant_A_tenant_name
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_tenant_A_tenant_name;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_tenant_A_tenant_name()
   BEGIN
       IF EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_tenant'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='tenant_name')
   THEN
         ALTER TABLE t_ds_tenant DROP `tenant_name`;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_tenant_A_tenant_name;
DROP PROCEDURE uc_dolphin_T_t_ds_tenant_A_tenant_name;

-- uc_dolphin_T_t_ds_task_instance_A_first_submit_time
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_task_instance_A_first_submit_time;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_task_instance_A_first_submit_time()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_task_instance'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='first_submit_time')
   THEN
         ALTER TABLE t_ds_task_instance ADD `first_submit_time` datetime DEFAULT NULL COMMENT 'task first submit time';
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_task_instance_A_first_submit_time();
DROP PROCEDURE uc_dolphin_T_t_ds_task_instance_A_first_submit_time;

-- uc_dolphin_T_t_ds_task_instance_A_delay_time
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_task_instance_A_delay_time;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_task_instance_A_delay_time()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_task_instance'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='delay_time')
   THEN
         ALTER TABLE t_ds_task_instance ADD `delay_time` int(4) DEFAULT '0' COMMENT 'task delay execution time';
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_task_instance_A_delay_time();
DROP PROCEDURE uc_dolphin_T_t_ds_task_instance_A_delay_time;

-- uc_dolphin_T_t_ds_task_instance_A_var_pool
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_task_instance_A_var_pool;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_task_instance_A_var_pool()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_task_instance'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='var_pool')
   THEN
         ALTER TABLE t_ds_task_instance ADD `var_pool` longtext NULL;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_task_instance_A_var_pool();
DROP PROCEDURE uc_dolphin_T_t_ds_task_instance_A_var_pool;

-- uc_dolphin_T_t_ds_process_instance_A_var_pool
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_process_instance_A_var_pool;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_process_instance_A_var_pool()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_process_instance'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='var_pool')
   THEN
         ALTER TABLE t_ds_process_instance ADD `var_pool` longtext NULL;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_process_instance_A_var_pool();
DROP PROCEDURE uc_dolphin_T_t_ds_process_instance_A_var_pool;

-- uc_dolphin_T_t_ds_process_definition_A_modify_by
drop PROCEDURE if EXISTS ct_dolphin_T_t_ds_process_definition_version;
delimiter d//
CREATE PROCEDURE ct_dolphin_T_t_ds_process_definition_version()
BEGIN
    CREATE TABLE IF NOT EXISTS `t_ds_process_definition_version` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'key',
        `process_definition_id` int(11) NOT NULL COMMENT 'process definition id',
        `version` int(11) DEFAULT NULL COMMENT 'process definition version',
        `process_definition_json` longtext COMMENT 'process definition json content',
        `description` text,
        `global_params` text COMMENT 'global parameters',
        `locations` text COMMENT 'Node location information',
        `connects` text COMMENT 'Node connection information',
        `receivers` text COMMENT 'receivers',
        `receivers_cc` text COMMENT 'cc',
        `create_time` datetime DEFAULT NULL COMMENT 'create time',
        `timeout` int(11) DEFAULT '0' COMMENT 'time out',
        `resource_ids` varchar(255) DEFAULT NULL COMMENT 'resource ids',
        PRIMARY KEY (`id`),
        UNIQUE KEY `process_definition_id_and_version` (`process_definition_id`,`version`) USING BTREE,
        KEY `process_definition_index` (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
END;

d//

delimiter ;
CALL ct_dolphin_T_t_ds_process_definition_version;
DROP PROCEDURE ct_dolphin_T_t_ds_process_definition_version;

-- ----------------------------
-- Table structure for t_ds_plugin_define
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_plugin_define`;
CREATE TABLE `t_ds_plugin_define` (
    `id` int NOT NULL AUTO_INCREMENT,
    `plugin_name` varchar(100) NOT NULL COMMENT 'the name of plugin eg: email',
    `plugin_type` varchar(100) NOT NULL COMMENT 'plugin type . alert=alert plugin, job=job plugin',
    `plugin_params` text COMMENT 'plugin params',
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `t_ds_plugin_define_UN` (`plugin_name`,`plugin_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ds_alert_plugin_instance
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_alert_plugin_instance`;
CREATE TABLE `t_ds_alert_plugin_instance` (
    `id`                     int NOT NULL AUTO_INCREMENT,
    `plugin_define_id`       int NOT NULL,
    `plugin_instance_params` text COMMENT 'plugin instance params. Also contain the params value which user input in web ui.',
    `create_time`            timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`            timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `instance_name`          varchar(200) DEFAULT NULL COMMENT 'alert instance name',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- uc_dolphin_T_t_ds_process_definition_A_warning_group_id
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_process_definition_A_warning_group_id;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_process_definition_A_warning_group_id()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_process_definition'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='warning_group_id')
   THEN
         ALTER TABLE t_ds_process_definition ADD COLUMN `warning_group_id` int(11) DEFAULT NULL COMMENT 'alert group id' AFTER `connects`;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_process_definition_A_warning_group_id();
DROP PROCEDURE uc_dolphin_T_t_ds_process_definition_A_warning_group_id;

-- uc_dolphin_T_t_ds_process_definition_version_A_warning_group_id
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_process_definition_version_A_warning_group_id;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_process_definition_version_A_warning_group_id()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_process_definition_version'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='warning_group_id')
   THEN
         ALTER TABLE t_ds_process_definition_version ADD COLUMN `warning_group_id` int(11) DEFAULT NULL COMMENT 'alert group id' AFTER `connects`;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_process_definition_version_A_warning_group_id();
DROP PROCEDURE uc_dolphin_T_t_ds_process_definition_version_A_warning_group_id;

-- uc_dolphin_T_t_ds_alertgroup_A_alert_instance_ids
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_alertgroup_A_alert_instance_ids;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_alert_instance_ids()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_alertgroup'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='alert_instance_ids')
   THEN
         ALTER TABLE t_ds_alertgroup ADD COLUMN `alert_instance_ids` varchar (255) DEFAULT NULL COMMENT 'alert instance ids' AFTER `id`;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_alertgroup_A_alert_instance_ids();
DROP PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_alert_instance_ids;

-- uc_dolphin_T_t_ds_alertgroup_A_create_user_id
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_alertgroup_A_create_user_id;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_create_user_id()
   BEGIN
       IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_NAME='t_ds_alertgroup'
           AND TABLE_SCHEMA=(SELECT DATABASE())
           AND COLUMN_NAME ='create_user_id')
   THEN
         ALTER TABLE t_ds_alertgroup ADD COLUMN `create_user_id` int(11) DEFAULT NULL COMMENT 'create user id' AFTER `alert_instance_ids`;
       END IF;
 END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_alertgroup_A_create_user_id();
DROP PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_create_user_id;

-- uc_dolphin_T_t_ds_alertgroup_A_add_UN_groupName
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_alertgroup_A_add_UN_groupName;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_add_UN_groupName()
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS
                   WHERE TABLE_NAME='t_ds_alertgroup'
                     AND TABLE_SCHEMA=(SELECT DATABASE())
                     AND INDEX_NAME ='t_ds_alertgroup_name_un')
    THEN
        ALTER TABLE t_ds_alertgroup ADD UNIQUE KEY `t_ds_alertgroup_name_un` (`group_name`);
    END IF;
END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_alertgroup_A_add_UN_groupName();
DROP PROCEDURE uc_dolphin_T_t_ds_alertgroup_A_add_UN_groupName;

-- uc_dolphin_T_t_ds_datasource_A_add_UN_datasourceName
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_datasource_A_add_UN_datasourceName;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_datasource_A_add_UN_datasourceName()
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS
                   WHERE TABLE_NAME='t_ds_datasource'
                     AND TABLE_SCHEMA=(SELECT DATABASE())
                     AND INDEX_NAME ='t_ds_datasource_name_un')
    THEN
        ALTER TABLE t_ds_datasource ADD UNIQUE KEY `t_ds_datasource_name_un` (`name`, `type`);
    END IF;
END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_datasource_A_add_UN_datasourceName();
DROP PROCEDURE uc_dolphin_T_t_ds_datasource_A_add_UN_datasourceName;

-- uc_dolphin_T_t_ds_schedules_A_add_timezone
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_schedules_A_add_timezone;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_schedules_A_add_timezone()
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.COLUMNS
                   WHERE TABLE_NAME='t_ds_schedules'
                     AND TABLE_SCHEMA=(SELECT DATABASE())
                     AND COLUMN_NAME ='timezone_id')
    THEN
        ALTER TABLE t_ds_schedules ADD COLUMN `timezone_id` varchar(40) default NULL COMMENT 'schedule timezone id' AFTER `end_time`;
    END IF;
END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_schedules_A_add_timezone();
DROP PROCEDURE uc_dolphin_T_t_ds_schedules_A_add_timezone;

-- uc_dolphin_T_t_ds_task_definition_A_drop_UN_taskName
drop PROCEDURE if EXISTS uc_dolphin_T_t_ds_task_definition_A_drop_UN_taskName;
delimiter d//
CREATE PROCEDURE uc_dolphin_T_t_ds_task_definition_A_drop_UN_taskName()
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.STATISTICS
                   WHERE TABLE_NAME='t_ds_task_definition'
                     AND TABLE_SCHEMA=(SELECT DATABASE())
                     AND INDEX_NAME ='task_unique')
        ALTER TABLE t_ds_task_definition drop INDEX `task_unique`;
    END IF;
END;

d//

delimiter ;
CALL uc_dolphin_T_t_ds_task_definition_A_drop_UN_taskName();
DROP PROCEDURE uc_dolphin_T_t_ds_task_definition_A_drop_UN_taskName;

-- ----------------------------
-- Table structure for t_ds_environment
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_environment`;
CREATE TABLE `t_ds_environment` (
   `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `code` bigint(20) DEFAULT NULL COMMENT 'encoding',
   `name` varchar(100) NOT NULL COMMENT 'environment config name',
   `config` text NULL DEFAULT NULL COMMENT 'this config contains many environment variables config',
   `description` text NULL DEFAULT NULL COMMENT 'the details',
   `operator` int(11) DEFAULT NULL COMMENT 'operator user id',
   `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `environment_name_unique` (`name`),
   UNIQUE KEY `environment_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ds_task_definition
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_task_definition`;
CREATE TABLE `t_ds_task_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'self-increasing id',
  `code` bigint(20) NOT NULL COMMENT 'encoding',
  `name` varchar(200) DEFAULT NULL COMMENT 'task definition name',
  `version` int(11) DEFAULT NULL COMMENT 'task definition version',
  `description` text COMMENT 'description',
  `project_code` bigint(20) NOT NULL COMMENT 'project code',
  `user_id` int(11) DEFAULT NULL COMMENT 'task definition creator id',
  `task_type` varchar(50) NOT NULL COMMENT 'task type',
  `task_params` longtext COMMENT 'job custom parameters',
  `flag` tinyint(2) DEFAULT NULL COMMENT '0 not available, 1 available',
  `task_priority` tinyint(4) DEFAULT NULL COMMENT 'job priority',
  `worker_group` varchar(200) DEFAULT NULL COMMENT 'worker grouping',
  `environment_code` bigint(20) DEFAULT '-1' COMMENT 'environment code',
  `fail_retry_times` int(11) DEFAULT NULL COMMENT 'number of failed retries',
  `fail_retry_interval` int(11) DEFAULT NULL COMMENT 'failed retry interval',
  `timeout_flag` tinyint(2) DEFAULT '0' COMMENT 'timeout flag:0 close, 1 open',
  `timeout_notify_strategy` tinyint(4) DEFAULT NULL COMMENT 'timeout notification policy: 0 warning, 1 fail',
  `timeout` int(11) DEFAULT '0' COMMENT 'timeout length,unit: minute',
  `delay_time` int(11) DEFAULT '0' COMMENT 'delay execution time,unit: minute',
  `resource_ids` text COMMENT 'resource id, separated by comma',
  `create_time` datetime NOT NULL COMMENT 'create time',
  `update_time` datetime DEFAULT NULL COMMENT 'update time',
  PRIMARY KEY (`id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ds_task_definition_log
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_task_definition_log`;
CREATE TABLE `t_ds_task_definition_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'self-increasing id',
  `code` bigint(20) NOT NULL COMMENT 'encoding',
  `name` varchar(200) DEFAULT NULL COMMENT 'task definition name',
  `version` int(11) DEFAULT NULL COMMENT 'task definition version',
  `description` text COMMENT 'description',
  `project_code` bigint(20) NOT NULL COMMENT 'project code',
  `user_id` int(11) DEFAULT NULL COMMENT 'task definition creator id',
  `task_type` varchar(50) NOT NULL COMMENT 'task type',
  `task_params` text COMMENT 'job custom parameters',
  `flag` tinyint(2) DEFAULT NULL COMMENT '0 not available, 1 available',
  `task_priority` tinyint(4) DEFAULT NULL COMMENT 'job priority',
  `worker_group` varchar(200) DEFAULT NULL COMMENT 'worker grouping',
  `environment_code` bigint(20) DEFAULT '-1' COMMENT 'environment code',
  `fail_retry_times` int(11) DEFAULT NULL COMMENT 'number of failed retries',
  `fail_retry_interval` int(11) DEFAULT NULL COMMENT 'failed retry interval',
  `timeout_flag` tinyint(2) DEFAULT '0' COMMENT 'timeout flag:0 close, 1 open',
  `timeout_notify_strategy` tinyint(4) DEFAULT NULL COMMENT 'timeout notification policy: 0 warning, 1 fail',
  `timeout` int(11) DEFAULT '0' COMMENT 'timeout length,unit: minute',
  `delay_time` int(11) DEFAULT '0' COMMENT 'delay execution time,unit: minute',
  `resource_ids` text COMMENT 'resource id, separated by comma',
  `operator` int(11) DEFAULT NULL COMMENT 'operator user id',
  `operate_time` datetime DEFAULT NULL COMMENT 'operate time',
  `create_time` datetime NOT NULL COMMENT 'create time',
  `update_time` datetime DEFAULT NULL COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE t_ds_command ADD COLUMN `environment_code` bigint(20) default '-1' COMMENT 'environment code' AFTER `worker_group`;
ALTER TABLE t_ds_error_command ADD COLUMN `environment_code` bigint(20) default '-1' COMMENT 'environment code' AFTER `worker_group`;
ALTER TABLE t_ds_schedules ADD COLUMN `environment_code` bigint(20) default '-1' COMMENT 'environment code' AFTER `worker_group`;
ALTER TABLE t_ds_process_instance ADD COLUMN `environment_code` bigint(20) default '-1' COMMENT 'environment code' AFTER `worker_group`;
ALTER TABLE t_ds_task_instance ADD COLUMN `environment_code` bigint(20) default '-1' COMMENT 'environment code' AFTER `worker_group`;
ALTER TABLE t_ds_task_instance ADD COLUMN `environment_config` text COMMENT 'environment config' AFTER `environment_code`;

ALTER TABLE t_ds_task_definition MODIFY COLUMN `resource_ids` text;
ALTER TABLE t_ds_task_definition_log MODIFY COLUMN `resource_ids` text;

-- ----------------------------
-- Table structure for t_ds_environment_worker_group_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_environment_worker_group_relation`;
CREATE TABLE `t_ds_environment_worker_group_relation` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `environment_code` bigint(20) NOT NULL COMMENT 'environment code',
  `worker_group` varchar(255) NOT NULL COMMENT 'worker group id',
  `operator` int(11) DEFAULT NULL COMMENT 'operator user id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `environment_worker_group_unique` (`environment_code`,`worker_group`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- These columns will not be used in the new version,if you determine that the historical data is useless, you can delete it using the sql below
-- ----------------------------

-- ALTER TABLE t_ds_alert DROP `show_type`, DROP `alert_type`, DROP `receivers`, DROP `receivers_cc`;

-- ALTER TABLE t_ds_alertgroup DROP `group_type`;

-- ALTER TABLE t_ds_process_definition DROP `receivers`, DROP `receivers_cc`;

-- ALTER TABLE t_ds_process_definition_version DROP `receivers`, DROP `receivers_cc`;

-- DROP TABLE IF EXISTS t_ds_relation_user_alertgroup;

-- ALTER TABLE t_ds_command DROP `dependence`;

-- ALTER TABLE t_ds_error_command DROP `dependence`;
