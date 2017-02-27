package com.dean.service.impl;

import com.dean.dao.OrderInfoDao;
import com.dean.dao.PkgMenuDao;
import com.dean.domain.OrderInfo;
import com.dean.domain.PkgMenu;
import com.dean.service.CouponService;
import com.dean.service.OrderInfoVO;
import com.dean.service.OrderService;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
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
    private CouponService couponService;
    @Autowired
    private PkgMenuDao pkgMenuDao;

    //配送费默认不需要
    private BigDecimal logisticsPrice = null;

    @Override
    public OrderInfoVO initOrderInfo(String typeMenu,String timeMenu,Long userId,int pkgDays) {
        OrderInfoVO orderInfoVO =  new OrderInfoVO();
        orderInfoVO.setTypeMenu(typeMenu);
        orderInfoVO.setTimeMenu(timeMenu);
        orderInfoVO.setUserId(userId);
        orderInfoVO.setPkgDays(pkgDays);
        orderInfoVO.setLogisticsPrice(logisticsPrice);
        PkgMenu pkgMenu = this.findPkgMenu(typeMenu, timeMenu, pkgDays);
        if(pkgMenu!=null&&pkgMenu.getSalePrice()!=null){
            orderInfoVO.setPkgSalePrice(pkgMenu.getSalePrice());
            orderInfoVO.setTotalPrice(this.getTotalPrice(pkgMenu.getSalePrice(), logisticsPrice));
            orderInfoVO.setPkgMenu(pkgMenu.getPkgMenu());
            orderInfoVO.setLastPrice(orderInfoVO.getTotalPrice());
        }
        return orderInfoVO;
    }

    @Override
    @Transactional
    public OrderInfoVO createOrderInfo(OrderInfoVO orderInfoVO) {
        OrderInfo orderInfo = null;
        if(StringUtils.isEmpty(orderInfoVO.getId())){
            orderInfo = new OrderInfo();
            orderInfo.setTimeMenu(orderInfoVO.getTimeMenu());
            orderInfo.setPkgDays(orderInfoVO.getPkgDays());
            orderInfo.setUserId(orderInfoVO.getUserId());
            orderInfo.setTypeMenu(orderInfoVO.getTypeMenu());
            PkgMenu pkgMenu = this.findPkgMenu(orderInfoVO.getTypeMenu(), orderInfoVO.getTimeMenu(), orderInfoVO.getPkgDays());
            if(pkgMenu!=null&&pkgMenu.getSalePrice()!=null){
                orderInfo.setPkgSalePrice(pkgMenu.getSalePrice());
                orderInfo.setTotalPrice(this.getTotalPrice(pkgMenu.getSalePrice(), logisticsPrice));
                orderInfo.setPkgMenu(pkgMenu.getPkgMenu());
            }
            orderInfo.setCreateTime(new Date());
            orderInfo.setStatus(Constants.ORDER_STATUS_PREPARE);
        }else{
            orderInfo = orderInfoDao.findOne(orderInfoVO.getId());
        }
        orderInfo.setRemark(orderInfoVO.getRemark());
        orderInfo.setCouponId(orderInfoVO.getCouponId());
        orderInfo.setCouponPrice(orderInfoVO.getCouponPrice());
        BigDecimal lastPrice = orderInfo.getTotalPrice();
        if(orderInfoVO.getCouponPrice()!=null){
            if(lastPrice.compareTo(orderInfoVO.getCouponPrice())>0){
                lastPrice = lastPrice.subtract(orderInfoVO.getCouponPrice());
            }else{
                lastPrice = new BigDecimal("0.00");
            }
        }
        orderInfo.setLastPrice(lastPrice);
        orderInfoDao.save(orderInfo);
        BeanUtils.copyProperties(orderInfo,orderInfoVO);
        return orderInfoVO;
    }

    @Override
    @Transactional
    public boolean payOrderInfo(OrderInfoVO orderInfoVO) {
        boolean boo = false;
        OrderInfo orderInfo = orderInfoDao.findById(orderInfoVO.getId());
        if(orderInfo.getStatus()!=null
                &&orderInfo.getStatus()<Constants.ORDER_STATUS_PAYED_ARRIVAL){
            orderInfo.setStatus(Constants.ORDER_STATUS_PAYED);
        }
        orderInfo.setPayTime(new Date());
        orderInfoDao.save(orderInfo);
        boo = true;
        return boo;
    }

    @Override
    @Transactional
    public void paySuccess(String orderId) {
        OrderInfo orderInfo = orderInfoDao.findOne(orderId);
        if(orderInfo.getStatus()!=null
                &&orderInfo.getStatus()!=Constants.ORDER_STATUS_PAYED_ARRIVAL){
            orderInfo.setStatus(Constants.ORDER_STATUS_PAYED_ARRIVAL);
            orderInfo.setArrivalTime(new Date());
            orderInfoDao.save(orderInfo);
            if(orderInfo.getCouponId()!=null){
                couponService.couponUse(orderInfo.getCouponId());
            }
        }
    }

    @Override
    public void payFail(String orderId) {
        OrderInfo orderInfo = orderInfoDao.findOne(orderId);
        if(orderInfo.getStatus()!=null
                &&orderInfo.getStatus()!=Constants.ORDER_STATUS_PAYED_ARRIVAL){
            orderInfo.setStatus(Constants.ORDER_STATUS_FAIL);
            orderInfo.setArrivalTime(new Date());
            orderInfoDao.save(orderInfo);
        }
    }

    private PkgMenu findPkgMenu(String typeMenu,String timeMenu,int pkgDays){
        PkgMenu pkgMenu = null;
        List<PkgMenu> list = pkgMenuDao.findByTypeMenuAndTimeMenuAndPkgDaysOrderByTimeMenu(typeMenu,timeMenu,pkgDays);
        if(list.size()>0){
            pkgMenu = list.get(0);
        }
        return pkgMenu;
    }
    private BigDecimal getTotalPrice(BigDecimal salePrice, BigDecimal logisticsPrice){
        BigDecimal total = salePrice;
        if(logisticsPrice!=null){
            total = total.add(logisticsPrice);
        }
        return total;
    }
}
