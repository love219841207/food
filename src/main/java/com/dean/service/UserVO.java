package com.dean.service;

import com.dean.domain.GroupUserInfo;
import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;

import java.io.Serializable;

/**
 * Created by dongxu on 2017/1/27.
 */
public class UserVO {
    //微信openid信息
    private WechatInfo wechatInfo;
    //B2C登录信息
    private UserInfo userInfo;
    //B2B2C登录信息
    private GroupUserInfo groupUserInfo;

    public GroupUserInfo getGroupUserInfo() {
        return groupUserInfo;
    }

    public void setGroupUserInfo(GroupUserInfo groupUserInfo) {
        this.groupUserInfo = groupUserInfo;
    }

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
