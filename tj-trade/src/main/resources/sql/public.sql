/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 180001 (180001)
 Source Host           : localhost:5432
 Source Catalog        : tj_trade
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180001 (180001)
 File Encoding         : 65001

 Date: 01/05/2026 22:21:27
*/


-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS "public"."cart";
CREATE TABLE "public"."cart" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "cover_url" varchar(512) COLLATE "pg_catalog"."default",
  "course_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "price" int4 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."cart"."id" IS '购物车条目 id';
COMMENT ON COLUMN "public"."cart"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."cart"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."cart"."cover_url" IS '课程封面路径';
COMMENT ON COLUMN "public"."cart"."course_name" IS '课程名称';
COMMENT ON COLUMN "public"."cart"."price" IS '单价（单位：分）';
COMMENT ON COLUMN "public"."cart"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."cart"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."cart" IS '购物车条目信息，也就是购物车中的课程';

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS "public"."order";
CREATE TABLE "public"."order" (
  "id" int8 NOT NULL,
  "pay_order_no" int8,
  "user_id" int8 NOT NULL,
  "status" int4 NOT NULL DEFAULT 1,
  "message" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "total_amount" int4 NOT NULL DEFAULT 0,
  "real_amount" int4 NOT NULL DEFAULT 0,
  "discount_amount" int4 NOT NULL DEFAULT 0,
  "pay_channel" varchar(32) COLLATE "pg_catalog"."default",
  "coupon_ids" jsonb,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "pay_time" timestamp(6),
  "close_time" timestamp(6),
  "finish_time" timestamp(6),
  "refund_time" timestamp(6),
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8,
  "deleted" int4 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."order"."id" IS '订单 id';
COMMENT ON COLUMN "public"."order"."pay_order_no" IS '支付交易流水单';
COMMENT ON COLUMN "public"."order"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."order"."status" IS '订单状态，1：待支付，2：已支付，3：已关闭，4：已完成，5：已报名，6：已申请退款';
COMMENT ON COLUMN "public"."order"."message" IS '状态备注';
COMMENT ON COLUMN "public"."order"."total_amount" IS '订单总金额，单位分';
COMMENT ON COLUMN "public"."order"."real_amount" IS '实付金额，单位分';
COMMENT ON COLUMN "public"."order"."discount_amount" IS '优惠金额，单位分';
COMMENT ON COLUMN "public"."order"."pay_channel" IS '支付渠道';
COMMENT ON COLUMN "public"."order"."coupon_ids" IS '优惠券 id 列表';
COMMENT ON COLUMN "public"."order"."create_time" IS '创建订单时间';
COMMENT ON COLUMN "public"."order"."pay_time" IS '支付时间';
COMMENT ON COLUMN "public"."order"."close_time" IS '订单关闭时间';
COMMENT ON COLUMN "public"."order"."finish_time" IS '订单完成时间，支付后30天';
COMMENT ON COLUMN "public"."order"."refund_time" IS '申请退款时间';
COMMENT ON COLUMN "public"."order"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."order"."creater" IS '创建人';
COMMENT ON COLUMN "public"."order"."updater" IS '更新人';
COMMENT ON COLUMN "public"."order"."deleted" IS '逻辑删除：0-未删除，1-已删除';
COMMENT ON TABLE "public"."order" IS '订单表';

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."order_detail";
CREATE TABLE "public"."order_detail" (
  "id" int8 NOT NULL,
  "order_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "price" int4 NOT NULL DEFAULT 0,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cover_url" varchar(512) COLLATE "pg_catalog"."default",
  "valid_duration" int4 DEFAULT 0,
  "course_expire_time" timestamp(6),
  "discount_amount" int4 NOT NULL DEFAULT 0,
  "real_pay_amount" int4 NOT NULL DEFAULT 0,
  "status" int4 NOT NULL DEFAULT 1,
  "refund_status" int4 DEFAULT 1,
  "pay_channel" varchar(32) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."order_detail"."id" IS '订单明细 id';
COMMENT ON COLUMN "public"."order_detail"."order_id" IS '订单id';
COMMENT ON COLUMN "public"."order_detail"."user_id" IS '用户 id';
COMMENT ON COLUMN "public"."order_detail"."course_id" IS '课程 id';
COMMENT ON COLUMN "public"."order_detail"."price" IS '课程价格（单位：分）';
COMMENT ON COLUMN "public"."order_detail"."name" IS '课程名称';
COMMENT ON COLUMN "public"."order_detail"."cover_url" IS '封面地址';
COMMENT ON COLUMN "public"."order_detail"."valid_duration" IS '课程学习有效期，单位：月。从付款时间开始算';
COMMENT ON COLUMN "public"."order_detail"."course_expire_time" IS '课程学习过期时间';
COMMENT ON COLUMN "public"."order_detail"."discount_amount" IS '折扣金额（单位：分）';
COMMENT ON COLUMN "public"."order_detail"."real_pay_amount" IS '实付金额（单位：分）';
COMMENT ON COLUMN "public"."order_detail"."status" IS '订单详情状态，1：待支付，2：已支付，3：已关闭，4：已完成，5：已报名';
COMMENT ON COLUMN "public"."order_detail"."refund_status" IS '1：待审批，2：取消退款，3：同意退款，4：拒绝退款，5：退款成功，6：退款失败';
COMMENT ON COLUMN "public"."order_detail"."pay_channel" IS '支付渠道名称';
COMMENT ON COLUMN "public"."order_detail"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."order_detail"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."order_detail"."creater" IS '创建人';
COMMENT ON COLUMN "public"."order_detail"."updater" IS '更新人';
COMMENT ON TABLE "public"."order_detail" IS '订单明细表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for refund_apply
-- ----------------------------
DROP TABLE IF EXISTS "public"."refund_apply";
CREATE TABLE "public"."refund_apply" (
  "id" int8 NOT NULL,
  "order_detail_id" int8 NOT NULL,
  "order_id" int8 NOT NULL,
  "refund_order_no" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "refund_amount" int4 NOT NULL DEFAULT 0,
  "status" int4 NOT NULL DEFAULT 1,
  "message" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "refund_reason" varchar(128) COLLATE "pg_catalog"."default",
  "question_desc" text COLLATE "pg_catalog"."default",
  "approver" int8,
  "approve_opinion" varchar(512) COLLATE "pg_catalog"."default",
  "remark" varchar(512) COLLATE "pg_catalog"."default",
  "refund_channel" varchar(32) COLLATE "pg_catalog"."default",
  "failed_reason" varchar(512) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "approve_time" timestamp(6),
  "finish_time" timestamp(6),
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "creater" int8,
  "updater" int8
)
;
COMMENT ON COLUMN "public"."refund_apply"."id" IS '退款 id';
COMMENT ON COLUMN "public"."refund_apply"."order_detail_id" IS '订单明细 id';
COMMENT ON COLUMN "public"."refund_apply"."order_id" IS '订单 id';
COMMENT ON COLUMN "public"."refund_apply"."refund_order_no" IS '退款单号，每次退款的唯一标示';
COMMENT ON COLUMN "public"."refund_apply"."user_id" IS '订单所属用户 id';
COMMENT ON COLUMN "public"."refund_apply"."refund_amount" IS '退款金额（单位：分）';
COMMENT ON COLUMN "public"."refund_apply"."status" IS '退款状态，1：待审批，2：取消退款，3：同意退款，4：拒绝退款，5：退款成功，6：退款失败';
COMMENT ON COLUMN "public"."refund_apply"."message" IS '退款状态描述';
COMMENT ON COLUMN "public"."refund_apply"."refund_reason" IS '申请退款原因';
COMMENT ON COLUMN "public"."refund_apply"."question_desc" IS '退款原因描述';
COMMENT ON COLUMN "public"."refund_apply"."approver" IS '审批人 id';
COMMENT ON COLUMN "public"."refund_apply"."approve_opinion" IS '审批意见';
COMMENT ON COLUMN "public"."refund_apply"."remark" IS '审批备注';
COMMENT ON COLUMN "public"."refund_apply"."refund_channel" IS '退款渠道';
COMMENT ON COLUMN "public"."refund_apply"."failed_reason" IS '退款失败原因';
COMMENT ON COLUMN "public"."refund_apply"."create_time" IS '创建退款申请时间';
COMMENT ON COLUMN "public"."refund_apply"."approve_time" IS '审批时间';
COMMENT ON COLUMN "public"."refund_apply"."finish_time" IS '退款完成时间（成功或失败）';
COMMENT ON COLUMN "public"."refund_apply"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."refund_apply"."creater" IS '创建人';
COMMENT ON COLUMN "public"."refund_apply"."updater" IS '更新人';
COMMENT ON TABLE "public"."refund_apply" IS '退款申请表';

-- ----------------------------
-- Records of refund_apply
-- ----------------------------

-- ----------------------------
-- Indexes structure for table cart
-- ----------------------------
CREATE INDEX "idx_cart_create_time" ON "public"."cart" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_cart_user_course" ON "public"."cart" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_cart_user_id" ON "public"."cart" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table cart
-- ----------------------------
ALTER TABLE "public"."cart" ADD CONSTRAINT "uk_user_course" UNIQUE ("user_id", "course_id");

-- ----------------------------
-- Checks structure for table cart
-- ----------------------------
ALTER TABLE "public"."cart" ADD CONSTRAINT "cart_price_check" CHECK (price >= 0);

-- ----------------------------
-- Primary Key structure for table cart
-- ----------------------------
ALTER TABLE "public"."cart" ADD CONSTRAINT "cart_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order
-- ----------------------------
CREATE INDEX "idx_order_coupon_ids" ON "public"."order" USING gin (
  "coupon_ids" "pg_catalog"."jsonb_ops"
);
CREATE INDEX "idx_order_create_time" ON "public"."order" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_order_pay_order_no" ON "public"."order" USING btree (
  "pay_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
) WHERE pay_order_no IS NOT NULL;
CREATE INDEX "idx_order_user_id" ON "public"."order" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_order_user_status" ON "public"."order" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "deleted" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table order
-- ----------------------------
ALTER TABLE "public"."order" ADD CONSTRAINT "order_total_amount_check" CHECK (total_amount >= 0);
ALTER TABLE "public"."order" ADD CONSTRAINT "order_real_amount_check" CHECK (real_amount >= 0);
ALTER TABLE "public"."order" ADD CONSTRAINT "order_discount_amount_check" CHECK (discount_amount >= 0 AND discount_amount <= total_amount);
ALTER TABLE "public"."order" ADD CONSTRAINT "order_amount_logic_check" CHECK (total_amount = (real_amount + discount_amount));
ALTER TABLE "public"."order" ADD CONSTRAINT "order_pay_check" CHECK ((status <> ALL (ARRAY[2, 4, 5])) OR pay_order_no IS NOT NULL AND pay_time IS NOT NULL);
ALTER TABLE "public"."order" ADD CONSTRAINT "order_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4, 5, 6]));

-- ----------------------------
-- Primary Key structure for table order
-- ----------------------------
ALTER TABLE "public"."order" ADD CONSTRAINT "order_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table order_detail
-- ----------------------------
CREATE INDEX "idx_order_detail_expire_time" ON "public"."order_detail" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "course_expire_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE course_expire_time IS NOT NULL;
CREATE INDEX "idx_order_detail_order_id" ON "public"."order_detail" USING btree (
  "order_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_order_detail_refund_status" ON "public"."order_detail" USING btree (
  "refund_status" "pg_catalog"."int4_ops" ASC NULLS LAST
) WHERE refund_status = ANY (ARRAY[1, 3, 5]);
CREATE INDEX "idx_order_detail_status" ON "public"."order_detail" USING btree (
  "order_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "status" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_order_detail_user_course" ON "public"."order_detail" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table order_detail
-- ----------------------------
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4, 5]));
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_refund_status_check" CHECK (refund_status = ANY (ARRAY[1, 2, 3, 4, 5, 6]));
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_discount_check" CHECK (discount_amount >= 0 AND discount_amount <= price);
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_real_pay_check" CHECK (real_pay_amount = (price - discount_amount));
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_expire_check" CHECK (valid_duration = 0 AND course_expire_time IS NULL OR valid_duration > 0 AND course_expire_time IS NOT NULL);
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_price_check" CHECK (price >= 0);

-- ----------------------------
-- Primary Key structure for table order_detail
-- ----------------------------
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "order_detail_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table refund_apply
-- ----------------------------
CREATE INDEX "idx_refund_apply_order_detail_id" ON "public"."refund_apply" USING btree (
  "order_detail_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refund_apply_order_id" ON "public"."refund_apply" USING btree (
  "order_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refund_apply_refund_order_no" ON "public"."refund_apply" USING btree (
  "refund_order_no" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refund_apply_status" ON "public"."refund_apply" USING btree (
  "status" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_refund_apply_user_id" ON "public"."refund_apply" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table refund_apply
-- ----------------------------
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "uk_refund_order_no" UNIQUE ("refund_order_no");

-- ----------------------------
-- Checks structure for table refund_apply
-- ----------------------------
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_approve_check" CHECK ((status <> ALL (ARRAY[3, 4])) OR approver IS NOT NULL AND approve_time IS NOT NULL);
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_finish_check" CHECK ((status <> ALL (ARRAY[5, 6])) OR finish_time IS NOT NULL);
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_failed_check" CHECK (status <> 6 OR failed_reason IS NOT NULL AND failed_reason::text <> ''::text);
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_status_check" CHECK (status = ANY (ARRAY[1, 2, 3, 4, 5, 6]));
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_amount_check" CHECK (refund_amount >= 0);

-- ----------------------------
-- Primary Key structure for table refund_apply
-- ----------------------------
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "refund_apply_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table order_detail
-- ----------------------------
ALTER TABLE "public"."order_detail" ADD CONSTRAINT "fk_order_detail_order" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table refund_apply
-- ----------------------------
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "fk_refund_apply_order" FOREIGN KEY ("order_id") REFERENCES "public"."order" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."refund_apply" ADD CONSTRAINT "fk_refund_apply_order_detail" FOREIGN KEY ("order_detail_id") REFERENCES "public"."order_detail" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
