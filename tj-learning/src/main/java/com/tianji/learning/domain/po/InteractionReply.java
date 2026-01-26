package com.tianji.learning.domain.po;

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
 * 互动问题的回答或评论
 * </p>
 *
 * @author fenny
 * @since 2023-11-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("interaction_reply")
@Schema(name="InteractionReply 对象", description="互动问题的回答或评论")
public class InteractionReply implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description= "互动问题的回答 id")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    @Schema(description= "互动问题问题 id")
    private Long questionId;

    @Schema(description= "回复的上级回答 id")
    private Long answerId;

    @Schema(description= "回答者 id")
    private Long userId;

    @Schema(description= "回答内容")
    private String content;

    @Schema(description= "回复的目标用户 id")
    private Long targetUserId;

    @Schema(description= "回复的目标回复 id")
    private Long targetReplyId;

    @Schema(description= "评论数量")
    private Integer replyTimes;

    @Schema(description= "点赞数量")
    private Integer likedTimes;

    @Schema(description= "是否被隐藏，默认false")
    private Boolean hidden;

    @Schema(description= "是否匿名，默认false")
    private Boolean anonymity;

    @Schema(description= "创建时间")
    private LocalDateTime createTime;

    @Schema(description= "更新时间")
    private LocalDateTime updateTime;


}
