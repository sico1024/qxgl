package com.service.impl;

import com.dao.FnDao;
import com.domain.Fn;
import com.service.FnService;
import jdbc.JdbcFront;

import java.util.ArrayList;
import java.util.List;

public class FnServiceImpl implements FnService {

    //代理帮忙产生一个接口的实现类
    private FnDao fnDao = new JdbcFront().createDaoImpl(FnDao.class);

    //用于查询所有的功能列表
    public List<Fn> findFnList() {
        //数据库中查询出来的没有规律排布的功能列表集合
        List<Fn> fnList = fnDao.selectList();
        //调用私有的方法将原有的功能列表按规律排布
        return this.reLoadFnList(fnList,-1);

    }

    //设计一个方法 用于将无规律的功能列表排布规律
    private List<Fn> reLoadFnList(List<Fn> fnList,int pno){
        //用于存储最后处理的结果
        List<Fn> result = new ArrayList<>();
        //遍历找寻所有的父功能为pno的功能
        for(Fn fn:fnList){
            if(fn.getPno() == pno){//找到对应父功能的编号
                //判断是按钮还是菜单
                if(fn.getFlag() == 2){//证明是按钮
                    //将按钮存入
                    result.add(fn);
                }else{//证明是菜单
                    List<Fn> children = reLoadFnList(fnList,fn.getFno());
                    fn.setChildren(children);
                    result.add(fn);
                }

            }
        }

        return result;
    }
}
