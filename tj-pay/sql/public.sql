/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_pay
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:19:59
*/


-- ----------------------------
-- Sequence structure for pay_channel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pay_channel_id_seq";
CREATE SEQUENCE "public"."pay_channel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for pay_channel
-- ----------------------------
DROP TABLE IF EXISTS "public"."pay_channel";
CREATE TABLE "public"."pay_channel" (
  "id" int8 NOT NULL DEFAULT nextval('pay_channel_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "channel_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "channel_priority" int4 NOT NULL DEFAULT 0,
  "channel_icon" text COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "creater" int8,
  "updater" int8,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."pay_channel"."id" IS '支付渠道 id';
COMMENT ON COLUMN "public"."pay_channel"."name" IS '支付渠道名称（长度限制50）';
COMMENT ON COLUMN "public"."pay_channel"."channel_code" IS '支付渠道编码，用于获取支付实现';
COMMENT ON COLUMN "public"."pay_channel"."channel_priority" IS '渠道优先级，数字越小优先级越高';
COMMENT ON COLUMN "public"."pay_channel"."channel_icon" IS '渠道图标';
COMMENT ON COLUMN "public"."pay_channel"."status" IS '支付渠道状态，1：使用中，2：停用';
COMMENT ON COLUMN "public"."pay_channel"."creater" IS '创建人';
COMMENT ON COLUMN "public"."pay_channel"."updater" IS '更新人';
COMMENT ON COLUMN "public"."pay_channel"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."pay_channel"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."pay_channel" IS '支付渠道表';

-- ----------------------------
-- Records of pay_channel
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS "public"."pay_order";
CREATE TABLE "public"."pay_order" (
  "id" int8 NOT NULL,
  "biz_order_no" int8 NOT NULL,
  "pay_order_no" int8 NOT NULL,
  "biz_user_id" int8 NOT NULL,
  "pay_channel_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "amount" int4 NOT NULL,
  "pay_type" int2 NOT NULL,
  "status" int2 NOT NULL DEFAULT 0,
  "expand_json" jsonb,
  "notify_url" text COLLATE "pg_catalog"."default",
  "notify_times" int4 NOT NULL DEFAULT 0,
  "notify_status" int2 NOT NULL DEFAULT 0,
  "result_code" varchar(50) COLLATE "pg_catalog"."default",
  "result_msg" text COLLATE "pg_catalog"."default",
  "pay_success_time" timestamp(6),
  "pay_over_time" timestamp(6),
  "qr_code_url" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" bool NOT NULL DEFAULT false
)
;
COMMENT ON COLUMN "public"."pay_order"."id" IS '主键id';
COMMENT ON COLUMN "public"."pay_order"."biz_order_no" IS '业务订单号';
COMMENT ON COLUMN "public"."pay_order"."pay_order_no" IS '支付单号';
COMMENT ON COLUMN "public"."pay_order"."biz_user_id" IS '支付用户 id';
COMMENT ON COLUMN "public"."pay_order"."pay_channel_code" IS '支付渠道编码（关联pay_channel表）';
COMMENT ON COLUMN "public"."pay_order"."amount" IS '支付金额，单位为分';
COMMENT ON COLUMN "public"."pay_order"."pay_type" IS '支付类型，1：h5,2:小程序，3：公众号，4：扫码';
COMMENT ON COLUMN "public"."pay_order"."status" IS '支付状态，0：待提交，1:待支付，2：支付成功，3：支付超时或取消';
COMMENT ON COLUMN "public"."pay_order"."expand_json" IS '拓展字段，用于传递不同渠道单独处理的字段（JSON格式）';
COMMENT ON COLUMN "public"."pay_order"."notify_url" IS '业务端回调接口';
COMMENT ON COLUMN "public"."pay_order"."notify_times" IS '业务端回调次数';
COMMENT ON COLUMN "public"."pay_order"."notify_status" IS '回调状态，0：待回调，1：回调成功，2：回调失败';
COMMENT ON COLUMN "public"."pay_order"."result_code" IS '第三方返回业务码';
COMMENT ON COLUMN "public"."pay_order"."result_msg" IS '第三方返回提示信息';
COMMENT ON COLUMN "public"."pay_order"."pay_success_time" IS '支付成功时间';
COMMENT ON COLUMN "public"."pay_order"."pay_over_time" IS '支付超时时间';
COMMENT ON COLUMN "public"."pay_order"."qr_code_url" IS '支付二维码';
COMMENT ON COLUMN "public"."pay_order"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."pay_order"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."pay_order"."creater" IS '创建人';
COMMENT ON COLUMN "public"."pay_order"."updater" IS '更新人';
COMMENT ON COLUMN "public"."pay_order"."deleted" IS '逻辑删除（false-未删除 true-已删除）';
COMMENT ON TABLE "public"."pay_order" IS '支付订单表';

-- ----------------------------
-- Records of pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for refund_order
-- ----------------------------
DROP TABLE IF EXISTS "public"."refund_order";
CREATE TABLE "public"."refund_order" (
  "id" int8 NOT NULL,
  "biz_order_no" int8 NOT NULL,
  "biz_refund_order_no" int8 NOT NULL,
  "pay_order_no" int8 NOT NULL,
  "refund_order_no" int8 NOT NULL,
  "refund_amount" int4 NOT NULL,
  "total_amount" int4 NOT NULL,
  "is_split" bool NOT NULL DEFAULT false,
  "pay_channel_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "result_code" varchar(50) COLLATE "pg_catalog"."default",
  "result_msg" text COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL DEFAULT 1,
  "refund_channel" varchar(50) COLLATE "pg_catalog"."default",
  "notify_failed_times" int4 NOT NULL DEFAULT 0,
  "notify_status" int2 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" bool NOT NULL DEFAULT false
)
;
COMMENT ON COLUMN "public"."refund_order"."id" IS '主键';
COMMENT ON COLUMN "public"."refund_order"."biz_order_no" IS '业务端已支付的订单 id';
COMMENT ON COLUMN "public"."refund_order"."biz_refund_order_no" IS '业务端要退款的订单 id';
COMMENT ON COLUMN "public"."refund_order"."pay_order_no" IS '支付单号，提交给第三方的那个';
COMMENT ON COLUMN "public"."refund_order"."refund_order_no" IS '退款单号，每次退款的唯一标示';
COMMENT ON COLUMN "public"."refund_order"."refund_amount" IS '本次退款金额，单位分';
COMMENT ON COLUMN "public"."refund_order"."total_amount" IS '总金额，单位分';
COMMENT ON COLUMN "public"."refund_order"."is_split" IS '是否是部分退款';
COMMENT ON COLUMN "public"."refund_order"."pay_channel_code" IS '支付渠道编码（关联pay_channel表）';
COMMENT ON COLUMN "public"."refund_order"."result_code" IS '第三方交易编码';
COMMENT ON COLUMN "public"."refund_order"."result_msg" IS '第三方交易信息';
COMMENT ON COLUMN "public"."refund_order"."status" IS '退款状态，1：退款中，2：退款成功，3：退款失败';
COMMENT ON COLUMN "public"."refund_order"."refund_channel" IS '退款渠道';
COMMENT ON COLUMN "public"."refund_order"."notify_failed_times" IS '业务端退款通知失败次数';
COMMENT ON COLUMN "public"."refund_order"."notify_status" IS '退款接口通知状态，0：待通知，1：通知成功，2：通知中，3：通知失败';
COMMENT ON COLUMN "public"."refund_order"."create_time" IS '退款单据创建时间';
COMMENT ON COLUMN "public"."refund_order"."update_time" IS '退款单据修改时间';
COMMENT ON COLUMN "public"."refund_order"."creater" IS '单据创建人，一般手动对账产生的单据才有值';
COMMENT ON COLUMN "public"."refund_order"."updater" IS '单据修改人，一般手动对账产生的单据才有值';
COMMENT ON COLUMN "public"."refund_order"."deleted" IS '逻辑删除（false-未删除 true-已删除）';
COMMENT ON TABLE "public"."refund_order" IS '退款订单表';

-- ----------------------------
-- Records of refund_order
-- ----------------------------

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pay_channel_id_seq"
OWNED BY "public"."pay_channel"."id";
SELECT setval('"public"."pay_channel_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table pay_channel
-- ----------------------------
CREATE INDEX "idx_pay_channel_channel_code" ON "public"."pay_channel" USING btree (
  "channel_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_pay_channel_create_time" ON "public"."pay_channel" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_pay_channel_priority_status" ON "public"."pay_channel" USING btree (
  "channel_priority" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE status = 1;

-- ----------------------------
-- Uniques structure for table pay_channel
-- ----------------------------
ALTER TABLE "public"."pay_channel" ADD CONSTRAINT "uk_pay_channel_code" UNIQUE ("channel_code");

-- ----------------------------
-- Checks structure for table pay_channel
-- ----------------------------
ALTER TABLE "public"."pay_channel" ADD CONSTRAINT "pay_channel_channel_priority_check" CHECK (channel_priority >= 0);
ALTER TABLE "public"."pay_channel" ADD CONSTRAINT "pay_channel_status_check" CHECK (status = ANY (ARRAY[1, 2]));

-- ----------------------------
-- Primary Key structure for table pay_channel
-- ----------------------------
ALTER TABLE "public"."pay_channel" ADD CONSTRAINT "pay_channel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table pay_order
-- ----------------------------
CREATE INDEX "idx_biz_order_no" ON "public"."pay_order" USING btree (
  "biz_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_biz_user_status" ON "public"."pay_order" USING btree (
  "biz_user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_expand_json" ON "public"."pay_order" USING gin (
  "expand_json" "pg_catalog"."jsonb_ops"
);
CREATE INDEX "idx_notify_status" ON "public"."pay_order" USING btree (
  "notify_status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = false;
CREATE INDEX "idx_pay_order_deleted" ON "public"."pay_order" USING btree (
  "deleted" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE deleted = false;
CREATE INDEX "idx_pay_order_no" ON "public"."pay_order" USING btree (
  "pay_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_pay_over_time" ON "public"."pay_order" USING btree (
  "pay_over_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE status = 1;

-- ----------------------------
-- Uniques structure for table pay_order
-- ----------------------------
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "uk_pay_order_no" UNIQUE ("pay_order_no");
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "uk_biz_order_channel_user" UNIQUE ("biz_order_no", "pay_channel_code", "biz_user_id");

-- ----------------------------
-- Checks structure for table pay_order
-- ----------------------------
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_notify_times_check" CHECK (notify_times >= 0);
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_notify_status_check" CHECK (notify_status = ANY (ARRAY[0, 1, 2]));
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "chk_pay_time" CHECK (pay_success_time IS NULL OR pay_over_time IS NULL OR pay_success_time < pay_over_time);
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_amount_check" CHECK (amount >= 0);
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_pay_type_check" CHECK (pay_type = ANY (ARRAY[1, 2, 3, 4]));
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_status_check" CHECK (status = ANY (ARRAY[0, 1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table pay_order
-- ----------------------------
ALTER TABLE "public"."pay_order" ADD CONSTRAINT "pay_order_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table refund_order
-- ----------------------------
CREATE INDEX "idx_biz_order_no_refund" ON "public"."refund_order" USING btree (
  "biz_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_biz_refund_order_no" ON "public"."refund_order" USING btree (
  "biz_refund_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_notify_status_refund" ON "public"."refund_order" USING btree (
  "notify_status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = false;
CREATE INDEX "idx_pay_channel_code_refund" ON "public"."refund_order" USING btree (
  "pay_channel_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_pay_order_no_refund" ON "public"."refund_order" USING btree (
  "pay_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refund_order_deleted" ON "public"."refund_order" USING btree (
  "deleted" "pg_catalog"."bool_ops" ASC NULLS LAST
) WHERE deleted = false;
CREATE INDEX "idx_refund_order_no" ON "public"."refund_order" USING btree (
  "refund_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refund_status" ON "public"."refund_order" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = false;
CREATE INDEX "idx_status_notify_status" ON "public"."refund_order" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "notify_status" "pg_catalog"."int2_ops" ASC NULLS LAST
) WHERE deleted = false;

-- ----------------------------
-- Uniques structure for table refund_order
-- ----------------------------
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "uk_refund_order_no" UNIQUE ("refund_order_no");
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "uk_biz_refund_pay_order" UNIQUE ("biz_refund_order_no", "pay_order_no");

-- ----------------------------
-- Checks structure for table refund_order
-- ----------------------------
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_notify_failed_times_check" CHECK (notify_failed_times >= 0);
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_notify_status_check" CHECK (notify_status = ANY (ARRAY[0, 1, 2, 3]));
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "chk_refund_amount" CHECK (refund_amount <= total_amount);
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_refund_amount_check" CHECK (refund_amount >= 0);
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_total_amount_check" CHECK (total_amount >= 0);
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_status_check" CHECK (status = ANY (ARRAY[1, 2, 3]));

-- ----------------------------
-- Primary Key structure for table refund_order
-- ----------------------------
ALTER TABLE "public"."refund_order" ADD CONSTRAINT "refund_order_pkey" PRIMARY KEY ("id");
