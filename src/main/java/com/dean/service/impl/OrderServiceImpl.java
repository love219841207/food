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
    public OrderInfoVO createOrderInfo(String typeMenu,String timeMenu,Long userId,int pkgDays) {
        OrderInfo orderInfo = new OrderInfo();
        OrderInfoVO orderInfoVO =  new OrderInfoVO();
        orderInfo.setCreateTime(new Date());
        orderInfo.setTypeMenu(typeMenu);
        orderInfo.setTimeMenu(timeMenu);
        orderInfo.setUserId(userId);
        orderInfo.setPkgDays(pkgDays);
        orderInfo.setLogisticsPrice(logisticsPrice);

        PkgMenu pkgMenu = this.findPkgMenu(typeMenu, timeMenu, pkgDays);
        if(pkgMenu!=null&&pkgMenu.getSalePrice()!=null){
            orderInfo.setPkgSalePrice(pkgMenu.getSalePrice());
            orderInfo.setTotalPrice(this.getTotalPrice(pkgMenu.getSalePrice(), logisticsPrice));
            orderInfo.setStatus(Constants.ORDER_STATUS_PREPARE);
            orderInfo.setPkgMenu(pkgMenu.getPkgMenu());
            orderInfo.setLastPrice(orderInfo.getTotalPrice());
        }else{
            logger.info("生成订单失败");
            orderInfo.setStatus(Constants.ORDER_STATUS_ERROR);
        }
        orderInfoDao.save(orderInfo);
        BeanUtils.copyProperties(orderInfo, orderInfoVO);
        return orderInfoVO;
    }

    @Override
    @Transactional
    public boolean checkOrderInfo(OrderInfoVO orderInfoVO) {
        boolean boo = false;
        OrderInfo orderInfo = orderInfoDao.findOne(orderInfoVO.getId());
        if(orderInfo!=null){
            orderInfo.setRemark(orderInfoVO.getRemark());
            orderInfo.setCouponId(orderInfoVO.getCouponId());
            orderInfo.setCouponPrice(orderInfoVO.getCouponPrice());
            BigDecimal lastPrice = orderInfo.getLastPrice();
            if(orderInfoVO.getCouponPrice()!=null){
                if(lastPrice.compareTo(orderInfoVO.getCouponPrice())>0){
                    lastPrice = lastPrice.subtract(orderInfoVO.getCouponPrice());
                }else{
                    lastPrice = new BigDecimal("0.00");
                }
                couponService.couponUse(orderInfoVO.getCouponId());
            }
            orderInfo.setLastPrice(lastPrice);
            orderInfo.setStatus(Constants.ORDER_STATUS_CHECK);
            orderInfoDao.save(orderInfo);
        }
        boo = true;
        return boo;
    }

    @Override
    public boolean chargeOrderInfo(OrderInfoVO orderInfoVO) {
        boolean boo = false;
        OrderInfo orderInfo = orderInfoDao.findOne(orderInfoVO.getId());
        orderInfo.setPayTime(new Date());
        orderInfo.setStatus(Constants.ORDER_STATUS_PAYED);
        orderInfoDao.save(orderInfo);
        boo = true;
        return boo;
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
