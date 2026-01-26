package com.tianji.api.dto.course;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(name = "课程分类")
public class CategoryDTO {
    @Schema(name = "课程分类 id")
    private Long id;
    @Schema(name = "课程分类名称")
    private String name;
    @Schema(name = "三级分类数量")
    private Integer thirdCategoryNum;
    @Schema(name = "课程数量")
    private Integer courseNum;
    @Schema(name = "状态", description = "状态：1：正常，2：禁用")
    private Integer status;
    @Schema(name = "状态描述")
    private String statusDesc;
    @Schema(name = "创建时间")
    private LocalDateTime createTime;
    @Schema(name = "更新时间")
    private LocalDateTime updateTime;
    @Schema(name = "排序")
    private Integer index;
    @Schema(name = "父id")
    private Long parentId;
    @Schema(name = "级别")
    private Integer level;
}
