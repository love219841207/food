package com.dean.service.impl;

import com.dean.dao.UserDao;
import com.dean.dao.WechatInfoDao;
import com.dean.domain.RegeditCode;
import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;
import com.dean.service.SmsService;
import com.dean.service.UserService;
import com.dean.service.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/1/24.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private WechatInfoDao wechatInfoDao;
    @Autowired
    private SmsService smsService;
    @Override
    public UserInfo createUser() {
        /*UserInfo user = new UserInfo();
        user.setCreateTime(new Date());
        user.setLastLoginTime(new Date());
        userDao.save(user);*/
        return null;
    }

    @Override
    public UserInfo BoundUser() {
       /* String phone = "15026750804";
        int random = (int)((Math.random()*9+1)*1000);
        String code = String.valueOf(random);
        RegeditCode regeditCode = new RegeditCode();
        regeditCode.setScene(1);
        regeditCode.setCode(code);
        regeditCode.setUserId(1L);
        regeditCode.setCreateTime(new Date());
        smsService.sendRegdit(phone,code);*/
        return null;
    }

    @Override
    public UserVO getUserVOByOpenId(String openId) {
        UserVO userVO = new UserVO();
        List<WechatInfo> wechats = wechatInfoDao.findWechatInfoByOpenId(openId);
        if(wechats.size()>0){
            WechatInfo wechatInfo = wechats.get(0);
            userVO.setWechatInfo(wechatInfo);
            if(wechatInfo.getUserId()!=null){
                UserInfo userInfo = userDao.findOne(wechatInfo.getUserId());
                if(userInfo!=null){
                    userVO.setUserInfo(userInfo);
                }
            }
        }else{
            WechatInfo wechatInfo = new WechatInfo();
            wechatInfo.setCreateTime(new Date());
            wechatInfo.setLastLoginTime(wechatInfo.getCreateTime());
            wechatInfo.setOpenId(openId);
            wechatInfoDao.save(wechatInfo);
        }
        return userVO;
    }
}
