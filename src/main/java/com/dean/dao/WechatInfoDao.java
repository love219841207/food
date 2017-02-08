package com.dean.dao;

import com.dean.domain.WechatInfo;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/1/27.
 */
public interface WechatInfoDao extends CrudRepository<WechatInfo,Long> {
    public List<WechatInfo> findByOpenId(String openId);
}
