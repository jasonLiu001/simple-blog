package cn.lands.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import cn.lands.Parameters;
import cn.lands.utils.DBUtils;
import org.apache.log4j.PropertyConfigurator;

import java.io.File;

public class ContextLoaderListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub

    }

    @Override
    public void contextInitialized(ServletContextEvent arg0) {
        // 检测表是否已经创建
        DBUtils.detectTable();
        String webRootPath = arg0.getServletContext().getRealPath("/");
        Parameters.WEB_ROOT_PATH = webRootPath;
        //log4j 配置文件路径
        PropertyConfigurator.configure(Parameters.LOG4J_CONFIG_PATH);
    }

}
