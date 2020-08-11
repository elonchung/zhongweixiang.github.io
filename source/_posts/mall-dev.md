---
title: Java商城开发相关技术和模块设计
date: 2017-06-28 13:10:09
categories:
- 学习资料
tags:
- 资料
comments: true
toc: true # 是否启用内容索引
keywords: Java,商城,
description: Java商城开发相关技术和模块设计
---

#### Java商城开发相关技术和模块设计

- 框架选择  springcloud alibaba

  - 注册中心consul
  - config
  - gateway   dubbo
  - security
  - 缓存redis
  - 事务使用seata
  - rabbitmq
  - 定时任务quartz
  - 整合springboot -admin
  - ORM mybatis-plus
  - 统一错误处理、日志aop
  - canal同步数据
  - elk搜索
  - logback.xml
  - 公共方法

- mall结构

  - 商城
    - 商品模块
      - 商品展示、分类
      - 购物车
      - 优惠券
      - 商品抢购
    - 订单模块
    - 物流模块
    - 支付模块
    - 评论模块
    - 用户中心
  - 管理中心
    - 商品
      - 商品发布管理
      - 商品分类管理
      - sku管理
      - 商品属性管理
      - 价格管理
    - 订单管理
      - 发货
      - 退货
      - 单据查询 报表
    - 物流信息管理
    - 用户权限控制
      - 用户角色
      - 用户
      - 用户权限-模块
      - 用户权限-模块操作节点
    - 运营管理
      - 广告展示
      - 抢购设置
      - 首页设置
      - 网站基础配置

  