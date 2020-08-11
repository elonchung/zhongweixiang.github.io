---
title: 微服务技术框架生态
date: 2019-07-10 13:21:52
categories: 
- Micro-server
tags:
- Micro-server
toc: true # 是否启用内容索引
keywords: Micro-server
description: 微服务技术框架生态
---

### 了解微服务

- 什么是微服务

- 为什么出现微服务
- 微服务解决问题



### 微服务技术框架生态

1. 微服务框架

   - Dubbo   

   - Spring Cloud

   - Spring Cloud Alibaba

     Dubbo是个微服务整体架构的框架，提供的功能包括服务注册发现，远程调用，监控等等。对标的项目是Spring Cloud。但Spring Cloud是一个系列的软件，有很多组件来拼装提供微服务的总体架构。Dubbo自己全封装了。

2. 注册中心 

   - Eureka
   - Consul
   - Zookeeper

3. 网关

   - Dubbo 
   - gateway

4. 熔断 路由 

   - Zuul  Ribbon Feign
   - Hystrix