package com.dean.service.impl;

import com.dean.service.WechatService;
import org.springframework.stereotype.Service;

/**
 * Created by dongxu on 2017/1/27.
 */
@Service
public class WechatServiceImpl implements WechatService {
    @Override
    public String getOpenId(String code) {
        return "openid1你好";
    }
}
