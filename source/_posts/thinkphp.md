---
title: Thinkphp 的初体验
date: 2016-08-15 16:54:28
categories:
- PHP
tags:
- PHP
toc: true # 是否启用内容索引
---

# 使用版本thinkphp3.2

## 查看运行源码

1. 入口文件（多个应用index.php） -> 公共入口文件(全站共用ThinkPHP.php)（定义常量）
2. Thinkphp引导类文件（项目初始化、include核心文件、相关配置、调试配置、中间件、驱动配置等）
3. App.class.php 执行应用程序（相当于路由，转发到Controller/action等操作）
4. MVC操作执行


## 了解目录结构
1. Application/ 应用目录包含一套MVC目录、自定义全局函数、配置目录等
2. ThinkPHP/
	Runtime/ 系统运行时目录
		Runtime/Logs/ 应用日志目录
		Runtime/Temp/ 应用缓存目录
		Runtime/Data/ 应用数据目录
		Runtime/Cache/ 应用模板缓存目录

	Library/ 系统核心类库目录
		Library/Think/ Think类库目录
		Library/Behavior/ 行为类库目录
		Library/Vendor/	第三方类库目录
	
	Common/ 应用公共目录、全局函数
	Conf/ 应用配置目录
	Lang/ 应用语言目录
	Tpl/ 应用静态目录
	Mode/ 系统应用模式目录

3. index.php 入口文件

## 了解MVC架构

1. Controller 接收用户请求、与Model交互、转发给View数据
2. Model 响应C操作数据库
3. View 接收C的数据并回显给用户信息

## 了解全局函数使用
### Thinkphp.class.php 引导类中做相应的加载。
- 全局函数	
- 项目公共函数
- 自定义函数

## 了解运行的核心文件

开启应用模式后
会生成~runtime.php 将核心文件的内容编译到一个文件中。不用每次都遍历引入核心文件，提高二次加载的效率

## 了解驱动使用

- 以配置方式加载不同驱动。
	例如：数据库支持mysql、sqlite、oracle等
	session 支持memcache/DB/mysqli等

优点：
上手容易，了解目录结构基本知道其运行流程及原理。
整合好一堆SDK ，第三方扩张，轻量级，快速开发。
难点：
就是要记一堆的全局函数的使用。
耦合性比较高。
不太支持平滑升级版本。基本上要重写应用。

