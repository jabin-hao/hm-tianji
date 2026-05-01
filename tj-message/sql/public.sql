/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_message
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:19:39
*/


-- ----------------------------
-- Sequence structure for sms_third_platform_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sms_third_platform_id_seq";
CREATE SEQUENCE "public"."sms_third_platform_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for message_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."message_template";
CREATE TABLE "public"."message_template" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "platform_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "sign_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "third_template_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "template_id" int8 DEFAULT 0,
  "status" int2 NOT NULL DEFAULT 1,
  "creater" int8,
  "updater" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."message_template"."id" IS '短信发送模板 id';
COMMENT ON COLUMN "public"."message_template"."name" IS '模板名称';
COMMENT ON COLUMN "public"."message_template"."platform_code" IS '第三方短信推送渠道 id';
COMMENT ON COLUMN "public"."message_template"."sign_name" IS '签名';
COMMENT ON COLUMN "public"."message_template"."third_template_code" IS '第三方短信模板 code';
COMMENT ON COLUMN "public"."message_template"."content" IS '第三方短信模板内容预览';
COMMENT ON COLUMN "public"."message_template"."template_id" IS '通知模板id，统用系统公告类短信会关联这个id';
COMMENT ON COLUMN "public"."message_template"."status" IS '短信模板状态，0-禁用，1-启用';
COMMENT ON COLUMN "public"."message_template"."creater" IS '创建人';
COMMENT ON COLUMN "public"."message_template"."updater" IS '更新人';
COMMENT ON COLUMN "public"."message_template"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."message_template"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."message_template" IS '第三方短信平台签名和模板信息';

-- ----------------------------
-- Records of message_template
-- ----------------------------

-- ----------------------------
-- Table structure for notice_task
-- ----------------------------
DROP TABLE IF EXISTS "public"."notice_task";
CREATE TABLE "public"."notice_task" (
  "id" int8 NOT NULL,
  "template_id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "partial" bool NOT NULL DEFAULT false,
  "push_time" timestamp(6) NOT NULL,
  "max_times" int4 NOT NULL DEFAULT 0,
  "interval" int4 NOT NULL DEFAULT 0,
  "expire_time" timestamp(6),
  "finished" bool NOT NULL DEFAULT false,
  "creater" int8,
  "updater" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."notice_task"."id" IS '公告任务 id';
COMMENT ON COLUMN "public"."notice_task"."template_id" IS '任务对应的通知模板 id';
COMMENT ON COLUMN "public"."notice_task"."name" IS '任务名称';
COMMENT ON COLUMN "public"."notice_task"."partial" IS 'true-通知所有人;false-通知部分人。默认false';
COMMENT ON COLUMN "public"."notice_task"."push_time" IS '任务预期执行时间';
COMMENT ON COLUMN "public"."notice_task"."max_times" IS '任务重复执行次数上限，0则不重复';
COMMENT ON COLUMN "public"."notice_task"."interval" IS '任务延迟执行时间间隔，单位是分钟';
COMMENT ON COLUMN "public"."notice_task"."expire_time" IS '任务失效时间';
COMMENT ON COLUMN "public"."notice_task"."finished" IS '任务是否已经完成';
COMMENT ON COLUMN "public"."notice_task"."creater" IS '创建人';
COMMENT ON COLUMN "public"."notice_task"."updater" IS '更新人';
COMMENT ON COLUMN "public"."notice_task"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."notice_task"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."notice_task" IS '系统通告的任务表，可以延期或定期发送通告';

-- ----------------------------
-- Records of notice_task
-- ----------------------------

-- ----------------------------
-- Table structure for notice_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."notice_template";
CREATE TABLE "public"."notice_template" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "type" int2 NOT NULL DEFAULT 3,
  "status" int2 NOT NULL DEFAULT 0,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "is_sms_template" bool NOT NULL DEFAULT false,
  "creater" int8,
  "updater" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."notice_template"."id" IS '通知模板 id';
COMMENT ON COLUMN "public"."notice_template"."name" IS '通知模板名称';
COMMENT ON COLUMN "public"."notice_template"."code" IS '通知模板代号，例如verify-code';
COMMENT ON COLUMN "public"."notice_template"."type" IS '通知类型：0-系统通知，1-笔记通知，2-问答通知，3-其它通知';
COMMENT ON COLUMN "public"."notice_template"."status" IS '模板状态:  0-草稿，1-使用中，2-停用';
COMMENT ON COLUMN "public"."notice_template"."title" IS '通知标题';
COMMENT ON COLUMN "public"."notice_template"."content" IS '通知内容模板';
COMMENT ON COLUMN "public"."notice_template"."is_sms_template" IS '是否包含第三方短信模板，默认false';
COMMENT ON COLUMN "public"."notice_template"."creater" IS '创建人';
COMMENT ON COLUMN "public"."notice_template"."updater" IS '更新人';
COMMENT ON COLUMN "public"."notice_template"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."notice_template"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."notice_template" IS '通知模板表';

-- ----------------------------
-- Records of notice_template
-- ----------------------------

-- ----------------------------
-- Table structure for public_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."public_notice";
CREATE TABLE "public"."public_notice" (
  "id" int8 NOT NULL,
  "type" int2 NOT NULL DEFAULT 0,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "push_time" timestamp(6) NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expire_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."public_notice"."id" IS '公告 id';
COMMENT ON COLUMN "public"."public_notice"."type" IS '公告类型';
COMMENT ON COLUMN "public"."public_notice"."title" IS '公告标题';
COMMENT ON COLUMN "public"."public_notice"."content" IS '公告通知内容，可以存放公告消息模板';
COMMENT ON COLUMN "public"."public_notice"."push_time" IS '公告预期发送时间';
COMMENT ON COLUMN "public"."public_notice"."create_time" IS '通知发布时间';
COMMENT ON COLUMN "public"."public_notice"."expire_time" IS '通知失效时间';
COMMENT ON TABLE "public"."public_notice" IS '公告消息模板表';

-- ----------------------------
-- Records of public_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sms_third_platform
-- ----------------------------
DROP TABLE IF EXISTS "public"."sms_third_platform";
CREATE TABLE "public"."sms_third_platform" (
  "id" int8 NOT NULL DEFAULT nextval('sms_third_platform_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "priority" int4 NOT NULL DEFAULT 0,
  "status" int2 NOT NULL DEFAULT 1,
  "creater" int8,
  "updater" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."sms_third_platform"."id" IS '短信平台 id';
COMMENT ON COLUMN "public"."sms_third_platform"."name" IS '短信平台名称';
COMMENT ON COLUMN "public"."sms_third_platform"."code" IS '短信平台代码，例如：ali';
COMMENT ON COLUMN "public"."sms_third_platform"."priority" IS '数字越小优先级越高，最小为0';
COMMENT ON COLUMN "public"."sms_third_platform"."status" IS '短信平台状态：0-禁用，1-启用';
COMMENT ON COLUMN "public"."sms_third_platform"."creater" IS '创建人';
COMMENT ON COLUMN "public"."sms_third_platform"."updater" IS '更新人';
COMMENT ON COLUMN "public"."sms_third_platform"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sms_third_platform"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sms_third_platform" IS '第三方云通讯平台表';

-- ----------------------------
-- Records of sms_third_platform
-- ----------------------------

-- ----------------------------
-- Table structure for user_inbox
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_inbox";
CREATE TABLE "public"."user_inbox" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "type" int2 NOT NULL DEFAULT 3,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "is_read" bool NOT NULL DEFAULT false,
  "publisher" int8 NOT NULL DEFAULT 0,
  "push_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expire_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."user_inbox"."id" IS '用户通知 id';
COMMENT ON COLUMN "public"."user_inbox"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."user_inbox"."type" IS '通知类型：0-系统通知，1-笔记通知，2-问答通知，3-其它通知';
COMMENT ON COLUMN "public"."user_inbox"."title" IS '通知标题';
COMMENT ON COLUMN "public"."user_inbox"."content" IS '通知或私信内容';
COMMENT ON COLUMN "public"."user_inbox"."is_read" IS '公告是否已读';
COMMENT ON COLUMN "public"."user_inbox"."publisher" IS '通知的发送者id，0则代表是系统';
COMMENT ON COLUMN "public"."user_inbox"."push_time" IS '消息推送时间';
COMMENT ON COLUMN "public"."user_inbox"."expire_time" IS '过期时间，一旦过期用户端不在展示';
COMMENT ON TABLE "public"."user_inbox" IS '用户通知记录表';

-- ----------------------------
-- Records of user_inbox
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sms_third_platform_id_seq"
OWNED BY "public"."sms_third_platform"."id";
SELECT setval('"public"."sms_third_platform_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table message_template
-- ----------------------------
CREATE INDEX "idx_message_template_platform_code" ON "public"."message_template" USING btree (
  "platform_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_message_template_platform_status" ON "public"."message_template" USING btree (
  "platform_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_message_template_status" ON "public"."message_template" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_message_template_template_id" ON "public"."message_template" USING btree (
  "template_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_message_template_third_template_code" ON "public"."message_template" USING btree (
  "third_template_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table message_template
-- ----------------------------
ALTER TABLE "public"."message_template" ADD CONSTRAINT "uk_message_template_platform_third_code" UNIQUE ("platform_code", "third_template_code");

-- ----------------------------
-- Checks structure for table message_template
-- ----------------------------
ALTER TABLE "public"."message_template" ADD CONSTRAINT "message_template_status_check" CHECK (status = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table message_template
-- ----------------------------
ALTER TABLE "public"."message_template" ADD CONSTRAINT "message_template_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table notice_task
-- ----------------------------
CREATE INDEX "idx_notice_task_expire_time" ON "public"."notice_task" USING btree (
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_task_finished" ON "public"."notice_task" USING btree (
  "finished" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_task_partial" ON "public"."notice_task" USING btree (
  "partial" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_task_push_expire" ON "public"."notice_task" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_task_push_finished" ON "public"."notice_task" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "finished" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE finished = false;
CREATE INDEX "idx_notice_task_push_time" ON "public"."notice_task" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_task_template_id" ON "public"."notice_task" USING btree (
  "template_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table notice_task
-- ----------------------------
ALTER TABLE "public"."notice_task" ADD CONSTRAINT "notice_task_interval_check" CHECK ("interval" >= 0);
ALTER TABLE "public"."notice_task" ADD CONSTRAINT "chk_notice_task_time" CHECK (expire_time IS NULL OR expire_time > push_time);
ALTER TABLE "public"."notice_task" ADD CONSTRAINT "notice_task_max_times_check" CHECK (max_times >= 0);

-- ----------------------------
-- Primary Key structure for table notice_task
-- ----------------------------
ALTER TABLE "public"."notice_task" ADD CONSTRAINT "notice_task_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table notice_template
-- ----------------------------
CREATE INDEX "idx_notice_template_code" ON "public"."notice_template" USING btree (
  "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_template_is_sms_template" ON "public"."notice_template" USING btree (
  "is_sms_template" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_template_sms_status" ON "public"."notice_template" USING btree (
  "is_sms_template" "pg_catalog"."bool_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE status = 1;
CREATE INDEX "idx_notice_template_status" ON "public"."notice_template" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_template_type" ON "public"."notice_template" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notice_template_type_status" ON "public"."notice_template" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table notice_template
-- ----------------------------
ALTER TABLE "public"."notice_template" ADD CONSTRAINT "uk_notice_template_code" UNIQUE ("code");

-- ----------------------------
-- Checks structure for table notice_template
-- ----------------------------
ALTER TABLE "public"."notice_template" ADD CONSTRAINT "notice_template_type_check" CHECK (type = ANY (ARRAY[0, 1, 2, 3]));
ALTER TABLE "public"."notice_template" ADD CONSTRAINT "notice_template_status_check" CHECK (status = ANY (ARRAY[0, 1, 2]));

-- ----------------------------
-- Primary Key structure for table notice_template
-- ----------------------------
ALTER TABLE "public"."notice_template" ADD CONSTRAINT "notice_template_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table public_notice
-- ----------------------------
CREATE INDEX "idx_public_notice_create_time" ON "public"."public_notice" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_public_notice_expire_time" ON "public"."public_notice" USING btree (
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_public_notice_push_expire" ON "public"."public_notice" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_public_notice_push_time" ON "public"."public_notice" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_public_notice_type" ON "public"."public_notice" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_public_notice_type_push" ON "public"."public_notice" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table public_notice
-- ----------------------------
ALTER TABLE "public"."public_notice" ADD CONSTRAINT "chk_public_notice_time" CHECK (expire_time IS NULL OR expire_time > push_time);

-- ----------------------------
-- Primary Key structure for table public_notice
-- ----------------------------
ALTER TABLE "public"."public_notice" ADD CONSTRAINT "public_notice_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sms_third_platform
-- ----------------------------
CREATE INDEX "idx_sms_third_platform_code" ON "public"."sms_third_platform" USING btree (
  "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sms_third_platform_create_time" ON "public"."sms_third_platform" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sms_third_platform_priority_status" ON "public"."sms_third_platform" USING btree (
  "priority" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE status = 1;
CREATE INDEX "idx_sms_third_platform_status" ON "public"."sms_third_platform" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table sms_third_platform
-- ----------------------------
ALTER TABLE "public"."sms_third_platform" ADD CONSTRAINT "uk_sms_third_platform_code" UNIQUE ("code");

-- ----------------------------
-- Checks structure for table sms_third_platform
-- ----------------------------
ALTER TABLE "public"."sms_third_platform" ADD CONSTRAINT "sms_third_platform_priority_check" CHECK (priority >= 0);
ALTER TABLE "public"."sms_third_platform" ADD CONSTRAINT "sms_third_platform_status_check" CHECK (status = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table sms_third_platform
-- ----------------------------
ALTER TABLE "public"."sms_third_platform" ADD CONSTRAINT "sms_third_platform_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table user_inbox
-- ----------------------------
CREATE INDEX "idx_user_inbox_expire_time" ON "public"."user_inbox" USING btree (
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_inbox_is_read" ON "public"."user_inbox" USING btree (
  "is_read" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_inbox_push_time" ON "public"."user_inbox" USING btree (
  "push_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_inbox_type" ON "public"."user_inbox" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_inbox_user_id" ON "public"."user_inbox" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_inbox_user_read_expire" ON "public"."user_inbox" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "is_read" "pg_catalog"."bool_ops" ASC NULLS LAST,
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE is_read = false AND expire_time IS NULL;
CREATE INDEX "idx_user_inbox_user_read_has_expire" ON "public"."user_inbox" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "is_read" "pg_catalog"."bool_ops" ASC NULLS LAST,
  "expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE is_read = false AND expire_time IS NOT NULL;
CREATE INDEX "idx_user_inbox_user_type" ON "public"."user_inbox" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table user_inbox
-- ----------------------------
ALTER TABLE "public"."user_inbox" ADD CONSTRAINT "chk_user_inbox_time" CHECK (expire_time IS NULL OR expire_time > push_time);
ALTER TABLE "public"."user_inbox" ADD CONSTRAINT "user_inbox_type_check" CHECK (type = ANY (ARRAY[0, 1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table user_inbox
-- ----------------------------
ALTER TABLE "public"."user_inbox" ADD CONSTRAINT "user_inbox_pkey" PRIMARY KEY ("id");
