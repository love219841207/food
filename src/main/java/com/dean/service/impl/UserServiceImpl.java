package com.dean.service.impl;

import com.dean.dao.GroupUserInfoDao;
import com.dean.dao.UserDao;
import com.dean.dao.WechatInfoDao;
import com.dean.domain.GroupUserInfo;
import com.dean.domain.UserInfo;
import com.dean.domain.WechatInfo;
import com.dean.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
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
    @Autowired
    private CouponService couponService;
    @Autowired
    private GroupUserInfoDao groupInfoVODao;


    @Override
    @Transactional
    public UserVO BoundUser(String phone, String openId) {
        UserVO userVO = new UserVO();
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
            logger.info("生成新用户id为[{}],送优惠券", userInfo.getId());
            couponService.bindCoupon(userInfo.getId());
        }
        userVO.setUserInfo(userInfo);
        WechatInfo wechatInfo = wechatInfoDao.findByOpenId(openId);
        if(wechatInfo!=null){
            wechatInfo.setUserId(userInfo.getId());
            wechatInfoDao.save(wechatInfo);
        }
        userVO.setWechatInfo(wechatInfo);
        return userVO;
    }

    @Override
    public UserVO getUserVOByOpenId(String openId) {
        logger.info("根据openid获取UserVO，openId为[{}]", openId);
        UserVO userVO = null;
        if(!StringUtils.isEmpty(openId)){
            userVO = new UserVO();
            WechatInfo wechatInfo = this.getWechatInfo(openId);
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

    private WechatInfo getWechatInfo(String openId){
        WechatInfo wechatInfo = null;
        if(!StringUtils.isEmpty(openId)){
            wechatInfo = wechatInfoDao.findByOpenId(openId);
            if(wechatInfo!=null){
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
        }else{
            logger.info("根据openid获取UserVO，openId为空");
        }
        return wechatInfo;
    }

    @Override
    public UserVO getUserVOByOpenId(String openId, String cid) {
        logger.info("根据openid获取UserVO，openId为[{}]", openId);
        UserVO userVO = null;
        if(!StringUtils.isEmpty(openId)){
            userVO = new UserVO();
            WechatInfo wechatInfo = this.getWechatInfo(openId);
            userVO.setWechatInfo(wechatInfo);
            GroupUserInfo groupUserInfo = groupInfoVODao.getByWechatIdAndCid(wechatInfo.getId(),cid);
            if(groupUserInfo!=null){
                userVO.setGroupUserInfo(groupUserInfo);
                logger.info("根据openid、cid获取UserInfo，userInfo[{}]", groupUserInfo.getId());
            }else{
                logger.info("根据openid、cid没有获取对应的注册信息[{}],[{}]", openId,cid);
            }
        }else{
            logger.info("根据openid获取UserVO，openId为空");
        }
        return userVO;
    }
}
