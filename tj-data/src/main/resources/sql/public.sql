/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_data
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:18:06
*/


-- ----------------------------
-- Table structure for course_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_info";
CREATE TABLE "public"."course_info" (
  "category" varchar(100) COLLATE "pg_catalog"."default",
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "new_stu_num" int4 NOT NULL DEFAULT 0,
  "order_amount" numeric(10,2) NOT NULL DEFAULT 0.00
)
;
COMMENT ON COLUMN "public"."course_info"."category" IS '课程分类';
COMMENT ON COLUMN "public"."course_info"."name" IS '课程名称';
COMMENT ON COLUMN "public"."course_info"."new_stu_num" IS '新增学生数量';
COMMENT ON COLUMN "public"."course_info"."order_amount" IS '订单金额';
COMMENT ON TABLE "public"."course_info" IS '课程信息统计表';

-- ----------------------------
-- Records of course_info
-- ----------------------------

-- ----------------------------
-- Table structure for today_data_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."today_data_info";
CREATE TABLE "public"."today_data_info" (
  "visits" numeric(8,2) NOT NULL DEFAULT 0.00,
  "order_amount" numeric(10,2) NOT NULL DEFAULT 0.00,
  "order_num" int4 NOT NULL DEFAULT 0,
  "stu_new_num" int4 NOT NULL DEFAULT 0,
  "stat_date" date NOT NULL DEFAULT CURRENT_DATE
)
;
COMMENT ON COLUMN "public"."today_data_info"."visits" IS '访问量，万次单位';
COMMENT ON COLUMN "public"."today_data_info"."order_amount" IS '今日订单金额,万元单位';
COMMENT ON COLUMN "public"."today_data_info"."order_num" IS '今日订单笔数';
COMMENT ON COLUMN "public"."today_data_info"."stu_new_num" IS '今日新增学员数';
COMMENT ON COLUMN "public"."today_data_info"."stat_date" IS '统计日期（主键）';
COMMENT ON TABLE "public"."today_data_info" IS '今日数据统计信息表';

-- ----------------------------
-- Records of today_data_info
-- ----------------------------

-- ----------------------------
-- Indexes structure for table course_info
-- ----------------------------
CREATE INDEX "idx_course_info_category" ON "public"."course_info" USING btree (
  "category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_info_name" ON "public"."course_info" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_info_new_stu_num" ON "public"."course_info" USING btree (
  "new_stu_num" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_info_order_amount" ON "public"."course_info" USING btree (
  "order_amount" "pg_catalog"."numeric_ops" ASC NULLS LAST
);

-- ----------------------------
-- Indexes structure for table today_data_info
-- ----------------------------
CREATE INDEX "idx_today_data_info_order_amount" ON "public"."today_data_info" USING btree (
  "order_amount" "pg_catalog"."numeric_ops" ASC NULLS LAST
);
CREATE INDEX "idx_today_data_info_stu_new_num" ON "public"."today_data_info" USING btree (
  "stu_new_num" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_today_data_info_visits" ON "public"."today_data_info" USING btree (
  "visits" "pg_catalog"."numeric_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table today_data_info
-- ----------------------------
ALTER TABLE "public"."today_data_info" ADD CONSTRAINT "today_data_info_pkey" PRIMARY KEY ("stat_date");
