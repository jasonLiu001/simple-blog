#!/bin/bash
# 编译项目
mvn package;
# 停止tomcat服务
sh /home/apache-tomcat-9.0.6/bin/shutdown.sh;
# 删除simplebolg目录
rm -rf /home/apache-tomcat-9.0.6/webapps/simpleblog/;
# 拷贝simpleblog.war到tomcat目录
cp -rf /home/github/simple-blog/target/simpleblog.war /home/apache-tomcat-9.0.6/webapps/;
# 启动tomcat服务
sh /home/apache-tomcat-9.0.6/bin/startup.sh;