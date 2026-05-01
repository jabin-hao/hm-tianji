/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_learning
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:18:50
*/


-- ----------------------------
-- Sequence structure for points_board_season_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."points_board_season_id_seq";
CREATE SEQUENCE "public"."points_board_season_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for points_record_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."points_record_id_seq";
CREATE SEQUENCE "public"."points_record_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for interaction_question
-- ----------------------------
DROP TABLE IF EXISTS "public"."interaction_question";
CREATE TABLE "public"."interaction_question" (
  "id" int8 NOT NULL,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "course_id" int8 NOT NULL,
  "chapter_id" int8 NOT NULL DEFAULT 0,
  "section_id" int8 NOT NULL DEFAULT 0,
  "user_id" int8 NOT NULL,
  "latest_answer_id" int8,
  "answer_times" int4 NOT NULL DEFAULT 0,
  "anonymity" bool NOT NULL DEFAULT false,
  "hidden" bool NOT NULL DEFAULT false,
  "status" int2 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."interaction_question"."id" IS '主键，互动问题的id';
COMMENT ON COLUMN "public"."interaction_question"."title" IS '互动问题的标题';
COMMENT ON COLUMN "public"."interaction_question"."description" IS '问题描述信息';
COMMENT ON COLUMN "public"."interaction_question"."course_id" IS '所属课程 id';
COMMENT ON COLUMN "public"."interaction_question"."chapter_id" IS '所属课程章 id';
COMMENT ON COLUMN "public"."interaction_question"."section_id" IS '所属课程节 id';
COMMENT ON COLUMN "public"."interaction_question"."user_id" IS '提问学员 id';
COMMENT ON COLUMN "public"."interaction_question"."latest_answer_id" IS '最新的一个回答的 id';
COMMENT ON COLUMN "public"."interaction_question"."answer_times" IS '问题下的回答数量';
COMMENT ON COLUMN "public"."interaction_question"."anonymity" IS '是否匿名，默认false';
COMMENT ON COLUMN "public"."interaction_question"."hidden" IS '是否被隐藏，默认false';
COMMENT ON COLUMN "public"."interaction_question"."status" IS '管理端问题状态：0-未查看，1-已查看';
COMMENT ON COLUMN "public"."interaction_question"."create_time" IS '提问时间';
COMMENT ON COLUMN "public"."interaction_question"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."interaction_question" IS '互动提问的问题表';

-- ----------------------------
-- Records of interaction_question
-- ----------------------------

-- ----------------------------
-- Table structure for interaction_reply
-- ----------------------------
DROP TABLE IF EXISTS "public"."interaction_reply";
CREATE TABLE "public"."interaction_reply" (
  "id" int8 NOT NULL,
  "question_id" int8 NOT NULL,
  "answer_id" int8 NOT NULL DEFAULT 0,
  "user_id" int8 NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "target_user_id" int8 NOT NULL DEFAULT 0,
  "target_reply_id" int8 NOT NULL DEFAULT 0,
  "reply_times" int4 NOT NULL DEFAULT 0,
  "liked_times" int4 NOT NULL DEFAULT 0,
  "hidden" bool NOT NULL DEFAULT false,
  "anonymity" bool NOT NULL DEFAULT false,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."interaction_reply"."id" IS '互动问题的回答 id';
COMMENT ON COLUMN "public"."interaction_reply"."question_id" IS '互动问题问题 id';
COMMENT ON COLUMN "public"."interaction_reply"."answer_id" IS '回复的上级回答 id';
COMMENT ON COLUMN "public"."interaction_reply"."user_id" IS '回答者 id';
COMMENT ON COLUMN "public"."interaction_reply"."content" IS '回答内容';
COMMENT ON COLUMN "public"."interaction_reply"."target_user_id" IS '回复的目标用户 id';
COMMENT ON COLUMN "public"."interaction_reply"."target_reply_id" IS '回复的目标回复 id';
COMMENT ON COLUMN "public"."interaction_reply"."reply_times" IS '评论数量';
COMMENT ON COLUMN "public"."interaction_reply"."liked_times" IS '点赞数量';
COMMENT ON COLUMN "public"."interaction_reply"."hidden" IS '是否被隐藏，默认false';
COMMENT ON COLUMN "public"."interaction_reply"."anonymity" IS '是否匿名，默认false';
COMMENT ON COLUMN "public"."interaction_reply"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."interaction_reply"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."interaction_reply" IS '互动问题的回答或评论表';

-- ----------------------------
-- Records of interaction_reply
-- ----------------------------

-- ----------------------------
-- Table structure for learning_lesson
-- ----------------------------
DROP TABLE IF EXISTS "public"."learning_lesson";
CREATE TABLE "public"."learning_lesson" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "status" int2 DEFAULT 0,
  "week_freq" int2,
  "plan_status" int2 NOT NULL DEFAULT 0,
  "learned_sections" int4 NOT NULL DEFAULT 0,
  "latest_section_id" int8,
  "latest_learn_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expire_time" timestamp(6),
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."learning_lesson"."id" IS '主键';
COMMENT ON COLUMN "public"."learning_lesson"."user_id" IS '学员id';
COMMENT ON COLUMN "public"."learning_lesson"."course_id" IS '课程id';
COMMENT ON COLUMN "public"."learning_lesson"."status" IS '课程状态，0-未学习，1-学习中，2-已学完，3-已失效';
COMMENT ON COLUMN "public"."learning_lesson"."week_freq" IS '每周学习频率，例如每周学习6小节，则频率为6';
COMMENT ON COLUMN "public"."learning_lesson"."plan_status" IS '学习计划状态，0-没有计划，1-计划进行中';
COMMENT ON COLUMN "public"."learning_lesson"."learned_sections" IS '已学习小节数量';
COMMENT ON COLUMN "public"."learning_lesson"."latest_section_id" IS '最近一次学习的小节id';
COMMENT ON COLUMN "public"."learning_lesson"."latest_learn_time" IS '最近一次学习的时间';
COMMENT ON COLUMN "public"."learning_lesson"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."learning_lesson"."expire_time" IS '过期时间';
COMMENT ON COLUMN "public"."learning_lesson"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."learning_lesson" IS '学生课程表';

-- ----------------------------
-- Records of learning_lesson
-- ----------------------------
INSERT INTO "public"."learning_lesson" VALUES (1, 2, 2, 2, 6, 1, 12, 16, '2023-04-11 22:34:45', '2022-08-05 20:02:50', '2023-08-05 20:02:29', '2023-04-19 10:29:29');
INSERT INTO "public"."learning_lesson" VALUES (2, 2, 3, 1, 4, 1, 3, 31, '2023-04-19 11:42:50', '2022-08-06 15:16:48', '2023-08-06 15:16:37', '2023-04-19 11:42:50');
INSERT INTO "public"."learning_lesson" VALUES (1585170299127607297, 129, 2, 0, NULL, 0, 0, 16, '2023-04-11 22:37:05', '2022-12-05 23:00:29', '2023-10-26 15:14:54', '2023-04-11 22:37:05');
INSERT INTO "public"."learning_lesson" VALUES (1601061367207464961, 2, 1549025085494521857, 1, 3, 1, 4, 1550383240983875589, '2023-04-11 16:34:44', '2022-12-09 11:49:11', '2023-12-09 11:49:11', '2023-04-11 16:34:43');

-- ----------------------------
-- Table structure for learning_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."learning_record";
CREATE TABLE "public"."learning_record" (
  "id" int8 NOT NULL,
  "lesson_id" int8 NOT NULL,
  "section_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "moment" int4 NOT NULL DEFAULT 0,
  "finished" bool NOT NULL DEFAULT false,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "finish_time" timestamp(6),
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."learning_record"."id" IS '学习记录的 id';
COMMENT ON COLUMN "public"."learning_record"."lesson_id" IS '对应课表的 id';
COMMENT ON COLUMN "public"."learning_record"."section_id" IS '对应小节的 id';
COMMENT ON COLUMN "public"."learning_record"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."learning_record"."moment" IS '视频的当前观看时间点，单位秒';
COMMENT ON COLUMN "public"."learning_record"."finished" IS '是否完成学习，默认false';
COMMENT ON COLUMN "public"."learning_record"."create_time" IS '第一次观看时间';
COMMENT ON COLUMN "public"."learning_record"."finish_time" IS '完成学习的时间';
COMMENT ON COLUMN "public"."learning_record"."update_time" IS '更新时间（最近一次观看时间）';
COMMENT ON TABLE "public"."learning_record" IS '学习记录表';

-- ----------------------------
-- Records of learning_record
-- ----------------------------

-- ----------------------------
-- Table structure for points_board
-- ----------------------------
DROP TABLE IF EXISTS "public"."points_board";
CREATE TABLE "public"."points_board" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "points" int4 NOT NULL DEFAULT 0,
  "rank" int4 NOT NULL,
  "season" int4 NOT NULL DEFAULT 1
)
;
COMMENT ON COLUMN "public"."points_board"."id" IS '榜单 id';
COMMENT ON COLUMN "public"."points_board"."user_id" IS '学生 id';
COMMENT ON COLUMN "public"."points_board"."points" IS '积分值';
COMMENT ON COLUMN "public"."points_board"."rank" IS '名次，只记录赛季前100';
COMMENT ON COLUMN "public"."points_board"."season" IS '赛季，例如 1,就是第一赛季，2-就是第二赛季';
COMMENT ON TABLE "public"."points_board" IS '学霸天梯榜';

-- ----------------------------
-- Records of points_board
-- ----------------------------

-- ----------------------------
-- Table structure for points_board_season
-- ----------------------------
DROP TABLE IF EXISTS "public"."points_board_season";
CREATE TABLE "public"."points_board_season" (
  "id" int4 NOT NULL DEFAULT nextval('points_board_season_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "begin_time" date NOT NULL,
  "end_time" date NOT NULL
)
;
COMMENT ON COLUMN "public"."points_board_season"."id" IS '自增长id，season标示';
COMMENT ON COLUMN "public"."points_board_season"."name" IS '赛季名称，例如：第1赛季';
COMMENT ON COLUMN "public"."points_board_season"."begin_time" IS '赛季开始时间';
COMMENT ON COLUMN "public"."points_board_season"."end_time" IS '赛季结束时间';
COMMENT ON TABLE "public"."points_board_season" IS '学霸天梯榜赛季配置表';

-- ----------------------------
-- Records of points_board_season
-- ----------------------------

-- ----------------------------
-- Table structure for points_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."points_record";
CREATE TABLE "public"."points_record" (
  "id" int8 NOT NULL DEFAULT nextval('points_record_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "type" int2 NOT NULL,
  "points" int4 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."points_record"."id" IS '积分记录表 id';
COMMENT ON COLUMN "public"."points_record"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."points_record"."type" IS '积分方式：1-课程学习，2-每日签到，3-课程问答， 4-课程笔记，5-课程评价';
COMMENT ON COLUMN "public"."points_record"."points" IS '积分值';
COMMENT ON COLUMN "public"."points_record"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."points_record" IS '学习积分记录，每个月底清零';

-- ----------------------------
-- Records of points_record
-- ----------------------------

-- ----------------------------
-- Function structure for update_learning_lesson_time
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_learning_lesson_time"();
CREATE FUNCTION "public"."update_learning_lesson_time"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
  NEW.update_time = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."points_board_season_id_seq"
OWNED BY "public"."points_board_season"."id";
SELECT setval('"public"."points_board_season_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."points_record_id_seq"
OWNED BY "public"."points_record"."id";
SELECT setval('"public"."points_record_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table interaction_question
-- ----------------------------
CREATE INDEX "idx_interaction_question_chapter_section" ON "public"."interaction_question" USING btree (
  "chapter_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "section_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_question_course_id" ON "public"."interaction_question" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_question_create_time" ON "public"."interaction_question" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_question_hidden" ON "public"."interaction_question" USING btree (
  "hidden" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE hidden = false;
CREATE INDEX "idx_interaction_question_status" ON "public"."interaction_question" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_question_user_id" ON "public"."interaction_question" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table interaction_question
-- ----------------------------
ALTER TABLE "public"."interaction_question" ADD CONSTRAINT "interaction_question_status_check" CHECK (status = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table interaction_question
-- ----------------------------
ALTER TABLE "public"."interaction_question" ADD CONSTRAINT "interaction_question_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table interaction_reply
-- ----------------------------
CREATE INDEX "idx_interaction_reply_answer_id" ON "public"."interaction_reply" USING btree (
  "answer_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_create_time" ON "public"."interaction_reply" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_hidden" ON "public"."interaction_reply" USING btree (
  "hidden" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE hidden = false;
CREATE INDEX "idx_interaction_reply_question_answer" ON "public"."interaction_reply" USING btree (
  "question_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "answer_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_question_id" ON "public"."interaction_reply" USING btree (
  "question_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_target_reply_id" ON "public"."interaction_reply" USING btree (
  "target_reply_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_target_user_id" ON "public"."interaction_reply" USING btree (
  "target_user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_interaction_reply_user_id" ON "public"."interaction_reply" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table interaction_reply
-- ----------------------------
ALTER TABLE "public"."interaction_reply" ADD CONSTRAINT "interaction_reply_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table learning_lesson
-- ----------------------------
CREATE UNIQUE INDEX "idx_user_id" ON "public"."learning_lesson" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table learning_lesson
-- ----------------------------
CREATE TRIGGER "trigger_learning_lesson_update_time" BEFORE UPDATE ON "public"."learning_lesson"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_learning_lesson_time"();

-- ----------------------------
-- Primary Key structure for table learning_lesson
-- ----------------------------
ALTER TABLE "public"."learning_lesson" ADD CONSTRAINT "learning_lesson_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table learning_record
-- ----------------------------
CREATE INDEX "idx_learning_record_create_time" ON "public"."learning_record" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_finished" ON "public"."learning_record" USING btree (
  "finished" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_lesson_id" ON "public"."learning_record" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_lesson_section" ON "public"."learning_record" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "section_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_section_id" ON "public"."learning_record" USING btree (
  "section_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_update_time" ON "public"."learning_record" USING btree (
  "update_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_user_id" ON "public"."learning_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_learning_record_user_lesson" ON "public"."learning_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table learning_record
-- ----------------------------
ALTER TABLE "public"."learning_record" ADD CONSTRAINT "uk_learning_record_user_lesson_section" UNIQUE ("user_id", "lesson_id", "section_id");

-- ----------------------------
-- Primary Key structure for table learning_record
-- ----------------------------
ALTER TABLE "public"."learning_record" ADD CONSTRAINT "learning_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table points_board
-- ----------------------------
CREATE INDEX "idx_points_board_points" ON "public"."points_board" USING btree (
  "points" "pg_catalog"."int4_ops" DESC NULLS FIRST
);
CREATE INDEX "idx_points_board_rank" ON "public"."points_board" USING btree (
  "rank" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_board_season" ON "public"."points_board" USING btree (
  "season" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_board_season_points" ON "public"."points_board" USING btree (
  "season" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "points" "pg_catalog"."int4_ops" DESC NULLS FIRST
);
CREATE INDEX "idx_points_board_season_rank" ON "public"."points_board" USING btree (
  "season" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "rank" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table points_board
-- ----------------------------
ALTER TABLE "public"."points_board" ADD CONSTRAINT "uk_points_board_user_season" UNIQUE ("user_id", "season");

-- ----------------------------
-- Checks structure for table points_board
-- ----------------------------
ALTER TABLE "public"."points_board" ADD CONSTRAINT "points_board_rank_check" CHECK (rank >= 1 AND rank <= 100);

-- ----------------------------
-- Primary Key structure for table points_board
-- ----------------------------
ALTER TABLE "public"."points_board" ADD CONSTRAINT "points_board_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table points_board_season
-- ----------------------------
CREATE INDEX "idx_points_board_season_begin_time" ON "public"."points_board_season" USING btree (
  "begin_time" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_board_season_end_time" ON "public"."points_board_season" USING btree (
  "end_time" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_board_season_time_range" ON "public"."points_board_season" USING btree (
  "begin_time" "pg_catalog"."date_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."date_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table points_board_season
-- ----------------------------
ALTER TABLE "public"."points_board_season" ADD CONSTRAINT "chk_season_time" CHECK (end_time > begin_time);

-- ----------------------------
-- Primary Key structure for table points_board_season
-- ----------------------------
ALTER TABLE "public"."points_board_season" ADD CONSTRAINT "points_board_season_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table points_record
-- ----------------------------
CREATE INDEX "idx_points_record_create_time" ON "public"."points_record" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_record_type" ON "public"."points_record" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_record_type_create_time" ON "public"."points_record" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_record_user_create_time" ON "public"."points_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_points_record_user_id" ON "public"."points_record" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table points_record
-- ----------------------------
ALTER TABLE "public"."points_record" ADD CONSTRAINT "points_record_type_check" CHECK (type = ANY (ARRAY[1, 2, 3, 4, 5]));

-- ----------------------------
-- Primary Key structure for table points_record
-- ----------------------------
ALTER TABLE "public"."points_record" ADD CONSTRAINT "points_record_pkey" PRIMARY KEY ("id");
