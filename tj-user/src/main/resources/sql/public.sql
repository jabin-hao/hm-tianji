/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_user
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:21:47
*/


-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "id" int8 NOT NULL,
  "username" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "cell_phone" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL DEFAULT 1,
  "type" int2 NOT NULL DEFAULT 2,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."sys_user"."id" IS '主键';
COMMENT ON COLUMN "public"."sys_user"."username" IS '用户名';
COMMENT ON COLUMN "public"."sys_user"."cell_phone" IS '手机号';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码（加密存储）';
COMMENT ON COLUMN "public"."sys_user"."status" IS '账户状态：0-禁用，1-正常';
COMMENT ON COLUMN "public"."sys_user"."type" IS '用户类型：1-其他员工, 2-普通学员，3-老师';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user"."creater" IS '创建者 id';
COMMENT ON COLUMN "public"."sys_user"."updater" IS '修改者 id';
COMMENT ON TABLE "public"."sys_user" IS '学员用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO "public"."sys_user" VALUES (2018317145732702210, '13165982930', '13165982930', '$2a$10$wCsHQVHTFm8n0SQ6EzNSdeD9iTnrIxhgk7cXdwkzR9jFuwHEFbpDO', 1, 2, '2026-02-02 21:34:40.595708', '2026-02-02 21:34:40.595708', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_detail";
CREATE TABLE "public"."sys_user_detail" (
  "id" int8 NOT NULL,
  "type" int2 NOT NULL DEFAULT 3,
  "name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "gender" int2 DEFAULT 0,
  "icon" varchar(512) COLLATE "pg_catalog"."default",
  "email" varchar(128) COLLATE "pg_catalog"."default",
  "qq" varchar(20) COLLATE "pg_catalog"."default",
  "birthday" date,
  "job" varchar(64) COLLATE "pg_catalog"."default",
  "province" varchar(32) COLLATE "pg_catalog"."default",
  "city" varchar(32) COLLATE "pg_catalog"."default",
  "district" varchar(32) COLLATE "pg_catalog"."default",
  "intro" text COLLATE "pg_catalog"."default",
  "photo" varchar(512) COLLATE "pg_catalog"."default",
  "role_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "dep_id" int8
)
;
COMMENT ON COLUMN "public"."sys_user_detail"."id" IS '关联用户 id';
COMMENT ON COLUMN "public"."sys_user_detail"."type" IS '用户类型：1-员工, 2-普通学员，3-老师';
COMMENT ON COLUMN "public"."sys_user_detail"."name" IS '名字';
COMMENT ON COLUMN "public"."sys_user_detail"."gender" IS '性别：0-男性，1-女性';
COMMENT ON COLUMN "public"."sys_user_detail"."icon" IS '头像地址';
COMMENT ON COLUMN "public"."sys_user_detail"."email" IS '邮箱';
COMMENT ON COLUMN "public"."sys_user_detail"."qq" IS 'QQ 号码';
COMMENT ON COLUMN "public"."sys_user_detail"."birthday" IS '生日';
COMMENT ON COLUMN "public"."sys_user_detail"."job" IS '岗位';
COMMENT ON COLUMN "public"."sys_user_detail"."province" IS '省';
COMMENT ON COLUMN "public"."sys_user_detail"."city" IS '市';
COMMENT ON COLUMN "public"."sys_user_detail"."district" IS '区';
COMMENT ON COLUMN "public"."sys_user_detail"."intro" IS '个人介绍';
COMMENT ON COLUMN "public"."sys_user_detail"."photo" IS '形象照地址';
COMMENT ON COLUMN "public"."sys_user_detail"."role_id" IS '角色 id';
COMMENT ON COLUMN "public"."sys_user_detail"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user_detail"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user_detail"."creater" IS '创建者 id';
COMMENT ON COLUMN "public"."sys_user_detail"."updater" IS '更新者 id';
COMMENT ON COLUMN "public"."sys_user_detail"."dep_id" IS '部门 id';
COMMENT ON TABLE "public"."sys_user_detail" IS '教师详情表（用户扩展信息）';

-- ----------------------------
-- Records of sys_user_detail
-- ----------------------------
INSERT INTO "public"."sys_user_detail" VALUES (2018317145732702210, 3, 'ozLqAfgm', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2026-02-02 21:34:40.595708', '2026-02-02 21:34:40.595708', NULL, NULL, NULL);

-- ----------------------------
-- Indexes structure for table sys_user
-- ----------------------------
CREATE INDEX "idx_user_cell_phone" ON "public"."sys_user" USING btree (
  "cell_phone" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_create_time" ON "public"."sys_user" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_user_type_status" ON "public"."sys_user" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "uk_user_cell_phone" UNIQUE ("cell_phone");

-- ----------------------------
-- Checks structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "user_status_check" CHECK (status = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "user_type_check" CHECK (type = ANY (ARRAY[1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_user_detail
-- ----------------------------
CREATE INDEX "idx_user_detail_address" ON "public"."sys_user_detail" USING btree (
  "province" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "city" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_detail_dep_id" ON "public"."sys_user_detail" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_detail_role_id" ON "public"."sys_user_detail" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_detail_type" ON "public"."sys_user_detail" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table sys_user_detail
-- ----------------------------
ALTER TABLE "public"."sys_user_detail" ADD CONSTRAINT "user_detail_gender_check" CHECK (gender IS NULL OR (gender = ANY (ARRAY[0, 1])));
ALTER TABLE "public"."sys_user_detail" ADD CONSTRAINT "user_detail_type_check" CHECK (type = ANY (ARRAY[1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table sys_user_detail
-- ----------------------------
ALTER TABLE "public"."sys_user_detail" ADD CONSTRAINT "user_detail_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table sys_user_detail
-- ----------------------------
ALTER TABLE "public"."sys_user_detail" ADD CONSTRAINT "fk_user_detail_user" FOREIGN KEY ("id") REFERENCES "public"."sys_user" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
