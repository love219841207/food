package com.dean.service;

/**
 * Created by dongxu on 2017/1/27.
 */
public interface WechatService {
    String getOpenid(String code);

    String getRedirUrl(String appUrl);

    boolean refreshApiToken();

    WechatUserInfoVO getWechatHeadImg(String openId);

    WxConfig createWxConfig(String url);

    PayConfig createPayConfig(String openId, String orderId, String attach, String body, String ip, int fee, WxConfig config);

    void orderCallBack(String xml);
}
