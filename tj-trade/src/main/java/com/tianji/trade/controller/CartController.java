package com.tianji.trade.controller;


import com.tianji.trade.domain.dto.CartsAddDTO;
import com.tianji.trade.domain.vo.CartVO;
import com.tianji.trade.service.ICartService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

/**
 * <p>
 * 购物车条目信息，也就是购物车中的课程 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-28
 */
@RestController
@RequestMapping("/carts")
@RequiredArgsConstructor
@Tag(name = "购物车相关接口")
public class CartController {

    private final ICartService cartService;

    @Operation(description = "添加课程到购物车")
    @PostMapping
    public void addCourse2Cart(@Valid @RequestBody CartsAddDTO cartsAddDTO){
        cartService.addCourse2Cart(cartsAddDTO.getCourseId());
    }

    @Operation(description = "获取购物车中的课程")
    @GetMapping
    public List<CartVO> getMyCarts(){
        return cartService.getMyCarts();
    }

    @Operation(description = "删除指定的购物车条目")
    @DeleteMapping("/{id}")
    public void deleteCartById(@PathVariable @Parameter(description = "购物车条目 id") Long id){
        cartService.deleteCartById(id);
    }

    @Operation(description = "批量删除购物车条目")
    @DeleteMapping
    public void deleteCartById(@Parameter(description = "购物车条目 id集合") @RequestParam("ids") List<Long> ids){
        cartService.deleteCartByIds(ids);
    }
}
