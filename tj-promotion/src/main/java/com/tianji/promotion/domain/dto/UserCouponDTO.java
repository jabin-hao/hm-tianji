package com.tianji.promotion.domain.dto;

import lombok.Data;

@Data
public class UserCouponDTO {
    /**
     * 用户 id
     */
    private Long userId;
    /**
     * 优惠券 id
     */
    private Long couponId;
}
