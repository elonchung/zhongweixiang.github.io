---
title: 网站优化所有问题 一（持续更新中）
date: 2018-05-06 09:31:05
categories: 
- 优化
tags:
- seo
toc: true # 是否启用内容索引
keywords: seo,网站优化,seo优化
description: 针对自己的网站进行优化
---


# 网站优化所有问题 一（持续更新中）

以下是通过[dareboost网站](https://www.dareboost.com)进行质量和性能报告

![ ](/uploads/site-optimize/Snipaste_05-06_17-22-41.jpg)

问题具体有几类：

- 浏览器呈现
- 缓存策略
- 合规数据量
- 请求数质量
- SEO
- 安全 
- jQuery的 

## Keep-Alive已启用 （已解决）
Keep-alive允许使用相同的TCP连接发送和接收多个请求（在HTTP 1.1中默认激活）。
![ ](/uploads/site-optimize/Snipaste_05-06_15-11-59.jpg)

## 启用压缩功能（已解决）

当 PageSpeed Insights 检测到以下情形时，就会触发此规则：所提供的资源是可压缩的，但未进行 gzip 压缩。

- 概览

所有现代浏览器都支持 gzip 压缩并会为所有 HTTP 请求自动协商此类压缩。启用 gzip 压缩可大幅缩减所传输的响应的大小（最多可缩减 90%），从而显著缩短下载相应资源所需的时间、减少客户端的流量消耗并加快网页的首次呈现速度。 要了解详情，请参阅使用 GZIP 压缩文本。

- 建议

在您的网络服务器上启用并测试 gzip 压缩支持。HTML5 Boilerplate 项目包含所有最热门服务器的示例配置文件，以及对每个配置标记和每项设置的详细注解：请在列表中查找您喜爱的服务器，并找到 gzip 部分，然后确认您已使用推荐的设置配置了您的服务器。 或者，您也可查看您的网络服务器的文档以了解如何启用压缩功能：
Apache：[使用 mod_deflate](http://httpd.apache.org/docs/current/mod/mod_deflate.html) 
Nginx：[使用 ngx_http_gzip_module](http://nginx.org/en/docs/http/ngx_http_gzip_module.html)


## 此页面暴露于“clickjacking”类型的攻击 （已解决）
让恶意的人不要将您的网页集成到他们的网站中。

- 点击劫持解释

当您的网页通过<frame\>或<iframe\>标记与恶意网站集成时，就会发生这种攻击。通过这样做，攻击者可以说服用户，当他们不在时，他们在自己的页面上。毫无戒心的用户可能会输入个人信息，这些信息在恶意网站上可见并因此易受攻击。

为了避免这种情况，请始终指明哪些域有权整合您的网页。

- 如何防止点击劫持？

配置一个“X-Frame-Options”HTTP标头。配置您的服务器，使主资源响应包含“X-Frame-Options”HTTP标头。

可以定义三个值：

DENY 防止任何框架或iframe集成页面;
SAMEORIGIN 仅授权来自相同域名的帧;
ALLOW-FROM uri指示允许将页面集成到框架中的域（但与某些浏览器不兼容）

此页面上未配置“X-Frame-Options”HTTP标头; 你更有可能遭受点击劫持。

![ ](/uploads/site-optimize/Snipaste_05-06_12-15-07.jpg)


## 指定一个字符集（已解决）

以下资源的HTTP标头中没有指定字符集。在HTTP标题中指定字符集可以加快浏览器呈现速度。

指定Content-TypeHTTP标头中使用的字符集可让浏览器立即解析页面。

![ ](/uploads/site-optimize/Snipaste_05-06_12-11-53.jpg)

- 解决问题：

![ ](/uploads/site-optimize/Snipaste_05-06_12-12-18.jpg)


## 在<img>标签上添加alt属性（已解决）

alt属性是SEO的重要标准。事实上，搜索引擎爬虫不能分析图形内容。这就是为什么他们使用替代文字来返回一致的结果，就像在Google图片中一样。
```
<img src =“product.jpg”alt =“我的产品说明” />
```
该alt属性用于几个与搜索引擎优化无关的情况：

当屏幕阅读器用于辅助功能时;
图像加载时，特别是对于慢速连接;
未找到图像文件时。

如果没有什么东西适合描述图像，则可以设置一个空文本。我们建议您确保大部分图片定义相关文字。阅读W3C的建议。

- 解决问题：

所有图片标签添加alt属性
```
<img class =“img-circle img-rotate” src =“/images/xxx.png” width=“200” height=“200” alt="xxxx" />
```

## 重定向需要551毫秒 （未解决）

重定向会触发网络上的可避免往返行为并增加页面加载时间。

- HTTP重定向问题

HTTP重定向允许指定从不同的URL访问所需的内容。它们触发一个新的HTTP请求来检索目标资源并返回一个介于300和399之间的HTTP代码。请参阅 HTTP重定向的规范。

重定向太长而无法访问正确的内容

- 原因：

http 80 强制转https 443


## 图像在浏览器端调整大小（未解决）

图像不得大于实际显示的大小，以避免加载不必要的数据。

- 调整图像大小解释

不建议在浏览器端调整图像大小以减少渲染大小。

例如，如果您的图像设置为在特定页面上以300px×300px呈现，请不要将1000px版本的原始图像上传到您的页面。相反，调整/裁剪图像以适应显示尺寸，然后将其上传到您的网站以减少页面重量和加载时间。

- 使用具有自适应设计或视网膜屏幕的图像？

响应式网站设计和视网膜屏幕不能证明图像调整大小。即使在这种情况下，也有一些方法可以将图片传送到合适的尺寸。我们建议您阅读以下资源：

[响应式图像简介](http://www.smashingmagazine.com/2013/05/the-state-of-responsive-web-design/)
[Picturefill，开始使用<picture>元素](http://scottjehl.github.io/picturefill/)
[RICG，致力于响应式图像的开发团队](https://responsiveimages.org/)