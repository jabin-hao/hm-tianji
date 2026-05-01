/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_exam
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:18:30
*/


-- ----------------------------
-- Sequence structure for question_biz_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."question_biz_id_seq";
CREATE SEQUENCE "public"."question_biz_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS "public"."question";
CREATE TABLE "public"."question" (
  "id" int8 NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" int2 NOT NULL,
  "cate_id1" int8 NOT NULL,
  "cate_id2" int8 NOT NULL DEFAULT 0,
  "cate_id3" int8 NOT NULL DEFAULT 0,
  "difficulty" int2 NOT NULL,
  "correct_times" int4 NOT NULL DEFAULT 0,
  "answer_times" int4 NOT NULL DEFAULT 0,
  "score" int4 NOT NULL DEFAULT 0,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."question"."id" IS '题目 id';
COMMENT ON COLUMN "public"."question"."name" IS '题干';
COMMENT ON COLUMN "public"."question"."type" IS '题目类型，1：单选题，2：多选题，3：不定向选择题，4：判断题，5：主观题';
COMMENT ON COLUMN "public"."question"."cate_id1" IS '1级课程分类id';
COMMENT ON COLUMN "public"."question"."cate_id2" IS '2级课程分类id';
COMMENT ON COLUMN "public"."question"."cate_id3" IS '3级课程分类id';
COMMENT ON COLUMN "public"."question"."difficulty" IS '难易度，1：简单，2：中等，3：困难';
COMMENT ON COLUMN "public"."question"."correct_times" IS '回答正确次数';
COMMENT ON COLUMN "public"."question"."answer_times" IS '回答次数';
COMMENT ON COLUMN "public"."question"."score" IS '分值';
COMMENT ON COLUMN "public"."question"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."question"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."question"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."question"."creater" IS '创建人';
COMMENT ON COLUMN "public"."question"."updater" IS '更新人';
COMMENT ON TABLE "public"."question" IS '题目表';

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for question_biz
-- ----------------------------
DROP TABLE IF EXISTS "public"."question_biz";
CREATE TABLE "public"."question_biz" (
  "id" int8 NOT NULL DEFAULT nextval('question_biz_id_seq'::regclass),
  "biz_id" int8 NOT NULL,
  "question_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."question_biz"."id" IS '主键';
COMMENT ON COLUMN "public"."question_biz"."biz_id" IS '业务id，要关联问题的某业务id，例如小节id';
COMMENT ON COLUMN "public"."question_biz"."question_id" IS '问题 id';
COMMENT ON TABLE "public"."question_biz" IS '问题和业务关联表，例如把小节id和问题id关联，一个小节下可以有多个问题';

-- ----------------------------
-- Records of question_biz
-- ----------------------------

-- ----------------------------
-- Table structure for question_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."question_detail";
CREATE TABLE "public"."question_detail" (
  "id" int8 NOT NULL,
  "options" jsonb,
  "answer" text COLLATE "pg_catalog"."default",
  "analysis" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."question_detail"."id" IS '题目 id';
COMMENT ON COLUMN "public"."question_detail"."options" IS '选择题选项，json数组格式';
COMMENT ON COLUMN "public"."question_detail"."answer" IS '选择题正确答案1到10，如果有多个答案，中间使用逗号隔开，如果是判断题，1：代表正确，其他代表错误';
COMMENT ON COLUMN "public"."question_detail"."analysis" IS '答案解析';
COMMENT ON TABLE "public"."question_detail" IS '题目详情表';

-- ----------------------------
-- Records of question_detail
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."question_biz_id_seq"
OWNED BY "public"."question_biz"."id";
SELECT setval('"public"."question_biz_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table question
-- ----------------------------
CREATE INDEX "idx_question_cate_combination" ON "public"."question" USING btree (
  "cate_id1" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "cate_id2" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "cate_id3" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_create_time" ON "public"."question" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_dep_id" ON "public"."question" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_difficulty" ON "public"."question" USING btree (
  "difficulty" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_type" ON "public"."question" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table question
-- ----------------------------
ALTER TABLE "public"."question" ADD CONSTRAINT "question_difficulty_check" CHECK (difficulty = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."question" ADD CONSTRAINT "question_type_check" CHECK (type = ANY (ARRAY[1, 2, 3, 4, 5]));

-- ----------------------------
-- Primary Key structure for table question
-- ----------------------------
ALTER TABLE "public"."question" ADD CONSTRAINT "question_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table question_biz
-- ----------------------------
CREATE INDEX "idx_question_biz_biz_id" ON "public"."question_biz" USING btree (
  "biz_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_biz_question_id" ON "public"."question_biz" USING btree (
  "question_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table question_biz
-- ----------------------------
ALTER TABLE "public"."question_biz" ADD CONSTRAINT "uk_question_biz" UNIQUE ("biz_id", "question_id");

-- ----------------------------
-- Primary Key structure for table question_biz
-- ----------------------------
ALTER TABLE "public"."question_biz" ADD CONSTRAINT "question_biz_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table question_detail
-- ----------------------------
CREATE INDEX "idx_question_detail_answer" ON "public"."question_detail" USING btree (
  "answer" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_question_detail_options" ON "public"."question_detail" USING gin (
  "options" "pg_catalog"."jsonb_ops"
);

-- ----------------------------
-- Primary Key structure for table question_detail
-- ----------------------------
ALTER TABLE "public"."question_detail" ADD CONSTRAINT "question_detail_pkey" PRIMARY KEY ("id");
