package com.dean.service;



/**
 * Created by dongxu on 2017/1/24.
 */
public interface UserService {
    UserVO BoundUser(String phone, String openId);

    /**
     * B2C根据@param openId获取登录信息
     *
     * @param openId
     * @return
     */
    UserVO getUserVOByOpenId(String openId);



}
