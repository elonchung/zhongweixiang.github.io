---
title: Web 高效开发必备的 PHP 框架
date: 2017-07-09 13:21:52
categories: 
- PHP
- 框架
tags:
- PHP
- 框架
---
## 多功能 THinkPHP 开源框架
项目简介：使用 THinkPHP 开发项目的过程中把一些常用的功能或者第三方 sdk 整合好，开源供亲们参考，如 Auth 权限管理、支付宝、微信支付、阿里oss、友盟推送、融云即时通讯、云通讯短信、Email、Excel、PDF 等等。这些都是经过线上运营考验的，无毒害可以免费放心折腾使用。只要不会某一天找到我说因为借鉴了这个开源产品的一些方法，而导致了好几个亿的损失，要我负责并赔偿就好~ ￣へ￣

此开源产品面向所有 THinkPHP 开发用户，因为我的基本思想是不改动框架的源文件，只是围绕着框架扩展，所以整合的这些功能都可以无痛兼容各种环境，既可以按照文章将整合的这些功能方便的移植到你已有的项目中，也可以直接以此项目为基础开发。

[项目地址](http://git.oschina.net/shuaibai123/thinkphp-bjyadmin)



## 基于 Laravel 的轻量级 web 部署系统 Fixhub

Fixhub

![](/uploads/framework.jpg)

项目简介：Fixhub 是一款免费、开源，基于 Laravel 5.3 框架开发的 web 自动部署系统。目前实现的功能主要包括：

- 支持 PHP、Python、JAVA、Ruby 等项目的发布。

- 通过 SSH 将程序部署到多台服务器上。

- 直接从 Git 仓库克隆项目代码并进行打包、安装。

- 执行远程服务器 bash 命令。

- 通过 Websocket 实现项目部署状态的实时跟踪。

- 在服务器保留追溯版本记录，以便快速回滚。

- 通过任务计划进行项目健康检测。

- 可通过 webhook 触发部署。

- 上线单申请、审核流程。

- Slack 和邮件通知。

[项目地址](http://git.oschina.net/Fixhub/Fixhub)




## 基于 Yii 框架协同办公管理系统 IBOS

项目简介：IBOS 是一个基于PHP开发、Yii框架、免费开源的，快速、高效的协同办公管理系统。最新的 IBOS 为协同办公应用开发提供了强有力的支持，这些支持包括：

- 复杂的用户组织结构管理支持。

- 灵活和完善的角色权限控制体系，权限粒度支持到方法的权限设置。

- 实用的功能和完善的插件机制。

- 模块化的功能应用机制，可单独安装卸载单个应用。

- 云平台支持-提供了对新浪 SAE 平台和本地环境双重支持的选择，具备“横跨性”和“平滑性”，支持本地化开发和调试以及部署切换。

- 缓存支持-提供了包括文件、数据库、Memcache、Xcache、Redis 等多种类型的缓存支持。

[项目地址](http://git.oschina.net/ibos/IBOS)



## 基于 CodeIgniter 框架的 CMS

项目简介：菜鸟 CMS 是用 CodeIgniter + bootstrap2.0 面向开发人员的通用管理后台，视情况而定是否运用到你自己的项目中，其主要功能包括：

- 权限模块

- 会员模块

- 文章模块

- 幻灯片模块

- 类别模块

- 缓存模块

- 日志模块

- 系统设置

[项目地址](http://git.oschina.net/eryang/CNCMS)




## 基于 zend 开发的 CMF 系统

项目简介：本项目是一个基于 zend framework 1.12.3 开发的 CMF 系统。

- 在不改动 zend framework 代码的基础上构建的基于 app 的 CMF 系统。

- 自带后台，以及安装模块。

- 对 zend framework 的 ini 配置文件进行缓存，大大提高了 zend framework 的运行速度。

- 巧妙的使用 zend framework 的 layout ,view 模块，使各 app 模块，可以使用全局 layout 进行布局，也可以 app 模块自定义的布局，（默认情况下 app 模块未定义 layout 布局将使用全局布局)。

- 数据库通过定义可以开启读写分离功能，通过配置 ini 文件，可以很方便的分库，各分库之间的功能可以无缝调用。

- 每个 app 模块包含有一个 library 库，各 app 模块 libray 库，可以互相调用，libray 分 dao,service,tool 三层结构，非常方便以后扩展。

- 类库实现自动加载，不需要特意 include。

- 等等还有许多其他功能，适合初学 zend framework 的开发人员学习以及高级开发人员在项目中使用。

[项目地址](http://git.oschina.net/wangkaihui/mycmf)




## 基于 phalcon 开发的内容管理系统

项目简介：本项目是基于 Phalcon 开发的内容管理系统。 特性：

- 继承 Phalcon 框架全功能。

- 多网站支持，异站点用户文件、同网站私有/共有网站隔离。

- 强大的个性化环境，每个用户可以对网站内容和表现形式进行个性化设置。

- 基于用户角色、模块、角色的权限控制系统，当然，您也可以通过回调函数进行更精细控制。

- 提供的站内搜索系统原生支持全文搜索。

- 使用 volt 编写主题模板，类 twig 语法，单比 twig 更高效。

- Tolowan 提供的实体管理、字段管理、表单管理、模型管理等机制，可以大大缩减二次开发的难度和所需时间。

[项目地址](http://git.oschina.net/itdashu/Tolowan)