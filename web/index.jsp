
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>登录</title>
    <style>
      html body{
        margin: 0;
        padding:0;
      }
      .loginText{
        position: absolute;
        top: 50%;
        margin-top: -200px;
        left: 50%;
        margin-left: -200px;
        width: 400px;
        height: 230px;
        background-color: cornflowerblue;
        border-style: solid;
        border-width: 3px;
        border-color: chocolate;
        border-radius: 10%;
        z-index: 99;
      }

      .loginText tr{
        font-family: Arial;
        font-size: 18px;
        height: 2em;
      }

      .loginText .textInfo{
        color: #000 ;
      }

      .loginText #submitButton{
        padding-top: 1.5em;
      }
      .loginText #submitButton input{
        width: 120px;
      }
      .loginText #submitButton input:hover{
        color: cornflowerblue;
      }

      .loginText .inputText input{
        width: 180px;
        height: 2em;
        background-color: #f5f5dc;
        padding-left: 0.5em;;
      }

      .loginText .inputText input:focus{
        background-color: #f5f5ba;
      }
      .loginText #loginError{
        height: 1em;
      }
      .loginText #loginError td{

        font-size: 12px;
        height: 13px;
        color: red;
      }
      .background{
        float: left;
        width: 100%;
        height:100%;
        background-color: #234;
        z-index: 98;
      }
    </style>
  </head>
  <body>
    <div class="loginText">
      <form action="login.do" method="post">
        <h2 align="center">渡一教育权限系统</h2>
        <table align="center">
          <tr id="loginError">
            <td  colspan="2">${param.login=="0"?"用户名或密码错误":""}</td>
          </tr>
          <tr>
            <td class="textInfo">账号：</td>
            <td class="inputText"><input type="text" name="uname"></td>
          </tr>
          <tr>
            <td class="textInfo">密码：</td>
            <td class="inputText"><input type="password" name="upass"></td>
          </tr>
          <tr>
            <td id="submitButton" colspan="2" align="center">
              <input type="submit" value="登录">
            </td>
          </tr>
        </table>
      </form>
    </div>
    <div class="background"></div>
  </body>
</html>
