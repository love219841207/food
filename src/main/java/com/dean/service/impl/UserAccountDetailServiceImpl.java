package com.dean.service.impl;

import com.dean.dao.UserAccountDetailDao;
import com.dean.domain.UserAccountDetail;
import com.dean.service.*;
import com.dean.util.Constants;
import org.hibernate.jpa.internal.EntityManagerFactoryImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/3/2.
 */
@Service
public class UserAccountDetailServiceImpl implements UserAccountDetailService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserAccountDetailDao userAccountDetailDao;
    @Override
    public void orderAdd(OrderInfoVO orderInfoVO) {
        if(orderInfoVO!=null){
            List<UserAccountDetail> list = userAccountDetailDao.findByOrderId(orderInfoVO.getId());
            if(list.size()<1){
                UserAccountDetail userAccountDetail = new UserAccountDetail();
                userAccountDetail.setHappenTime(new Date());
                userAccountDetail.setType(Constants.USER_ACCOUNT_ORDER_ADD);
                userAccountDetail.setOrderId(orderInfoVO.getId());
                userAccountDetail.setNum(orderInfoVO.getPkgDays());
                userAccountDetail.setUserId(orderInfoVO.getUserId());
                userAccountDetail.setTypeMenu(orderInfoVO.getTypeMenu());
                userAccountDetail.setTimeMenu(orderInfoVO.getTimeMenu());
                userAccountDetailDao.save(userAccountDetail);
                logger.info("支付成功增加剩余份数明细，orderid为[{}]",orderInfoVO.getId());
            }else{
                logger.info("支付成功，但是订单已经增加剩余份数明细，orderid为[{}]",orderInfoVO.getId());
            }

        }
    }

    @Override
    public UserAccountVO findByUserId(Long userId) {
        List<Object[]> list = userAccountDetailDao.findSurplus(userId);
        return null;
    }
}
