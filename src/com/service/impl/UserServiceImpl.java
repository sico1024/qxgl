package com.service.impl;

import com.dao.UserDao;
import com.domain.PageInfo;
import com.domain.User;
import com.service.UserService;
import com.util.MySpring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = MySpring.getBean("com.dao.impl.UserDaoImpl");

    public User login(String uname,String upass){
        User user = userDao.selectOne(uname);

        if(user!=null && user.getUpass().equals(upass)){
            ThreadLocal<User> threadLocal = new ThreadLocal<>();
            return user;
        }
        return null;
    }

    //找出满足筛选条件得用户
    //params 有 用户编号，用户名称，用户性别，每页显示几行
    public PageInfo findUserByCondition(Map<String,Object> params){
        //查询所有满足条件的用户数量
        Long totalRow = userDao.totalCount(params);

        //获取每页显示的行数
        Integer length = (Integer) params.get("row");
        //总页数
        Integer maxPage = (int)Math.ceil(1.0*totalRow/length);
        //查询所有满足条件的用户

        //跳转的页面
        Integer page = (Integer)params.get("page");
        page = Math.min(page,maxPage);

        params.put("start",(page-1)*length);
        params.put("length",length);
        List<User> userList = userDao.selectList(params);

        return new PageInfo(userList,maxPage);
    }

    public String addUser(Map<String,Object> params){
        //将密码统一设置为123456
        params.put("upass",123456);
        int result = userDao.insert(params);
        if(result==1){
            return "success";
        }
        return "false";
    }

    public void deleteUser(Map<String,Object> params){
        userDao.update(params);
    }

    public void editUser(User user){
        Map<String,Object> params = new HashMap<>();
        params.put("uno",user.getUno());
        params.put("uname",user.getUname());
        params.put("truename",user.getTruename());
        params.put("sex",user.getSex());
        params.put("age",user.getAge());

        userDao.update(params);
    }

    public int importUsers(List<User> users){
        int result = 0;
        for(User u:users){
            result += userDao.insert(u);
        }
        return result;
    }

    public User exportUser(Integer uno){
        return userDao.selectUserById(uno);
    }

    public User findUserById(Integer uno){
        return userDao.selectUserById(uno);
    }

    public String updatePwd(Integer uno,String oldPass,String newPass){
        //先查询出相对应的user密码
        User user = userDao.selectUserById(uno);
        //对比原密码和输入原密码是否一致
        if(user.getUpass().equals(oldPass)){//证明原密码正确
            Map<String,Object> params = new HashMap<>();
            params.put("uno",uno);
            params.put("upass",newPass);
            userDao.update(params);
            return "密码修改成功";
        }
        return "原密码错误";//如果原密码失败
    }
}
