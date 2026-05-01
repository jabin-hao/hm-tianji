/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_search
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:21:06
*/


-- ----------------------------
-- Table structure for interests
-- ----------------------------
DROP TABLE IF EXISTS "public"."interests";
CREATE TABLE "public"."interests" (
  "id" int8 NOT NULL,
  "interests" varchar(512) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."interests"."id" IS '主键，对应用户id';
COMMENT ON COLUMN "public"."interests"."interests" IS '感兴趣的二级分类id，以逗号分隔，例如：120,220,330';
COMMENT ON COLUMN "public"."interests"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."interests"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."interests" IS '用户兴趣表，保存感兴趣的二级分类id';

-- ----------------------------
-- Records of interests
-- ----------------------------

-- ----------------------------
-- Indexes structure for table interests
-- ----------------------------
CREATE INDEX "idx_interests_category" ON "public"."interests" USING btree (
  "interests" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interests_user_id" ON "public"."interests" USING btree (
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table interests
-- ----------------------------
ALTER TABLE "public"."interests" ADD CONSTRAINT "interests_pkey" PRIMARY KEY ("id");
