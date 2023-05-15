package io.github.xkk1.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SearchStudentServlet {
    public static final String URL = "jdbc:mysql://localhost:3306/StudentInfoManager";
    public static final String USER = "root";
    public static final String PASSWORD = "123456";

    public List<List<String>> get(String id){
        try {
            // 1.加载驱动程序
            Class.forName("com.mysql.jdbc.Driver");
            // 2. 获得数据库连接
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            //3 .操作数据库，实现增删改查
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, name, age FROM StudentInfo WHERE id LIKE '%"+ id +"%'");
            List<List<String>> studentsInfo = new ArrayList<>();
            while (rs.next()) {
                List<String> studentInfo = new ArrayList<>();
                // studentInfo.add(String.valueOf(rs.getInt("id")));
                studentInfo.add(String.valueOf(rs.getString("id")));
                studentInfo.add(rs.getString("name"));
                studentInfo.add(String.valueOf(rs.getInt("age")));
                studentsInfo.add(studentInfo);
            }
            conn.close();
            return studentsInfo;
        } catch (Exception e) {
            List<List<String>> studentsInfo = new ArrayList<>();
            List<String> studentInfo = new ArrayList<>();
            studentInfo.add("-1");
            studentInfo.add("服务器错误");
            studentInfo.add("-1");
            studentsInfo.add(studentInfo);
            return studentsInfo;
        }
    }
}
