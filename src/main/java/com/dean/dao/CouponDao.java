package com.dean.dao;

import com.dean.domain.Coupon;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface CouponDao extends CrudRepository<Coupon,Long>{
    List<Coupon> findByUserIdAndStatus(Long userId, int status);
}
