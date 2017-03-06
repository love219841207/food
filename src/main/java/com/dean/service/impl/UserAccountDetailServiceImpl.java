package com.dean.service.impl;

import com.dean.dao.UserAccountDetailDao;
import com.dean.domain.UserAccountDetail;
import com.dean.service.*;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    @Autowired
    private MenuService menuService;

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
    public List<AccountSurplusVO> findSurplus(Long userId) {
        List<AccountSurplusVO> uavList = new ArrayList<AccountSurplusVO>();
        AccountSurplusVO userAccountVO = null;
        List<Object[]> list = userAccountDetailDao.findSurplus(userId);
        for(Object[] o : list){
            userAccountVO = new AccountSurplusVO();
            userAccountVO.setUserId(userId);
            userAccountVO.setSurplus(((BigDecimal) o[0]).intValue());
            userAccountVO.setTimeMenu((String) o[1]);
            userAccountVO.setTypeMenu((String) o[2]);
            uavList.add(userAccountVO);
        }
        return uavList;
    }

    @Override
    public List<AccountFixedVO> findFixed(Long userId) {
        List<UserAccountDetail> list = userAccountDetailDao.findByUserIdAndTypeOrderByFixDateDesc(userId, Constants.USER_ACCOUNT_FIX_MUL);
        List<AccountFixedVO> afs = new ArrayList<AccountFixedVO>();
        List<Date> ls = menuService.findFixDate(Constants.FIX_NEXT_DATE);
       // List<TimeMenuVO> tms =  menuService.findTimeMenu();
       /* Map<Date,UserAccountDetail> map = list.stream().collect(
                Collectors.toMap(UserAccountDetail::getFixDate,(p) -> p)
        );*/
        AccountFixedVO af = null;
        for(Date d : ls){
            af = new AccountFixedVO();
            af.setUserId(userId);
            af.setFixDate(d);
            af.setWeekDay(DateUtils.getWeekOfDate(d));
            String[] typeMenus = this.getTypeMenu(list,d);
            if(!StringUtils.isEmpty(typeMenus[0])){
                af.setNn(typeMenus[0]);
            }
            if(!StringUtils.isEmpty(typeMenus[1])){
                af.setNt(typeMenus[1]);
            }
            afs.add(af);
        }
        return afs;
    }

    private String[] getTypeMenu(List<UserAccountDetail> list,Date d){
        String[] strs = new String[2];
        for(UserAccountDetail userAccountDetail : list){
            if(DateUtils.getStringDate(userAccountDetail.getFixDate()).equals(DateUtils.getStringDate(d))){
                if(userAccountDetail.getTimeMenu().equals(Constants.TIME_MENU_NOON)){
                    strs[0] = userAccountDetail.getTypeMenu();
                }else{
                    strs[1] = userAccountDetail.getTypeMenu();
                }
            }
        }
        return strs;
    }
}
