package com.tianji.promotion.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.promotion.domain.dto.CouponFormDTO;
import com.tianji.promotion.domain.dto.CouponIssueFormDTO;
import com.tianji.promotion.domain.query.CouponQuery;
import com.tianji.promotion.domain.vo.CouponDetailVO;
import com.tianji.promotion.domain.vo.CouponPageVO;
import com.tianji.promotion.domain.vo.CouponVO;
import com.tianji.promotion.service.ICouponService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

/**
 * <p>
 * 优惠券的规则信息 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-12-03
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/coupons")
@Tag(name = "优惠券相关接口")
public class CouponController {

    private final ICouponService couponService;

    @Operation(description = "新增优惠券接口")
    @PostMapping
    public void saveCoupon(@RequestBody @Valid CouponFormDTO dto){
        couponService.saveCoupon(dto);
    }
    @Operation(description = "修改优惠券接口")
    @PutMapping("{id}")
    public void updateById(@RequestBody @Valid CouponFormDTO dto, @PathVariable Long id){
        couponService.updateById(dto, id);
    }
    @Operation(description = "删除优惠券接口")
    @DeleteMapping("{id}")
    public void deleteById(@PathVariable @Parameter(description = "优惠券 id") Long id){
        couponService.deleteById(id);
    }

    @Operation(description="查询优惠券接口")
    @GetMapping("{id}")
    public CouponDetailVO queryById(@PathVariable @Parameter(description = "优惠券 id") Long id){
        return couponService.queryById(id);
    }

    @Operation(description="分页查询优惠券列表接口-管理端")
    @GetMapping("/page")
    public PageDTO<CouponPageVO> queryCouponByPage(CouponQuery query){
        return couponService.queryCouponByPage(query);
    }

    @Operation(description="发放优惠券接口")
    @PutMapping("/{id}/issue")
    public void beginIssue(@RequestBody @Valid CouponIssueFormDTO dto) {
        couponService.beginIssue(dto);
    }

    @Operation(description="查询发放中的优惠券列表-用户端")
    @GetMapping("/list")
    public List<CouponVO> queryIssuingCoupons(){
        return couponService.queryIssuingCoupons();
    }

    @Operation(description="停发优惠券")
    @PutMapping("/{id}/pause")
    public void pauseIssue(@PathVariable @Parameter(description = "优惠券 id") long id) {
        couponService.pauseIssue(id);
    }
}