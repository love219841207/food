package com.dean.dao;

import com.dean.domain.GroupInfo;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import javax.transaction.Transactional;

/**
 * Created by dongxu on 2017/2/10.
 */
public interface GroupInfoDao extends CrudRepository<GroupInfo,Long>{
    public GroupInfo findOneByWechatId(Long wechatId);

    @Transactional
    @Modifying
    @Query("update GroupInfo r set r.status= ?1 where r.id= ?2")
    void batchUpdate(Integer status, Long id);
}
