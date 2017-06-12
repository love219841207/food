package com.dean.service.impl;

import com.dean.dao.UserAccountDetailDao;
import com.dean.domain.UserAccountDetail;
import com.dean.service.*;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

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
    @Autowired
    private DeliveryAddressService deliveryAddressService;

    @Autowired
    private UserDeliveryTimeService userDeliveryTimeService;

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
        Map<Date,String[]> map = new HashMap<Date,String[]>();
        String[] str = null;
        for(UserAccountDetail uad : list){
           if(map.get(uad.getFixDate())==null){
               str = new String[2];
               map.put(uad.getFixDate(),str);
           }else{
               str = map.get(uad.getFixDate());
           }
            if(uad.getTimeMenu().equals(Constants.TIME_MENU_NOON)){
                str[0] = uad.getTypeMenu();
            }else if(uad.getTimeMenu().equals(Constants.TIME_MENU_NIGHT)){
                str[1] = uad.getTypeMenu();
            }
        }
        List<Date> ls = menuService.findFixDate(Constants.FIX_NEXT_DATE);
        List<AccountFixedVO> afs = new ArrayList<AccountFixedVO>();
        AccountFixedVO af = null;
        for(Date d : ls){
            af = new AccountFixedVO();
            af.setUserId(userId);
            af.setFixDate(d);
            af.setWeekDay(DateUtils.getWeekOfDate(d));
            if(map.get(d)!=null){
                str  = map.get(d);
                if(!StringUtils.isEmpty(str[0])){
                    af.setNn(str[0]);
                }
                if(!StringUtils.isEmpty(str[1])){
                    af.setNt(str[1]);
                }
            }
            afs.add(af);
        }
        return afs;
    }

    @Override
    @Transactional
    public void saveDetailfs(String str,Long userId) {
        UserDeliveryTimeVO userDeliveryTimeVO = userDeliveryTimeService.findByUserId(userId);
        if(userDeliveryTimeVO==null){
            logger.error("排餐的时候出现送餐时间为空无法操作!");
        }else{
            JsonNode info = null;
            try {
                info =  new ObjectMapper().readTree(str);
            } catch (IOException e) {
                logger.error("解析排餐数据格式错误[{}]",info);
            }
            List<UserAccountDetail> list = new ArrayList<UserAccountDetail>();
            UserAccountDetail userAccountDetail = null;
            if(info.isArray()){
                for (JsonNode objNode : info){
                    userAccountDetail = new UserAccountDetail();
                    logger.info(objNode.toString());
                    userAccountDetail.setUserId(userId);
                    userAccountDetail.setHappenTime(new Date());
                    userAccountDetail.setType(Constants.USER_ACCOUNT_FIX_MUL);
                    //排餐为单份排餐
                    userAccountDetail.setNum(-Constants.USER_ACCOUNT_FIX_NUM);
                    String fixDate = objNode.path("_fixDate").asText();
                    userAccountDetail.setFixDate(DateUtils.getDate(fixDate));
                    String _str = null;
                    Long deliveryId = null;
                    DeliveryAddressVO deliveryAddressVO = null;
                    if(objNode.has("_nn")){
                        _str = objNode.path("_nn").asText();
                        userAccountDetail.setTimeMenu(Constants.TIME_MENU_NOON);
                        userAccountDetail.setTypeMenu(_str);
                        userAccountDetail.setDeliveryTime(userDeliveryTimeVO.getNnTime());
                    }
                    if(objNode.has("_nt")){
                        _str = objNode.path("_nt").asText();
                        userAccountDetail.setTimeMenu(Constants.TIME_MENU_NIGHT);
                        userAccountDetail.setTypeMenu(_str);
                        userAccountDetail.setDeliveryTime(userDeliveryTimeVO.getNtTime());
                    }
                    if(objNode.has("_devId")){
                        if(deliveryAddressVO==null){
                            deliveryAddressVO = deliveryAddressService.findById(objNode.path("_devId").asLong());
                        }
                        userAccountDetail.setDeliveryPhone(deliveryAddressVO.getPhone());
                        userAccountDetail.setDeliveryName(deliveryAddressVO.getName());
                        userAccountDetail.setDeliveryAdd(deliveryAddressVO.getAddressName()+"-"+deliveryAddressVO.getAddressExtend());
                    }
                    list.add(userAccountDetail);
                }
            }
            int hour = new Date().getHours();
            if(hour<Constants.FIX_NEXT_DATE_HOUR){
                userAccountDetailDao.deleteDetails(userId, Constants.USER_ACCOUNT_FIX_MUL);
            }else{
                userAccountDetailDao.deleteDetailsExt(userId, Constants.USER_ACCOUNT_FIX_MUL);
            }
            userAccountDetailDao.save(list);
        }

    }
}
