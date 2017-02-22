package com.dean.service.impl;

import com.dean.dao.OrderInfoDao;
import com.dean.dao.PkgMenuDao;
import com.dean.domain.OrderInfo;
import com.dean.domain.PkgMenu;
import com.dean.service.OrderInfoVO;
import com.dean.service.OrderService;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/21.
 */
@Service
public class OrderServiceImpl implements OrderService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private OrderInfoDao orderInfoDao;
    @Autowired
    private PkgMenuDao pkgMenuDao;

    //配送费默认不需要
    private BigDecimal logisticsPrice = null;

    @Override
    public OrderInfoVO createOrderInfo(String typeMenu,String timeMenu,Long userId,int pkgDays) {
        OrderInfo orderInfo = new OrderInfo();
        OrderInfoVO orderInfoVO = null;
        orderInfo.setCreateTime(new Date());
        orderInfo.setTypeMenu(typeMenu);
        orderInfo.setTimeMenu(timeMenu);
        orderInfo.setUserId(userId);
        orderInfo.setPkgDays(pkgDays);
        orderInfo.setLogisticsPrice(logisticsPrice);
        BigDecimal totalPrice = this.getTotalPrice(typeMenu,timeMenu,pkgDays,logisticsPrice);
        if(totalPrice!=null){
            orderInfo.setTotalPrice(totalPrice);
            orderInfo.setStatus(Constants.ORDER_STATUS_PREPARE);
            orderInfo.setLastPrice(totalPrice);
            orderInfoDao.save(orderInfo);
            orderInfoVO = new OrderInfoVO();
            BeanUtils.copyProperties(orderInfo, orderInfoVO);
        }else{
            logger.info("生成订单失败，由于totalprice计算出来为null");
        }
        return orderInfoVO;
    }

    private BigDecimal getTotalPrice(String typeMenu,String timeMenu,int pkgDays,BigDecimal logisticsPrice){
        List<PkgMenu> list = pkgMenuDao.findByTypeMenuAndTimeMenuAndPkgDaysOrderByTimeMenu(typeMenu,timeMenu,pkgDays);
        BigDecimal total = null;
        if(list.size()>0){
            total = list.get(0).getSalePrice();
            if(logisticsPrice!=null){
                total = total.add(logisticsPrice);
            }
        }else{
            logger.info("生成订单错误,通过type、time、days查找打包价钱无数据.参数为[{},{},{}]", typeMenu, timeMenu,pkgDays);
        }
        return total;
    }
}
