/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_course
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:17:37
*/


-- ----------------------------
-- Sequence structure for category3_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."category3_id_seq";
CREATE SEQUENCE "public"."category3_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."category_id_seq";
CREATE SEQUENCE "public"."category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for course_subject_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."course_subject_id_seq";
CREATE SEQUENCE "public"."course_subject_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for course_teacher_draft_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."course_teacher_draft_id_seq";
CREATE SEQUENCE "public"."course_teacher_draft_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for subject_category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."subject_category_id_seq";
CREATE SEQUENCE "public"."subject_category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for subject_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."subject_id_seq";
CREATE SEQUENCE "public"."subject_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for cata_id_and_sub_score
-- ----------------------------
DROP TABLE IF EXISTS "public"."cata_id_and_sub_score";
CREATE TABLE "public"."cata_id_and_sub_score" (
  "cata_id" int8 NOT NULL,
  "subject_id" int8 NOT NULL,
  "score" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."cata_id_and_sub_score"."cata_id" IS '目录id';
COMMENT ON COLUMN "public"."cata_id_and_sub_score"."subject_id" IS '题目id';
COMMENT ON COLUMN "public"."cata_id_and_sub_score"."score" IS '题目对应的分数';
COMMENT ON TABLE "public"."cata_id_and_sub_score" IS '课程练习目录与题目分数关联表';

-- ----------------------------
-- Records of cata_id_and_sub_score
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS "public"."category";
CREATE TABLE "public"."category" (
  "id" int8 NOT NULL DEFAULT nextval('category_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int8 NOT NULL DEFAULT 0,
  "level" int2 NOT NULL,
  "priority" int4 NOT NULL DEFAULT 0,
  "status" int2 NOT NULL DEFAULT 1,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."category"."id" IS '课程分类id';
COMMENT ON COLUMN "public"."category"."name" IS '分类名称';
COMMENT ON COLUMN "public"."category"."parent_id" IS '父分类id，一级分类父id为0';
COMMENT ON COLUMN "public"."category"."level" IS '分类级别，1,2,3：代表一级分类，二级分类，三级分类';
COMMENT ON COLUMN "public"."category"."priority" IS '同级目录优先级，数字越小优先级越高，可以重复';
COMMENT ON COLUMN "public"."category"."status" IS '课程分类状态，1：正常，0：禁用';
COMMENT ON COLUMN "public"."category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."category"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."category"."creater" IS '创建者';
COMMENT ON COLUMN "public"."category"."updater" IS '更新者';
COMMENT ON COLUMN "public"."category"."deleted" IS '逻辑删除标识（0未删，1已删）';
COMMENT ON TABLE "public"."category" IS '课程分类表';

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for category3
-- ----------------------------
DROP TABLE IF EXISTS "public"."category3";
CREATE TABLE "public"."category3" (
  "id" int8 NOT NULL DEFAULT nextval('category3_id_seq'::regclass),
  "first_cate_id" int8,
  "second_cate_id" int8,
  "third_cate_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."category3"."id" IS '关联记录主键ID';
COMMENT ON COLUMN "public"."category3"."first_cate_id" IS '一级分类ID';
COMMENT ON COLUMN "public"."category3"."second_cate_id" IS '二级分类ID';
COMMENT ON COLUMN "public"."category3"."third_cate_id" IS '三级分类ID';
COMMENT ON COLUMN "public"."category3"."create_time" IS '记录创建时间';
COMMENT ON TABLE "public"."category3" IS '三级分类关联表（存储一/二/三级分类ID的映射关系）';

-- ----------------------------
-- Records of category3
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS "public"."course";
CREATE TABLE "public"."course" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "course_type" int2 NOT NULL,
  "cover_url" varchar(500) COLLATE "pg_catalog"."default",
  "first_cate_id" int8,
  "second_cate_id" int8,
  "third_cate_id" int8,
  "free" int2 NOT NULL DEFAULT 1,
  "price" int4,
  "template_type" int2 NOT NULL DEFAULT 1,
  "template_url" varchar(500) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "purchase_start_time" timestamp(6),
  "purchase_end_time" timestamp(6),
  "step" int2 NOT NULL DEFAULT 0,
  "score" int2 DEFAULT 0,
  "media_duration" int4 DEFAULT 0,
  "valid_duration" int2 DEFAULT 0,
  "section_num" int4 DEFAULT 0,
  "dep_id" int8,
  "publish_times" int4 DEFAULT 0,
  "publish_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."course"."id" IS '课程草稿id，对应正式草稿id';
COMMENT ON COLUMN "public"."course"."name" IS '课程名称';
COMMENT ON COLUMN "public"."course"."course_type" IS '课程类型，1：直播课，2：录播课';
COMMENT ON COLUMN "public"."course"."cover_url" IS '封面链接';
COMMENT ON COLUMN "public"."course"."first_cate_id" IS '一级课程分类id';
COMMENT ON COLUMN "public"."course"."second_cate_id" IS '二级课程分类id';
COMMENT ON COLUMN "public"."course"."third_cate_id" IS '三级课程分类id';
COMMENT ON COLUMN "public"."course"."free" IS '售卖方式0付费，1：免费';
COMMENT ON COLUMN "public"."course"."price" IS '课程价格，单位为分';
COMMENT ON COLUMN "public"."course"."template_type" IS '模板类型，1：固定模板，2：自定义模板';
COMMENT ON COLUMN "public"."course"."template_url" IS '自定义模板的连接';
COMMENT ON COLUMN "public"."course"."status" IS '课程状态，1：待上架，2：已上架，3：下架，4：已完结';
COMMENT ON COLUMN "public"."course"."purchase_start_time" IS '课程购买有效期开始时间';
COMMENT ON COLUMN "public"."course"."purchase_end_time" IS '课程购买有效期结束时间';
COMMENT ON COLUMN "public"."course"."step" IS '信息填写进度';
COMMENT ON COLUMN "public"."course"."score" IS '课程评价得分，45代表4.5星';
COMMENT ON COLUMN "public"."course"."media_duration" IS '课程总时长';
COMMENT ON COLUMN "public"."course"."valid_duration" IS '课程有效期，单位月';
COMMENT ON COLUMN "public"."course"."section_num" IS '课程总节数，包括练习';
COMMENT ON COLUMN "public"."course"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course"."publish_times" IS '发布次数';
COMMENT ON COLUMN "public"."course"."publish_time" IS '最近一次发布时间';
COMMENT ON COLUMN "public"."course"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course"."updater" IS '更新人';
COMMENT ON COLUMN "public"."course"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."course" IS '草稿课程表';

-- ----------------------------
-- Records of course
-- ----------------------------

-- ----------------------------
-- Table structure for course_cata_subject
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_cata_subject";
CREATE TABLE "public"."course_cata_subject" (
  "id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "cata_id" int8 NOT NULL,
  "subject_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."course_cata_subject"."id" IS '小节题目关系 id';
COMMENT ON COLUMN "public"."course_cata_subject"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."course_cata_subject"."cata_id" IS '小节 id';
COMMENT ON COLUMN "public"."course_cata_subject"."subject_id" IS '题目 id';
COMMENT ON TABLE "public"."course_cata_subject" IS '课程-题目关系表草稿';

-- ----------------------------
-- Records of course_cata_subject
-- ----------------------------

-- ----------------------------
-- Table structure for course_cata_subject_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_cata_subject_draft";
CREATE TABLE "public"."course_cata_subject_draft" (
  "id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "cata_id" int8 NOT NULL,
  "subject_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."course_cata_subject_draft"."id" IS '小节题目关系 id';
COMMENT ON COLUMN "public"."course_cata_subject_draft"."course_id" IS '课程id';
COMMENT ON COLUMN "public"."course_cata_subject_draft"."cata_id" IS '小节 id';
COMMENT ON COLUMN "public"."course_cata_subject_draft"."subject_id" IS '题目 id';
COMMENT ON COLUMN "public"."course_cata_subject_draft"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."course_cata_subject_draft" IS '课程-题目关系表草稿';

-- ----------------------------
-- Records of course_cata_subject_draft
-- ----------------------------

-- ----------------------------
-- Table structure for course_catalogue
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_catalogue";
CREATE TABLE "public"."course_catalogue" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "trailer" int2 NOT NULL DEFAULT 0,
  "course_id" int8 NOT NULL,
  "type" int2 NOT NULL,
  "parent_catalogue_id" int8 NOT NULL DEFAULT 0,
  "media_id" int8,
  "video_id" int8,
  "video_name" varchar(200) COLLATE "pg_catalog"."default",
  "living_start_time" timestamp(6),
  "living_end_time" timestamp(6),
  "play_back" int2 NOT NULL DEFAULT 0,
  "media_duration" int4 DEFAULT 0,
  "c_index" int4 NOT NULL DEFAULT 0,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."course_catalogue"."id" IS '课程目录 id';
COMMENT ON COLUMN "public"."course_catalogue"."name" IS '目录名称';
COMMENT ON COLUMN "public"."course_catalogue"."trailer" IS '是否支持试看';
COMMENT ON COLUMN "public"."course_catalogue"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."course_catalogue"."type" IS '目录类型1：章，2：节，3：测试';
COMMENT ON COLUMN "public"."course_catalogue"."parent_catalogue_id" IS '所属章id，只有小节和测试有该值，章没有，章默认为0';
COMMENT ON COLUMN "public"."course_catalogue"."media_id" IS '媒资 id';
COMMENT ON COLUMN "public"."course_catalogue"."video_id" IS '视频 id';
COMMENT ON COLUMN "public"."course_catalogue"."video_name" IS '视频名称';
COMMENT ON COLUMN "public"."course_catalogue"."living_start_time" IS '直播开始时间';
COMMENT ON COLUMN "public"."course_catalogue"."living_end_time" IS '直播结束时间';
COMMENT ON COLUMN "public"."course_catalogue"."play_back" IS '是否支持回放';
COMMENT ON COLUMN "public"."course_catalogue"."media_duration" IS '视频时长，以秒为单位';
COMMENT ON COLUMN "public"."course_catalogue"."c_index" IS '用于章节排序';
COMMENT ON COLUMN "public"."course_catalogue"."dep_id" IS '部门id';
COMMENT ON COLUMN "public"."course_catalogue"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_catalogue"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_catalogue"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_catalogue"."updater" IS '更新人';
COMMENT ON COLUMN "public"."course_catalogue"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."course_catalogue" IS '目录草稿表';

-- ----------------------------
-- Records of course_catalogue
-- ----------------------------

-- ----------------------------
-- Table structure for course_catalogue_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_catalogue_draft";
CREATE TABLE "public"."course_catalogue_draft" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "trailer" int2 NOT NULL DEFAULT 0,
  "course_id" int8 NOT NULL,
  "type" int2 NOT NULL,
  "parent_catalogue_id" int8 NOT NULL DEFAULT 0,
  "media_id" int8,
  "video_id" int8,
  "video_name" varchar(200) COLLATE "pg_catalog"."default",
  "living_start_time" timestamp(6),
  "living_end_time" timestamp(6),
  "play_back" int2 NOT NULL DEFAULT 0,
  "c_index" int4 NOT NULL DEFAULT 0,
  "media_duration" int4 DEFAULT 0,
  "can_update" bool NOT NULL DEFAULT true,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."course_catalogue_draft"."id" IS '课程目录 id';
COMMENT ON COLUMN "public"."course_catalogue_draft"."name" IS '目录名称';
COMMENT ON COLUMN "public"."course_catalogue_draft"."trailer" IS '是否支持试看';
COMMENT ON COLUMN "public"."course_catalogue_draft"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."course_catalogue_draft"."type" IS '目录类型1：章节，2：小节，3：测试';
COMMENT ON COLUMN "public"."course_catalogue_draft"."parent_catalogue_id" IS '所属章节 id，只有小节和测试有该值，章节没有，章节默认为0';
COMMENT ON COLUMN "public"."course_catalogue_draft"."media_id" IS '媒资 id';
COMMENT ON COLUMN "public"."course_catalogue_draft"."video_id" IS '视频 id';
COMMENT ON COLUMN "public"."course_catalogue_draft"."video_name" IS '视频名称';
COMMENT ON COLUMN "public"."course_catalogue_draft"."living_start_time" IS '直播开始时间';
COMMENT ON COLUMN "public"."course_catalogue_draft"."living_end_time" IS '直播结束时间';
COMMENT ON COLUMN "public"."course_catalogue_draft"."play_back" IS '是否支持回放';
COMMENT ON COLUMN "public"."course_catalogue_draft"."c_index" IS '用于章节排序';
COMMENT ON COLUMN "public"."course_catalogue_draft"."media_duration" IS '以s为单位';
COMMENT ON COLUMN "public"."course_catalogue_draft"."can_update" IS '是否可以修改，上架后的目录位置不能移动';
COMMENT ON COLUMN "public"."course_catalogue_draft"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_catalogue_draft"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_catalogue_draft"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_catalogue_draft"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_catalogue_draft"."updater" IS '更新人';
COMMENT ON TABLE "public"."course_catalogue_draft" IS '目录草稿表';

-- ----------------------------
-- Records of course_catalogue_draft
-- ----------------------------

-- ----------------------------
-- Table structure for course_content
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_content";
CREATE TABLE "public"."course_content" (
  "id" int8 NOT NULL,
  "course_introduce" text COLLATE "pg_catalog"."default",
  "use_people" text COLLATE "pg_catalog"."default",
  "course_detail" text COLLATE "pg_catalog"."default",
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."course_content"."id" IS '课程内容 id';
COMMENT ON COLUMN "public"."course_content"."course_introduce" IS '课程介绍';
COMMENT ON COLUMN "public"."course_content"."use_people" IS '适用人群';
COMMENT ON COLUMN "public"."course_content"."course_detail" IS '课程详情';
COMMENT ON COLUMN "public"."course_content"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_content"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_content"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_content"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_content"."updater" IS '更新人';
COMMENT ON COLUMN "public"."course_content"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."course_content" IS '课程内容表（存储课程大文本信息）';

-- ----------------------------
-- Records of course_content
-- ----------------------------

-- ----------------------------
-- Table structure for course_content_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_content_draft";
CREATE TABLE "public"."course_content_draft" (
  "id" int8 NOT NULL,
  "course_introduce" text COLLATE "pg_catalog"."default",
  "use_people" text COLLATE "pg_catalog"."default",
  "course_detail" text COLLATE "pg_catalog"."default",
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."course_content_draft"."id" IS '课程内容 id';
COMMENT ON COLUMN "public"."course_content_draft"."course_introduce" IS '课程介绍';
COMMENT ON COLUMN "public"."course_content_draft"."use_people" IS '适用人群';
COMMENT ON COLUMN "public"."course_content_draft"."course_detail" IS '课程详情';
COMMENT ON COLUMN "public"."course_content_draft"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_content_draft"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_content_draft"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_content_draft"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_content_draft"."updater" IS '更新人';
COMMENT ON TABLE "public"."course_content_draft" IS '课程内容草稿表（存储课程大文本信息）';

-- ----------------------------
-- Records of course_content_draft
-- ----------------------------

-- ----------------------------
-- Table structure for course_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_draft";
CREATE TABLE "public"."course_draft" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "course_type" int2 NOT NULL,
  "cover_url" varchar(500) COLLATE "pg_catalog"."default",
  "first_cate_id" int8,
  "second_cate_id" int8,
  "third_cate_id" int8,
  "free" int2 NOT NULL DEFAULT 1,
  "price" int4,
  "template_type" int2 NOT NULL DEFAULT 1,
  "template_url" varchar(500) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "purchase_start_time" timestamp(6),
  "purchase_end_time" timestamp(6),
  "step" int2 NOT NULL DEFAULT 1,
  "score" int2 DEFAULT 0,
  "media_duration" int4 DEFAULT 0,
  "valid_duration" int2 DEFAULT 0,
  "section_num" int4 DEFAULT 0,
  "can_update" bool NOT NULL DEFAULT true,
  "c_version" int4 DEFAULT 0,
  "dep_id" int8,
  "publish_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."course_draft"."id" IS '课程草稿id，对应正式草稿id';
COMMENT ON COLUMN "public"."course_draft"."name" IS '课程名称';
COMMENT ON COLUMN "public"."course_draft"."course_type" IS '课程类型，1：直播课，2：录播课';
COMMENT ON COLUMN "public"."course_draft"."cover_url" IS '封面链接';
COMMENT ON COLUMN "public"."course_draft"."first_cate_id" IS '一级课程分类 id';
COMMENT ON COLUMN "public"."course_draft"."second_cate_id" IS '二级课程分类 id';
COMMENT ON COLUMN "public"."course_draft"."third_cate_id" IS '三级课程分类 id';
COMMENT ON COLUMN "public"."course_draft"."free" IS '售卖方式0付费，1：免费';
COMMENT ON COLUMN "public"."course_draft"."price" IS '课程价格，单位为分';
COMMENT ON COLUMN "public"."course_draft"."template_type" IS '模板类型，1：固定模板，2：自定义模板';
COMMENT ON COLUMN "public"."course_draft"."template_url" IS '自定义模板的连接';
COMMENT ON COLUMN "public"."course_draft"."status" IS '课程状态，1：待上架，2：已上架，3：下架，4：已完结';
COMMENT ON COLUMN "public"."course_draft"."purchase_start_time" IS '课程购买有效期开始时间';
COMMENT ON COLUMN "public"."course_draft"."purchase_end_time" IS '课程购买有效期结束时间';
COMMENT ON COLUMN "public"."course_draft"."step" IS '信息填写进度1：基本信息已经保存，2：课程目录已经保存，3：课程视频已保存，4：课程题目已保存，5：课程老师已经保存';
COMMENT ON COLUMN "public"."course_draft"."score" IS '课程评分，45代表4.5星';
COMMENT ON COLUMN "public"."course_draft"."media_duration" IS '视频总时长';
COMMENT ON COLUMN "public"."course_draft"."valid_duration" IS '课程有效期，单位月';
COMMENT ON COLUMN "public"."course_draft"."section_num" IS '课程总节数';
COMMENT ON COLUMN "public"."course_draft"."can_update" IS '是否可以修改';
COMMENT ON COLUMN "public"."course_draft"."c_version" IS '课程版本号';
COMMENT ON COLUMN "public"."course_draft"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_draft"."publish_time" IS '发布时间';
COMMENT ON COLUMN "public"."course_draft"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_draft"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_draft"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_draft"."updater" IS '更新人';
COMMENT ON TABLE "public"."course_draft" IS '草稿课程表';

-- ----------------------------
-- Records of course_draft
-- ----------------------------

-- ----------------------------
-- Table structure for course_subject
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_subject";
CREATE TABLE "public"."course_subject" (
  "id" int8 NOT NULL DEFAULT nextval('course_subject_id_seq'::regclass),
  "course_id" int8 NOT NULL,
  "subject_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."course_subject"."id" IS '课程题目关系 id';
COMMENT ON COLUMN "public"."course_subject"."course_id" IS '课程ID';
COMMENT ON COLUMN "public"."course_subject"."subject_id" IS '题目ID';
COMMENT ON TABLE "public"."course_subject" IS '课程题目关系列表';

-- ----------------------------
-- Records of course_subject
-- ----------------------------

-- ----------------------------
-- Table structure for course_teacher
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_teacher";
CREATE TABLE "public"."course_teacher" (
  "id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "teacher_id" int8 NOT NULL,
  "is_show" int2 NOT NULL DEFAULT 1,
  "c_index" int4 NOT NULL DEFAULT 0,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."course_teacher"."id" IS '课程老师关系 id';
COMMENT ON COLUMN "public"."course_teacher"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."course_teacher"."teacher_id" IS '老师 id';
COMMENT ON COLUMN "public"."course_teacher"."is_show" IS '用户端是否展示';
COMMENT ON COLUMN "public"."course_teacher"."c_index" IS '序号';
COMMENT ON COLUMN "public"."course_teacher"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_teacher"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_teacher"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_teacher"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_teacher"."updater" IS '更新人';
COMMENT ON COLUMN "public"."course_teacher"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."course_teacher" IS '课程老师关系表草稿';

-- ----------------------------
-- Records of course_teacher
-- ----------------------------

-- ----------------------------
-- Table structure for course_teacher_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."course_teacher_draft";
CREATE TABLE "public"."course_teacher_draft" (
  "id" int8 NOT NULL DEFAULT nextval('course_teacher_draft_id_seq'::regclass),
  "course_id" int8 NOT NULL,
  "teacher_id" int8 NOT NULL,
  "is_show" int2 NOT NULL DEFAULT 1,
  "c_index" int4 NOT NULL DEFAULT 0,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."course_teacher_draft"."id" IS '课程老师关系 id';
COMMENT ON COLUMN "public"."course_teacher_draft"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."course_teacher_draft"."teacher_id" IS '老师 id';
COMMENT ON COLUMN "public"."course_teacher_draft"."is_show" IS '用户端是否展示';
COMMENT ON COLUMN "public"."course_teacher_draft"."c_index" IS '序号';
COMMENT ON COLUMN "public"."course_teacher_draft"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."course_teacher_draft"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."course_teacher_draft"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."course_teacher_draft"."creater" IS '创建人';
COMMENT ON COLUMN "public"."course_teacher_draft"."updater" IS '更新人';
COMMENT ON COLUMN "public"."course_teacher_draft"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."course_teacher_draft" IS '课程老师关系表草稿';

-- ----------------------------
-- Records of course_teacher_draft
-- ----------------------------

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS "public"."subject";
CREATE TABLE "public"."subject" (
  "id" int8 NOT NULL DEFAULT nextval('subject_id_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "subject_type" int2 NOT NULL,
  "difficulty" int2 NOT NULL,
  "option1" text COLLATE "pg_catalog"."default",
  "option2" text COLLATE "pg_catalog"."default",
  "option3" text COLLATE "pg_catalog"."default",
  "option4" text COLLATE "pg_catalog"."default",
  "option5" text COLLATE "pg_catalog"."default",
  "option6" text COLLATE "pg_catalog"."default",
  "option7" text COLLATE "pg_catalog"."default",
  "option8" text COLLATE "pg_catalog"."default",
  "option9" text COLLATE "pg_catalog"."default",
  "option10" text COLLATE "pg_catalog"."default",
  "answer" text COLLATE "pg_catalog"."default",
  "analysis" text COLLATE "pg_catalog"."default",
  "correct_times" int4 NOT NULL DEFAULT 0,
  "score" int4 NOT NULL DEFAULT 0,
  "dep_id" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "use_times" int4 NOT NULL DEFAULT 0,
  "answer_times" int4 NOT NULL DEFAULT 0,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."subject"."id" IS '题目 id';
COMMENT ON COLUMN "public"."subject"."name" IS '题干';
COMMENT ON COLUMN "public"."subject"."subject_type" IS '题目类型，1：单选题，2：多选题，3：不定向选择题，4：判断题，5：主观题';
COMMENT ON COLUMN "public"."subject"."difficulty" IS '难易度，1：简单，2：中等，3：困难';
COMMENT ON COLUMN "public"."subject"."option1" IS '选择题答案1';
COMMENT ON COLUMN "public"."subject"."option2" IS '选择题答案2';
COMMENT ON COLUMN "public"."subject"."option3" IS '选择题答案3';
COMMENT ON COLUMN "public"."subject"."option4" IS '选择题答案4';
COMMENT ON COLUMN "public"."subject"."option5" IS '选择题答案5';
COMMENT ON COLUMN "public"."subject"."option6" IS '选择题答案6';
COMMENT ON COLUMN "public"."subject"."option7" IS '选择题答案7';
COMMENT ON COLUMN "public"."subject"."option8" IS '选择题答案8';
COMMENT ON COLUMN "public"."subject"."option9" IS '选择题答案9';
COMMENT ON COLUMN "public"."subject"."option10" IS '选择题答案10';
COMMENT ON COLUMN "public"."subject"."answer" IS '选择题正确答案1到10，如果有多个答案，中间使用逗号隔开，如果是判断题，1：代表正确，其他代表错误';
COMMENT ON COLUMN "public"."subject"."analysis" IS '答案解析';
COMMENT ON COLUMN "public"."subject"."correct_times" IS '回答正确次数';
COMMENT ON COLUMN "public"."subject"."score" IS '分值';
COMMENT ON COLUMN "public"."subject"."dep_id" IS '部门 id';
COMMENT ON COLUMN "public"."subject"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."subject"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."subject"."use_times" IS '引用次数';
COMMENT ON COLUMN "public"."subject"."answer_times" IS '作答次数';
COMMENT ON COLUMN "public"."subject"."creater" IS '创建人';
COMMENT ON COLUMN "public"."subject"."updater" IS '更新人';
COMMENT ON COLUMN "public"."subject"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."subject" IS '题目表';

-- ----------------------------
-- Records of subject
-- ----------------------------

-- ----------------------------
-- Table structure for subject_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."subject_category";
CREATE TABLE "public"."subject_category" (
  "id" int8 NOT NULL DEFAULT nextval('subject_category_id_seq'::regclass),
  "subject_id" int8 NOT NULL,
  "first_cate_id" int8 NOT NULL,
  "second_cate_id" int8 NOT NULL DEFAULT 0,
  "third_cate_id" int8 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."subject_category"."id" IS '主键id';
COMMENT ON COLUMN "public"."subject_category"."subject_id" IS '题目 id';
COMMENT ON COLUMN "public"."subject_category"."first_cate_id" IS '一级课程分类 id';
COMMENT ON COLUMN "public"."subject_category"."second_cate_id" IS '二级课程分类 id';
COMMENT ON COLUMN "public"."subject_category"."third_cate_id" IS '三级课程分类 id';
COMMENT ON TABLE "public"."subject_category" IS '课程分类关系表';

-- ----------------------------
-- Records of subject_category
-- ----------------------------

-- ----------------------------
-- Table structure for subject_use_num
-- ----------------------------
DROP TABLE IF EXISTS "public"."subject_use_num";
CREATE TABLE "public"."subject_use_num" (
  "id" int8 NOT NULL,
  "num" int4 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."subject_use_num"."id" IS '关联题目/分类等维度的ID';
COMMENT ON COLUMN "public"."subject_use_num"."num" IS '使用次数';
COMMENT ON TABLE "public"."subject_use_num" IS '题目使用次数统计表';

-- ----------------------------
-- Records of subject_use_num
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."category3_id_seq"
OWNED BY "public"."category3"."id";
SELECT setval('"public"."category3_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."category_id_seq"
OWNED BY "public"."category"."id";
SELECT setval('"public"."category_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."course_subject_id_seq"
OWNED BY "public"."course_subject"."id";
SELECT setval('"public"."course_subject_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."course_teacher_draft_id_seq"
OWNED BY "public"."course_teacher_draft"."id";
SELECT setval('"public"."course_teacher_draft_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."subject_category_id_seq"
OWNED BY "public"."subject_category"."id";
SELECT setval('"public"."subject_category_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."subject_id_seq"
OWNED BY "public"."subject"."id";
SELECT setval('"public"."subject_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table cata_id_and_sub_score
-- ----------------------------
CREATE INDEX "idx_subject_id" ON "public"."cata_id_and_sub_score" USING btree (
  "subject_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table cata_id_and_sub_score
-- ----------------------------
ALTER TABLE "public"."cata_id_and_sub_score" ADD CONSTRAINT "cata_id_and_sub_score_pkey" PRIMARY KEY ("cata_id", "subject_id");

-- ----------------------------
-- Indexes structure for table category
-- ----------------------------
CREATE INDEX "idx_category_deleted" ON "public"."category" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_category_parent_id" ON "public"."category" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_category_status_level" ON "public"."category" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "level" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table category
-- ----------------------------
ALTER TABLE "public"."category" ADD CONSTRAINT "category_status_check" CHECK (status = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."category" ADD CONSTRAINT "category_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."category" ADD CONSTRAINT "category_level_check" CHECK (level = ANY (ARRAY[1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table category
-- ----------------------------
ALTER TABLE "public"."category" ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table category3
-- ----------------------------
CREATE INDEX "idx_category3_first" ON "public"."category3" USING btree (
  "first_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_category3_second" ON "public"."category3" USING btree (
  "second_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_category3_third" ON "public"."category3" USING btree (
  "third_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table category3
-- ----------------------------
ALTER TABLE "public"."category3" ADD CONSTRAINT "uk_category3_ids" UNIQUE ("first_cate_id", "second_cate_id", "third_cate_id");

-- ----------------------------
-- Primary Key structure for table category3
-- ----------------------------
ALTER TABLE "public"."category3" ADD CONSTRAINT "category3_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course
-- ----------------------------
CREATE INDEX "idx_course_cate" ON "public"."course" USING btree (
  "first_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "second_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "third_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_create_time" ON "public"."course" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_dep_deleted" ON "public"."course" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_course_purchase_time" ON "public"."course" USING btree (
  "purchase_start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "purchase_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_status_free" ON "public"."course" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "free" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table course
-- ----------------------------
ALTER TABLE "public"."course" ADD CONSTRAINT "course_free_check" CHECK (free = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course" ADD CONSTRAINT "course_template_type_check" CHECK (template_type = ANY (ARRAY[1, 2]));
ALTER TABLE "public"."course" ADD CONSTRAINT "course_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4]));
ALTER TABLE "public"."course" ADD CONSTRAINT "course_step_check" CHECK (step >= 0 AND step <= 100);
ALTER TABLE "public"."course" ADD CONSTRAINT "course_score_check" CHECK (score >= 0 AND score <= 50);
ALTER TABLE "public"."course" ADD CONSTRAINT "course_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course" ADD CONSTRAINT "chk_course_price" CHECK (free = 0 AND price IS NOT NULL AND price >= 0 OR free = 1);
ALTER TABLE "public"."course" ADD CONSTRAINT "chk_purchase_time" CHECK (purchase_end_time IS NULL OR purchase_start_time IS NULL OR purchase_end_time >= purchase_start_time);
ALTER TABLE "public"."course" ADD CONSTRAINT "course_course_type_check" CHECK (course_type = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table course
-- ----------------------------
ALTER TABLE "public"."course" ADD CONSTRAINT "course_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_cata_subject
-- ----------------------------
CREATE INDEX "idx_course_cata_subject_cata_id" ON "public"."course_cata_subject" USING btree (
  "cata_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_course_cata" ON "public"."course_cata_subject" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "cata_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_course_id" ON "public"."course_cata_subject" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_subject_id" ON "public"."course_cata_subject" USING btree (
  "subject_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_cata_subject
-- ----------------------------
ALTER TABLE "public"."course_cata_subject" ADD CONSTRAINT "uk_course_cata_subject" UNIQUE ("course_id", "cata_id", "subject_id");

-- ----------------------------
-- Primary Key structure for table course_cata_subject
-- ----------------------------
ALTER TABLE "public"."course_cata_subject" ADD CONSTRAINT "course_cata_subject_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_cata_subject_draft
-- ----------------------------
CREATE INDEX "idx_course_cata_subject_draft_cata_id" ON "public"."course_cata_subject_draft" USING btree (
  "cata_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_draft_course_cata" ON "public"."course_cata_subject_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "cata_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_draft_course_id" ON "public"."course_cata_subject_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_draft_create_time" ON "public"."course_cata_subject_draft" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_cata_subject_draft_subject_id" ON "public"."course_cata_subject_draft" USING btree (
  "subject_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_cata_subject_draft
-- ----------------------------
ALTER TABLE "public"."course_cata_subject_draft" ADD CONSTRAINT "uk_course_cata_subject_draft" UNIQUE ("course_id", "cata_id", "subject_id");

-- ----------------------------
-- Primary Key structure for table course_cata_subject_draft
-- ----------------------------
ALTER TABLE "public"."course_cata_subject_draft" ADD CONSTRAINT "course_cata_subject_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_catalogue
-- ----------------------------
CREATE INDEX "idx_course_catalogue_cindex" ON "public"."course_catalogue" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "c_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_course_id" ON "public"."course_catalogue" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_deleted" ON "public"."course_catalogue" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_course_catalogue_parent_id" ON "public"."course_catalogue" USING btree (
  "parent_catalogue_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_type" ON "public"."course_catalogue" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table course_catalogue
-- ----------------------------
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "course_catalogue_trailer_check" CHECK (trailer = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "course_catalogue_type_check" CHECK (type = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "course_catalogue_play_back_check" CHECK (play_back = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "chk_living_time" CHECK (living_end_time IS NULL OR living_start_time IS NULL OR living_end_time >= living_start_time);
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "course_catalogue_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table course_catalogue
-- ----------------------------
ALTER TABLE "public"."course_catalogue" ADD CONSTRAINT "course_catalogue_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_catalogue_draft
-- ----------------------------
CREATE INDEX "idx_course_catalogue_draft_can_update" ON "public"."course_catalogue_draft" USING btree (
  "can_update" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_draft_cindex" ON "public"."course_catalogue_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "c_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_draft_course_id" ON "public"."course_catalogue_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_draft_parent_id" ON "public"."course_catalogue_draft" USING btree (
  "parent_catalogue_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_catalogue_draft_type" ON "public"."course_catalogue_draft" USING btree (
  "type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table course_catalogue_draft
-- ----------------------------
ALTER TABLE "public"."course_catalogue_draft" ADD CONSTRAINT "course_catalogue_draft_trailer_check" CHECK (trailer = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_catalogue_draft" ADD CONSTRAINT "course_catalogue_draft_type_check" CHECK (type = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."course_catalogue_draft" ADD CONSTRAINT "course_catalogue_draft_play_back_check" CHECK (play_back = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_catalogue_draft" ADD CONSTRAINT "chk_living_time_draft" CHECK (living_end_time IS NULL OR living_start_time IS NULL OR living_end_time >= living_start_time);

-- ----------------------------
-- Primary Key structure for table course_catalogue_draft
-- ----------------------------
ALTER TABLE "public"."course_catalogue_draft" ADD CONSTRAINT "course_catalogue_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_content
-- ----------------------------
CREATE INDEX "idx_course_content_create_time" ON "public"."course_content" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_content_deleted" ON "public"."course_content" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_course_content_dep_id" ON "public"."course_content" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table course_content
-- ----------------------------
ALTER TABLE "public"."course_content" ADD CONSTRAINT "course_content_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table course_content
-- ----------------------------
ALTER TABLE "public"."course_content" ADD CONSTRAINT "course_content_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_content_draft
-- ----------------------------
CREATE INDEX "idx_course_content_draft_create_time" ON "public"."course_content_draft" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_content_draft_dep_id" ON "public"."course_content_draft" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_content_draft_update_time" ON "public"."course_content_draft" USING btree (
  "update_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table course_content_draft
-- ----------------------------
ALTER TABLE "public"."course_content_draft" ADD CONSTRAINT "course_content_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_draft
-- ----------------------------
CREATE INDEX "idx_course_draft_can_update" ON "public"."course_draft" USING btree (
  "can_update" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_cate" ON "public"."course_draft" USING btree (
  "first_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "second_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "third_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_create_time" ON "public"."course_draft" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_dep_id" ON "public"."course_draft" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_purchase_time" ON "public"."course_draft" USING btree (
  "purchase_start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "purchase_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_status_free" ON "public"."course_draft" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "free" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_draft_step" ON "public"."course_draft" USING btree (
  "step" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table course_draft
-- ----------------------------
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_free_check" CHECK (free = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_template_type_check" CHECK (template_type = ANY (ARRAY[1, 2]));
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4]));
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_step_check" CHECK (step = ANY (ARRAY[1, 2, 3, 4, 5]));
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_score_check" CHECK (score >= 0 AND score <= 50);
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "chk_course_draft_price" CHECK (free = 0 AND price IS NOT NULL AND price >= 0 OR free = 1);
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "chk_course_draft_purchase_time" CHECK (purchase_end_time IS NULL OR purchase_start_time IS NULL OR purchase_end_time >= purchase_start_time);
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_course_type_check" CHECK (course_type = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table course_draft
-- ----------------------------
ALTER TABLE "public"."course_draft" ADD CONSTRAINT "course_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_subject
-- ----------------------------
CREATE INDEX "idx_course_subject_course_id" ON "public"."course_subject" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_subject_subject_id" ON "public"."course_subject" USING btree (
  "subject_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_subject
-- ----------------------------
ALTER TABLE "public"."course_subject" ADD CONSTRAINT "uk_course_subject" UNIQUE ("course_id", "subject_id");

-- ----------------------------
-- Primary Key structure for table course_subject
-- ----------------------------
ALTER TABLE "public"."course_subject" ADD CONSTRAINT "course_subject_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_teacher
-- ----------------------------
CREATE INDEX "idx_course_teacher_cindex" ON "public"."course_teacher" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "c_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_course_id" ON "public"."course_teacher" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_deleted" ON "public"."course_teacher" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_course_teacher_dep_id" ON "public"."course_teacher" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_teacher_id" ON "public"."course_teacher" USING btree (
  "teacher_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_teacher
-- ----------------------------
ALTER TABLE "public"."course_teacher" ADD CONSTRAINT "uk_course_teacher" UNIQUE ("course_id", "teacher_id");

-- ----------------------------
-- Checks structure for table course_teacher
-- ----------------------------
ALTER TABLE "public"."course_teacher" ADD CONSTRAINT "course_teacher_is_show_check" CHECK (is_show = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_teacher" ADD CONSTRAINT "course_teacher_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table course_teacher
-- ----------------------------
ALTER TABLE "public"."course_teacher" ADD CONSTRAINT "course_teacher_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table course_teacher_draft
-- ----------------------------
CREATE INDEX "idx_course_teacher_draft_cindex" ON "public"."course_teacher_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "c_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_draft_course_id" ON "public"."course_teacher_draft" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_draft_deleted" ON "public"."course_teacher_draft" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_course_teacher_draft_dep_id" ON "public"."course_teacher_draft" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_course_teacher_draft_teacher_id" ON "public"."course_teacher_draft" USING btree (
  "teacher_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table course_teacher_draft
-- ----------------------------
ALTER TABLE "public"."course_teacher_draft" ADD CONSTRAINT "uk_course_teacher_draft" UNIQUE ("course_id", "teacher_id");

-- ----------------------------
-- Checks structure for table course_teacher_draft
-- ----------------------------
ALTER TABLE "public"."course_teacher_draft" ADD CONSTRAINT "course_teacher_draft_is_show_check" CHECK (is_show = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."course_teacher_draft" ADD CONSTRAINT "course_teacher_draft_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table course_teacher_draft
-- ----------------------------
ALTER TABLE "public"."course_teacher_draft" ADD CONSTRAINT "course_teacher_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table subject
-- ----------------------------
CREATE INDEX "idx_subject_create_time" ON "public"."subject" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_deleted" ON "public"."subject" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_subject_dep_id" ON "public"."subject" USING btree (
  "dep_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_difficulty" ON "public"."subject" USING btree (
  "difficulty" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_subject_type" ON "public"."subject" USING btree (
  "subject_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table subject
-- ----------------------------
ALTER TABLE "public"."subject" ADD CONSTRAINT "subject_difficulty_check" CHECK (difficulty = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."subject" ADD CONSTRAINT "subject_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."subject" ADD CONSTRAINT "subject_subject_type_check" CHECK (subject_type = ANY (ARRAY[1, 2, 3, 4, 5]));

-- ----------------------------
-- Primary Key structure for table subject
-- ----------------------------
ALTER TABLE "public"."subject" ADD CONSTRAINT "subject_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table subject_category
-- ----------------------------
CREATE INDEX "idx_subject_category_cate_combination" ON "public"."subject_category" USING btree (
  "first_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "second_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "third_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_category_first_cate" ON "public"."subject_category" USING btree (
  "first_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_category_second_cate" ON "public"."subject_category" USING btree (
  "second_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_category_subject_id" ON "public"."subject_category" USING btree (
  "subject_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_subject_category_third_cate" ON "public"."subject_category" USING btree (
  "third_cate_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table subject_category
-- ----------------------------
ALTER TABLE "public"."subject_category" ADD CONSTRAINT "uk_subject_category" UNIQUE ("subject_id", "first_cate_id", "second_cate_id", "third_cate_id");

-- ----------------------------
-- Primary Key structure for table subject_category
-- ----------------------------
ALTER TABLE "public"."subject_category" ADD CONSTRAINT "subject_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table subject_use_num
-- ----------------------------
CREATE INDEX "idx_subject_use_num_num" ON "public"."subject_use_num" USING btree (
  "num" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table subject_use_num
-- ----------------------------
ALTER TABLE "public"."subject_use_num" ADD CONSTRAINT "subject_use_num_pkey" PRIMARY KEY ("id");
