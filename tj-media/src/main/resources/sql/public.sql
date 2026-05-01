/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_media
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:19:13
*/


-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS "public"."file";
CREATE TABLE "public"."file" (
  "id" int8 NOT NULL,
  "key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "filename" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "request_id" varchar(100) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "platform" int2 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."file"."id" IS '主键，文件id';
COMMENT ON COLUMN "public"."file"."key" IS '文件在云端的唯一标示，例如：aaa.jpg';
COMMENT ON COLUMN "public"."file"."filename" IS '文件上传时的名称';
COMMENT ON COLUMN "public"."file"."request_id" IS '请求 id';
COMMENT ON COLUMN "public"."file"."status" IS '状态：1-待上传 2-已上传,未使用 3-已使用';
COMMENT ON COLUMN "public"."file"."platform" IS '状态：1-腾讯 2-阿里';
COMMENT ON COLUMN "public"."file"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."file"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."file"."creater" IS '创建者';
COMMENT ON COLUMN "public"."file"."updater" IS '更新者';
COMMENT ON COLUMN "public"."file"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."file" IS '文件表，可以是普通文件、图片等';

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS "public"."media";
CREATE TABLE "public"."media" (
  "id" int8 NOT NULL,
  "file_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "filename" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "media_url" text COLLATE "pg_catalog"."default",
  "cover_url" text COLLATE "pg_catalog"."default",
  "duration" float8 NOT NULL DEFAULT 0.0,
  "request_id" varchar(100) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "size" int8 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."media"."id" IS '主键';
COMMENT ON COLUMN "public"."media"."file_id" IS '文件在云端的唯一标示，例如：387702302659783576';
COMMENT ON COLUMN "public"."media"."filename" IS '文件名称';
COMMENT ON COLUMN "public"."media"."media_url" IS '媒体播放地址';
COMMENT ON COLUMN "public"."media"."cover_url" IS '媒体封面地址';
COMMENT ON COLUMN "public"."media"."duration" IS '视频时长，单位秒';
COMMENT ON COLUMN "public"."media"."request_id" IS '请求 id';
COMMENT ON COLUMN "public"."media"."status" IS '状态：1-上传中，2-已上传';
COMMENT ON COLUMN "public"."media"."size" IS '媒资大小，单位字节';
COMMENT ON COLUMN "public"."media"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."media"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."media"."creater" IS '创建者';
COMMENT ON COLUMN "public"."media"."updater" IS '更新者';
COMMENT ON COLUMN "public"."media"."deleted" IS '逻辑删除';
COMMENT ON TABLE "public"."media" IS '媒资表，主要是视频文件';

-- ----------------------------
-- Records of media
-- ----------------------------

-- ----------------------------
-- Indexes structure for table file
-- ----------------------------
CREATE INDEX "idx_file_create_time" ON "public"."file" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_file_deleted" ON "public"."file" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_file_key" ON "public"."file" USING btree (
  "key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_file_platform" ON "public"."file" USING btree (
  "platform" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_file_platform_status" ON "public"."file" USING btree (
  "platform" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_file_status" ON "public"."file" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table file
-- ----------------------------
ALTER TABLE "public"."file" ADD CONSTRAINT "uk_file_key_platform" UNIQUE ("key", "platform");

-- ----------------------------
-- Checks structure for table file
-- ----------------------------
ALTER TABLE "public"."file" ADD CONSTRAINT "file_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."file" ADD CONSTRAINT "file_status_check" CHECK (status = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."file" ADD CONSTRAINT "file_platform_check" CHECK (platform = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table file
-- ----------------------------
ALTER TABLE "public"."file" ADD CONSTRAINT "file_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table media
-- ----------------------------
CREATE INDEX "idx_media_create_time" ON "public"."media" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_media_deleted" ON "public"."media" USING btree (
  "deleted" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = 0;
CREATE INDEX "idx_media_duration" ON "public"."media" USING btree (
  "duration" "pg_catalog"."float8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_media_file_id" ON "public"."media" USING btree (
  "file_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_media_size" ON "public"."media" USING btree (
  "size" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_media_status" ON "public"."media" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table media
-- ----------------------------
ALTER TABLE "public"."media" ADD CONSTRAINT "uk_media_file_id" UNIQUE ("file_id");

-- ----------------------------
-- Checks structure for table media
-- ----------------------------
ALTER TABLE "public"."media" ADD CONSTRAINT "media_status_check" CHECK (status = ANY (ARRAY[1, 2]));
ALTER TABLE "public"."media" ADD CONSTRAINT "media_deleted_check" CHECK (deleted = ANY (ARRAY[0, 1]));

-- ----------------------------
-- Primary Key structure for table media
-- ----------------------------
ALTER TABLE "public"."media" ADD CONSTRAINT "media_pkey" PRIMARY KEY ("id");
