package com.dean.service;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface OrderService {

    OrderInfoVO createOrderInfo(String typeMenu, String timeMenu, Long userId, int pkgDays);

    boolean checkOrderInfo(OrderInfoVO orderInfoVO);

    boolean chargeOrderInfo(OrderInfoVO orderInfoVO);

}
