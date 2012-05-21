package com.demo.main;

import com.demo.service.Service;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Component;

@Component
public class DefaultLauncher implements Launcher {

    public void launch(Class configCls) {
        AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(configCls);
        Service service = (Service) ctx.getBean("service");
        service.go();
    }
}
