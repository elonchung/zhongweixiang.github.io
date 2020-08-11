---
title: 常用Maven包 -- pom.xml
---



## Maven -- pom.xml

####  打包相关插件

```xml
<properties>
 <maven.build.timestamp.format>yyyy-MM-dd</maven.build.timestamp.format>
	<project.jar.output.directory>
         G:\packages
 </project.jar.output.directory>
</properties>
<build>
 <plugins>
     <!--用于启动 springboot 插件 ！！！！！试了下，不能和下面插件共存-->
     <plugin>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-maven-plugin</artifactId>
         <configuration>
             <fork>true</fork>
         </configuration>
     </plugin>
     
     <!--用于跳过测试test插件 -->
     <plugin>
         <groupId>org.apache.maven.plugins</groupId>
         <artifactId>maven-surefire-plugin</artifactId>
         <configuration>
             <skip>true</skip>
         </configuration>
     </plugin>
     <!--用于把包打到指定目录插件 -->
     <plugin>
         <artifactId>maven-antrun-plugin</artifactId>
         <executions>
             <execution>
                 <!-- 在maven进行package的时候执行-->
                 <phase>package</phase>  
                 <configuration>
                     <tasks>
                         <!--jar包保存位置 -->
                         <copy todir="${project.jar.output.directory}${maven.build.timestamp}"> 
                             <!--antrun自动生成的配置文件的保存位置，这里默认是父项目的target文件夹 -->
                             <fileset dir="${project.build.directory}">
                                 <include name="*.jar" />
                             </fileset>
                         </copy>
                     </tasks>
                 </configuration>
                 <goals>
                     <goal>run</goal>
                 </goals>
             </execution>
         </executions>
     </plugin>
 </plugins>
</build>
```

