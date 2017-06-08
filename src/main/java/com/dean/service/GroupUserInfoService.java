package com.dean.service;

/**
 * Created by dongxu on 2017/6/6.
 */
public interface GroupUserInfoService {
    public GroupUserInfoVO getByWechatIdAndCid(Long wechatId,Long cid);

    public GroupUserInfoVO saveGroupBook(GroupUserInfoVO groupUserInfoVO);
}
