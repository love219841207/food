package com.dean.service;


/**
 * Created by dongxu on 2017/5/10.
 */

public interface HealthyInfoService {
    HealthyInfoVO getHealthyInfoVO(Long userId);

    void save(HealthyInfoVO healthyInfoVO);

    BodyIndexVO getBodyIndexVO(Long userId);
}
