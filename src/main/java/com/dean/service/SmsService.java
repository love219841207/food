package com.dean.service;

/**
 * Created by dongxu on 2017/1/27.
 */
public interface SmsService {
    public boolean sendRegdit(String phone,String randomCode,String openId);
}
