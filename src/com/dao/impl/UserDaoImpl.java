package com.dao.impl;

import com.dao.UserDao;
import com.domain.User;
import jdbc.JdbcFront;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDaoImpl implements UserDao {

    //orm框架的使用对象
    private JdbcFront front = new JdbcFront();

    //这个方法用于按照用户名查找方法
    public User selectOne(String uname) {

        String sql = "select uno,uname,upass,truename,age,sex,yl1,yl2 from t_user where uname=#{uname} and del=1";
        Map<String,String> param = new HashMap<>();
        param.put("uname",uname);

        return this.front.selectOne(sql,User.class,param);
    }

    //查询所有符合条件得用户个数
    public long totalCount(Map<String,Object> params){
        StringBuilder sql = new StringBuilder("select count(*) from t_user where del=1 and uno!=#{userUno} ");

        Integer uno = (Integer) params.get("uno");
        if(uno!=null){
            sql.append("and uno=#{uno} ");
        }

        String uname = (String) params.get("uname");
        if(uname!=null && !"".equals(uname)){
            sql.append("and uname like concat(#{uname},'%') ");
        }
        String sex = (String) params.get("sex");
        if(sex!=null && !"".equals(sex)){
            sql.append("and sex=#{sex} ");
        }

        return this.front.selectOne(sql.toString(),Long.class,params);
    }


    //这个方法用于按照三个条件查找相对应的用户
    public List<User> selectList(Map<String,Object> params){
        StringBuilder sql = new StringBuilder("select uno,uname,truename,age,sex,yl1,yl2 from t_user where del=1 and uno!=#{userUno} ");

        Integer uno = (Integer) params.get("uno");
        if(uno!=null){
            sql.append("and uno=#{uno} ");
        }

        String uname = (String) params.get("uname");
        if(uname!=null&&!"".equals(uname)){
            sql.append("and uname like concat(#{uname},'%') ");
        }
        String sex = (String) params.get("sex");
        if(sex!=null&&!"".equals(sex)){
            sql.append("and sex=#{sex} ");
        }
        sql.append("order by createtime desc limit #{start} , #{length} ");
        return front.selectList(sql.toString(),User.class,params);
    }

    public User selectUserById(Integer uno){
        Map<String,Object> param = new HashMap<>();
        param.put("uno",uno);
        String sql = "select uno,uname,upass,truename,sex,age,yl1,yl2 from t_user where del=1 and uno=#{uno}";
        return front.selectOne(sql,User.class,param);
    }

    public int insert(Map<String,Object> params){
        String sql = "insert into t_user values(null,#{uname},#{upass},#{truename},#{sex},#{age},1,now(),#{yl1},#{yl2})";
        return front.insert(sql,params);
    }

    public int insert(User user){
        String sql = "insert into t_user values(null,#{uname},#{upass},#{truename},#{sex},#{age},1,now(),#{yl1},#{yl2})";
        return front.insert(sql,user);
    }

    public int update(Map<String,Object> params){
        StringBuilder sql = new StringBuilder("update t_user set yl1=#{yl1} ");

        String uname = (String)params.get("uname");
        if(uname!=null&&!"".equals(uname)){
            sql.append(",uname=#{uname}");
        }

        String upass = (String)params.get("upass");
        if(upass!=null&&!"".equals(upass)){
            sql.append(",upass=#{upass} ");
        }

        String truename = (String)params.get("truename");
        if(truename!=null&&!"".equals(truename)){
            sql.append(",truename=#{truename} ");
        }

        String sex = (String)params.get("sex");
        if(sex!=null&&!"".equals(sex)){
            sql.append(",sex=#{sex} ");
        }

        Integer age = (Integer)params.get("age");
        if(age!=null&&!"".equals(age)){
            sql.append(",age=#{age} ");
        }

        Integer del = (Integer) params.get("del");
        if(del!=null){
            sql.append(",del=#{del} ");
        }
        sql.append("where uno=#{uno}");
        return front.update(sql.toString(),params);
    }
}
