package com.dean.service;

import com.dean.domain.AddressInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by dongxu on 2017/3/1.
 */
public interface AddressInfoService {
    List<Map<String,Object>> findALl();

    public List<AddressInfoVO> findAll();

    public AddressInfoVO findById(Long id);
}
