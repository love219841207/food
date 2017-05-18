package com.dean.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by dongxu on 2017/2/1.
 */
@ConfigurationProperties(prefix = "spring.wechat.route")
public class WechatRouteProperties {
    private String authUrl;

    public String getAuthUrl() {
        return authUrl;
    }

    public void setAuthUrl(String authUrl) {
        this.authUrl = authUrl;
    }
}
