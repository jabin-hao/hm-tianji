package com.tianji.promotion.mapper;

import com.tianji.promotion.domain.po.Coupon;
import com.tianji.promotion.domain.po.UserCoupon;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tianji.promotion.enums.UserCouponStatus;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 用户领取优惠券的记录，是真正使用的优惠券信息 Mapper 接口
 * </p>
 *
 * @author fenny
 * @since 2023-12-05
 */

public interface UserCouponMapper extends BaseMapper<UserCoupon> {

    @Select("""
            SELECT
            \tc.id,
            \tc.discount_type,
            \tc.`specific`,
            \tc.discount_value,
            \tc.threshold_amount,
            \tc.max_discount_amount,
            \tuc.id AS creater\s
            FROM
            \tcoupon c
            \tINNER JOIN user_coupon uc ON c.id = uc.coupon_id\s
            WHERE
            \tuc.`status` = 1\s
            \tAND uc.user_id = #{userId};""")
    List<Coupon> queryMyCoupons(@Param("userId") Long userId);


    @Select("""
            SELECT
            \tc.id,
            \tc.discount_type,
            \tc.`specific`,
            \tc.discount_value,
            \tc.threshold_amount,
            \tc.max_discount_amount,
            \tuc.id AS creater\s
            FROM
            \tuser_coupon uc
            \tINNER JOIN coupon c ON uc.coupon_id = c.id\s
            WHERE
            \tuc.id IN (:userCouponIds)\s
            \tAND uc.STATUS = #{status}""")
    List<Coupon> queryCouponByUserCouponIds(
            @Param("userCouponIds") List<Long> userCouponIds,@Param("status") UserCouponStatus status);
}
