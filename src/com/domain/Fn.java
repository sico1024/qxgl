package com.domain;

import java.io.Serializable;
import java.util.List;

public class Fn implements Serializable {
    private Integer fno;
    private String fname;
    private String fhref;
    private Integer flag;
    private String ftarget;
    private Integer pno;

    private Fn pfn;
    private String yl1;
    private String yl2;

    private List<Fn> children;//用来存储当前菜单的子菜单或子按钮

    public List<Fn> getChildren() {
        return children;
    }

    public void setChildren(List<Fn> children) {
        this.children = children;
    }

    public Fn() {
    }

    public Fn(Integer fno, String fname, String fhref, Integer flag, String ftarget, Integer pno, Fn pfn, String yl1, String yl2) {
        this.fno = fno;
        this.fname = fname;
        this.fhref = fhref;
        this.flag = flag;
        this.ftarget = ftarget;
        this.pno = pno;
        this.pfn = pfn;
        this.yl1 = yl1;
        this.yl2 = yl2;
    }

    public Integer getFno() {
        return fno;
    }

    public void setFno(Integer fno) {
        this.fno = fno;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getFhref() {
        return fhref;
    }

    public void setFhref(String fhref) {
        this.fhref = fhref;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public String getFtarget() {
        return ftarget;
    }

    public void setFtarget(String ftarget) {
        this.ftarget = ftarget;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public Fn getPfn() {
        return pfn;
    }

    public void setPfn(Fn pfn) {
        this.pfn = pfn;
    }

    public String getYl1() {
        return yl1;
    }

    public void setYl1(String yl1) {
        this.yl1 = yl1;
    }

    public String getYl2() {
        return yl2;
    }

    public void setYl2(String yl2) {
        this.yl2 = yl2;
    }

}
