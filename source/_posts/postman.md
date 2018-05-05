---
title: Postman模拟登录调试
date: 2016-03-20 10:38:56
categories: 
- 小公举
tags:
- 小公举
toc: true # 是否启用内容索引
keywords: php,Postman,调试,模拟登录调试
description: postman 算是一个神器了，对于后台开发来说简直就是福音。
---
  
# postman模拟登录调试


postman 算是一个神器了，对于后台开发来说简直就是福音。

因为可以直接模拟表单，查看数据等。

## postman入门使用

首先请chrome商店下载postman，选择应用中的postman，拓展程序中的postman interceptor也可以一并安装，这个是为了让我们能够模拟登录用的插件。

[chrome postman下载地址](https://chrome.google.com/webstore/search/postman?utm_source=chrome-ntp-icon)

### 1.了解postman
你可以选择各种请求方式。这里我选的是post。
![1241](/uploads/clip1486265057.png)


### 2. 构造请求表单
如下图，在body标签中，选择form-data，然后构造了一个有四个请求参数的表单。然后点击send就能够请求和返回后台了。

![124](/uploads/clip1486265262.png)

## postman模拟登录请求

### 1. chrome打开postman interceptor
chrome中打开request capture，Filter requests默认是全部都抓取，你可以自定义。

如：localhost:8081表示只拦截本地的8081端口的请求。默认的配置.*配置拦截所有请求，可以使用默认配置不用修改。

![1234](/uploads/clip1486265372.png)

### 2. 在浏览器中登录需要调试的网站
如果你已经的登录了，那么刷新一下网站就好了，主要是让postman interceptor获取到你这个网站的cookie

### 3. 配置postman
在Postman中启用Interceptor，如下图：
![1231](/uploads/clip1486266012.png)


然后你就可以愉快的调试了～