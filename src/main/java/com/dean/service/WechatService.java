package com.dean.service;

/**
 * Created by dongxu on 2017/1/27.
 */
public interface WechatService {
    public String getOpenid(String code);

    public String getRedirUrl(String appUrl);

    public boolean refreshApiToken();

    public WechatUserInfoVo getWechatHeadImg(String openId);
}
