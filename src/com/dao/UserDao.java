package com.dao;

import com.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    User selectOne(String uname);

    long totalCount(Map<String,Object> params);

    List<User> selectList(Map<String,Object> params);

    int insert(Map<String,Object> params);

    int insert(User user);

    int update(Map<String,Object> params);

    User selectUserById(Integer uno);


}
