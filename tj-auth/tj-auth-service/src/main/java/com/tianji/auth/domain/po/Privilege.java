package com.tianji.auth.domain.po;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.tianji.auth.domain.dto.PrivilegeDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 权限表，包括菜单权限和访问路径权限
 * </p>
 *
 * @author 虎哥
 * @since 2022-07-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("privilege")
public class Privilege implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId
    private Long id;

    /**
     * 菜单 id
     */
    private Long menuId;

    /**
     * 说明
     */
    private String intro;

    /**
     * API 权限的请求方式
     */
    private String method;

    /**
     * API 权限的请求路径
     */
    private String uri;

    /**
     * 是否是内部接口
     */
    private Boolean internal;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 创建者 id
     */

    private Long creater;

    /**
     * 更新者 id
     */

    private Long updater;

    /**
     * 部门 id
     */
    private Long depId;

    /**
     * 逻辑删除，默认0
     */
    private Integer deleted;

    public Privilege() {
    }

    public Privilege(PrivilegeDTO dto) {
        this.id = dto.getId();
        this.menuId = dto.getMenuId();
        this.intro = dto.getIntro();
        this.method = dto.getMethod();
        this.uri = dto.getUri();
        this.internal = dto.getInternal();
    }

    public PrivilegeDTO toDTO(){
        PrivilegeDTO dto = new PrivilegeDTO();
        dto.setId(id);
        dto.setMenuId(menuId);
        dto.setIntro(intro);
        dto.setMethod(method);
        dto.setUri(uri);
        dto.setInternal(internal);
        return dto;
    }
}
