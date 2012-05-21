package com.demo;

import com.demo.main.Launcher;
import com.demo.main.Main;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= OtherConfig.class)
public class OtherConfigTest {
    @Autowired ApplicationContext appContext;

    @Test
    public void testLaunch() {
        appContext.getBean(Launcher.class).launch(OtherConfig.class);
    }
    
    @Test
    public void testMain() {
        Main.main("com.demo.OtherConfig");
    }
}
