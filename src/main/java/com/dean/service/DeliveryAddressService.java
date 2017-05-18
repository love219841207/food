package com.dean.service;

import java.util.List;

/**
 * Created by dongxu on 2017/3/1.
 */
public interface DeliveryAddressService {
    List<DeliveryAddressVO> findByUserId(Long userId);

    DeliveryAddressVO findById(Long id);

    void save(DeliveryAddressVO deliveryAddressVO);

    void delete(Long id);

    DeliveryAddressVO getPlanDeliveryAddressVO(Long id, Long userId);
}
