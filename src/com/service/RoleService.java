package com.service;

import com.domain.MyPageObj;
import com.domain.Role;

import java.util.List;

public interface RoleService {

    MyPageObj<Role> findRoleByCondition(Integer rno, String rname, String description, Integer row, Integer page);

    List<Role> selectAlreadyRole(Integer uno);
    List<Role> selectUnlinkedRole(Integer uno);


}
