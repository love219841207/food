package com.dean.dao;

import com.dean.domain.UserDeliveryTime;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/6/8.
 */
public interface UserDeliveryTimeDao extends CrudRepository<UserDeliveryTime,Long>{
    public UserDeliveryTime findByUserId(Long userId);
}
