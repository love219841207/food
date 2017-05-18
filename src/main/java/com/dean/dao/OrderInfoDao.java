package com.dean.dao;

import com.dean.domain.OrderInfo;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import javax.persistence.LockModeType;
import java.util.List;

/**
 * Created by dongxu on 2017/2/21.
 */
public interface OrderInfoDao extends CrudRepository<OrderInfo,String>{
    @Lock(value = LockModeType.PESSIMISTIC_WRITE)
    OrderInfo findById(String id);

    @Query("SELECT r FROM OrderInfo r where r.userId= ?1 and r.status>=3 order by r.createTime desc")
    List<OrderInfo> findByUserIdOrderByCreateTimeDesc(Long id);
}
