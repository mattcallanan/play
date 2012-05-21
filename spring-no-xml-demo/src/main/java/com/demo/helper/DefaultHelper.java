package com.demo.helper;

import com.demo.log.Log;
import org.slf4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class DefaultHelper implements Helper {
    @Log Logger log;

    public void help() {
        log.info("DefaultHelper.help");
    }
}
