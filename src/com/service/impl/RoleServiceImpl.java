package com.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dao.RoleDao;
import com.domain.MyPageObj;
import com.domain.PageInfo;
import com.domain.Role;
import com.service.RoleService;
import com.util.MySpring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleServiceImpl implements RoleService {
    private RoleDao roleDao = MySpring.getBean("com.dao.impl.RoleDaoImpl");

    public MyPageObj<Role> findRoleByCondition(Integer rno, String rname, String description, Integer row, Integer page) {
        Map<String,Object> params = new HashMap<>();
        params.put("rno",rno);
        params.put("rname",rname);
        params.put("description",description);
        //查询出所有的角色行数总和
        int totalCount = (int) roleDao.selectRoleTotalCount(params);
        //每页显示行数
        int length = row;
        //计算最大页数
        int maxPage = Math.max(1,(int)Math.ceil(1.0*totalCount/length));


        //计算分页查询的开始索引
        //page是当前要查询的页数，length是每页要显示的行数，maxPage是能查询的最大页
        int start = (Math.min(page,maxPage)-1)*length;
        params.put("start",start);
        params.put("length",length);

        List<Role> roleList = roleDao.selectList(params);

        MyPageObj<Role> obj = new MyPageObj<>();
        obj.setList(roleList);
        obj.setMaxPage(maxPage);
        return obj;

    }

    public List<Role> selectAlreadyRole(Integer uno) {
        //组装参数
        Map<String,Object> params = new HashMap<>();
        params.put("uno",uno);
        return roleDao.selectRoleByUserUno(params);
    }

    public List<Role> selectUnlinkedRole(Integer uno) {
        Map<String,Object> params = new HashMap<>();
        params.put("uno",uno);
        return roleDao.selectUnlinkedRoleByUserUno(params);
    }
}
