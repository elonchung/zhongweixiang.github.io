---
title: mybatis-开启懒加载
date: 2019-12-09 19:31:23
tags:
- mybatis
toc: true # 是否启用内容索引
keywords: mybatis-开启懒加载
description: mybatis-开启懒加载
---



## mybatis-开启懒加载



```
#配置
mybatis-plus.configuration.lazy-loading-enabled=true #开启懒加载
mybatis-plus.configuration.aggressive-lazy-loading=false #需要时加载

```

### Mybatis懒加载报错末尾显示_$$_jvst12a_0["handler"])的解决方案

1. ### 返回的类加上注解（即实体类）  此种方法比较方便

   @JsonIgnoreProperties(value = { "handler" })

2. 解决方法
   关闭该查询的懒加载 fetchType=“eager”

   <collection ...  fetchType="eager"> </collection>

3. 配置json转换器属性SerializationFeature.FAIL_ON_EMPTY_BEANS为false