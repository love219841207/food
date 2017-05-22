package com.dean.dao;

import com.dean.domain.RegeditCode;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/5/22.
 */
public interface RegeditCodeDao extends CrudRepository<RegeditCode,Long> {
    @Query("SELECT r FROM RegeditCode r where r.scene= ?2 and r.openId= ?1 and r.createTime> ?3 order by r.createTime desc")
    List<RegeditCode> findByOpenIdAndSceneOrderByCreateTime(String openId, int scene, Date createTime);
}
