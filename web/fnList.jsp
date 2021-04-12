
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <script>
            window.onload = function(){
                selectFn();




            }

            function selectFn(){
                //异步ajax请求查询功能列表
                var xhr = new XMLHttpRequest();
                xhr.open("post","fnList.do",true);
                xhr.send();
                xhr.onreadystatechange = function(){
                    if(xhr.readyState == 4 && xhr.status == 200){
                        doBack(xhr.responseText);
                    }
                    function doBack(result){
                        var fns = eval('('+result+')');

                        var showDiv = document.getElementById("show");

                        showFn(fns,showDiv);
                        function showFn(fns,position){
                            //拼接
                            var ul = document.createElement('ul');
                            position.appendChild(ul);
                            for(var i=0;i<fns.length;i++){
                                var fn = fns[i];

                                var li = document.createElement('li');
                                ul.appendChild(li);
                                var div = document.createElement('div');
                                li.appendChild(div);
                                div.innerHTML = fn.fname;
                                if (fn.children && fn.children.length>0){
                                    showFn(fn.children,li);
                                }
                            }
                        }
                    }
                }
            }
        </script>
        <style>
            li {
                list-style: none;
                margin-top: 8px;
            }
        </style>
    </head>
    <body>
        <div id="show">

        </div>
    </body>
</html>
