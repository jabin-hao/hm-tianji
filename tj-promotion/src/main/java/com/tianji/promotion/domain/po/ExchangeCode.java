package com.tianji.promotion.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;

import java.io.Serial;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import com.tianji.promotion.enums.ExchangeCodeStatus;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 兑换码
 * </p>
 *
 * @author fenny
 * @since 2023-12-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("exchange_code")
@Schema(name="ExchangeCode 对象", description="兑换码")
public class ExchangeCode implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "兑换码 id")
    @TableId(value = "id", type = IdType.INPUT)
    private Integer id;

    @Schema(description= "兑换码")
    private String code;

    @Schema(description= "兑换码状态， 1：待兑换，2：已兑换，3：兑换活动已结束")
    private ExchangeCodeStatus status;

    @Schema(description= "兑换人")
    private Long userId;

    @Schema(description= "兑换类型，1：优惠券，以后再添加其它类型")
    private Integer type;

    @Schema(description= "兑换码目标id，例如兑换优惠券，该id则是优惠券的配置id")
    private Long exchangeTargetId;

    @Schema(description= "创建时间")
    private LocalDateTime createTime;

    @Schema(description= "兑换码过期时间")
    private LocalDateTime expiredTime;

    @Schema(description= "更新时间")
    private LocalDateTime updateTime;


}
