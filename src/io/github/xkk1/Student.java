package io.github.xkk1;

public class Student {
    private String id;
    private String name;
    private String age;
   public String msg;

    public Student() {
        this.name = "";
        this.age = "0";
        this.msg = "";
    }

    public Student(String name) {
        this.name = name;
        this.age = "0";
        this.msg = "";
    }

    public Student(String name, String age) {
        this.name = name;
        this.age = age;
        this.msg = "";
    }

    public Student(String name, String age, String msg) {
        this.name = name;
        this.age = age;
        this.msg = msg;
    }

    @Override
    public String toString() {
        // return super.toString();
        return "Student{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean verify(Student student) {
        if ("".equals(student.getName())) {
            this.msg = "学生姓名不能为空！";
            return false;
        }
        if ("".equals(student.getAge())) {
            this.msg = "学生年龄不能为空！";
            return false;
        }
        try {
            int i = Integer.parseInt(student.getAge());
            if (i < 0) {
                this.msg = "学生年龄不能为负数！";
                return false;
            }
        } catch (NumberFormatException e) {
            this.msg = "学生年龄不合法！";
            return false;
        }
        return true;
    }

    public boolean verifyId(Student studentId) {
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
}
