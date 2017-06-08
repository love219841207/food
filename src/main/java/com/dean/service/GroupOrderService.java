package com.dean.service;

import java.util.List;

/**
 * Created by dongxu on 2017/6/6.
 */
public interface GroupOrderService {
    public GroupOrderVO getUserId(Long groupUserId);

    public void saveGroupOrderVO(GroupOrderVO groupOrderVO);

    public boolean canEdit();

    public List findReport(Long groupInfoId,String bookDay);


}
