package com.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyPageObj<T> {
    private List<T> list;

    private Integer maxPage;

    public Integer getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(Integer maxPage) {
        this.maxPage = maxPage;
    }

    public MyPageObj(List<T> list, Integer maxPage) {
        this.list = list;
        this.maxPage = maxPage;
    }

    public MyPageObj(){}

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

}
