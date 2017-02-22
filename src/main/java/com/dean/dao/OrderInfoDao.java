package com.dean.dao;

import com.dean.domain.OrderInfo;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface OrderInfoDao extends CrudRepository<OrderInfo,String>{
}
