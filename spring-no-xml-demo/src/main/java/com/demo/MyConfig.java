package com.demo;

import com.demo.service.MyService;
import com.demo.service.Service;
import org.springframework.context.annotation.*;

@Configuration
@Import(CommonConfig.class)
@ComponentScan(basePackages = {"com.demo"}, excludeFilters = @ComponentScan.Filter(type = FilterType.ANNOTATION, value = Configuration.class))
public class MyConfig {
    @Bean Service service() { return new MyService(); }
}
