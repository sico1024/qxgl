<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .childTag{
            display: none;
        }
        html,body{
            margin: 0;
            padding: 0;
        }
        .top{
            height: 20%;
            width: 100%;
            background-color: #a9a9a9;
        }

        .left{
            height: 80%;
            width: 20%;
            float: left;
            background-color: #dcdcdc;
        }
        .right{
            height: 80%;
            width: 80%;
            float: right;
        }

        .top h1{
            margin: 0;
            position: absolute;
            top: 40px;
            left: 20px;
        }
        .top .user-info{
            margin: 0;
            position: absolute;
            top: 40px;
            right: 20px;
        }

        .top .user-info span{
            color: #008c8c;
        }

        ul li{
            padding: 0;
            list-style: none;
        }

        li{
            margin-left: 18px;
            margin-top: 8px;
        }

        li:hover{
            cursor: default;
        }
        .model-personalInfo{
            width:300px;
            height: 400px;
            background-color: cornflowerblue;
            position: absolute;
            top:50px;
            left: 50%;
            margin-left: -150px;
            z-index: 102;
            display: none;
            border-style: solid;
            border-width: 1px;
            border-color: chocolate;
            border-radius: 10px;
        }
        .model-background{
            width: 100%;
            height: 100%;
            top:0px;
            left: 0px;
            background-color: black;
            opacity: 50%;
            position:absolute;
            z-index: 101;
            display: none;
        }

        .model-personalInfo td{
            height: 3em;
            width: 100px;
        }
        .model-personalInfo .input-info{
            width: 100px;
        }
    </style>
    <script>
        function personalInfo() {
            var models = document.getElementsByClassName("personal");
            for(var i=0;i<models.length;i++){
                models[i].style.display='block';
            }
        }
        window.onload = function () {
            document.getElementById("user-sex").value = "${sessionScope.user.sex}"
            document.getElementById("personal-back").onclick = function(){
                var models = document.getElementsByClassName("personal");
                for(var i=0;i<models.length;i++){
                    models[i].style.display='none';
                }
            }
            document.getElementById("logoutBtn").onclick = function(){
                location.href = "logout.do";
            }

            var fatherTags = document.getElementsByClassName("fatherTag");
            for(var i = 0; i<fatherTags.length; i++){
                var tag = fatherTags[i];
                tag.onclick = function (tag) {
                    var nextTag = this.nextElementSibling;
                    if(nextTag){
                        var display = nextTag.style.display;
                        if(display=='none'){
                            nextTag.style.display = 'block';
                        }else{
                            nextTag.style.display = 'none';
                        }
                    }
                }
            }
        }
    </script>
</head>
<body>
    <%--  上部分 --%>
    <div class="top">
        <h1>渡一教育信息管理系统</h1>
        <div class="user-info">
            欢迎【<span><a href="javascript:personalInfo()">${sessionScope.user.truename}</a></span>】进入系统
        </div>
    </div>
    <%--  左侧--%>
    <div class="left">
        <ul class="menu">
            <li>
                <div class="fatherTag">权限管理</div>
                <ul class="childTag">
                    <li>
                        <div><a href="userList.do" target="right">用户管理</a></div>
                    </li>
                    <li><div><a href="roleList.jsp" target="right">角色管理</a></div></li>
                    <li><div><a href="fnList.jsp" target="right">功能管理</a></div></li>
                </ul>
            </li>
            <li>
                <div class="fatherTag">基本信息管理</div>
                <ul class="childTag">
                    <li><div>商品管理</div></li>
                    <li><div>供应商管理</div></li>
                    <li><div>库房管理</div></li>
                </ul>
            </li>
            <li>
                <div class="fatherTag">经营管理</div>
            </li>
            <li><div class="fatherTag">库存管理</div></li>
            <li><div class="fatherTag">财务管理</div></li>
            <li>
                <div class="fatherTag">系统管理</div>
                <ul class="childTag">
                    <li><div><a href="updatePwd.jsp" target="right">修改密码</a></div></li>
                </ul>
            </li>
        </ul>
    </div>
    <%--  右侧--%>
    <div class="right">
        <iframe name="right" width="100%" height="100%" frameborder="0">

        </iframe>
    </div>
    <div id="personal-back" class="personal model-background"></div>
    <div class="personal model-personalInfo">
        <form action="updateUser.do" method="post">
            <h3 align="center">个人信息</h3>
            <table align="center">
                <input type="hidden" name="uno" value="${sessionScope.user.uno}">
                <tr>
                    <td>用户编号:</td>
                    <td><input class="input-info" type="text" value="${sessionScope.user.uno}" disabled="disabled"></td>
                </tr>
                <tr>
                    <td>用户名:</td>
                    <td><input name="uname" class="input-info" type="text" value="${sessionScope.user.uname}"></td>
                </tr>
                <tr>
                    <td>真实姓名:</td>
                    <td><input name="truename" class="input-info" type="text" value="${sessionScope.user.truename}"></td>
                </tr>
                <tr>
                    <td>年龄:</td>
                    <td><input name="age" class="input-info" type="text" value="${sessionScope.user.age}"></td>
                </tr>
                <tr>
                    <td>性别:</td>
                    <td>
                        <select name="sex" id="user-sex">
                            <option>男</option>
                            <option>女</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" value="提交修改"></td>
                    <td><input id="logoutBtn" type="button" value="注销"></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
