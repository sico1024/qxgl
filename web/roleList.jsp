
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        body html{
            margin: 0;
            padding: 0;
         }
        thead{
            font-weight: bold;
        }
        tr td{
            height: 2.0em;
            text-align: center;
        }
        ul {
            margin: 0;
            padding: 0;
        }

        .filterBox{
            float: left;
            margin-left: 10%;
            margin-bottom: 8px;
            padding: 0;
        }
        li{
            display: inline;
            margin-right: 8px;
            list-style: none;
        }
        .bottom{
            float: right;
            margin-right: 10%;
            margin-top: 8px;
        }
    </style>
    <script>
        window.onload = function(){
            selectByCondition();
            document.getElementById("selectBtn").onclick = function(){
                selectByCondition();
            }
            document.getElementById("cleanSelectBtn").onclick = function(){
                document.getElementById("rnoText").value = "";
                document.getElementById("rnameText").value = "";
                document.getElementById("descriptionText").value = "";
                selectByCondition();
            }
            document.getElementById("showRowSelect").onchange = function(){
                selectByCondition();
            }
            document.getElementById("showPageSelect").onchange = function () {
                selectByCondition();
            }
            document.getElementById("prevPageBtn").onclick = function() {
                var pageSelect = document.getElementById("showPageSelect");
                var pageSelectText = parseInt(pageSelect.value);
                if(1 == pageSelectText){
                    return;
                }
                pageSelectText--;
                pageSelect.value = pageSelectText;
                selectByCondition();
            }
            document.getElementById("nextPageBtn").onclick = function() {
                var pageSelect = document.getElementById("showPageSelect");
                var pageSelectText = parseInt(pageSelect.value);
                var maxPage = pageSelect.childElementCount;
                if(pageSelectText == maxPage){
                    return;
                }
                pageSelectText++;
                pageSelect.value = pageSelectText;
                selectByCondition();
            }
        }
        function selectByCondition() {
            var rno = document.getElementById("rnoText").value;
            var rname = document.getElementById("rnameText").value;
            var description = document.getElementById("descriptionText").value;
            var row = document.getElementById("showRowSelect").value;
            var page = document.getElementById("showPageSelect").value;

            var xhr = new XMLHttpRequest();
            xhr.open("post","roleList.do",true);
            xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            xhr.send("rno="+rno+"&rname="+rname+"&description="+description+"&row="+row+"&page="+page);
            xhr.onreadystatechange = function () {
                if(xhr.readyState== 4 && xhr.status == 200){
                    show(xhr.responseText);
                }
            }
        }

        function show(result){
            var obj = eval('('+result+')');
            var roles = obj.list;
            var maxPage = obj.maxPage;
            //将当前显示的最大页显示在页面上
            var pageSelect = document.getElementById("showPageSelect");
            var nowPage = pageSelect.value;
            pageSelect.innerHTML = '';

            for(var i=1;i<=maxPage;i++){
                pageSelect.innerHTML += '<option>'+i+'</option>';
            }
            if(nowPage < maxPage){
                pageSelect.value = nowPage ;
            }else{
                pageSelect.value = maxPage ;
            }
            //将所有的数据拼接在表格上
            var body = document.getElementById("tableBody");
            //刷新页面
            body.innerHTML = '';
            if(roles.length == 0){
                //没有数据
                body.innerHTML = '<tr><td align="center" colspan="4">没有任何记录</td></tr>' ;
            }
            for(var i=0;i<roles.length;i++){
                var tr = document.createElement("tr");
                body.appendChild(tr);
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                td1.innerText = roles[i].rno;
                td2.innerText = roles[i].rname;
                td3.innerText = roles[i].description;
                td4.innerHTML = '<a href="">编辑</a> | <a href="">删除</a>';
            }

        }
    </script>
</head>
<body>
<div class="title"><h2 align="center">角色列表</h2></div>
<div class="filterBox">
    <ul>
        <li><input id="rnoText" type="text" placeholder="请输入角色编号"></li>
        <li><input id="rnameText" type="text" placeholder="请输入角色名称"></li>
        <li><input id="descriptionText" type="text" placeholder="请输入角色描述"></li>
        <li><input id="selectBtn" type="button" value="查询"></li>
        <li><input id="cleanSelectBtn" type="button" value="清空查询"></li>
    </ul>
</div>
<div class="role-table">
    <table align="center" border="1" width="80%" cellspacing="0">
        <thead>
        <tr>
            <td >角色编号</td>
            <td>角色名称</td>
            <td>角色描述</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody id="tableBody">

        </tbody>
    </table>
</div>

<div class="bottom">
    <ul>
        <li>
            显示
            <select id="showRowSelect">
                <option>5</option>
                <option>10</option>
                <option>15</option>
            </select>
            条
        </li>
        <li>
            跳转
            <select name="" id="showPageSelect">
                <option >1</option>
            </select>
            页
        </li>
        <li>
            <button id="prevPageBtn">上一页</button>
        </li>
        <li>
            <button id="nextPageBtn">下一页</button>
        </li>
    </ul>
</div>
</body>
</html>
