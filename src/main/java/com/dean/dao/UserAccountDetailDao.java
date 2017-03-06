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

    @Query("select a from UserAccountDetail a where a.userId=?1 and type=?2 and fixDate>CURDATE()")
    List<UserAccountDetail> findByUserIdAndTypeOrderByFixDateDesc(Long userId, int type);

    @Query(value="select sum(num),time_menu,type_menu from user_account_detail where user_id=?1 group by time_menu,type_menu",nativeQuery=true)
    List<Object[]> findSurplus(Long userId);
}
