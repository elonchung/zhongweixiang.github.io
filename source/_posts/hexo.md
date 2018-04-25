---
title: hexo使用
date: 2017-06-29 13:21:52
categories: 
- 小公举 
- 博客
tags:
- 小公举
---
自己也算是摸爬滚打搭建成功，然后自己再重新安装部署一遍，把完整步骤分享给大家，同时最后有一些连接，如果我的步骤不行，大家可以参考其他人的（这个有点花费时间，大家提前有个心理准备 - _-）



## 安装hexo

安装要求（以下为下载链接 安装步骤省略 ）：
- [下载安装Git](https://gitforwindows.org/)
- [下载安装node.js](https://nodejs.org/en/)

1、创建文件夹（我的是在E盘创建的Hexo）
利用 npm 命令即可安装。在文件夹空白位置点击鼠标右键，选择Git Bash
在电脑任意位置右键
![](/uploads/1531909-ed306496f5c34312.png)
2、输入命令：

```
npm install -g hexo
```
![](/uploads/1531909-0b9d56643f6b27cc.png)
注意：-g是指全局安装hexo 
\--save是指项目独立安装hexo。

## 初始化Hexo与使用

### 1、初始化成功后生成的一些列文件
- 在Hexo文件下，右键运行Git Bash，输入命令：

``` 
hexo init
```
![](/uploads/1531909-f6ae9b7089741c89.png)


### 2、获取主题next ，修改基础配置

其中可以在这里[浏览更多主题](https://hexo.io/themes/)，然后在Hexo文件夹下 Git Bash

输入命令：

```
git clone https://github.com/iissnan/hexo-theme-nextthemes/next
```
（next为主题名字），来获得更多主题
下载成功（如果需要更改主题，请在_cofig.yml修改theme）

在_config.yml，进行基础配置
![](/uploads/Snipaste_04-25_11-42-16.png)

### 3、本地浏览博客

分别输入 如下命令：
```
hexo g
     
hexo s
```

这里有更多hexo常用命令

在浏览器输入：localhost：4000 ，就可以进行访问，效果如下：



效果图
### 4、写文章

在E:\Hexo\source\_posts文件下，新建.md文件就可以写文章

新建hexo.md文件

```
---
title: hexo使用
date: 2018-04-09 13:21:52
categories: 
- 小公举 
- 博客
tags:
- 小公举
---
```

浏览效果
![](/uploads/Snipaste11-20-48.png)


## 部署到Github上

### 1、申请Github账号，（注意别忘了进行账号邮箱验证）
![](/uploads/Snipaste_04-25_11-28-22.png)

### 2、new repository

![](/uploads/Snipaste_04-25_11-29-19.png)



### 3、在_config.yml进行配置

![](/uploads/Snipaste_04-25_11-31-08.png)


（注意：要保存）
###  4、安装hexo-deployer-git自动部署发布工具

在Hexo文件夹下 Git Bash
```
npm instal lhexo-deployer-git  --save
```
![](/uploads/Snipaste_04-25_11-31-08.png)


### 5、发布到Github

输入如下命令：

```
清理缓存文件
hexo clean

构建及部署到github上
hexo g -d
或者
hexo d -g
```

第一次发布需要验证github账号
发布完成
在仓库中我们也可以看到

### 6、如需要验证ssh 
[浏览这个教程](https://jingyan.baidu.com/article/d8072ac47aca0fec95cefd2d.html)


### 7、测试访问

在浏览器输入：https://zhongweixiang.github.io/

  