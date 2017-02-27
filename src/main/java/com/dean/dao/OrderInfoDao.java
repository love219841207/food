package com.dean.dao;

import com.dean.domain.OrderInfo;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.repository.CrudRepository;

import javax.persistence.LockModeType;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface OrderInfoDao extends CrudRepository<OrderInfo,String>{
    @Lock(value = LockModeType.PESSIMISTIC_WRITE)
    OrderInfo findById(String id);
}
