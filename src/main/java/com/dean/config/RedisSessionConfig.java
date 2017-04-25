package com.dean.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

/**
 * Created by dongxu on 2017/4/25.
 */

@Configuration
@EnableRedisHttpSession
public class RedisSessionConfig {
}
