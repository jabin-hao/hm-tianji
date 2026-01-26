package com.tianji.auth.controller;


import cn.hutool.core.collection.CollectionUtil;
import com.tianji.auth.domain.dto.MenuDTO;
import com.tianji.auth.domain.po.Menu;
import com.tianji.auth.domain.vo.MenuOptionVO;
import com.tianji.auth.service.IMenuService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 权限表，包括菜单权限和访问路径权限 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-06-16
 */
@RestController
@RequestMapping("/menus")
@Tag(name = "菜单管理")
@RequiredArgsConstructor
public class MenuController {

    private final IMenuService menuService;

    /**
     * 根据父菜单 id查询子菜单
     * @param pid 父菜单id，如果给 0 就是查询1级菜单
     * @return 菜单集合
     */
    @GetMapping("/parent/{pid}")
    @Operation(description = "根据父菜单 id查询子菜单")
    public List<MenuOptionVO> listMenusByParent(
            @PathVariable @Parameter(name = "父菜单 id", example = "0") Long pid){
        // 1.根据父id查询
        List<Menu> list = menuService.lambdaQuery().eq(Menu::getParentId, pid).list();
        // 2.非空判断
        if (CollectionUtil.isEmpty(list)) {
            return Collections.emptyList();
        }
        // 3.数据转换
        return list.stream().map(MenuOptionVO::new).collect(Collectors.toList());
    }

    @GetMapping("{id}")
    @Operation(description = "根据 id查询菜单")
    public MenuOptionVO getMenuById(@PathVariable @Parameter(name = "菜单 id", example = "1") Long id) {
        Menu menu = menuService.getById(id);
        if (menu == null) {
            return null;
        }
        return new MenuOptionVO(menu);
    }

    /**
     * 查询菜单，按照多级菜单组成树结构
     * @return 菜单列表，组成树结构
     */
    @GetMapping
    @Operation(description = "查询菜单，按照多级菜单组成树结构")
    public List<MenuOptionVO> listMenuTree(){
        // 1.查询所有菜单
        List<Menu> menus = menuService.list();
        return convert2MenuDTOs(menus);
    }

    private List<MenuOptionVO> convert2MenuDTOs(List<Menu> menus) {
        if (CollectionUtil.isEmpty(menus)) {
            return Collections.emptyList();
        }
        // 2.按照父菜单id分组
        Map<Long, List<MenuOptionVO>> menuMap = menus.stream()
                .map(MenuOptionVO::new)
                .collect(Collectors.groupingBy(MenuOptionVO::getParentId));
        // 3.组合
        // 3.1.获取1级菜单
        List<MenuOptionVO> parents = menuMap.get(0L);
        // 3.2.获取2级菜单
        for (MenuOptionVO parent : parents) {
            List<MenuOptionVO> subMenus = menuMap.get(parent.getId());
            subMenus.sort(Comparator.comparingInt(MenuOptionVO::getPriority));
            parent.setSubMenus(subMenus);
        }
        // 3.3.排序
        parents.sort(Comparator.comparingInt(MenuOptionVO::getPriority));
        return parents;
    }

    /**
     * 根据当前登录用户的权限查询菜单选项，按照多级菜单组成树结构
     * @return 菜单列表，组成树结构
     */
    @GetMapping("me")
    @Operation(description = "查询我的菜单，按照多级菜单组成树结构")
    public List<MenuOptionVO> listMenuTreeByUser(){
        // 1.查询所有菜单
        List<Menu> menus = menuService.listMenuByUser();
        return convert2MenuDTOs(menus);
    }

    @PostMapping
    @Operation(description = "新增菜单")
    public void saveMenu(@RequestBody MenuDTO menuDTO){
        // 1.数据转换
        Menu menu = new Menu(menuDTO);
        // 2.保存
        menuService.saveMenu(menu);
    }

    @PutMapping("{id}")
    @Operation(description="更新菜单")
    public void updateMenu(
            @RequestBody MenuDTO menuDTO,
            @PathVariable @Parameter(name= "菜单 id", example = "1") Long id) {
        menuDTO.setId(id);
        menuService.updateById(new Menu(menuDTO));
    }

    @DeleteMapping("{id}")
    @Operation(description = "根据 id删除菜单")
    public void deleteMenu(
            @PathVariable @Parameter(name= "菜单 id", example = "1") Long id) {
        menuService.deleteMenu(id);
    }

    @PostMapping("/role/{roleId}")
    @Operation(description = "绑定角色与菜单权限")
    public void bindRoleMenus(
            @PathVariable @Parameter(name= "角色 id", example = "1") Long roleId,
            @Parameter(name= "菜单 id集合") List<Long> menuIds){
        menuService.bindRoleMenus(roleId, menuIds);
    }

    @DeleteMapping("/role/{roleId}")
    @Operation(description = "解除角色的菜单权限")
    public void deleteRoleMenus(
            @PathVariable @Parameter(name= "角色 id", example = "1") Long roleId,
            @Parameter(name= "菜单 id集合") List<Long> menuIds){
        menuService.deleteRoleMenus(roleId, menuIds);
    }
}
