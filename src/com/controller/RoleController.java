package com.controller;

import com.domain.MyPageObj;
import com.domain.Role;
import com.service.RoleService;
import com.util.MySpring;
import mymvc.RequestMapping;
import mymvc.RequestParam;
import mymvc.ResponseBody;

import java.util.List;


public class RoleController {
    private RoleService roleService = MySpring.getBean("com.service.impl.RoleServiceImpl");

    //这个方法用于处理按条件查找用户角色
    @RequestMapping("roleList.do")
    @ResponseBody
    public MyPageObj<Role> roleList(@RequestParam("rno")Integer rno,@RequestParam("rname") String rname,@RequestParam("description") String description,@RequestParam("row") Integer row,@RequestParam("page") Integer page){
        return roleService.findRoleByCondition(rno,rname,description,row,page);
    }


    @RequestMapping("linkedRole.do")
    @ResponseBody
    public List<Role> linkedRole(@RequestParam("uno")Integer uno){
        return roleService.selectAlreadyRole(uno);
    }

    @RequestMapping("unlinkRole.do")
    @ResponseBody
    public List<Role> unlinkRole(@RequestParam("uno")Integer uno){
        List<Role> result = roleService.selectUnlinkedRole(uno);
        return result;
    }
}
