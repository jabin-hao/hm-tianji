package com.tianji.promotion.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;

import java.io.Serial;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 促销活动，形式多种多样，例如：优惠券
 * </p>
 *
 * @author fenny
 * @since 2023-12-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("promotion")
@Schema(name="Promotion 对象", description="促销活动，形式多种多样，例如：优惠券")
public class Promotion implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "促销活动 id")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    @Schema(description= "活动名称")
    private String name;

    @Schema(description= "促销活动类型：1-优惠券，2-分销")
    private Integer type;

    @Schema(description= "是否是热门活动：true或false，默认false")
    private Integer hot;

    @Schema(description= "活动开始时间")
    private LocalDateTime beginTime;

    @Schema(description= "活动结束时间")
    private LocalDateTime endTime;

    @Schema(description= "创建时间")
    private LocalDateTime createTime;

    @Schema(description= "更新时间")
    private LocalDateTime updateTime;

    @Schema(description= "创建人")
    private Long creater;

    @Schema(description= "更新人")
    private Long updater;


}
