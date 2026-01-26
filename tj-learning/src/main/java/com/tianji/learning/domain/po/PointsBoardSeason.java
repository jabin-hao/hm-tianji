package com.tianji.learning.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;

import java.io.Serial;
import java.time.LocalDate;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author fenny
 * @since 2023-11-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("points_board_season")
@Schema(name="PointsBoardSeason 对象", description="")
public class PointsBoardSeason implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "自增长id，season标示")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @Schema(description= "赛季名称，例如：第1赛季")
    private String name;

    @Schema(description= "赛季开始时间")
    private LocalDate beginTime;

    @Schema(description= "赛季结束时间")
    private LocalDate endTime;


}
