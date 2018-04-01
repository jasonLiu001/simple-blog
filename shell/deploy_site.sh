#!/bin/bash
# 切换到项目根目录
cd /home/github/simple-blog;
# 编译项目
mvn clean package;
# 停止tomcat服务
# sh /home/apache-tomcat-9.0.6/bin/shutdown.sh;
# 删除simplebolg目录及文件
rm -rf /home/apache-tomcat-9.0.6/webapps/simpleblog/;
rm -rf /home/apache-tomcat-9.0.6/webapps/simpleblog.war;
# 拷贝simpleblog.war到tomcat目录
cp -rf /home/github/simple-blog/target/simpleblog.war /home/apache-tomcat-9.0.6/webapps/;
# 启动tomcat服务
# sh /home/apache-tomcat-9.0.6/bin/startup.sh;