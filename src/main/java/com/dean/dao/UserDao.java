package com.dean.dao;

import com.dean.domain.UserInfo;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/1/24.
 */
public interface UserDao extends CrudRepository<UserInfo,Long>{
}
