package com.dean.dao;

import com.dean.domain.WechatApiToken;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/2/8.
 */
public interface WechatApiTokenDao extends CrudRepository<WechatApiToken,Long> {
}
