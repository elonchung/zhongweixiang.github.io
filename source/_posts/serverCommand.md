---
title: rockectMQ安装、启动
date: 2019-11-02 13:21:52
categories: 
- rockectMQ
tags:
- rockectMQ
toc: true # 是否启用内容索引
keywords: rockectMQ
description: rockectMQ安装、启动
---



```shell
 
cd www/server/rocketmq-all-4.7.0-bin-release/bin
# 启动mqnamesrv 

nohup mqnamesrv 1>/www/server/rocketmq-all-4.7.0-bin-release/logs/ng.log 2>/www/server/rocketmq-all-4.7.0-bin-release/logs/ng-err.log &

#启动mqbroker
nohup mqbroker >/www/server/rocketmq-all-4.7.0-bin-release/logs/mq.log &

#启动mqbroker 8088
nohup java -jar /www/server/rocketmq-console-ng-1.0.1.jar &

#防火墙
firewall-cmd --zone=public --add-port=8088/tcp --permanent   
firewall-cmd --reload
```







参考：https://www.cnblogs.com/jing99/p/13166602.html