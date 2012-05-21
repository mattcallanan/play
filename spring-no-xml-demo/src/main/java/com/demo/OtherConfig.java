package com.demo;

import com.demo.helper.Helper;
import com.demo.helper.OtherHelper;
import com.demo.service.OtherService;
import com.demo.service.Service;
import org.springframework.context.annotation.*;

@Configuration
@Import(CommonConfig.class)
@ComponentScan(basePackages = {"com.demo"}, excludeFilters = @ComponentScan.Filter(type = FilterType.ANNOTATION, value = Configuration.class))
public class OtherConfig {
    @Bean Service service() { return new OtherService(); }
    @Bean Helper helper() { return new OtherHelper(); }
}
