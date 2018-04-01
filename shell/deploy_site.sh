#!/bin/bash
# 切换到项目根目录
cd /home/github/simple-blog;
# 编译项目
mvn package;
# 删除simplebolg目录
rm -rf /home/apache-tomcat-9.0.6/webapps/simpleblog/;
# 拷贝simpleblog.war到tomcat目录
cp -rf /home/github/simple-blog/target/simpleblog.war /home/apache-tomcat-9.0.6/webapps/;