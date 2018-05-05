---
title: 高级PHP知识点
date: 2017-07-10 10:21:34
categories: 
- PHP 
tags:
- PHP
toc: true # 是否启用内容索引
keywords: php,悲观锁,乐观锁,高级PHP
description: 高级PHP知识点
---

## 1. mysqli

*   类似与PDO，是一个存取mysql的函数库，php官方推荐
*   与PDO相比

    *   它仅支持mysql，PDO支持12中不同的数据库引擎
    *   两者都提供了OOP的支持，但是mysqli还支持函数式（过程式）的API
    *   **PDO支持名称式参数，mysqli不支持**，例如：  
	
	```php
	$params = array(':username' => 'test', ':email' => $mail, ':last_login' => time() - 3600);  
	$pdo->prepare('  
		SELECT * FROM users  
	  	WHERE username = :username  
	  	AND email = :email  
	  	AND last_login > :last_login');
	$pdo->execute($params);  
	```

## 2. 如何在PHP中保持长链接

*   polling &amp; long polling 最基本，废弃，性能差
*   websocket 高并发不能用select，win要用iocp，linux要用epoll（现成的扩展libevent）
*   高并发继续增长，单进程的websocket无法满足，拆成多进程，新问题：进程间通信、负载均衡、session唯一等，现成方案可以使用swoole

 ## 3. php内存泄露

*   问题：当你在Linux下频繁存取文件后,物理内存会很快被用光,当程序结束后,内存不会被正常释放,而是一直作为caching。解决方案：处理一个文件后手动释放一下内存（sync &amp;&amp; echo 3 &gt; /proc/sys/vm/drop_caches）
*   症状都表现为内存占用的持续增长
*   php.ini中的auto_append_file和auto_prepend_file可以在每个请求前后注入代码，配合查询/proc/{$pid}/status中的相应记录可以知道每个进程内存占用情况，php可以使用getmypid()函数获取当前进程的id
*   php5.2使用引用计数垃圾回收机制，php5.3使用“引用计数系统中的同步周期回收”（Concurrent Cycle Collection in Reference Counted Systems），是在引用计数的基础上加入了同步循环回收，可以解决循环引用引起的内存泄漏。

## 4. 事务里如果不同表的引擎不同会怎样

* MyISAM不支持事务，InnoDB支持
* 语句会正常执行，但不支持事务的引擎涉及的表会无法回滚

## 5. explain里面有两列是跟索引有关的，是什么？

*  possible_keys：可能可以利用的索引的名字。这里的索引名字是创建索引时指定的索引昵称；如果索引没有昵称，则默认显示的是索引中第一个列的名字（在本例中，它是“firstname”）。默认索引名字的含义往往不是很明显。
*  key：它显示了MySQL实际使用的索引的名字。如果它为空（或NULL），则MySQL不使用索引。
*  key_len：索引中被使用部分的长度，以字节计

## 6. SQL如何调优？如何发现执行慢的SQL？

*   使用mysql的慢日志来记录所有的慢sql，默认记录执行时间超过10s的sql
*   使用explain来分析sql的执行情况；
*   使用show processlist; 命令查看当前mysql的运行情况；

## 7. memcached集群如何存储数据和保持一致性？

*   取模算法
*   一致性哈希算法
*   session与一般缓存数据在服务器级别分离，将session存在独立的服务器池中
*   使用magent缓存代理实现高可用（session重建可用这种方式避免）

## 8. 数据库是如何做集群的，主备之间是如何做数据同步的？

*   mysql本身支持主从同步的设置，在my.conf中做相应设置（client id），原理是基于主数据库的日志，在从服务器上执行日志中相同的sql
*   阿里的Cobar，官方的MySQL Cluster（商业案例不多）
*   读写分离，会增加开发的复杂度，读取的数据也不容易保证实时

## 9. 解释下php-fpm的相关概念和作用

*   CGI是一个协议，FastCGI是CGI的升级，还是一个协议，php-fpm是fastCGI的PHP实现，
参考：[https://segmentfault.com/q/1010000000256516](https://segmentfault.com/q/1010000000256516)
*   实现了FastCGI协议的PHP进程管理器，PHP5.3以后才被官方默认加入，之前只是个第三方插件
*   功能包括：

    *   支持平滑停止/启动的高级进程管理功能；
    *   可以工作于不同的 uid/gid/chroot 环境下，并监听不同的端口和使用不同的 php.ini 配置文件（可取代 safe_mode 的设置）；
    *   stdout 和 stderr 日志记录;
    *   发生意外情况的时候能够重新启动并缓存被破坏的 opcode;
    *   文件上传优化支持;
    *   &#8220;慢日志&#8221; &#8211; 记录脚本（不仅记录文件名，还记录 PHP backtrace 信息，可以使用 ptrace或者类似工具读取和分析远程进程的运行数据）运行所导致的异常缓慢;
    *   fastcgi_finish_request() &#8211; 特殊功能：用于在请求完成和刷新数据后，继续在后台执行耗时的工作（录入视频转换、统计处理等）；
    *   动态／静态子进程产生；
    *   基本 SAPI 运行状态信息（类似Apache的 mod_status）；
    *   基于 php.ini 的配置文件。

## 10. 悲观锁和乐观锁 [参考连接](http://www.cnblogs.com/Bob-FD/p/3352216.html)

*   悲观锁：假定会发生并发冲突，一上来先加锁，再进行读写操作。优点：没有脏读，缺点：数据加锁时间较长，影响并发性能
*   乐观锁：假定不会发生并发冲突，只在提交更改时才加锁，读取和更改时并不加锁。优点：并发性能好，缺点：有脏读的可能
*   结论：在实际生产环境里边,如果并发量不大且不允许脏读，可以使用悲观锁解决并发问题；但如果系统的并发非常大的话,悲观锁定会带来非常大的性能问题,所以我们就要选择乐观锁定的方法.

## 11. 接口加密措施

*   加密算法：MD5、Sha1、Sha256、AES/DES、非对称加密（公钥私钥）
*   加签名：传递的信息为明文，仅做防篡改校验
*   直接对接口传递的信息进行加密，即传递的信息非明文，加密算法可以使用上述加密算法
*   https协议，整个请求使用ssl进行加密，传递的信息非明文，但是用fiddle等工具仍可解密，因此敏感信息仍需结合上述两种方法进行加密和防篡改
*   OAuth2.0
    * 例子：Jane (用户,资源的所有者) 将自己度假的照片 (受保护资源) 上传到了图片分享网站A (服务提供方).她现在想要在另外一个网站B (Client, 消费方) 在线打印这些照片. 一般情况下, Jane 需要使用自己的用户名和密码登陆网站A.但是, Jane 并不希望将自己的用户名和密码泄露给网站B. 可是网站B需要访问图片分享网站A的图片并将其打印出来.
	*  基于令牌（token）的身份认证和权限控制，平安玩的passport就是OAuth2.0的一个实现

## 12. nginx如何配置负载均衡 [参考连接](http://blog.csdn.net/xyang81/article/details/51702900)

*   Nginx负载均衡是通过upstream模块来实现的
*   内置实现了三种负载策略：

    *   轮询（默认）：根据请求次数，将每个请求均匀分配到每台服务器，可以为每台服务器分配不同的权重（weight，默认为1），权重高的被分配的几率相应增大
    *   最少连接：将请求分配到连接数最少的服务器上，Nginx会统计哪些服务器的连接数最少
    *   IP Hash：使用hash算法将客户端IP分配到不同的服务器上，后续该IP的所有请求均分配到之前分配的服务器上

## 13. 打点统计 监控措施 监控工具

*   第三方打点统计API，如Google Analytics等
*   目前在做的项目：交易一致性监控，单独部署的服务器在备库上对第三方订单进行反查跑批，比对双方订单状态及金额的一致性
*   第三方监控工具，目前在用的zabbix，系统和网络性能监控，zabbix服务端可以独立运作，也可以结合zabbix agent完成更多监控工作。

## 14. php5.5特性

*   生成器(Generators)
*   密码哈希API
*   finally
*   empty()支持函数调用和表达式
*   类名解析
*   foreach改进：支持list()

## 15. autoload原理: [参考](http://leanote.com/blog/post/58b04e2bab64410ab800125f)

## 16. redis集群：[参考](https://www.zhihu.question/21419897)

## 17. mysql连接池

## 18. 如何配置PHP的session存储在缓存

*   修改php.ini配置文件实现。

    *   修改session存储方式
	> session.save_handler = memcached

    *   修改session存储地址，号替换为你的IP:Port, 在管理中心，点击“云缓存Memcached”，在云缓存 Memcached“管理视图”，可以看到系统分配的IP:Port
	> session.save_path = "...:*"
 
    *   设置一个合理时间，只缓存热点数据
	> session.gc_maxlifetime = 1500

*   代码中直接设置。
	> ini_set("session.save_handler","memcached");
	ini_set("session.save_path","...:**");
	> ini_set("session.gc_maxlifetime",1500);

## 19. PHP实现接口

## 20. 大文件读取

<ul>
<li>使用fopen和fseek逐行或逐块读取</li>