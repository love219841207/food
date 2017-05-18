package com.dean.dao;

import com.dean.domain.OrderWechatPayment;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/27.
 */
public interface OrderWechatPaymentDao extends CrudRepository<OrderWechatPayment,Long>{
    List<OrderWechatPayment> findByOutTradeAndOpenId(String orderId, String openId);
}
