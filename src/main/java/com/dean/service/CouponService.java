package com.dean.service;

/**
 * Created by dongxu on 2017/2/22.
 */
public interface CouponService {
    CouponVO findByUserId(Long userId);

    Integer findCountByUserId(Long userId);

    CouponVO getById(Long id);

    boolean couponUse(Long couponId);

    Long bindCoupon(Long userId);
}
