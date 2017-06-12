package com.dean.service.impl;

import com.dean.dao.OrderInfoDao;
import com.dean.dao.PkgMenuDao;
import com.dean.domain.OrderInfo;
import com.dean.domain.PkgMenu;
import com.dean.service.CouponService;
import com.dean.service.OrderInfoVO;
import com.dean.service.OrderService;
import com.dean.service.UserAccountDetailService;
import com.dean.util.Constants;
import com.dean.util.IdWorker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/21.
 */
@Service
public class OrderServiceImpl implements OrderService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private IdWorker idWorker;
    @Autowired
    private OrderInfoDao orderInfoDao;
    @Autowired
    private CouponService couponService;
    @Autowired
    private PkgMenuDao pkgMenuDao;
    @Autowired
    private UserAccountDetailService userAccountDetailService;

    @Override
    public OrderInfoVO initOrderInfo(String typeMenu,String timeMenu,Long userId,Integer pkgDays,BigDecimal logisticsPrice) {
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
            orderInfo.setId(String.valueOf(idWorker.nextId()));
            orderInfo.setTimeMenu(orderInfoVO.getTimeMenu());
            orderInfo.setPkgDays(orderInfoVO.getPkgDays());
            orderInfo.setUserId(orderInfoVO.getUserId());
            orderInfo.setTypeMenu(orderInfoVO.getTypeMenu());
            orderInfo.setLogisticsPrice(orderInfoVO.getLogisticsPrice());
            PkgMenu pkgMenu = this.findPkgMenu(orderInfoVO.getTypeMenu(), orderInfoVO.getTimeMenu(), orderInfoVO.getPkgDays());
            if(pkgMenu!=null&&pkgMenu.getSalePrice()!=null){
                orderInfo.setPkgSalePrice(pkgMenu.getSalePrice());
                orderInfo.setTotalPrice(this.getTotalPrice(pkgMenu.getSalePrice(), orderInfoVO.getLogisticsPrice()));
                orderInfo.setPkgMenu(pkgMenu.getPkgMenu());
            }
            orderInfo.setCreateTime(new Date());
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
        //需要付钱
        boolean coupon = true;
        if(lastPrice.compareTo(BigDecimal.ZERO)>0){
            orderInfo.setStatus(Constants.ORDER_STATUS_PREPARE);
        }else{
            orderInfo.setStatus(Constants.ORDER_STATUS_NOT_PAY);
            if(orderInfo.getCouponId()!=null){
                coupon = couponService.couponUse(orderInfo.getCouponId());
            }
        }
        if(!coupon){
            orderInfoVO.setErrorMsg("优惠券无法使用!");
        }else{
            orderInfoDao.save(orderInfo);
            BeanUtils.copyProperties(orderInfo, orderInfoVO);
            if(orderInfo.getStatus()==Constants.ORDER_STATUS_NOT_PAY){
                userAccountDetailService.orderAdd(orderInfoVO);
            }
        }
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
            OrderInfoVO orderInfoVO = new OrderInfoVO();
            BeanUtils.copyProperties(orderInfo,orderInfoVO);
            userAccountDetailService.orderAdd(orderInfoVO);
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

    @Override
    public List<OrderInfoVO> getList(Long userId) {
        List<OrderInfo> infos = orderInfoDao.findByUserIdOrderByCreateTimeDesc(userId);
        List<OrderInfoVO> orderInfoVOs = new ArrayList<OrderInfoVO>();
        OrderInfoVO orderInfoVO = null;
        for(OrderInfo orderInfo : infos){
            orderInfoVO = new OrderInfoVO();
            BeanUtils.copyProperties(orderInfo,orderInfoVO);
            orderInfoVOs.add(orderInfoVO);
        }
        return orderInfoVOs;
    }

    @Override
    public OrderInfoVO findById(String orderId) {
        OrderInfo orderInfo =  orderInfoDao.findOne(orderId);
        OrderInfoVO orderInfoVO =null;
        if(orderInfo!=null){
            orderInfoVO = new OrderInfoVO();
            BeanUtils.copyProperties(orderInfo,orderInfoVO);
        }
        return orderInfoVO;
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
