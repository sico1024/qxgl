<%--
  Created by IntelliJ IDEA.
  User: 13063
  Date: 2020/9/10
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建用户</title>
    <style type="text/css">
        .addUser{
            width: 400px;
            margin: 50px auto 0px;
            background-color: #ccc;
            border: solid indianred 1px;
            border-radius: 8px;
        }
        .addUser h2{
            position: relative;
            top: 10px;
        }
        .addUser table input {
            outline: none;
            height: 25px;
        }
        .addUser table tr{
            height: 35px;
        }

        .addUser .sexInfo{
            position: relative;
            top: -7px;
        }

        .addUser .button{
            width: 80px;
        }

        .addUser tr .right{
            margin-left: 20px;
        }
        .addUser tr .right input{
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
    <div class="addUser">
        <h2 align="center">新建用户</h2>
        <form action="addUser.do" method="post">
            <table align="center">
                <tr>
                    <td>用户名:</td>
                    <td><input type="text" name="uname"></td>
                </tr>
                <tr>
                    <td>真实姓名:</td>
                    <td><input type="text" name="truename"></td>
                </tr>

                <tr>
                    <td>年龄:</td>
                    <td><input type="text" name="age"></td>
                </tr>
                <tr>
                    <td>性别：</td>
                    <td>
                        <lable><input type="radio" name="sex" value="男" checked="checked"><span class="sexInfo">男</span></lable>
                        <lable class="right"><input type="radio" name="sex" value="女"><span class="sexInfo">女</span></lable>
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
