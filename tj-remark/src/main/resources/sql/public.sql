/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_remark
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:20:43
*/


-- ----------------------------
-- Table structure for liked_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."liked_record";
CREATE TABLE "public"."liked_record" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "biz_id" int8 NOT NULL,
  "biz_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."liked_record"."id" IS '主键 id';
COMMENT ON COLUMN "public"."liked_record"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."liked_record"."biz_id" IS '点赞的业务 id';
COMMENT ON COLUMN "public"."liked_record"."biz_type" IS '点赞的业务类型';
COMMENT ON COLUMN "public"."liked_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."liked_record"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."liked_record" IS '点赞记录表';

-- ----------------------------
-- Records of liked_record
-- ----------------------------

-- ----------------------------
-- Indexes structure for table liked_record
-- ----------------------------
CREATE INDEX "idx_liked_record_biz_type_biz_id" ON "public"."liked_record" USING btree (
  "biz_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "biz_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_liked_record_user_biz" ON "public"."liked_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "biz_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "biz_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_liked_record_user_id" ON "public"."liked_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table liked_record
-- ----------------------------
ALTER TABLE "public"."liked_record" ADD CONSTRAINT "uk_user_biz_type_biz_id" UNIQUE ("user_id", "biz_type", "biz_id");

-- ----------------------------
-- Primary Key structure for table liked_record
-- ----------------------------
ALTER TABLE "public"."liked_record" ADD CONSTRAINT "liked_record_pkey" PRIMARY KEY ("id");
