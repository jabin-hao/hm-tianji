package com.tianji.learning.domain.po;

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
 * 学霸天梯榜
 * </p>
 *
 * @author fenny
 * @since 2023-11-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("points_board")
@Schema(name="PointsBoard 对象", description="学霸天梯榜")
public class PointsBoard implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "榜单 id")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    @Schema(description= "学生 id")
    private Long userId;

    @Schema(description= "积分值")
    private Integer points;

    @Schema(description= "名次，只记录赛季前100")
    private Integer rank;

    @Schema(description= "赛季，例如 1,就是第一赛季，2-就是第二赛季")
    private Integer season;


}
