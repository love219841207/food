package com.dean.service.impl;

import com.dean.dao.UserDeliveryTimeDao;
import com.dean.domain.UserDeliveryTime;
import com.dean.service.UserDeliveryTimeService;
import com.dean.service.UserDeliveryTimeVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by dongxu on 2017/6/8.
 */
@Service
public class UserDeliveryTimeServiceImpl implements UserDeliveryTimeService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserDeliveryTimeDao userDeliveryTimeDao;
    @Override
    public UserDeliveryTimeVO findByUserId(Long userId) {
        logger.info("获取订餐时间区间UserId[{}]",userId);
        UserDeliveryTime userDeliveryTime = userDeliveryTimeDao.findByUserId(userId);
        UserDeliveryTimeVO userDeliveryTimeVO = new UserDeliveryTimeVO();
        if(userDeliveryTime!=null){
            BeanUtils.copyProperties(userDeliveryTime, userDeliveryTimeVO);
        }else{
            userDeliveryTimeVO.setUserId(userId);
        }
        logger.info("获取订餐时间区结束userDeliveryTimeVOId[{}]",userDeliveryTimeVO.getId());
        return userDeliveryTimeVO;
    }

    @Override
    public void saveUserDeliveryTimeVO(UserDeliveryTimeVO userDeliveryTimeVO, String timeMenu, String slev) {
        logger.info("保存订餐时间");
        UserDeliveryTime userDeliveryTime = null;
        if(userDeliveryTimeVO.getId()!=null){
            userDeliveryTime = userDeliveryTimeDao.findOne(userDeliveryTimeVO.getId());
        }else{
            userDeliveryTime = new UserDeliveryTime();
            userDeliveryTime.setUserId(userDeliveryTimeVO.getUserId());
        }
        if(timeMenu.equals(Constants.TIME_MENU_NOON)){
            userDeliveryTime.setNnTime(slev);
        }else{
            userDeliveryTime.setNtTime(slev);
        }
        userDeliveryTimeDao.save(userDeliveryTime);
    }
}
