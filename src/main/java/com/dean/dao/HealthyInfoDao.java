package com.dean.dao;

import com.dean.domain.HealthyInfo;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/5/10.
 */
public interface HealthyInfoDao extends CrudRepository<HealthyInfo,Long>{
    HealthyInfo findByUserId(Long userId);
}
