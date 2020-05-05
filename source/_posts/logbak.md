---
title: logback.xml
---



### logback.xml



##### application.properties

```properties
# 开发环境配置
# 数据源配置，请修改为你项目的实际配置
spring.datasource.url=jdbc:log4jdbc:mysql://localhost:3306/test
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.driver-class-name=net.sf.log4jdbc.sql.jdbcapi.DriverSpy
```

##### log4jdbc.log4j2.properties

```properties
# If you use SLF4J. First, you need to tell log4jdbc-log4j2 that you want to use the SLF4J logger
log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
log4jdbc.auto.load.popular.drivers=false
log4jdbc.drivers=com.mysql.jdbc.Driver
```

##### logback.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds" debug="false">
    <contextName>ModelName</contextName>
    <property name="log.charset" value="utf-8" />
    <property name="LOG_HOME" value="G:\logs\platform" />
    <property name="log.pattern" value="%black(%contextName-) %red(%d{yyyy-MM-dd HH:mm:ss}) %green([%thread]) %highlight(%-5level) %boldMagenta(%logger{36}) - %gray(%msg%n)" />

    <!--输出到控制台-->
    <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>${log.charset}</charset>
        </encoder>
    </appender>

    <!--普通日志输出到控制台-->
    <root level="info">
        <appender-ref ref="console" />
    </root>

    <!--监控sql日志输出 -->
    <logger name="jdbc.sqlonly" level="INFO" additivity="false">
        <appender-ref ref="console" />
    </logger>

    <logger name="jdbc.resultset" level="ERROR" additivity="false">
        <appender-ref ref="console" />
    </logger>

    <!--  如想看到表格数据，将OFF改为INFO  -->
    <logger name="jdbc.resultsettable" level="OFF" additivity="false">
        <appender-ref ref="console" />
    </logger>

    <logger name="jdbc.connection" level="OFF" additivity="false">
        <appender-ref ref="console" />
    </logger>

    <logger name="jdbc.sqltiming" level="OFF" additivity="false">
        <appender-ref ref="console" />
    </logger>

    <logger name="jdbc.audit" level="OFF" additivity="false">
        <appender-ref ref="console" />
    </logger>
</configuration>
```

```XML
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
	<!-- 该配置主要是打印  logback 的配置信息 -->
	<statusListener class="ch.qos.logback.core.status.OnConsoleStatusListener"/>
	
	<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
		<encoder>
			<pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
		</encoder>
	</appender>
 	
 	<appender name="ACCESS" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!-- 按天回滚 daily -->
			<fileNamePattern>logs/access-%d{yyyy-MM-dd}.log</fileNamePattern>
			<!-- 日志最大的历史 10天 -->
			<maxHistory>10</maxHistory>
		</rollingPolicy>
		<encoder>
			<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger - %msg%n</pattern>
		</encoder>
		<!-- 日志级别限制 -->
		<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
			<level>INFO</level>
			<onMatch>ACCEPT</onMatch>
			<onMismatch>DENY </onMismatch>
		</filter>
		<!--日志文件最大的大小 -->
		<triggeringPolicy
			class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
			<MaxFileSize>10MB</MaxFileSize>
		</triggeringPolicy>
	</appender>
 	
 	<!--sql 打印在控制台-->
 	<logger name="jdbc.sqltiming" level="INFO">
 		<appender-ref ref="console" />
 	</logger>
 	
 	<logger name="jdbc.resultsettable" level="INFO"></logger>
 	<logger name="jdbc.sqlonly" level="OFF"></logger>
 	<logger name="jdbc.audit" level="OFF"></logger>
 	<logger name="jdbc.resultset" level="OFF"></logger>
 	<logger name="jdbc.connection" level="OFF"></logger>
	
        <!--同时记录log日志-->	
 	<root level="INFO">
 		<appender-ref ref="ACCESS" />
 	</root>
	
</configuration>
```