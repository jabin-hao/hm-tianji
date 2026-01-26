package com.tianji.learning.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serial;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.tianji.learning.enums.PointsRecordType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 学习积分记录，每个月底清零
 * </p>
 *
 * @author fenny
 * @since 2023-11-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("points_record")
@Schema(name="PointsRecord 对象", description="学习积分记录，每个月底清零")
public class PointsRecord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "积分记录表 id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Schema(description= "用户 id")
    private Long userId;

    @Schema(description= "积分方式：1-课程学习，2-每日签到，3-课程问答， 4-课程笔记，5-课程评价")
    private PointsRecordType type;

    @Schema(description= "积分值")
    private Integer points;

    @Schema(description= "创建时间")
    private LocalDateTime createTime;


}
