package io.github.xkk1.api;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/api/delStudentPostJson")
public class delStudentPostJson extends HttpServlet {
    private String msg = "";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        io.github.xkk1.Student studentId;
        try {
            request.setCharacterEncoding("UTF-8"); // 获取请求 body 数据，先设置编码
            InputStream is = request.getInputStream();
            ObjectMapper mapper = new ObjectMapper();
            // 简单暴力 直接转换为 Student 对象
            studentId = mapper.readValue(is, io.github.xkk1.Student.class);
            // delStudentPostJsonSystem.out.println("获取的json字符串转换的studentId:" + studentId);
            if (studentId.verifyId(studentId)) {
                this.msg = "500错误 连接数据库失败!";
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
                // 查询此学生是否存在
                String sql1 = "SELECT id FROM StudentInfo WHERE id=?"; // 生成一条 sql 语句
                PreparedStatement ps = conn.prepareStatement(sql1);
                ps.setInt(1, Integer.parseInt(studentId.getId()));
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    this.msg = "删除学生失败！没有学号为“" + studentId.getId() + "”的学生！";
                    // 关闭数据库连接对象
                    conn.close();
                } else {
                    String sql2 = "DELETE FROM studentinfo WHERE id = ?"; // 生成一条sql语句
                    // 创建一个 Statement 对象
                    ps = conn.prepareStatement(sql2);
                    ps.setInt(1, Integer.parseInt(studentId.getId()));
                    // 执行sql语句
                    if (ps.executeUpdate() != 1) {
                        this.msg = "500错误 操作数据库失败!";
                    } else {
                        this.msg = "success";
                    }
                    // 关闭数据库连接对象
                    conn.close();
                    // 为sql语句中第一个问号赋值
                }
            } else {
                if (!"".equals(studentId.getMsg())) {
                    this.msg = studentId.getMsg();
                }
            }

//            String json = "{\n" +
//                    "\t\"userId\": 1,\n" +
//                    "\t\"userName\": \"xxx的博客\",\n" +
//                    "\t\"blogUrl\": \" https: //xxx.xxx.com\",\n" +
//                    "\t\"sex\": \"男\"\n" +
//                    "}";
//
//            //返回结果
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            // 获取PrintWriter对象
//            PrintWriter out = response.getWriter();
//            out.print(json);
//            // 释放PrintWriter对象
//            out.flush();
//            out.close();
        } catch (Exception e) {
            this.msg = "服务器错误！";
        }
        // 返回结果
        response.setCharacterEncoding("UTF-8");
        // 获取PrintWriter对象
        PrintWriter out = response.getWriter();
        out.print(this.msg);
        // 释放PrintWriter对象
        out.flush();
        out.close();
    }
}


