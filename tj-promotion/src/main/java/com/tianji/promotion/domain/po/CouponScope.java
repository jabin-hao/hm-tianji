package com.tianji.promotion.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serial;
import java.io.Serializable;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 优惠券作用范围信息
 * </p>
 *
 * @author fenny
 * @since 2023-12-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("coupon_scope")
@Schema(name="CouponScope 对象", description="优惠券作用范围信息")
public class CouponScope implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Schema(description= "范围限定类型：1-分类，2-课程，等等")
    private Integer type;

    @Schema(description= "优惠券 id")
    private Long couponId;

    @Schema(description= "优惠券作用范围的业务id，例如分类id、课程id")
    private Long bizId;


}
