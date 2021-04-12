<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 13063
  Date: 2020/9/14
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        .editUser{
            width: 400px;
            margin: 50px auto 0px;
            background-color: #ccc;
            border: solid indianred 1px;
            border-radius: 8px;
        }
        .editUser h2{
            position: relative;
            top: 10px;
        }
        .editUser table input {
            outline: none;
            height: 25px;
        }
        .editUser table tr{
            height: 35px;
        }

        .editUser .sexInfo{
            position: relative;
            top: -7px;
        }

        .editUser .button{
            width: 80px;
        }

        .editUser tr .right{
            margin-left: 20px;
        }
        .editUser tr .right input{
            margin-left: 50px;
        }
    </style>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById("returnBtn").onclick = function () {
                window.history.back();
            }
        }
    </script>
</head>
<body>
<div class="editUser">
    <h2 align="center">新建用户</h2>
    <form action="editUser.do" method="post">
        <table align="center">
            <input type="hidden" name="uno" value="${param.uno}">
            <tr>
                <td>用户名:</td>
                <td><input type="text" name="uname" value="${param.uname}"></td>
            </tr>
            <tr>
                <td>真实姓名:</td>
                <td><input type="text" name="truename" value="${param.truename}"></td>
            </tr>

            <tr>
                <td>年龄:</td>
                <td><input type="text" name="age" value="${param.age}"></td>
            </tr>
            <tr>
                <td>性别：</td>
                <td>
                    <c:choose>
                        <c:when test="${param.sex=='男'}">
                            <lable><input type="radio" name="sex" value="男" checked="checked"><span class="sexInfo">男</span></lable>
                            <lable class="right"><input type="radio" name="sex" value="女"><span class="sexInfo">女</span></lable>
                        </c:when>
                        <c:otherwise>
                            <lable><input type="radio" name="sex" value="男"><span class="sexInfo">男</span></lable>
                            <lable class="right"><input type="radio" name="sex" value="女" checked="checked"><span class="sexInfo" >女</span></lable>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>
                    <input class="button" type="submit" value="提交">
                </td>
                <td class="right">
                    <input id="returnBtn" class="button" type="button" value="返回">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
