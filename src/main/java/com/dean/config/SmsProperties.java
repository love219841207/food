package com.dean.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by dongxu on 2017/1/27.
 */
@ConfigurationProperties(prefix = "spring.sms")
public class SmsProperties {
    private String type;
    private String signName;
    private String templateCode;

    private String url;
    private String appKey;
    private String appSecret;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getAppKey() {
        return appKey;
    }

    public void setAppKey(String appKey) {
        this.appKey = appKey;
    }

    public String getAppSecret() {
        return appSecret;
    }

    public void setAppSecret(String appSecret) {
        this.appSecret = appSecret;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSignName() {
        return signName;
    }

    public void setSignName(String signName) {
        this.signName = signName;
    }

    public String getTemplateCode() {
        return templateCode;
    }

    public void setTemplateCode(String templateCode) {
        this.templateCode = templateCode;
    }
}
