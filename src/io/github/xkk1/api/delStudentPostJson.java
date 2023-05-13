package io.github.xkk1.api;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
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
import java.util.Map;

@WebServlet("/api/delStudentPostJson")
public class delStudentPostJson extends HttpServlet {
    private String msg = "";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        StudentId studentId= null;
        try {
            request.setCharacterEncoding("UTF-8"); // 获取请求 body 数据，先设置编码
            InputStream is = request.getInputStream();
            ObjectMapper mapper = new ObjectMapper();
            // 简单暴力 直接转换为 Student 对象
            studentId = mapper.readValue(is, StudentId.class);
            // delStudentPostJsonSystem.out.println("获取的json字符串转换的studentId:" + studentId);
            if (verify(studentId)) {
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
                String sql = "DELETE FROM studentinfo WHERE id = ?"; // 生成一条sql语句
                // 创建一个 Statement 对象
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(studentId.getId()));
                // 执行sql语句
                if(ps.executeUpdate() != 1) {
                    this.msg = "500错误 操作数据库失败!";
                } else {
                    this.msg = "success";
                }
                // 关闭数据库连接对象
                conn.close();
                // 为sql语句中第一个问号赋值
            }

//            String json = "{\n" +
//                    "\t\"userId\": 1,\n" +
//                    "\t\"userName\": \"pan_junbiao的博客\",\n" +
//                    "\t\"blogUrl\": \" https: //blog.csdn.net/pan_junbiao\",\n" +
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
    public boolean verify(StudentId studentId) {
        if ("".equals(studentId.getId())) {
            this.msg = "学生ID不能为空！";
            return false;
        }
        try {
            int i = Integer.parseInt(studentId.getId());
            if (i < 0) {
                this.msg = "学生ID不能为负数！";
                return false;
            }
        } catch (NumberFormatException e) {
            this.msg = "学生ID不合法！";
            return false;
        }
        return true;
    }
    static class StudentId {
        private String id;

        @Override
        public String toString() {
            // return super.toString();
            return "StudentID{" +
                    "id='" + id + "'}";
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }
    }
}


