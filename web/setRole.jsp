<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="js/jquery-3.5.1.js" type="text/javascript"></script>
    <style type="text/css">

        html body{
            margin: 0;
            padding: 0;
        }
        h2{
            text-align: center;
        }
        .roleTable{
            float:left;
            width:300px;
            height: 500px;
            border-style: solid;
            border-width: 1px;
        }
        table{
            width: 300px;
        }

        tr{
            font-size: 16px;
            text-align: center;
            margin-bottom: 10px;
        }
        .alreadySet{
            position:absolute;
            top:80px;
            left: 50%;
            margin-left: -450px;
        }
        .notSet{
            position: absolute;
            top:80px;
            left: 50%;
            margin-left: 150px;
        }

        .movBtn{
            position: absolute;
            left: 50%;
            margin-left: -50px;
        }
        .toRightBtn{
            top: 200px;
        }

        .toLeftBtn{
            top: 300px;
        }

        .movBtn input{
            width: 100px;
        }
    </style>
    <script type="text/javascript">
            $(function () {
                //请求获取到已经分配的角色
                $.ajax({
                    url:'linkedRole.do',
                    type:'post',
                    async:true,
                    data:{
                        uno:$('#unoText').val()
                    },
                    success:function (roles) {
                        for(var i = 0;i<roles.length;i++){
                            var role = roles[i];
                            $('#alreadyRole').append('<tr rno="'+role.rno+'"><td>'+role.rno+'</td><td>'+role.rname+'</td></tr>')
                        }
                    },
                    dataType:'json'
                });
                //ajax请求未分配的角色
                $.ajax({
                   url:'unlinkRole.do',
                   type:'post',
                   async:true,
                   data:{
                       uno:$('#unoText').val()
                   } ,
                    success:function(roles){
                        for(var i = 0;i<roles.length;i++){
                            var role = roles[i];
                            $('#unLinkedRole').append('<tr rno="'+role.rno+'"><td>'+role.rno+'</td><td>'+role.rname+'</td></tr>')
                        }
                    },
                   dataType:'json'
                });


            });
    </script>
</head>
<body>
    <input id="unoText" type="hidden" value="${param.uno}">
    <h2>分配角色</h2>
<!--    显示已分配的角色-->
    <div class="roleTable alreadySet">
        <table>
            <thead>
                <tr><th colspan="2" style="color: red;font-size:20px">已分配角色列表</th></tr>
                <tr>
                    <th>角色编号</th>
                    <th>角色名称</th>
                </tr>
            </thead>
            <tbody id="alreadyRole">

            </tbody>
        </table>
    </div>

    <div class="movBtn toRightBtn">
        <input id="toRightBtn" type="button" value=">>>">
    </div>
    <div class="movBtn toLeftBtn">
        <input id="toLeftBtn" type="button" value="<<<">
    </div>
<!--    显示未分配的角色列表-->
    <div class="roleTable notSet">
        <table>
            <thead>
            <tr><th colspan="2" style="color: green;font-size: 20px">未分配角色列表</th></tr>
            <tr>
                <th>角色编号</th>
                <th>角色名称</th>
            </tr>
            </thead>
            <tbody id="unLinkedRole">

            </tbody>
        </table>

    </div>
</body>
</html>
