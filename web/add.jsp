<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统-增加学生</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/notiflix-3.2.6.min.css" />
    <script src="js/notiflix-3.2.6.min.js"></script>
    <style>.nav ul li:nth-child(1) a {color: black;background-color: white;}</style>
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
        <h2>增加学生</h2>
        <%-- Add New Student --%>
        <label for="name">姓名：</label><input type="text" id="name" name="name"> <br />
        <label for="age">年龄：</label><input type="text" id="age" name="age"> <br />
        <input type="submit" value="增加学生" id="add-student-button">
    </main>
    <footer class="footer">
        by <a href="https://xkk1.github.io" target="_blank">小喾苦</a>
    </footer>
    <script>
        document.querySelector("#add-student-button").addEventListener("click", ajax_submit);
        function ajax_submit(){
            Notiflix.Loading.dots('等待服务器的回应……', {
                clickToClose: true,
            });
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
                callback: verify_response
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
        function verify_response(status, resp) {
            Notiflix.Loading.remove();
            if (resp == "success") {
                Notiflix.Report.success(
                    '添加成功',
                    "添加学生成功！",
                    '确定',
                );
            } else {
                Notiflix.Report.failure(
                    '添加学生失败',
                    resp,
                    '确定',
                );
            }
        }
    </script>
</body>
</html>