package com.tianji.auth.domain.vo;

import com.tianji.auth.domain.po.Privilege;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "API 权限选项实体")
public class PrivilegeOptionVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description="权限 id", example = "1")
    private Long id;
    @Schema(description="权限说明", example = "新增员工")
    private String intro;
    @Schema(description="是否选中", example = "true")
    private Boolean checked;

    public PrivilegeOptionVO(Privilege privilege) {
    }
}
