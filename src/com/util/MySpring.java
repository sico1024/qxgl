package com.util;

import java.util.HashMap;
import java.util.Map;

public class MySpring {

    //有一个集合用来存储所有的对象
    private static Map<String,Object> beanBox = new HashMap<>();


    //给一个类全名帮你管理对象，ioc实现单例
    //工具类为了方便调用方法采用静态的方式
    public static <T> T getBean(String className){
        T obj = (T)beanBox.get(className);
        if(obj==null){//证明集合内没有该类型的对象需要创建一个
            //为了防止多线程并发产生的问题，这里用锁保证对象创建是单例的
            synchronized(beanBox){
                //双重判断保证安全性
                obj = (T)beanBox.get(className);
                if(obj==null){
                    try {
                        //反射创建对象，将对象存入集合之中
                        Class clazz = Class.forName(className);
                        obj = (T)clazz.newInstance();
                        beanBox.put(className,obj);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return obj;
    }
}
