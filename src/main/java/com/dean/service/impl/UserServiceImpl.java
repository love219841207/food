package com.dean.service.impl;

import com.dean.dao.UserDao;
import com.dean.dao.WechatInfoDao;
import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;
import com.dean.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/1/24.
 */
@Service
public class UserServiceImpl implements UserService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserDao userDao;
    @Autowired
    private WechatInfoDao wechatInfoDao;
    @Autowired
    private WechatService wechatService;
    @Autowired
    private SmsService smsService;


    @Override
    public UserInfo BoundUser(String phone, String openId) {
        List<UserInfo> infos = userDao.findByPhone(phone);
        UserInfo userInfo = null;
        if(infos.size()>0){
            userInfo = infos.get(0);
            logger.info("绑定用户用户已经存在,userinfo的id为[{}]",userInfo.getId());
        }else{
            userInfo = new UserInfo();
            userInfo.setPhone(phone);
            userInfo.setCreateTime(new Date());
            userInfo.setLastLoginTime(userInfo.getCreateTime());
            userDao.save(userInfo);
        }
        List<WechatInfo> wechatInfos = wechatInfoDao.findByOpenId(openId);
        WechatInfo wechatInfo = null;
        if(wechatInfos.size()>0){
            wechatInfo=wechatInfos.get(0);
            wechatInfo.setUserId(userInfo.getId());
            wechatInfoDao.save(wechatInfo);
        }
        return userInfo;
    }

    @Override
    public UserVO getUserVOByOpenId(String openId) {
        logger.info("根据openid获取UserVO，openId为[{}]", openId);
        UserVO userVO = null;
        if(!StringUtils.isEmpty(openId)){
            userVO = new UserVO();
            List<WechatInfo> wechats = wechatInfoDao.findByOpenId(openId);
            WechatInfo wechatInfo = null;
            if(wechats.size()>0){
                wechatInfo = wechats.get(0);
                logger.info("根据openid获取UserVO，openId为[{}],openid已经存在",openId);
            }else{
                wechatInfo = new WechatInfo();
                wechatInfo.setCreateTime(new Date());
                wechatInfo.setLastLoginTime(wechatInfo.getCreateTime());
                wechatInfo.setOpenId(openId);
                WechatUserInfoVO wechatUserInfoVo = wechatService.getWechatHeadImg(openId);
                wechatInfo.setHeadImg(wechatUserInfoVo.getHeadImg());
                wechatInfo.setNickName(wechatUserInfoVo.getNickName());
                wechatInfoDao.save(wechatInfo);
                logger.info("根据openid获取UserVO，openId为[{}],openid不存在，已经创建",openId);
            }
            userVO.setWechatInfo(wechatInfo);
            if(wechatInfo.getUserId()!=null){
                UserInfo userInfo = userDao.findOne(wechatInfo.getUserId());
                if(userInfo!=null){
                    userVO.setUserInfo(userInfo);
                }
                logger.info("根据openid获取UserInfo，userInfo[{}]",userInfo.getId());
            }else{
                logger.info("根据openid获取UserInfo，UserId为空");
            }
        }else{
            logger.info("根据openid获取UserVO，openId为空");
        }

        return userVO;
    }
}
