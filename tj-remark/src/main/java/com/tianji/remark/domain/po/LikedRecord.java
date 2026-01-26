package com.tianji.remark.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serial;
import java.time.LocalDateTime;
import java.io.Serializable;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 点赞记录表
 * </p>
 *
 * @author fenny
 * @since 2023-11-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("liked_record")
@Schema(name="LikedRecord 对象", description="点赞记录表")
public class LikedRecord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description="主键 id")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    @Schema(description="用户 id")
    private Long userId;

    @Schema(description="点赞的业务 id")
    private Long bizId;

    @Schema(description="点赞的业务类型")
    private String bizType;

    @Schema(description="创建时间")
    private LocalDateTime createTime;

    @Schema(description="更新时间")
    private LocalDateTime updateTime;
}
