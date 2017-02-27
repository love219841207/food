package com.dean.service.impl;

import com.dean.dao.CouponDao;
import com.dean.domain.Coupon;
import com.dean.service.CouponService;
import com.dean.service.CouponVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/22.
 */
@Service
public class CouponServiceImpl implements CouponService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private CouponDao couponDao;
    @Override
    public CouponVO findByUserId(Long userId) {
        CouponVO couponVO = null;
        List<Coupon> list = couponDao.findByUserIdAndStatus(userId, Constants.COUPON_STATUS_VALID);
        if(list.size()>0){
            couponVO = new CouponVO();
            BeanUtils.copyProperties(list.get(0),couponVO);
        }
        return couponVO;
    }

    @Override
    public CouponVO getById(Long id) {
        Coupon coupon = couponDao.findOne(id);
        CouponVO couponVO = new CouponVO();
        BeanUtils.copyProperties(coupon,couponVO);
        return couponVO;
    }

    @Override
    public boolean couponUse(Long couponId) {
        boolean boo = false;
        Coupon coupon = couponDao.findOne(couponId);
        if(coupon!=null&&coupon.getStatus()==Constants.COUPON_STATUS_VALID){
            coupon.setUseTime(new Date());
            coupon.setStatus(Constants.COUPON_STATUS_USED);
            couponDao.save(coupon);
            boo = true;
        }else{
            logger.error("优惠券已经使用或者无效重复了[{}]", couponId);
        }
        return boo;
    }
}
