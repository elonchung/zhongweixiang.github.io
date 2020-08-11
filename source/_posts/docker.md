---
title: docker 学习 
date: 2020-03-02 13:21:52
categories: 
- Docker
- ES
- Canal 
tags:
- Docker
- ES
- Canal 
toc: true # 是否启用内容索引
keywords: Docker,ES,elasticsearch,logstash,kibana
description: docker 安装elk6.7.0  logstash实现自动同步增量数据
---

## docker 学习



### 数据卷 /数据挂载

- 多容器可以共用同一个宿主挂载的目录





使用方式

	1. 直接 -v 主机目录:容器数据目录
 	2. docker inspect    id  查看挂载  mounts[]

docker run -it --name 子容器 --volumes-from 父容器  镜像





 安装 软件

```shell
# docker命令参数说明
--restart always  随着docker启动而软件自动启动  
-d  后台保护进程启动
-p  端口映射
--name 容器名
-e 其他配置
-v 挂载目录
exec -it 容器名 /bin/bash 进入容器


# 安装 RocketMQ
docker run -d -p 9876:9876 -v /d/develop/rocketmq/data/namesrv/logs:/root/logs -v /d/develop/rocketmq/data/namesrv/store:/root/store --name rmqnamesrv -e "MAX_POSSIBLE_HEAP=100000000" rocketmqinc/rocketmq sh mqnamesrv

docker run -d -p 10911:10911 -p 10909:10909 -v /d/develop/rocketmq/data/broker/logs:/root/logs -v /d/develop/rocketmq/data/broker/store:/root/store --name rmqbroker --link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" rocketmqinc/rocketmq sh mqbroker -c ../conf/broker.conf

docker run -e "JAVA_OPTS=-Drocketmq.namesrv.addr=127.0.0.1:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" -p 8282:8080 -t styletang/rocketmq-console-ng

#安装rabbitmq
docker run -d  --restart always --name rabbitmq3.7.26 -p 5672:5672 -p 15672:15672 -v /d/docker/rabbitmq/data:/var/lib/rabbitmq --hostname myRabbit -e RABBITMQ_DEFAULT_VHOST=my_vhost --restart=always -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin 37ed13330d04

```


### 安装mysql同步canal

````shell
#安装mysql同步canal
docker network create --subnet=172.18.0.0/24 mynetwork
--net mynetwork --ip 172.18.0.2

docker run -p 11111:11111 --name canal-2 -d canal/canal-server:v1.1.4 -v /d/develop/canal/conf:/home/admin/canal-server/conf

docker run -d  --restart always --privileged=true --net mynetwork --ip 172.18.0.8  -v /d/develop/docker/mysql/my.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -v /d/develop/docker/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 --name mysql57 mysql:5.7.30


docker exec -it canal-server bash

tailf -100 canal-server/logs/example/example.log

````

```ini
[mysqld]
log-bin=mysql-bin # 开启binlog
binlog-format=ROW # 选择ROW模式
server_id=1 # 配置MySQL replaction需要定义，不要和Canal的slaveId重复
```

```mysql
# 创建账号
CREATE USER canal IDENTIFIED BY 'canal'; 
# 授予权限
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
-- GRANT ALL PRIVILEGES ON *.* TO 'canal'@'%' ;
# 刷新并应用
FLUSH PRIVILEGES;

show variables like 'log_bin';
show variables like 'binlog_format';
show master status;
```

参考：https://www.cnblogs.com/1124li/p/11713757.html