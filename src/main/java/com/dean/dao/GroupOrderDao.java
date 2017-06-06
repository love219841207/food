package com.dean.dao;


import com.dean.domain.GroupOrder;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;

/**
 * Created by dongxu on 2017/6/6.
 */
public interface GroupOrderDao extends CrudRepository<GroupOrder,Long> {
    public GroupOrder findByGroupUserIdAndBookDay(Long groupUserId,Date bookDay);
}
