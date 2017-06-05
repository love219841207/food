package com.dean.dao;


import com.dean.domain.GroupUserInfo;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/6/1.
 */
public interface GroupUserInfoDao extends CrudRepository<GroupUserInfo,Long> {
    public GroupUserInfo getByWechatIdAndCid(Long id,String cid);
}
