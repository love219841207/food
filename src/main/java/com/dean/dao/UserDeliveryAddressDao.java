package com.dean.dao;

import com.dean.domain.UserDeliveryAddress;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/3/1.
 */
public interface UserDeliveryAddressDao extends CrudRepository<UserDeliveryAddress,Long>{
    List<UserDeliveryAddress> findByUserId(Long id);
}
