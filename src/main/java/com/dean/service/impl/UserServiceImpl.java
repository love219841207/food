package com.dean.service.impl;

import com.dean.dao.UserDao;
import com.dean.domain.User;
import com.dean.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by dongxu on 2017/1/24.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public User createUser() {
        User user = new User();
        user.setWechatId("aaaaa");
        user.setCreateTime(new Date());
        user.setLastLoginTime(new Date());
        userDao.save(user);
        return user;
    }

    @Override
    public User BoundUser() {
        return null;
    }
}
