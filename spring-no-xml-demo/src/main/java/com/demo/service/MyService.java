package com.demo.service;

import com.demo.log.Log;
import com.demo.helper.Helper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MyService implements Service {
    @Autowired Helper helper;
    @Log Logger log;
    
    public void go() {
        log.info("MyService.go");
        helper.help();
    }
}
