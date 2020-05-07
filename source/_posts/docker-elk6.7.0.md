---
title: docker 安装elk6.7.0
date: 2020-05-02 13:21:52
categories: 
- Docker
- ES
tags:
- Docker
- ES
toc: true # 是否启用内容索引
keywords: Docker,ES,elasticsearch,logstash,kibana
description: docker 安装elk6.7.0  logstash实现自动同步增量数据
---



### docker 安装elk6.7.0  logstash实现自动同步增量数据

- 拉取容器并安装sebp/elk:670

```
docker run -it --privileged=true -p 5601:5601 -p 9200:9200  -p 5044:5044  -p 9300:9300 -v /opt/elasticsearch/elk-data:/var/lib/elasticsearch/data -v /opt/elasticsearch/plugins:/opt/elasticsearch/plugins  -v /opt/elasticsearch/logstash:/opt/logstash/config/config-mysql --name elk7 sebp/elk:670
```



```
cd /opt/elasticsearch/logstash/config/config-mysql
```



进入配置目录

下载mysql-connector-java-5.1.46.jar

新建goods.conf 和 goods_increment.conf 



全量配置goods.conf

```ini
input {
   jdbc {
        jdbc_connection_string => "jdbc:mysql://172.17.0.1:3306/wl-produce-mall?characterEncoding=UTF-8&useSSL=false&autoReconnect=true"
        jdbc_user => "wltest"
        jdbc_password => "wltest"
        #此处的路径最好是绝对路径，行对路径取决与允许命令的目录
        jdbc_driver_library => "../config/config-mysql/mysql-connector-java-5.1.46.jar"
        jdbc_driver_class => "com.mysql.jdbc.Driver"
        jdbc_default_timezone =>"Asia/Shanghai"
	jdbc_paging_enabled => "true"
        jdbc_page_size => "50000"
        #此处的路径最好是绝对路径，行对路径取决与允许命令的目录
        #statement => "SELECT * FROM wp_goods WHERE  goods_status in (4,6) AND last_update_time > :sql_last_value AND last_update_time < NOW() ORDER BY last_update_time DESC"
        statement => "select * from wp_goods where goods_status in (4,6) "
		#statement => "SELECT * FROM wp_goods WHERE  goods_status IN (4,6) AND last_update_time > UNIX_TIMESTAMP( :sql_last_value )*1000 AND last_update_time < UNIX_TIMESTAMP(NOW())*1000 ORDER BY last_update_time DESC"
		#use_column_value => "true"
       	#tracking_column => "last_update_time"
       	#tracking_column_type => "numeric"
		#tracking_column_type => "timestamp"
		#record_last_run => "true"
	 	#last_run_metadata_path => "/opt/elk/other/config-mysql/lastquery"
		clean_run => "true"
		#statement_filepath => "/opt/elk/other/config-mysql/exec.sql"
#        schedule => "*/5 * * * * *"
		schedule => "*/2 * * * * *"
        type => "goods"
    }
}



output {
        
        #设置窗口日志输出
        stdout {
          codec => json_lines
        }

        if [type] == "goods" {
                elasticsearch {
                hosts => ["localhost:9200"]
                #注意index的值不支持大写字母
                index => "goods"
                #document_type自行设置，不设置时，默认为doc
                #document_type => "goods2"
                #此处的值来自查询sql中的列名称，根据需要自行配置
                document_id => "%{id}"
        }
    }
}

```



自增配置goods_increment.conf

```ini
input {
   jdbc {
        jdbc_connection_string => "jdbc:mysql://172.17.0.1:3306/wl-produce-mall?characterEncoding=UTF-8&useSSL=false&autoReconnect=true"
        jdbc_user => "wltest"
        jdbc_password => "wltest"
        #此处的路径最好是绝对路径，行对路径取决与允许命令的目录
        jdbc_driver_library => "../config/config-mysql/mysql-connector-java-5.1.46.jar"
        jdbc_driver_class => "com.mysql.jdbc.Driver"
        jdbc_default_timezone => "Asia/Shanghai"
	   	jdbc_paging_enabled => "true"
        jdbc_page_size => "50000"
        #此处的路径最好是绝对路径，行对路径取决与允许命令的目录
        #statement => "SELECT * FROM wp_goods WHERE  goods_status in (4,6) AND last_update_time > :sql_last_value AND last_update_time < NOW() ORDER BY last_update_time DESC"
        #statement => "select * from wp_goods where goods_status in (4,6) "
		statement => "SELECT * FROM wp_goods WHERE  goods_status IN (4,5,6,7) AND last_update_time > UNIX_TIMESTAMP( :sql_last_value )*1000 AND last_update_time < UNIX_TIMESTAMP(NOW())*1000 ORDER BY last_update_time DESC"
	#use_column_value => "true"
       #	tracking_column => "last_update_time"
       # tracking_column_type => "numeric"
	#tracking_column_type => "timestamp"
		#record_last_run => "true"
	 	#last_run_metadata_path => "/opt/elk/other/config-mysql/lastquery"
		clean_run => "false" 
		#statement_filepath => "/opt/elk/other/config-mysql/exec.sql"
       # schedule => "* * * * *"
		schedule => "*/5 * * * * *"
        type => "goods"
    }
}

output {
        
        #设置窗口日志输出
        stdout {
          codec => json_lines
        }

        if [type] == "goods" {
                elasticsearch {
                hosts => ["localhost:9200"]
                #注意index的值不支持大写字母
                index => "goods"
                #document_type自行设置，不设置时，默认为doc
                #document_type => "goods"
                #此处的值来自查询sql中的列名称，根据需要自行配置
                document_id => "%{id}"
        }
    }
}

```

>  **注意坑**：在容器中如果访问宿主ip数据库使用：172.17.0.1

先执行goods.conf导入所有商品数据

```cmd
命令：
docker ps -a 

进入容器：
docker exec -it 容器id或名称 /bin/bash

cd /opt/logstash/bin

./logstash -f ../config/config-mysql/goods.conf 

成功后 ctrl+c 停止

nohub ./logstash -f ../config/config-mysql/goods_increment.conf  >/dev/null &

如果已经有执行的logstash任务可以加一个参数：--path.data=/config/config-mysql

查看日志
tailf /opt/elasticsearch/logstash/conf/nohup.out
```

