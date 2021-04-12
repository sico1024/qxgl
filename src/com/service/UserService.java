package com.service;

import com.domain.PageInfo;
import com.domain.User;

import java.util.List;
import java.util.Map;

/**
 * 面向接口编程的体现
 */
public interface UserService {

    User login(String uname, String upass);

    PageInfo findUserByCondition(Map<String,Object> params);

    String addUser(Map<String,Object> params);

    void deleteUser(Map<String,Object> params);


    void editUser(User user);

    int importUsers(List<User> users);

    User exportUser(Integer uno);

    User findUserById(Integer uno);

    String updatePwd(Integer uno,String oldPass,String newPass);
}
