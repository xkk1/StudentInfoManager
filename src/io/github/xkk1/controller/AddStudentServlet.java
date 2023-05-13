package io.github.xkk1.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Arrays;

@WebServlet("/api/addStudent")
public class AddStudentServlet extends HttpServlet {
    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 设置客户端编码格式
            request.setCharacterEncoding("UTF-8");
            // 接收客户端传递参数
            String name = request.getParameter("name");
            String ageStr = request.getParameter("age");
            // 判断参数是否为空
            if (name == null || "".equals(name.trim())) {
                // 提示用户信息
                request.setAttribute("failure_msg", "学生姓名不能为空！");
                // 请求转发跳转到login.jsp
                request.getRequestDispatcher("/index_old.jsp").forward(request, response);
                return;
            }
            if (ageStr == null || "".equals(ageStr.trim())) {
                // 提示用户信息
                // request.setAttribute("failure_msg", "学生年龄不能为空！");
                // 请求转发跳转到 index_old.jsp
                // request.getRequestDispatcher("/index_old.jsp").forward(request, response);
                // 设置信息到 session 作用域
                request.setAttribute("failure_msg", "学生年龄不能为空！");
                // 跳转到 index_old.jsp
                response.sendRedirect("../index_old.jsp");
                return;
            }
            int age;
            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                // 提示用户信息
                request.setAttribute("failure_msg", "学生年龄不合法！");
                // 请求转发跳转到 index_old.jsp
                request.getRequestDispatcher("/index_old.jsp").forward(request, response);
                return;
            }
            // 加载数据库驱动
            Class.forName("com.mysql.jdbc.Driver");
            // 声明数据库view的URL
            String url = "jdbc:mysql://localhost:3306/StudentInfoManager";
            // 数据库用户名
            String user = "root";
            // 数据库密码
            String password = "123456";
            // 建立数据库连接，获得连接对象conn
            Connection conn = DriverManager.getConnection(url, user, password);
            String sql = "INSERT INTO studentinfo (name, age) VALUES (?, ?)"; // 生成一条sql语句
            // 创建一个 Statement 对象
            PreparedStatement ps = conn.prepareStatement(sql);
            // 为sql语句中第一个问号赋值
            ps.setString(1, name);
            // 为sql语句中第二个问号赋值
            ps.setInt(2, age);
            // 执行sql语句
            ps.executeUpdate();
            // 关闭数据库连接对象
            conn.close();
            request.getRequestDispatcher("/index_old.jsp").forward(request, response);
        } catch (Exception e) {
            // throw new RuntimeException(e);
            // 设置信息到 session 作用域
            request.setAttribute("failure_msg", "500错误！<br />服务器错误！"+ Arrays.toString(e.getStackTrace()));
            // 跳转到 index_old.jsp
            request.getRequestDispatcher("/index_old.jsp").forward(request, response);
        }

    }
}
