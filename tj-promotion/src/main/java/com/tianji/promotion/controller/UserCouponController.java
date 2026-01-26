package com.tianji.promotion.controller;

import com.tianji.promotion.domain.dto.CouponDiscountDTO;
import com.tianji.promotion.domain.dto.OrderCouponDTO;
import com.tianji.promotion.domain.dto.OrderCourseDTO;
import com.tianji.promotion.service.IUserCouponService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user-coupons")
@Tag(name = "优惠券相关接口")
public class UserCouponController {

    private final IUserCouponService userCouponService;

    @Operation(description = "领取优惠券接口")
    @PostMapping("/{couponId}/receive")
    public void receiveCoupon(@PathVariable Long couponId){
        userCouponService.receiveCoupon(couponId);
    }

    @Operation(description = "兑换码兑换优惠券接口")
    @PostMapping("/{code}/exchange")
    public void exchangeCoupon(@PathVariable String code){
        userCouponService.exchangeCoupon(code);
    }

    @Operation(description = "查询我的优惠券可用方案")
    @PostMapping("/available")
    public List<CouponDiscountDTO> findDiscountSolution(@RequestBody List<OrderCourseDTO> orderCourses){
        return userCouponService.findDiscountSolution(orderCourses);
    }

    @Operation(description = "根据券方案计算订单优惠明细")
    @PostMapping("/discount")
    public CouponDiscountDTO queryDiscountDetailByOrder(@RequestBody OrderCouponDTO orderCouponDTO){
        return userCouponService.queryDiscountDetailByOrder(orderCouponDTO);
    }

    @Operation(description = "核销指定优惠券")
    @PutMapping("/use")
    public void writeOffCoupon(@Parameter(description = "用户优惠券 id集合") @RequestParam("couponIds") List<Long> userCouponIds){
        userCouponService.writeOffCoupon(userCouponIds);
    }

}