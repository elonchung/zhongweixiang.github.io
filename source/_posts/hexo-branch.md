---
title: Hexo利用Github分支在不同电脑上写博客
date: 2017-06-30 08:49:53
categories:
- Git
tags: 
- Git
- 小公举
---
Hexo是一个很好的开源博客框架，支持Markdown的写作方式，并且可以与Github Page协作轻松搭建博客，非常适合展示性的个人博客。Hexo通过将Markdown文件编译成html文件，然后将html文件直接部署到网站上，所以被称作静态博客，因为直接就是访问的最终的html文件，不会有PHP那样的中间处理，所以对浏览器来讲会比较快。

当然，这种方式也有缺点，一是Github毕竟部署在国外，而且访问偶尔会抽风，所以速度无法保障；二是所有的静态页面由于都需要保存在github里的自己名下的网站同名项目仓库内，所以如果项目仓库是public的，那么所有人都会看到你的网站代码， 这个其实应该也没有关系吧！！！hexo都是开源的，而且静态博客是编译后的，框架和主题都是用的别人开源出来的，但博客写了不就是让别人看的？所以应该真的无所谓。。。

如果你实在不想让别人看到你的md原件，那么就不要使用本文所说的同一个项目的分支啦，就去新建一个项目来单独保存源码文件吧，并且把这个项目设为priviate的，要花钱的哦，这样别人就看不到啦。。。

下面进入正题， 利用github的不同分支来分别保存网站静态文件与hexo源码（md原始文件及主题等），实现在不同电脑上都可以自由写博客

## Github Page
这里假设你已经在github上建好了page的仓库，也就是 “yourusername.github.io”的名字的项目仓库，比如我的 dxjia.github.io 。另外，也假设你在自己的电脑上已经配置好git、hexo、node js等环境。

新建hexo分支
仓库建好之后，都是默认一个 master 分支的，Github page要求你的网站文件必须存放在这个 master 分支上，这个没得选；所以我们需要新建另外一个分支来保存我们的hexo原始文件；


## 设置默认分支
因为我们写博客更多的是更新这个分支，网站文件所在的 master 分支则由 hexo d 命令发布文章的时候进行推送，所以我们将 hexo分支设置为默认分支，这样我们在新的电脑环境下 git clone 该仓库时，自动切到 hexo`分支。


## 配置hexo deploy参数
为了保证 hexo d 命令可以正确部署到 master 分支，在hexo 的配置文件 _config.yml 文件中配置参数如下：

> deploy:
  type: git
  repo: https://github.com/dxjia/dxjia.github.io.git
   branch: master
hexo 3.0之后 deploy type，将github改为了git，这样适用性更广了，如果你发现无法 hexo d ，使用下面的命令安装git deployer插件后重试即可。
> npm install hexo-deployer-git --save

## 修改推送到hexo分支
上一步的deploy参数正确配置后，文章写完使用 hexo g -d 命令就可以直接部署了，生成的博客静态文件会自动部署到 username.github.io 仓库的 master 分支上，这时候通过浏览器访问 http://username.github.io 就可以看到你的博客页面里。

网站页面是保存了，但这时候我们还没有保存我们的hexo原始文件，包括我们的文章md文件，我们千辛万苦修改的主题配置等。。。接下来使用下面的步骤将他们都统统推送到 hexo 分支上去

> git add .
git commit -m “change description”
> git push origin hexo

这样就OK了，我们的原始文件就都上去了，换电脑也不怕了。

## 日常写博客
有时候我们可能会在不同的电脑上写博客，那在不同的电脑上配置 hexo、git、node.js，以及配置git ssh key等都要折腾一下的，这是免不了的，也是比wordpress等其他博客框架麻烦的一点。

## 已有环境

如果在电脑上已经写过博客，那么可以在已有的工作目录下同步之前写的博客。在你的仓库目录下右键’git bash shell’，起来bash命令行，然后

> git pull

这样你的状态就更新了，之后就是 hexo 命令写文章啦。。。

写完 hexo g -d 部署好后，使用

> git add .
git commit -m “change description”
> git push origin hexo

推送上去。

## 新的环境
到了新的电脑上时，我们需要将项目先下载到本地，然后再进行hexo初始化。

> git clone https://github.com/dxjia/dxjia.github.io.git
cd dxjia.github.io
npm install hexo
npm install
> npm install hexo-deployer-git –save

之后开始写博客，写好部署好之后，别忘记 git add , ….git push origin hexo…推上去。。。