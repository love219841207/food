package com.dean.dao;

import com.dean.domain.UserAccountDetail;
import org.springframework.data.jpa.repository.Modifying;
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
    @Modifying
    @Query(value="delete t from user_account_detail t where t.user_id=?1 and t.type=?2 and t.fix_date>CURDATE()",nativeQuery=true)
    void deleteDetails(Long userId,int type);

    @Modifying
    @Query(value="delete t from user_account_detail t where t.user_id=?1 and t.type=?2 and t.fix_date>CURDATE()+1",nativeQuery=true)
    void deleteDetailsExt(Long userId,int type);


}
