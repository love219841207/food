package com.dean.service;

/**
 * Created by dongxu on 2017/3/2.
 */
public interface UserAccountDetailService {
    void orderAdd(OrderInfoVO orderInfoVO);

    UserAccountVO findByUserId(Long userId);

}
