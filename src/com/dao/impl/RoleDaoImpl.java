package com.dao.impl;

import com.dao.RoleDao;
import com.domain.Role;
import jdbc.JdbcFront;

import java.util.List;
import java.util.Map;

public class RoleDaoImpl implements RoleDao {
    private JdbcFront front = new JdbcFront();

    public List<Role> selectList(Map<String, Object> params) {
        //sql语句 考虑拼接性能
        StringBuilder sql = new StringBuilder("select rno,rname,description,yl1,yl2 from t_role where del = 1 ");

        //如果传入了对应的条件就在sql语句后面拼接上响应的条件筛选语句
        Integer rno = (Integer) params.get("rno");
        if(rno!=null){
            sql.append("and rno=#{rno} ");
        }

        String rname = (String) params.get("rname");
        if(rname!=null && !"".equals(rname)){
            sql.append("and rname like concat('%',#{rname},'%') ");
        }

        String description = (String) params.get("description");
        if(description!=null && !"".equals(description)){
            sql.append("and description like concat('%',#{description},'%') ");
        }

        sql.append("order by createtime desc limit #{start},#{length}");

        return this.front.selectList(sql.toString(),Role.class,params);
    }

    //查询所有符合条件的角色个数
    public long selectRoleTotalCount(Map<String,Object> params){
        StringBuilder sql = new StringBuilder("select count(*) from t_role where del = 1 ");

        Integer rno = (Integer) params.get("rno");
        if(rno!=null){
            sql.append("and rno=#{rno} ");
        }

        String rname = (String) params.get("rname");
        if(rname!=null && !"".equals(rname)){
            sql.append("and rname like concat('%',#{rname},'%') ");
        }

        String description = (String) params.get("description");
        if(description!=null && !"".equals(description)){
            sql.append("and description like concat('%',#{description},'%') ");
        }

        return this.front.selectOne(sql.toString(),Long.class,params);
    }


    public List<Role> selectRoleByUserUno(Map<String, Object> params) {
        String sql = "select r.rno,r.rname from t_role r inner join t_user_role ur on ur.rno=r.rno where uno = #{uno}";

        return front.selectList(sql,Role.class,params);
    }

    public List<Role> selectUnlinkedRoleByUserUno(Map<String, Object> params) {
        String sql = "select rno,rname from t_role where rno not in(select rno from t_user_role where uno = #{uno})";
        return front.selectList(sql,Role.class,params);
    }
}
