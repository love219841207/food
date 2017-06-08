package com.dean.dao;


import com.dean.domain.GroupOrder;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by dongxu on 2017/6/6.
 */
public interface GroupOrderDao extends CrudRepository<GroupOrder,Long> {
    public GroupOrder findByGroupUserIdAndBookDay(Long groupUserId,Date bookDay);

    @Query(value="SELECT u.dep,u.name,o.av as a,o.bv as b from group_order o LEFT JOIN " +
            " group_user_info u on o.group_user_id = u.id " +
            " where u.cid=?1 and o.book_day=?2 ",nativeQuery = true )
    public List findReport(Long groupInfoId,String bookDay);
}
