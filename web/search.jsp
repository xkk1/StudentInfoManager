<%@ page import="java.util.List" %>
<%@ page import="io.github.xkk1.controller.SearchStudentServlet" %>
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
    <title>学生信息管理系统-查找学生</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/notiflix-3.2.6.min.css" />
    <script src="js/notiflix-3.2.6.min.js"></script>
    <style>.nav ul li:nth-child(3) a {color: black;background-color: white;}</style>
  </head>
  <body>
    <header class="header">
        <h1>学生信息管理系统</h1>
        <nav class="nav">
            <ul>
                <li><a href="add.jsp">增加学生</a></li>
                <li><a href="del.jsp">删除学生</a></li>
                <li><a href="search.jsp">查找学生</a></li>
                <li><a href="change.jsp">更改学生</a></li>
            </ul>
        </nav>
    </header>
    <main class="main">
        <h2>查找学生</h2>
        <%-- Add New Student --%>
        <label for="id">学号：</label> <input type="text" id="id" name="id"> <br />
        <input type="submit" value="查找" id="search-student-button">
        <c:if test='<%=request.getParameter("id") != null && ! "".equals(request.getParameter("id"))%>'>
        <script>
            document.querySelector("#id").value = "<%=request.getParameter("id")%>";
        </script>
        <table id="show-students-info-table">
            <thead>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>年龄</th>
                <th>操作</th>
            </tr>
            </thead>
            <%
                try {
                    List<List<String>> StudentsInfoList = new SearchStudentServlet().get(request.getParameter("id"));
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
                    <td><button onclick="delStudent(['${StudentInfo[0]}','${StudentInfo[1]}'])">删除</button>&ensp;
                        <button onclick="changeStudent(['${StudentInfo[0]}','${StudentInfo[1]}','${StudentInfo[2]}'])">修改</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </c:if>
        <c:if test='<%=!(request.getParameter("id") != null && ! "".equals(request.getParameter("id")))%>'>
            <h3>请输入您要查询的学号</h3>
        </c:if>
    </main>
    <script>
        document.querySelector("#search-student-button").addEventListener("click", go_search);
        function go_search() {
            let id = document.querySelector("#id").value;
            if (id == null || id === "") {
                Notiflix.Report.failure('查找学生失败','未提供学号！','确定',);
                return;
            } else if (! /^\d*$/.test(id)) {
                Notiflix.Report.failure('查找学生失败', '非法的学号！学号只能是非负整数！', '确定',);
                return;
            }
            window.location.href = window.location.origin + window.location.pathname + "?id=" + id;
        }
        function delStudent(StudentInfo) {
            Notiflix.Confirm.show(
                '确认删除',
                '你确定要删除'+StudentInfo[1]+'吗？',
                '确定',
                '取消',
                () => {
                    ajax_submit_del_student_from_id(StudentInfo[0]);
                },
                () => {
                    // alert('If you say so...');
                },
                {

                },
            );
        }
        function ajax_submit_del_student_from_id(id) {
            if (id == null) {
                Notiflix.Report.failure('删除学生失败','未提供学号！','确定',);
                return;
            } else if (! /^\d*$/.test(id)) {
                Notiflix.Report.failure('删除学生失败', '非法的学号！学号只能是非负整数！', '确定',);
                return;
            }
            Notiflix.Loading.dots('等待服务器的回应……', {
                clickToClose: true,
            });
            let json = {
                id: id, // 键为id，值为 id
            };
            ajax({
                url: "api/delStudentPostJson",
                method: "post",
                //body上为 json格式的字符串
                contentType: "application/json",
                // JSON.stringify(json) 是将一个json对象序列化成一个字符串，格式是json格式
                body: JSON.stringify(json),
                callback: verify_response1
            });
        }
        function changeStudent(StudentInfo) {
            var NewStudentInfo = ["","","", StudentInfo[0]];
            NewStudentInfo[0] = prompt("请输入新的学号：", StudentInfo[0]);
            if (NewStudentInfo[0] == null || NewStudentInfo[0] === "") {
                return;
            }
            NewStudentInfo[1] = prompt("请输入新的姓名：", StudentInfo[1]);
            if (NewStudentInfo[1] == null || NewStudentInfo[1] === "") {
                return;
            }
            NewStudentInfo[2] = prompt("请输入新的年龄：", StudentInfo[2]);
            if (NewStudentInfo[2] == null || NewStudentInfo[2] === "") {
                return;
            }
            ajax_submit_new_student_info(NewStudentInfo);
            // Notiflix.Confirm.prompt(
            //     '更改学生信息：','请输入新的学号：',StudentInfo[0],'确认','取消',
            //     (clientAnswer) => {
            //         NewStudentInfo[0] = clientAnswer;
            //         Notiflix.Confirm.prompt(
            //             '更改学生信息：','请输入新的姓名：',StudentInfo[1],'确认','取消',
            //             (clientAnswer) => {
            //                 NewStudentInfo[1] = clientAnswer;
            //                 Notiflix.Confirm.prompt(
            //                     '更改学生信息：','请输入新的年龄：',StudentInfo[2],'确认','取消',
            //                     (clientAnswer) => {
            //                         NewStudentInfo[2] = clientAnswer;
            //                         ajax_submit_new_student_info(NewStudentInfo);
            //                     },
            //                     (clientAnswer) => {},{},
            //                 );
            //             },
            //             (clientAnswer) => {},{},
            //         );
            //     },
            //     (clientAnswer) => {},{},
            // );
        }
        function ajax_submit_new_student_info(NewStudentInfo) {
            Notiflix.Loading.dots('等待服务器的回应……', {
                clickToClose: true,
            });
            let json = {
                id: NewStudentInfo[0], // 键为id，值为 id
                name: NewStudentInfo[1],
                age: NewStudentInfo[2],
                oldId: NewStudentInfo[3],
            };
            ajax({
                url: "api/changeStudentPostJson",
                method: "post",
                //body上为 json格式的字符串
                contentType: "application/json",
                // JSON.stringify(json) 是将一个json对象序列化成一个字符串，格式是json格式
                body: JSON.stringify(json),
                callback: verify_response2
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
        function verify_response1(status, resp) {
            Notiflix.Loading.remove();
            if (resp == "success") {
                Notiflix.Report.success(
                    '删除成功',
                    "删除学生成功！",
                    '确定',
                    () => {
                        location.reload();
                    }
                );
            } else {
                Notiflix.Report.failure(
                    '删除学生失败',
                    resp,
                    '确定',
                );
            }
        }
        function verify_response2(status, resp) {
            Notiflix.Loading.remove();
            if (resp == "success") {
                Notiflix.Report.success(
                    '更改成功',
                    "更改学生信息成功！",
                    '确定',
                    () => {
                        location.reload();
                    }
                );
            } else {
                Notiflix.Report.failure(
                    '更改学生信息失败',
                    resp,
                    '确定',
                );
            }
        }
    </script>
  <footer class="footer">
    by <a href="https://xkk1.github.io" target="_blank">小喾苦</a>
  </footer>
  </body>
</html>
