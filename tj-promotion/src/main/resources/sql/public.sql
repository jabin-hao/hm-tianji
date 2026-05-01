/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_promotion
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:20:20
*/


-- ----------------------------
-- Sequence structure for coupon_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."coupon_id_seq";
CREATE SEQUENCE "public"."coupon_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for coupon_scope_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."coupon_scope_id_seq";
CREATE SEQUENCE "public"."coupon_scope_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for user_coupon_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_coupon_id_seq";
CREATE SEQUENCE "public"."user_coupon_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS "public"."coupon";
CREATE TABLE "public"."coupon" (
  "id" int8 NOT NULL DEFAULT nextval('coupon_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "type" int2 NOT NULL DEFAULT 1,
  "discount_type" int2 NOT NULL,
  "specific" bool NOT NULL DEFAULT false,
  "discount_value" int4 NOT NULL DEFAULT 0,
  "threshold_amount" int4 NOT NULL DEFAULT 0,
  "max_discount_amount" int4 NOT NULL DEFAULT 0,
  "obtain_way" int2 NOT NULL,
  "issue_begin_time" timestamp(6) NOT NULL,
  "issue_end_time" timestamp(6) NOT NULL,
  "term_days" int4 NOT NULL DEFAULT 0,
  "term_begin_time" timestamp(6),
  "term_end_time" timestamp(6),
  "status" int2 NOT NULL DEFAULT 1,
  "total_num" int4 NOT NULL DEFAULT 0,
  "issue_num" int4 NOT NULL DEFAULT 0,
  "used_num" int4 NOT NULL DEFAULT 0,
  "user_limit" int4 NOT NULL DEFAULT 1,
  "ext_param" jsonb,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."coupon"."id" IS '优惠券 id';
COMMENT ON COLUMN "public"."coupon"."name" IS '优惠券名称，可以和活动名称保持一致';
COMMENT ON COLUMN "public"."coupon"."type" IS '优惠券类型，1：普通券。目前就一种，保留字段';
COMMENT ON COLUMN "public"."coupon"."discount_type" IS '优惠券类型，1：每满减，2：折扣，3：无门槛，4：普通满减';
COMMENT ON COLUMN "public"."coupon"."specific" IS '是否限定作用范围，false：不限定，true：限定。默认false';
COMMENT ON COLUMN "public"."coupon"."discount_value" IS '折扣值，如果是满减则存满减金额，如果是折扣，则存折扣率，8折就是存80';
COMMENT ON COLUMN "public"."coupon"."threshold_amount" IS '使用门槛，0：表示无门槛，其他值：最低消费金额';
COMMENT ON COLUMN "public"."coupon"."max_discount_amount" IS '最高优惠金额，满减最大，0：表示没有限制，不为0，则表示该券有金额的限制';
COMMENT ON COLUMN "public"."coupon"."obtain_way" IS '获取方式：1：手动领取，2：兑换码';
COMMENT ON COLUMN "public"."coupon"."issue_begin_time" IS '开始发放时间';
COMMENT ON COLUMN "public"."coupon"."issue_end_time" IS '结束发放时间';
COMMENT ON COLUMN "public"."coupon"."term_days" IS '优惠券有效期天数，0：表示有效期是指定有效期的';
COMMENT ON COLUMN "public"."coupon"."term_begin_time" IS '优惠券有效期开始时间';
COMMENT ON COLUMN "public"."coupon"."term_end_time" IS '优惠券有效期结束时间';
COMMENT ON COLUMN "public"."coupon"."status" IS '优惠券配置状态，1：待发放，2：未开始   3：进行中，4：已结束，5：暂停';
COMMENT ON COLUMN "public"."coupon"."total_num" IS '总数量，不超过5000';
COMMENT ON COLUMN "public"."coupon"."issue_num" IS '已发行数量，用于判断是否超发';
COMMENT ON COLUMN "public"."coupon"."used_num" IS '已使用数量';
COMMENT ON COLUMN "public"."coupon"."user_limit" IS '每个人限领的数量，默认1';
COMMENT ON COLUMN "public"."coupon"."ext_param" IS '拓展参数字段，保留字段';
COMMENT ON COLUMN "public"."coupon"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."coupon"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."coupon"."creater" IS '创建人';
COMMENT ON COLUMN "public"."coupon"."updater" IS '更新人';
COMMENT ON TABLE "public"."coupon" IS '优惠券的规则信息';

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_scope
-- ----------------------------
DROP TABLE IF EXISTS "public"."coupon_scope";
CREATE TABLE "public"."coupon_scope" (
  "id" int8 NOT NULL DEFAULT nextval('coupon_scope_id_seq'::regclass),
  "type" int4 NOT NULL,
  "coupon_id" int8 NOT NULL,
  "biz_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."coupon_scope"."id" IS '主键id';
COMMENT ON COLUMN "public"."coupon_scope"."type" IS '范围限定类型：1-分类，2-课程，等等';
COMMENT ON COLUMN "public"."coupon_scope"."coupon_id" IS '优惠券 id';
COMMENT ON COLUMN "public"."coupon_scope"."biz_id" IS '优惠券作用范围的业务id，例如分类id、课程id';
COMMENT ON TABLE "public"."coupon_scope" IS '优惠券作用范围信息表';

-- ----------------------------
-- Records of coupon_scope
-- ----------------------------

-- ----------------------------
-- Table structure for exchange_code
-- ----------------------------
DROP TABLE IF EXISTS "public"."exchange_code";
CREATE TABLE "public"."exchange_code" (
  "id" int4 NOT NULL,
  "code" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL DEFAULT 1,
  "user_id" int8,
  "type" int4 NOT NULL DEFAULT 1,
  "exchange_target_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expired_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."exchange_code"."id" IS '兑换码 id';
COMMENT ON COLUMN "public"."exchange_code"."code" IS '兑换码';
COMMENT ON COLUMN "public"."exchange_code"."status" IS '兑换码状态， 1：待兑换，2：已兑换，3：兑换活动已结束';
COMMENT ON COLUMN "public"."exchange_code"."user_id" IS '兑换人';
COMMENT ON COLUMN "public"."exchange_code"."type" IS '兑换类型，1：优惠券，以后再添加其它类型';
COMMENT ON COLUMN "public"."exchange_code"."exchange_target_id" IS '兑换码目标id，例如兑换优惠券，该id则是优惠券的配置id';
COMMENT ON COLUMN "public"."exchange_code"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."exchange_code"."expired_time" IS '兑换码过期时间';
COMMENT ON COLUMN "public"."exchange_code"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."exchange_code" IS '兑换码表';

-- ----------------------------
-- Records of exchange_code
-- ----------------------------

-- ----------------------------
-- Table structure for promotion
-- ----------------------------
DROP TABLE IF EXISTS "public"."promotion";
CREATE TABLE "public"."promotion" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "type" int4 NOT NULL,
  "hot" int4 NOT NULL DEFAULT 0,
  "begin_time" timestamp(6) NOT NULL,
  "end_time" timestamp(6) NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."promotion"."id" IS '促销活动 id';
COMMENT ON COLUMN "public"."promotion"."name" IS '活动名称';
COMMENT ON COLUMN "public"."promotion"."type" IS '促销活动类型：1-优惠券，2-分销';
COMMENT ON COLUMN "public"."promotion"."hot" IS '是否是热门活动：0-false，1-true，默认false';
COMMENT ON COLUMN "public"."promotion"."begin_time" IS '活动开始时间';
COMMENT ON COLUMN "public"."promotion"."end_time" IS '活动结束时间';
COMMENT ON COLUMN "public"."promotion"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."promotion"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."promotion"."creater" IS '创建人';
COMMENT ON COLUMN "public"."promotion"."updater" IS '更新人';
COMMENT ON TABLE "public"."promotion" IS '促销活动表（形式多种多样，例如：优惠券）';

-- ----------------------------
-- Records of promotion
-- ----------------------------

-- ----------------------------
-- Table structure for user_coupon
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_coupon";
CREATE TABLE "public"."user_coupon" (
  "id" int8 NOT NULL DEFAULT nextval('user_coupon_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "coupon_id" int8 NOT NULL,
  "term_begin_time" timestamp(6) NOT NULL,
  "term_end_time" timestamp(6) NOT NULL,
  "used_time" timestamp(6),
  "status" int2 NOT NULL DEFAULT 1,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."user_coupon"."id" IS '用户券 id';
COMMENT ON COLUMN "public"."user_coupon"."user_id" IS '优惠券的拥有者';
COMMENT ON COLUMN "public"."user_coupon"."coupon_id" IS '优惠券模板 id';
COMMENT ON COLUMN "public"."user_coupon"."term_begin_time" IS '优惠券有效期开始时间';
COMMENT ON COLUMN "public"."user_coupon"."term_end_time" IS '优惠券有效期结束时间';
COMMENT ON COLUMN "public"."user_coupon"."used_time" IS '优惠券使用时间（核销时间）';
COMMENT ON COLUMN "public"."user_coupon"."status" IS '优惠券状态，1：未使用，2：已使用，3：已失效';
COMMENT ON COLUMN "public"."user_coupon"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."user_coupon"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."user_coupon" IS '用户领取优惠券的记录，是真正使用的优惠券信息';

-- ----------------------------
-- Records of user_coupon
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."coupon_id_seq"
OWNED BY "public"."coupon"."id";
SELECT setval('"public"."coupon_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."coupon_scope_id_seq"
OWNED BY "public"."coupon_scope"."id";
SELECT setval('"public"."coupon_scope_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_coupon_id_seq"
OWNED BY "public"."user_coupon"."id";
SELECT setval('"public"."user_coupon_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table coupon
-- ----------------------------
CREATE INDEX "idx_coupon_discount_type" ON "public"."coupon" USING btree (
  "discount_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_coupon_issue_time" ON "public"."coupon" USING btree (
  "issue_begin_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "issue_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_coupon_status" ON "public"."coupon" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_coupon_status_issue" ON "public"."coupon" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "issue_begin_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "issue_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE status = 3;

-- ----------------------------
-- Checks structure for table coupon
-- ----------------------------
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_discount_type_check" CHECK (discount_type = ANY (ARRAY[1, 2, 3, 4]));
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_discount_value_check" CHECK (discount_value >= 0);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_threshold_amount_check" CHECK (threshold_amount >= 0);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_max_discount_amount_check" CHECK (max_discount_amount >= 0);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_obtain_way_check" CHECK (obtain_way = ANY (ARRAY[1, 2]));
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_issue_time_check" CHECK (issue_end_time > issue_begin_time);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_term_time_check" CHECK (term_days <> 0 OR term_begin_time IS NULL AND term_end_time IS NULL OR term_end_time > term_begin_time);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4, 5]));
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_total_num_check" CHECK (total_num >= 0 AND total_num <= 5000);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_issue_num_check" CHECK (issue_num >= 0 AND issue_num <= total_num);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_used_num_check" CHECK (used_num >= 0 AND used_num <= issue_num);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_type_check" CHECK (type = 1);
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_user_limit_check" CHECK (user_limit >= 1);

-- ----------------------------
-- Primary Key structure for table coupon
-- ----------------------------
ALTER TABLE "public"."coupon" ADD CONSTRAINT "coupon_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table coupon_scope
-- ----------------------------
CREATE INDEX "idx_coupon_scope_coupon_id" ON "public"."coupon_scope" USING btree (
  "coupon_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_coupon_scope_type_biz" ON "public"."coupon_scope" USING btree (
  "type" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "biz_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table coupon_scope
-- ----------------------------
ALTER TABLE "public"."coupon_scope" ADD CONSTRAINT "uk_coupon_type_biz" UNIQUE ("coupon_id", "type", "biz_id");

-- ----------------------------
-- Checks structure for table coupon_scope
-- ----------------------------
ALTER TABLE "public"."coupon_scope" ADD CONSTRAINT "coupon_scope_type_check" CHECK (type = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table coupon_scope
-- ----------------------------
ALTER TABLE "public"."coupon_scope" ADD CONSTRAINT "coupon_scope_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table exchange_code
-- ----------------------------
CREATE INDEX "idx_exchange_code_code" ON "public"."exchange_code" USING btree (
  "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_exchange_code_status" ON "public"."exchange_code" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_exchange_expired_time" ON "public"."exchange_code" USING btree (
  "expired_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE status = 1;
CREATE INDEX "idx_exchange_target_type" ON "public"."exchange_code" USING btree (
  "exchange_target_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "type" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table exchange_code
-- ----------------------------
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "uk_exchange_code" UNIQUE ("code");

-- ----------------------------
-- Checks structure for table exchange_code
-- ----------------------------
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "exchange_code_time_check" CHECK (expired_time > create_time);
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "exchange_code_user_check" CHECK (status <> 2 OR user_id IS NOT NULL);
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "exchange_code_status_check" CHECK (status = ANY (ARRAY[1, 2, 3]));
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "exchange_code_type_check" CHECK (type = 1);

-- ----------------------------
-- Primary Key structure for table exchange_code
-- ----------------------------
ALTER TABLE "public"."exchange_code" ADD CONSTRAINT "exchange_code_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table promotion
-- ----------------------------
CREATE INDEX "idx_promotion_hot" ON "public"."promotion" USING btree (
  "hot" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE hot = 1;
CREATE INDEX "idx_promotion_time" ON "public"."promotion" USING btree (
  "begin_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_promotion_type" ON "public"."promotion" USING btree (
  "type" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_promotion_type_hot_time" ON "public"."promotion" USING btree (
  "type" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "hot" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "begin_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE type = 1 AND hot = 1;

-- ----------------------------
-- Checks structure for table promotion
-- ----------------------------
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_hot_check" CHECK (hot = ANY (ARRAY[0, 1]));
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_time_check" CHECK (end_time > begin_time);
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_type_check" CHECK (type = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table promotion
-- ----------------------------
ALTER TABLE "public"."promotion" ADD CONSTRAINT "promotion_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table user_coupon
-- ----------------------------
CREATE INDEX "idx_user_coupon_coupon_id" ON "public"."user_coupon" USING btree (
  "coupon_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_coupon_term_time" ON "public"."user_coupon" USING btree (
  "term_begin_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "term_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE status = 1;
CREATE INDEX "idx_user_coupon_user_id" ON "public"."user_coupon" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_coupon_user_status" ON "public"."user_coupon" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table user_coupon
-- ----------------------------
ALTER TABLE "public"."user_coupon" ADD CONSTRAINT "user_coupon_term_time_check" CHECK (term_end_time > term_begin_time);
ALTER TABLE "public"."user_coupon" ADD CONSTRAINT "user_coupon_used_time_check" CHECK (status <> 2 OR used_time IS NOT NULL);
ALTER TABLE "public"."user_coupon" ADD CONSTRAINT "user_coupon_used_in_term_check" CHECK (status <> 2 OR used_time >= term_begin_time AND used_time <= term_end_time);
ALTER TABLE "public"."user_coupon" ADD CONSTRAINT "user_coupon_status_check" CHECK (status = ANY (ARRAY[1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table user_coupon
-- ----------------------------
ALTER TABLE "public"."user_coupon" ADD CONSTRAINT "user_coupon_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table coupon_scope
-- ----------------------------
ALTER TABLE "public"."coupon_scope" ADD CONSTRAINT "fk_coupon_scope_coupon" FOREIGN KEY ("coupon_id") REFERENCES "public"."coupon" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
