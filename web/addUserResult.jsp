<%--
  Created by IntelliJ IDEA.
  User: 13063
  Date: 2020/9/11
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册结果</title>
    <script type="text/javascript">
        window.onload = function(){
            var result = document.getElementById("result").value;
            if("success"==result){
                alert("新建成功");
                location.href = "userList.do";
            }else{
                alert("新建失败");
                window.history.back();
            }
        }
    </script>
</head>
<body>
    <input id="result" type="hidden" value="${param.result}">
</body>
</html>
