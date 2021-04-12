package com.controller;

import com.dao.FnDao;
import com.domain.Fn;
import com.service.FnService;
import com.util.MySpring;
import mymvc.RequestMapping;
import mymvc.ResponseBody;

import java.util.List;

public class FnController {

    private FnService fnService = MySpring.getBean("com.service.impl.FnServiceImpl");
    @RequestMapping("fnList.do")
    @ResponseBody
    public List<Fn> fnList(){
        return fnService.findFnList();
    }
}
