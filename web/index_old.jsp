<%@ page import="java.util.List" %>
<%@ page import="io.github.xkk1.controller.GetStudentsInfo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: xkk
  Date: 2023/5/8
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/notiflix-3.2.6.min.css" />
    <script src="js/notiflix-3.2.6.min.js"></script>
    <style>
      form {
        display: inline-block;
        padding: 6px;
        border-radius: 1rem;
        background-color: rgba(255, 202, 138, 0.1);
      }
      .msg {
        color: red;
      }
      #show-students-info-table {
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        border: 1px solid black;
        border-collapse: collapse;
      }
      #show-students-info-table td,
      #show-students-info-table th {
        border: 1px solid black;
        padding: 5px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <header class="header">
      <h1>学生信息管理系统</h1>
    </header>
    <main class="main">
     <%-- Add New Student --%>
     <form method="post" action="<c:url value="/api/addStudent"/>">
       <h2>添加学生</h2>
       <label for="name">姓名：</label><input type="text" id="name" name="name"><br>
       <label for="age">年龄：</label><input type="text" id="age" name="age"><br>
       <input type="submit" value="添加学生"> <span class="msg">${msg}</span>
     </form>
     <table id="show-students-info-table">
       <thead>
       <tr>
         <th>ID</th>
         <th>姓名</th>
         <th>年龄</th>
         <th>操作（还没实现）</th>
       </tr>
       </thead>
       <%
         try {
           List<List<String>> StudentsInfoList = new GetStudentsInfo().get();
           pageContext.setAttribute("StudentsInfoList", StudentsInfoList);
         } catch (Exception e) {
           throw new RuntimeException(e);
         }
       %>
       <tbody>
         <c:forEach items="${StudentsInfoList}" var="StudentInfo">
           <tr>
             <td>${StudentInfo[0]}</td>
             <td>${StudentInfo[1]}</td>
             <td>${StudentInfo[2]}</td>
             <td><button onclick="delStudent([${StudentInfo[0]},'${StudentInfo[1]}'])">删除</button><button>修改</button></td>
           </tr>
         </c:forEach>
       </tbody>
     </table>
    </main>
  <script>
    function delStudent(StudentInfo) {
      Notiflix.Confirm.show(
              '确认删除',
              '你确定要删除'+StudentInfo[1]+'吗？',
              '确定',
              '取消',
              () => {
                // alert('Thank you.');
              },
              () => {
                // alert('If you say so...');
              },
              {

              },
      );

    }
    let success_msg = "${success_msg}";
    let failure_msg = "${failure_msg}";
    if (success_msg != "") {
      Notiflix.Report.success(
              '成功',
              success_msg,
              '好的',
      );
    }
    if (failure_msg != "") {
      Notiflix.Report.failure(
              '失败',
              failure_msg,
              '确定',
      );
    }
  </script>
  <script>
    function ajax_submit(){
      let name = document.querySelector("#name");
      let age = document.querySelector("#age");
      let json = {
        name: name.value, // 键为username，值为对象的value属性
        age: age.value,
      };
      ajax({
        url: "api/addStudentPostJson",
        method: "post",
        //body上为 json格式的字符串
        contentType: "application/json",
        // JSON.stringify(json) 是将一个json对象序列化成一个字符串，格式是json格式
        body: JSON.stringify(json),
        callback: function(status,resp){
          // alert("后端返回的内容: " + resp)
          console.log(resp);
        }
      });
    }
    function ajax(args){//var ajax = function(){}
      let xhr = new XMLHttpRequest();
      // 设置回调函数
      xhr.onreadystatechange = function(){
        // 4: 客户端接收到响应后回调
        if(xhr.readyState == 4){
          // 回调函数可能需要使用响应的内容，作为传入参数
          args.callback(xhr.status, xhr.responseText);
        }
      }
      xhr.open(args.method, args.url);
      //如果args中，contentType属性有内容，就设置Content-Type请求头
      if(args.contentType){//js中，if判断，除了判断boolean值，还可以判断字符串，对象等，有值就为true
        xhr.setRequestHeader("Content-Type", args.contentType);
      }
      //如果args中，设置了body请求正文，调用send(body)
      if(args.body){
        xhr.send(args.body);
      }else{//如果没有设置，调用send()
        xhr.send();
      }
    }
  </script>
  <footer class="footer">
    by <a href="https://xkk1.github.io" target="_blank">小喾苦</a>
  </footer>
  </body>
</html>
