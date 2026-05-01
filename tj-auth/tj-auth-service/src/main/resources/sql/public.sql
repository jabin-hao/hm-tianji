/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_auth
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:16:08
*/


-- ----------------------------
-- Sequence structure for account_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."account_role_id_seq";
CREATE SEQUENCE "public"."account_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for login_record_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."login_record_id_seq";
CREATE SEQUENCE "public"."login_record_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for role_menu_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."role_menu_id_seq";
CREATE SEQUENCE "public"."role_menu_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for role_privilege_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."role_privilege_id_seq";
CREATE SEQUENCE "public"."role_privilege_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for account_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."account_role";
CREATE TABLE "public"."account_role" (
  "id" int8 NOT NULL DEFAULT nextval('account_role_id_seq'::regclass),
  "account_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."account_role"."id" IS '主键ID';
COMMENT ON COLUMN "public"."account_role"."account_id" IS '账户id';
COMMENT ON COLUMN "public"."account_role"."role_id" IS '角色id';
COMMENT ON TABLE "public"."account_role" IS '账户、角色关联表';

-- ----------------------------
-- Records of account_role
-- ----------------------------

-- ----------------------------
-- Table structure for login_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."login_record";
CREATE TABLE "public"."login_record" (
  "id" int8 NOT NULL DEFAULT nextval('login_record_id_seq'::regclass),
  "user_id" int8,
  "cell_phone" varchar(20) COLLATE "pg_catalog"."default",
  "login_time" timestamp(6),
  "logout_time" timestamp(6),
  "login_date" date,
  "duration" int8,
  "ipv4" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."login_record"."id" IS '主键';
COMMENT ON COLUMN "public"."login_record"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."login_record"."cell_phone" IS '用户手机号';
COMMENT ON COLUMN "public"."login_record"."login_time" IS '登录时间';
COMMENT ON COLUMN "public"."login_record"."logout_time" IS '登出时间';
COMMENT ON COLUMN "public"."login_record"."login_date" IS '登录日期';
COMMENT ON COLUMN "public"."login_record"."duration" IS '登录时长，单位是秒';
COMMENT ON COLUMN "public"."login_record"."ipv4" IS 'ip 地址';
COMMENT ON TABLE "public"."login_record" IS '登录信息记录表';

-- ----------------------------
-- Records of login_record
-- ----------------------------
INSERT INTO "public"."login_record" VALUES (1, 2018317145732702210, NULL, '2026-02-02 21:52:11.559954', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (2, 2018317145732702210, NULL, '2026-02-02 21:55:41.169882', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (3, 2018317145732702210, NULL, '2026-02-02 21:55:46.556216', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (4, 2018317145732702210, NULL, '2026-02-02 21:59:03.224973', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (5, 2018317145732702210, NULL, '2026-02-02 22:01:06.670494', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (6, 2018317145732702210, NULL, '2026-02-02 22:01:16.03395', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (7, 2018317145732702210, NULL, '2026-02-02 22:02:42.299512', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (8, 2018317145732702210, NULL, '2026-02-02 22:07:17.031686', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (9, 2018317145732702210, NULL, '2026-02-02 22:09:42.231968', NULL, '2026-02-02', NULL, '127.0.0.1');
INSERT INTO "public"."login_record" VALUES (10, 2018317145732702210, NULL, '2026-02-02 22:12:38.191244', NULL, '2026-02-02', NULL, '127.0.0.1');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."menu";
CREATE TABLE "public"."menu" (
  "id" int8 NOT NULL,
  "parent_id" int8 DEFAULT 0,
  "has_children" bool DEFAULT false,
  "label" varchar(100) COLLATE "pg_catalog"."default",
  "path" varchar(255) COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "priority" int4 DEFAULT 127,
  "create_time" timestamp(6),
  "update_time" timestamp(6),
  "creater" int8,
  "updater" int8,
  "dep_id" int8,
  "deleted" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."menu"."id" IS '主键';
COMMENT ON COLUMN "public"."menu"."parent_id" IS '父菜单id，默认0代表没有父菜单';
COMMENT ON COLUMN "public"."menu"."has_children" IS '是否有子菜单，默认false';
COMMENT ON COLUMN "public"."menu"."label" IS '菜单文本';
COMMENT ON COLUMN "public"."menu"."path" IS '菜单路径';
COMMENT ON COLUMN "public"."menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."menu"."priority" IS '顺序优先级，默认127';
COMMENT ON COLUMN "public"."menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."menu"."creater" IS '创建者 id';
COMMENT ON COLUMN "public"."menu"."updater" IS '更新者 id';
COMMENT ON COLUMN "public"."menu"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."menu"."deleted" IS '逻辑删除，默认0';
COMMENT ON TABLE "public"."menu" IS '权限表，包括菜单权限和访问路径权限';

-- ----------------------------
-- Records of menu
-- ----------------------------

-- ----------------------------
-- Table structure for privilege
-- ----------------------------
DROP TABLE IF EXISTS "public"."privilege";
CREATE TABLE "public"."privilege" (
  "id" int8 NOT NULL,
  "menu_id" int8,
  "intro" varchar(255) COLLATE "pg_catalog"."default",
  "method" varchar(20) COLLATE "pg_catalog"."default",
  "uri" varchar(255) COLLATE "pg_catalog"."default",
  "internal" bool,
  "create_time" timestamp(6),
  "update_time" timestamp(6),
  "creater" int8,
  "updater" int8,
  "dep_id" int8,
  "deleted" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."privilege"."id" IS '主键';
COMMENT ON COLUMN "public"."privilege"."menu_id" IS '菜单 id';
COMMENT ON COLUMN "public"."privilege"."intro" IS '说明';
COMMENT ON COLUMN "public"."privilege"."method" IS 'API 权限的请求方式';
COMMENT ON COLUMN "public"."privilege"."uri" IS 'API 权限的请求路径';
COMMENT ON COLUMN "public"."privilege"."internal" IS '是否是内部接口';
COMMENT ON COLUMN "public"."privilege"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."privilege"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."privilege"."creater" IS '创建者 id';
COMMENT ON COLUMN "public"."privilege"."updater" IS '更新者 id';
COMMENT ON COLUMN "public"."privilege"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."privilege"."deleted" IS '逻辑删除，默认0';
COMMENT ON TABLE "public"."privilege" IS '权限表，包括菜单权限和访问路径权限';

-- ----------------------------
-- Records of privilege
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS "public"."role";
CREATE TABLE "public"."role" (
  "id" int8 NOT NULL,
  "code" varchar(50) COLLATE "pg_catalog"."default",
  "name" varchar(100) COLLATE "pg_catalog"."default",
  "type" int2,
  "create_time" timestamp(6),
  "update_time" timestamp(6),
  "creater" int8,
  "updater" int8,
  "dep_id" int8,
  "deleted" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."role"."id" IS '主键';
COMMENT ON COLUMN "public"."role"."code" IS '角色代号，例如：admin';
COMMENT ON COLUMN "public"."role"."name" IS '角色名称';
COMMENT ON COLUMN "public"."role"."type" IS '角色类型：0-固定角色（不可选）1-自定义角色';
COMMENT ON COLUMN "public"."role"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."role"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."role"."creater" IS '创建者id';
COMMENT ON COLUMN "public"."role"."updater" IS '更新者id';
COMMENT ON COLUMN "public"."role"."dep_id" IS '部门id';
COMMENT ON COLUMN "public"."role"."deleted" IS '逻辑删除，默认0';
COMMENT ON TABLE "public"."role" IS '角色表';

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."role_menu";
CREATE TABLE "public"."role_menu" (
  "id" int8 NOT NULL DEFAULT nextval('role_menu_id_seq'::regclass),
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."role_menu"."id" IS '主键';
COMMENT ON COLUMN "public"."role_menu"."role_id" IS '角色 id';
COMMENT ON COLUMN "public"."role_menu"."menu_id" IS '菜单 id';
COMMENT ON TABLE "public"."role_menu" IS '账户、角色关联表（修正：实际为角色-菜单关联表）';

-- ----------------------------
-- Records of role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for role_privilege
-- ----------------------------
DROP TABLE IF EXISTS "public"."role_privilege";
CREATE TABLE "public"."role_privilege" (
  "id" int8 NOT NULL DEFAULT nextval('role_privilege_id_seq'::regclass),
  "role_id" int8 NOT NULL,
  "privilege_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."role_privilege"."id" IS '主键';
COMMENT ON COLUMN "public"."role_privilege"."role_id" IS '角色 id';
COMMENT ON COLUMN "public"."role_privilege"."privilege_id" IS '权限 id';
COMMENT ON TABLE "public"."role_privilege" IS '账户、角色关联表（修正：实际为角色-权限关联表）';

-- ----------------------------
-- Records of role_privilege
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."account_role_id_seq"
OWNED BY "public"."account_role"."id";
SELECT setval('"public"."account_role_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."login_record_id_seq"
OWNED BY "public"."login_record"."id";
SELECT setval('"public"."login_record_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."role_menu_id_seq"
OWNED BY "public"."role_menu"."id";
SELECT setval('"public"."role_menu_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."role_privilege_id_seq"
OWNED BY "public"."role_privilege"."id";
SELECT setval('"public"."role_privilege_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table account_role
-- ----------------------------
CREATE INDEX "idx_account_role_account_id" ON "public"."account_role" USING btree (
  "account_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_account_role_role_id" ON "public"."account_role" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_account_role_unique" ON "public"."account_role" USING btree (
  "account_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table account_role
-- ----------------------------
ALTER TABLE "public"."account_role" ADD CONSTRAINT "account_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table login_record
-- ----------------------------
CREATE INDEX "idx_login_record_cell_phone" ON "public"."login_record" USING btree (
  "cell_phone" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_login_record_date_user" ON "public"."login_record" USING btree (
  "login_date" "pg_catalog"."date_ops" ASC NULLS LAST,
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_login_record_user_id" ON "public"."login_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table login_record
-- ----------------------------
ALTER TABLE "public"."login_record" ADD CONSTRAINT "login_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table menu
-- ----------------------------
CREATE INDEX "idx_menu_dep_deleted" ON "public"."menu" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_menu_parent_id" ON "public"."menu" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_menu_priority" ON "public"."menu" USING btree (
  "priority" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table menu
-- ----------------------------
ALTER TABLE "public"."menu" ADD CONSTRAINT "menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table privilege
-- ----------------------------
CREATE INDEX "idx_privilege_dep_deleted" ON "public"."privilege" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_privilege_menu_id" ON "public"."privilege" USING btree (
  "menu_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_privilege_uri_method" ON "public"."privilege" USING btree (
  "uri" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "method" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table privilege
-- ----------------------------
ALTER TABLE "public"."privilege" ADD CONSTRAINT "privilege_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table role
-- ----------------------------
CREATE INDEX "idx_role_code" ON "public"."role" USING btree (
  "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_role_dep_id" ON "public"."role" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_role_type_deleted" ON "public"."role" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table role
-- ----------------------------
ALTER TABLE "public"."role" ADD CONSTRAINT "role_code_key" UNIQUE ("code");

-- ----------------------------
-- Checks structure for table role
-- ----------------------------
ALTER TABLE "public"."role" ADD CONSTRAINT "chk_role_type" CHECK (type = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table role
-- ----------------------------
ALTER TABLE "public"."role" ADD CONSTRAINT "role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table role_menu
-- ----------------------------
CREATE INDEX "idx_role_menu_menu_id" ON "public"."role_menu" USING btree (
  "menu_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_role_menu_role_id" ON "public"."role_menu" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_role_menu_unique" ON "public"."role_menu" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "menu_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table role_menu
-- ----------------------------
ALTER TABLE "public"."role_menu" ADD CONSTRAINT "role_menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table role_privilege
-- ----------------------------
CREATE INDEX "idx_role_privilege_privilege_id" ON "public"."role_privilege" USING btree (
  "privilege_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_role_privilege_role_id" ON "public"."role_privilege" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_role_privilege_unique" ON "public"."role_privilege" USING btree (
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "privilege_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table role_privilege
-- ----------------------------
ALTER TABLE "public"."role_privilege" ADD CONSTRAINT "role_privilege_pkey" PRIMARY KEY ("id");
