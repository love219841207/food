package com.dean.service;



/**
 * Created by dongxu on 2017/1/24.
 */
public interface UserService {
    UserVO BoundUser(String phone, String openId);

    UserVO getUserVOByOpenId(String openId);
}
