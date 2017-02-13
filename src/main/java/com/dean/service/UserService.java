package com.dean.service;

import com.dean.domain.UserInfo;

/**
 * Created by dongxu on 2017/1/24.
 */
public interface UserService {
    public UserInfo BoundUser(String phone,String openId);

    public UserVO getUserVOByOpenId(String openId);
}
