package com.tianji.common.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

@Schema(description = "DTO 基础属性")
public class BaseDTO {
    @Schema(description="创建人 id")
    private Long creater;
    @Schema(description="更新人 id")
    private Long updater;
    @Schema(description="创建时间")
    private LocalDateTime createTime;
    @Schema(description="更新时间")
    private LocalDateTime updateTime;
}
