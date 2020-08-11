---
title: Java商城订单设计
date: 2017-06-28 13:10:09
categories:
- 学习资料
tags:
- 资料
comments: true
toc: true # 是否启用内容索引
keywords: Java,商城,
description: Java商城订单设计
---

```java
/**
 * 生成18位订单编号:8位日期+2位平台号码+2位支付方式+6位以上自增id
 */
private String generateOrderSn(OmsOrder order) {
    StringBuilder sb = new StringBuilder();
    String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
    String key = REDIS_DATABASE+":"+ REDIS_KEY_ORDER_ID + date;
    Long increment = redisService.incr(key, 1);
    sb.append(date);
    sb.append(String.format("%02d", order.getSourceType()));
    sb.append(String.format("%02d", order.getPayType()));
    String incrementStr = increment.toString();
    if (incrementStr.length() <= 6) {
        sb.append(String.format("%06d", increment));
    } else {
        sb.append(incrementStr);
    }
    return sb.toString();
}
```





### 订单下单流程

1. 获取购物车信息

2. 生成下单的商品信息（不同商品有不同信息）

3. 判断购物车中商品是否库存充足

4. 是否使用活动优惠或优惠券（全场通用，指定分类，指定商品） 优惠券处理算出相应金额

5. 积分使用规则

6. 算出最终实付金额

7. 进行锁定库存

8. 根据商品合计、运费、活动优惠、优惠券、积分计算应付金额

9. 订单状态，收货人信息、使用优惠，积分，设置自动收货天数等转化为订单信息并插入数据库 主订单和订单详情表

10. 后续相关操作：修改优惠券，积分计算，删除购物车，发送延迟消息（什么时候超时取消订单）消息队列

    

### 超时支付订单取消    或 订单取消

1. 修改订单状态为交易取消
2. 解除订单商品库存锁定
3. 修改优惠券使用状态
4. 返还使用积分







开发阶段

初期开发，

1. 主体框架完善，基本增删改查，严谨地方（金额，抢购）等把控好。
2. 用户量达到瓶颈，优化代码，考虑加缓存，扩容服务器，备份服务器，负载均衡等
3. 单机优化，JVM优化，数据库慢查询优化，加载时间要求阈值





多线程最多的场景：web服务器本身；各种专用服务器（如游戏服务器）；多线程的常见应用场景：

1、后台任务，例如：定时向大量（100w以上）的用户发送邮件；

2、异步处理，例如：发微博、记录日志等；

3、分布式计算

##### 



ThreadLocal是一种多线程间并发访问变量的解决方案。与synchronized等加锁的方式不同，ThreadLocal完全不提供锁，而使用了以空间换时间的手段，为每个线程提供`变量的独立副本`，以保障线程安全，因此它`不是一种数据共享`的解决方案。

