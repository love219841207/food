package com.dean.config;

import com.dean.util.IdWorker;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by dongxu on 2017/5/11.
 */
/*@Configuration*/
public class SnowflakeConfig {
    @Bean
    IdWorker initIdWorker(){
        return new IdWorker(0,0);
    }
}
