package com.dean.service;

import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;


/**
 * Created by dongxu on 2017/1/27.
 */
public class UserVO {
    //微信openid信息
    private WechatInfo wechatInfo;
    //B2C登录信息
    private UserInfo userInfo;

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public WechatInfo getWechatInfo() {
        return wechatInfo;
    }

    public void setWechatInfo(WechatInfo wechatInfo) {
        this.wechatInfo = wechatInfo;
    }
}
