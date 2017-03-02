package com.dean.dao;

import com.dean.domain.UserDeliveryAddress;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/3/1.
 */
public interface UserDeliveryAddressDao extends CrudRepository<UserDeliveryAddress,Long>{
    List<UserDeliveryAddress> findByUserId(Long userId);

    List<UserDeliveryAddress> findByUserIdAndId(Long userId,Long id);

    @Query("SELECT r FROM UserDeliveryAddress r where r.userId= ?1 and r.dft='1'")
    List<UserDeliveryAddress> findDefault(Long userId);
    @Modifying
    @Query("update UserDeliveryAddress r set r.dft=null where r.userId= ?1")
    void batchUpdate(Long userId);

    @Modifying
    @Query("update UserDeliveryAddress r set r.dft=null where r.userId= ?1 and r.id !=?2")
    void batchUpdateExId(Long userId, Long id);
}
