package com.dean.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by dongxu on 2017/2/1.
 */
@ConfigurationProperties(prefix = "spring.wechat")
public class WechatProperties {
    private String appid;
    private String secret;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }
}
