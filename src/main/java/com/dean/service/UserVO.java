package com.dean.service;

import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;

import java.io.Serializable;

/**
 * Created by dongxu on 2017/1/27.
 */
public class UserVO {

    private UserInfo userInfo;
    private WechatInfo wechatInfo;

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
