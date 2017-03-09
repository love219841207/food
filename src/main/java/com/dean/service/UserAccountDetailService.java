package com.dean.service;

import java.util.List;

/**
 * Created by dongxu on 2017/3/2.
 */
public interface UserAccountDetailService {
    void orderAdd(OrderInfoVO orderInfoVO);

    List<AccountSurplusVO> findSurplus(Long userId);

    List<AccountFixedVO> findFixed(Long userId);

    void saveDetailfs(String str, Long userId);

}
