package com.dean.service;

/**
 * Created by dongxu on 2017/6/8.
 */
public interface UserDeliveryTimeService {
    public UserDeliveryTimeVO findByUserId(Long userId);

    public void saveUserDeliveryTimeVO(UserDeliveryTimeVO userDeliveryTimeVO,String timeMenu,String slev);
}
