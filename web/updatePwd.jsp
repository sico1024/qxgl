
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html>
<head>
    <style>
        .mainPanel{
            width: 300px;
            height: 280px;
            position: absolute;
            top: 100px;
            left: 50%;
            margin-left: -150px;
            background-color: cornflowerblue;
            border-style: solid;
            border-width: 2px;
            border-color: chocolate;
            border-radius: 10px;
        }
        .mainPanel td{
            height: 3em;
        }

        .mainPanel td .inputText {
            width: 120px;
        }
        .pass-error{
            color: red;
            position: relative;
            left: 135px;
            top:16px;
            font-size: 12px;
            display: none;
        }
    </style>

    <script>
        window.onload = function(){
            document.getElementById("submitBtn").onclick = function(){
                var oldPass = document.getElementById("oldPass").value;
                var newPass = document.getElementById("newPass").value;
                var ensurePass = document.getElementById("ensurePass").value;
                if(""==oldPass||""==newPass||""==ensurePass||oldPass==null||newPass==null||ensurePass==null){
                    alert("请将信息填入完整");
                    return;
                }
                if(newPass!=ensurePass){
                    alert("两次输入密码不一致");
                    return;
                }
                var xhr = new XMLHttpRequest();
                xhr.open("post","updatePwd.do",true);
                xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                xhr.send("oldPass="+oldPass+"&newPass="+newPass);
                xhr.onreadystatechange = function () {
                    if(xhr.readyState==4 && xhr.status == 200){
                        doBack(xhr.responseText);
                    }
                }
            }
            function doBack(result){
                alert(result);
                if("原密码错误"==result){
                    document.getElementById("oldPass").style.borderColor = 'red';
                }else if("密码修改成功"==result){
                    location.href = "updatePwd.jsp";
                }
            }
        }
    </script>
</head>
<body>
    <div class="mainPanel">
        <h3 align="center">修改密码</h3>
        <span class="pass-error">原密码错误</span>
        <table align="center">
            <tr>
                <td>原密码：</td>
                <td><input id="oldPass" name="oldPass" type="password" class="inputText"></td>
            </tr>
            <tr>
                <td>新密码：</td>
                <td><input id="newPass" name="newPass" type="password" class="inputText"></td>
            </tr>
            <tr>
                <td>确认密码：</td>
                <td><input id="ensurePass" type="password" class="inputText"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input id="submitBtn" type="button" value="提交修改"></td>
            </tr>
        </table>
    </div>
</body>
</html>
