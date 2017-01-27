package com.dean.service;

import com.dean.domain.UserInfo;

/**
 * Created by dongxu on 2017/1/24.
 */
public interface UserService {
    public UserInfo createUser();

    public UserInfo BoundUser();

    public UserVO getUserVOByOpenId(String openId);
}
