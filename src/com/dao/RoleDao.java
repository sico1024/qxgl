package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    List<Role> selectList(Map<String,Object> params);

    long selectRoleTotalCount(Map<String,Object> params);

    List<Role> selectRoleByUserUno(Map<String,Object> params);


    List<Role> selectUnlinkedRoleByUserUno(Map<String,Object> params);
}
