package com.dean.service;

/**
 * Created by dongxu on 2017/2/22.
 */
public interface CouponService {
    CouponVO findByUserId(Long userId);

    CouponVO getById(Long id);

    void couponUse(Long couponId);
}
