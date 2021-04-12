
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style type="text/css">
        body html{
            margin:0;
            padding:0;
        }
        th,td{
            height: 2.0em;
            text-align: center;
        }
        h2{
            text-align: center;
        }
        .filter{
            float: left;
            margin-left: 10%;
            margin-bottom: 8px;
            padding: 0;
        }
        ul{
            padding: 0;
            margin: 0;
        }
        li{
            list-style: none;
            margin-right: 8px;
            display: inline;
        }

        .bottom{
            margin: 0;
            padding: 0;
            float: right;
            margin-right: 10%;
            margin-top: 8px;
        }

        .model-importUsers{
            position: absolute;
            top: 50%;
            margin-top: -200px;
            left: 50%;
            margin-left: -250px;
            z-index: 99;
            width: 500px;
            height: 300px;
            background-color: cornflowerblue;
            border-style: solid;
            border-width: 2px;
            border-color: chocolate;
            border-radius: 10px;
            display: none;
        }

        .model-back{
            width:100%;
            height:100%;
            background-color: #000;
            z-index: 98;
            position: absolute;
            top: 0;
            left: 0;
            opacity: 50%;
            display: none;
        }


    </style>
    <script>
        window.onload = function () {
            //将页面带回来的性别信息填写再页面上
            document.getElementById("sexSelect").value = '${requestScope.sex}';
            //显示当前数据有多少页
            var pageCount = document.getElementById("r_maxPage").value;
            var pageSelect = document.getElementById("pageSelect");
            for (var i=1;i<=pageCount;i++){
                pageSelect.innerHTML +='<option>'+i+'</option>';
            }
            //携带回来的性别参数显示在当前页
            var r_sex = document.getElementById("r_sex").value;
            document.getElementById("sexSelect").value = r_sex;
            //携带回来的每页显示行数显示在当前页面
            var r_row = document.getElementById("r_row").value;
            document.getElementById("row").value = r_row;
            //携带回来的当前页数显示在当前页面
            var r_page = document.getElementById("r_page").value;
            minPage = Math.min(parseInt(r_page),parseInt(pageCount));
            document.getElementById("pageSelect").value = minPage;
            //给查询按钮绑定事件
            var selectBtn = document.getElementById('selectBtn');
            selectBtn.onclick = function(){
                doRequest();
            }
            //给清空按钮绑定事件
            document.getElementById("clearSelectBtn").onclick = function () {
                document.getElementById("unoInp").value = "";
                document.getElementById("unameInp").value = "";
                document.getElementById("sexSelect").value = "";
                doRequest();
            }

            //给上一页绑定按钮事件
            document.getElementById("prevBtn").onclick = function(){
                parseInt(r_page);
                if(r_page==1){
                    return;
                }
                r_page--;
                document.getElementById("pageSelect").value = r_page;
                doRequest();
            }
            //给下一页绑定按钮事件
            document.getElementById("nextBtn").onclick = function () {
                parseInt(r_page);
                parseInt(pageCount);
                if(r_page==pageCount){
                    return;
                }
                r_page++;
                document.getElementById("pageSelect").value = r_page;
                doRequest();
            }
            //给显示行数的下拉框绑定事件
            document.getElementById("row").onchange = function () {
                doRequest();
            }
            //给显示的页数下拉框绑定事件
            document.getElementById("pageSelect").onchange = function(){
                doRequest();
            }

            //发送请求
            var doRequest = function() {
                var uno = document.getElementById("unoInp").value;
                var uname = document.getElementById("unameInp").value;
                var sex = document.getElementById("sexSelect").value;
                var row = document.getElementById("row").value;
                var page = document.getElementById("pageSelect").value;
                location.href = 'userList.do?uno='+uno+'&uname='+uname+'&sex='+sex+'&row='+row+'&page='+page+'';
            }

            document.getElementById("addUser").onclick = function () {
                location.href = "addUser.jsp";
            }

            document.getElementById("check-all").onclick = function(){
                var value = this.checked;
                var checkBoxes = document.getElementsByClassName("check-box");
                for(var i=0;i<checkBoxes.length;i++){
                    checkBoxes[i].checked = value;
                }

            }

             var boxes = document.getElementsByClassName("check-box");
            for(var i=0;i<boxes.length;i++){
                boxes[i].onclick = function () {
                    if (this.checked == false) {
                        document.getElementById("check-all").checked = false;
                    }
                }
            }


            document.getElementById("deleteListBtn").onclick = function(){
                var selectBoxes = document.getElementsByClassName("check-box");
                var unos = "";
                for(var i=0;i<selectBoxes.length;i++){
                    if(selectBoxes[i].checked==true){
                        unos += selectBoxes[i].value + ",";
                    }
                }
                if(unos.length==0){
                    alert("请选择要删除的用户");
                    return;
                }
                unos = unos.substr(0,unos.length-1);
                location.href = "deleteList.do?checkBox="+unos;
            }

            document.getElementById("importUsers").onclick = function(){
                var models = document.getElementsByClassName("model");
                for(var i=0;i<models.length;i++){
                    models[i].style.display='block';
                }
            }
            document.getElementById("modelBack").onclick = function(){
                var models = document.getElementsByClassName("model");
                for(var i=0;i<models.length;i++){
                    models[i].style.display='none';
                }
            }

            document.getElementById("downloadBtn").onclick = function(){
                location.href = "downloadTemplate.do";
            }

            document.getElementById("exportBtn").onclick = function(){
                var checkBox = document.getElementsByClassName("check-box");
                var unos = "";
                for(var i=0;i<checkBox.length;i++){
                    if(checkBox[i].checked==true){
                        unos += checkBox[i].value+",";
                    }
                }
                if(unos.length==0){
                    alert("请选择要导出的用户");
                    return;
                }
                unos = unos.substr(0,unos.length-1);
                location.href = "exportUsers.do?unos="+unos;
            }
        }


        var deleteUser = function (uno) {
            var result = confirm("确认删除该用户？");
            if(result==false){
                return;
            }
            location.href = "deleteUser.do?uno="+uno;
        }
    </script>
</head>
<body>
<%--用于获取request携带回来得值--%>
    <input id="r_maxPage" type="hidden" value="${requestScope.info.pageCount}">
    <input id="r_uno" type="hidden" value="${requestScope.uno}">
    <input id="r_uname" type="hidden" value="${requestScope.uname}">
    <input id="r_sex" type="hidden" value="${requestScope.sex}">
    <input id="r_row" type="hidden" value="${requestScope.row}">
    <input id="r_page" type="hidden" value="${requestScope.page}">
    <h2>用户列表</h2>
<%--    上面的筛选条件--%>
    <div class="filter">
        <ul>
            <li><input id="unoInp" type="text" placeholder="请输入编号" value="${requestScope.uno}"></li>
            <li><input id="unameInp" type="text" placeholder="请输入用户名关键字" value="${requestScope.uname}"></li>
            <li>
                <select name="sex" id="sexSelect">
                    <option value="">==性别==</option>
                    <option >男</option>
                    <option >女</option>
                </select>
            </li>
            <li><input id="selectBtn" type="button" value="查询"></li>
            <li><input id="clearSelectBtn" type="button" value="清空查询"></li>
            <li><input id="addUser" type="button" value="新建用户"></li>
            <li><input id="deleteListBtn" type="button" value="批量删除"></li>
            <li><input id="importUsers" type="button" value="批量导入"></li>
            <li><input id="exportBtn" type="button" value="批量导出"></li>
        </ul>
    </div>
<%--    中间显示的表格--%>
    <div>
        <table  align="center" cellspacing="0" border="1" width="80%">
            <thead>
                <tr>
                    <th><input type="checkbox" id="check-all"></th>
                    <th>用户编号</th>
                    <th>用户名</th>
                    <th>真实姓名</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${requestScope.info.userList.size() == 0}">
                        <tr>
                            <td>嗷嗷，没有任何记录</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${requestScope.info.userList}" var="user">
                            <tr>
                                <td><input type="checkbox" value="${user.uno}" class="check-box"></td>
                                <td>${user.uno}</td>
                                <td>${user.uname}</td>
                                <td>${user.truename}</td>
                                <td>${user.sex}</td>
                                <td>${user.age}</td>
                                <td>
                                    <a href="editUser.jsp?uno=${user.uno}&uname=${user.uname}&truename=${user.truename}&sex=${user.sex}&age=${user.age}">编辑</a> |
                                    <a href="javascript:deleteUser(${user.uno})" >删除</a>|
                                    <a href="setRole.jsp?uno=${user.uno}">分配角色</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>

        </table>
    </div>
<%--    下面跳转页等功能--%>
    <div class="bottom">
        <ul>
            <li>显示
                <select name="row" id="row">
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="15">15</option>
                </select>
                条
            </li>
            <li>跳转

                <select name="page" id="pageSelect">

                </select>
                页
            </li>
            <li><input id="prevBtn" type="button" value="上一页"></li>
            <li><input id="nextBtn" type="button" value="下一页"></li>
        </ul>
    </div>

    <div class="model-importUsers model">
        <form action="importUsers.do" method="post" enctype="multipart/form-data">
            <table align="center">
                <tr><td><h2>批量导入</h2></td></tr>
                <tr>
                    <td><input id="downloadBtn" type="button" value="下载导入模板"></td>
                </tr>
                <tr>
                    <td>
                        <input type="file" name="excel" value="请选择文件">
                    </td>
                </tr>

                <tr>
                    <td><input type="submit" value="提交文件"></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="modelBack" class="model-back model"></div>
</body>
</html>
