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
                <li><a href="check.jsp">查找学生</a></li>
                <li><a href="change.jsp">更改学生</a></li>
            </ul>
        </nav>
    </header>
    <main class="main">
      <h1>还没实现……</h1>
<%--     <table id="show-students-info-table">--%>
<%--       <thead>--%>
<%--       <tr>--%>
<%--         <th>ID</th>--%>
<%--         <th>姓名</th>--%>
<%--         <th>年龄</th>--%>
<%--         <th>操作（还没实现）</th>--%>
<%--       </tr>--%>
<%--       </thead>--%>
<%--       <%--%>
<%--         try {--%>
<%--           List<List<String>> StudentsInfoList = new GetStudentsInfo().get();--%>
<%--           pageContext.setAttribute("StudentsInfoList", StudentsInfoList);--%>
<%--         } catch (Exception e) {--%>
<%--           throw new RuntimeException(e);--%>
<%--         }--%>
<%--       %>--%>
<%--       <tbody>--%>
<%--         <c:forEach items="${StudentsInfoList}" var="StudentInfo">--%>
<%--           <tr>--%>
<%--             <td>${StudentInfo[0]}</td>--%>
<%--             <td>${StudentInfo[1]}</td>--%>
<%--             <td>${StudentInfo[2]}</td>--%>
<%--             <td><button>修改</button></td>--%>
<%--           </tr>--%>
<%--         </c:forEach>--%>
<%--       </tbody>--%>
<%--     </table>--%>
<%--    </main>--%>
<%--  <script>--%>
<%--    function delStudent(StudentInfo) {--%>
<%--      Notiflix.Confirm.show(--%>
<%--              '确认删除',--%>
<%--              '你确定要删除'+StudentInfo[1]+'吗？',--%>
<%--              '确定',--%>
<%--              '取消',--%>
<%--              () => {--%>
<%--                // alert('Thank you.');--%>
<%--              },--%>
<%--              () => {--%>
<%--                // alert('If you say so...');--%>
<%--              },--%>
<%--              {--%>

<%--              },--%>
<%--      );--%>
<%--    }--%>
<%--  </script>--%>
  <footer class="footer">
    by <a href="https://xkk1.github.io" target="_blank">小喾苦</a>
  </footer>
  </body>
</html>
