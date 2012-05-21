package com.demo;

import com.demo.log.LoggerPostProcessor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;

@Configuration
public class CommonConfig {
    @Bean LoggerPostProcessor logging() { return new LoggerPostProcessor(); }
}
