package com.dean.dao;

import com.dean.domain.UserAccountDetail;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/3/2.
 */
public interface UserAccountDetailDao extends CrudRepository<UserAccountDetail,Long>{
    List<UserAccountDetail> findByOrderId(String orderId);

    @Query("select sum(num),timeMenu,typeMenu from UserAccountDetail where userId=?1 group by timeMenu,typeMenu")
    List<Object[]> findSurplus(Long userId);
}
