package com.dao;

import com.domain.Fn;
import jdbc.annotations.Select;

import java.util.List;

public interface FnDao {

    @Select("select fno,fname,fhref,flag,ftarget,pno,yl1,yl2 from t_fn where del = 1")
    public List<Fn> selectList();
}
