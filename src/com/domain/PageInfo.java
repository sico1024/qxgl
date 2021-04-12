package com.domain;

import java.util.ArrayList;
import java.util.List;

public class PageInfo {

    private List<User> userList = new ArrayList<>();
    private Integer pageCount;

    public PageInfo(List<User> userList, Integer pageCount) {
        this.userList = userList;
        this.pageCount = pageCount;
    }

    public PageInfo() {
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }
}
