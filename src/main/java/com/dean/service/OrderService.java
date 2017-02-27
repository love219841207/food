package com.dean.service;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface OrderService {

    OrderInfoVO initOrderInfo(String typeMenu, String timeMenu, Long userId, int pkgDays);

    OrderInfoVO createOrderInfo(OrderInfoVO orderInfoVO);

    boolean payOrderInfo(OrderInfoVO orderInfoVO);

    void paySuccess(String orderId);

    void payFail(String orderId);

}
