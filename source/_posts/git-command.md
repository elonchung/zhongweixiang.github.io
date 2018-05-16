---
title: Git 命令清单 (补充)
date: 2016-08-15 16:54:28
categories:
- Git
tags:
- Git
toc: true # 是否启用内容索引
keywords: git,git配置,git命令,git命令清单
description: 熟练使用，恐怕要记住60～100个命令
---
我每天使用 Git ，但是很多命令记不住。
一般来说，日常使用只要记住下图6个命令，就可以了。但是熟练使用，恐怕要记住60～100个命令。

![git](/uploads/git.png)

下面是我整理的常用 Git 命令清单。几个专用名词的译名如下。



	* Workspace：工作区

	* Index / Stage：暂存区

	* Repository：仓库区（或本地仓库）

	* Remote：远程仓库




## 新建代码库


- 在当前目录新建一个Git代码库
> $ git init


- 新建一个目录，将其初始化为Git代码库
> $ git init [project-name]


- 下载一个项目和它的整个代码历史
> $ git clone [url]


## 配置


Git的设置文件为.gitconfig，它可以在用户主目录下（全局配置），也可以在项目目录下（项目配置）。


- 显示当前的Git配置
> $ git config --list


- 编辑Git配置文件
> $ git config -e [--global]


- 设置提交代码时的用户信息
> $ git config [--global] user.name "[name]"
> $ git config [--global] user.email "[email address]"


## 增加/删除文件




- 添加指定文件到暂存区
> $ git add [file1] [file2] ...


- 添加指定目录到暂存区，包括子目录
> $ git add [dir]


- 添加当前目录的所有文件到暂存区
> $ git add .


- 删除工作区文件，并且将这次删除放入暂存区
> $ git rm [file1] [file2] ...


- 停止追踪指定文件，但该文件会保留在工作区
> $ git rm --cached [file]


- 改名文件，并且将这个改名放入暂存区
> $ git mv [file-original] [file-renamed]


## 代码提交


- 提交暂存区到仓库区
> $ git commit -m [message]


- 提交暂存区的指定文件到仓库区
> $ git commit [file1] [file2] ... -m [message]


- 提交工作区自上次commit之后的变化，直接到仓库区
> $ git commit -a


- 提交时显示所有diff信息
> $ git commit -v


- 使用一次新的commit，替代上一次提交
- 如果代码没有任何新变化，则用来改写上一次commit的提交信息
> $ git commit --amend -m [message]


- 重做上一次commit，并包括指定文件的新变化
> $ git commit --amend [file1] [file2] ...


## 分支


- 列出所有本地分支
> $ git branch


- 列出所有远程分支
> $ git branch -r


- 列出所有本地分支和远程分支
> $ git branch -a


- 新建一个分支，但依然停留在当前分支
> $ git branch [branch-name]


- 新建一个分支，并切换到该分支
> $ git checkout -b [branch]


- 新建一个分支，指向指定commit
> $ git branch [branch] [commit]


- 新建一个分支，与指定的远程分支建立追踪关系
> $ git branch --track [branch] [remote-branch]


- 切换到指定分支，并更新工作区
> $ git checkout [branch-name]


- 建立追踪关系，在现有分支与指定的远程分支之间
> $ git branch --set-upstream [branch] [remote-branch]


- 合并指定分支到当前分支
> $ git merge [branch]


- 选择一个commit，合并进当前分支
> $ git cherry-pick [commit]


- 删除分支
> $ git branch -d [branch-name]


- 删除远程分支
> $ git push origin --delete [branch-name]
> $ git branch -dr [remote/branch]


## 标签


- 列出所有tag
> $ git tag


- 新建一个tag在当前commit
> $ git tag [tag]


- 新建一个tag在指定commit
> $ git tag [tag] [commit]


- 查看tag信息
> $ git show [tag]


- 提交指定tag
> $ git push [remote] [tag]


- 提交所有tag
> $ git push [remote] --tags


- 新建一个分支，指向某个tag
> $ git checkout -b [branch] [tag]


## 查看信息




- 显示有变更的文件
> $ git status


- 显示当前分支的版本历史
> $ git log


- 显示commit历史，以及每次commit发生变更的文件
> $ git log --stat


- 显示某个文件的版本历史，包括文件改名
> $ git log --follow [file]
> $ git whatchanged [file]


- 显示指定文件相关的每一次diff
> $ git log -p [file]


- 显示指定文件是什么人在什么时间修改过
> $ git blame [file]


- 显示暂存区和工作区的差异
> $ git diff


- 显示暂存区和上一个commit的差异
> $ git diff --cached [file]


- 显示工作区与当前分支最新commit之间的差异
> $ git diff HEAD


- 显示两次提交之间的差异
> $ git diff [first-branch]...[second-branch]


- 显示某次提交的元数据和内容变化
> $ git show [commit]


- 显示某次提交发生变化的文件
> $ git show --name-only [commit]


- 显示某次提交时，某个文件的内容
> $ git show [commit]:[filename]


- 显示当前分支的最近几次提交
> $ git reflog


## 远程同步


- 下载远程仓库的所有变动
> $ git fetch [remote]


- 显示所有远程仓库
> $ git remote -v


- 显示某个远程仓库的信息
> $ git remote show [remote]


- 增加一个新的远程仓库，并命名
> $ git remote add [shortname] [url]


- 取回远程仓库的变化，并与本地分支合并
> $ git pull [remote] [branch]


- 上传本地指定分支到远程仓库
> $ git push [remote] [branch]


- 强行推送当前分支到远程仓库，即使有冲突
> $ git push [remote] --force


- 推送所有分支到远程仓库
> $ git push [remote] --all


## 撤销




- 恢复暂存区的指定文件到工作区
> $ git checkout [file]

- 恢复某个commit的指定文件到工作区
> $ git checkout [commit] [file]


- 恢复上一个commit的所有文件到工作区
> $ git checkout .


- 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
> $ git reset [file]


- 重置暂存区与工作区，与上一次commit保持一致
> $ git reset --hard


- 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
> $ git reset [commit]


- 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
> $ git reset --hard [commit]


- 重置当前HEAD为指定commit，但保持暂存区和工作区不变
> $ git reset --keep [commit]


- 新建一个commit，用来撤销指定commit
后者的所有变化都将被前者抵消，并且应用到当前分支
> $ git revert [commit]

## 其他


- 生成一个可供发布的压缩包
> $ git archive


## 工作中常用到的方法 （补充部分）  

### **一、 创建与合并分支**

1、 从master分支创建dev分支并切换到dev分支：

> git checkout master 
    
> git checkout -b dev 
    

其中，git checkout -b dev 等价于：

> git branch dev 
    
> git checkout dev 
    

查看本地当前的分支，分支前面带“*”表示当前分支，剩下的分支表示本地有的分支：

> git branch 
    

查看远程全部的分支，白色的表示本地有的，红色的表示本地没有，仅在远程存在：

> git  branch-a 
    

  

2、修改代码、提交代码（当前的操作是在dev分支上进行）

> git add a.html 
    
> git commit -m "提交文件a.html" 
    

3、分支合并(将dev合并到master)

> git checkout master
    
> git merge dev 
    

4、合并完成后，删除dev分支.(删除dev分支时，注意我们当前所在的分支不能是dev分支)

> git branch -d dev 
    

5、删除后，查看分支(此时看不到dev分支了)

> git branch 
    

6、总结 ：工作中经常从master创建新的分支，具体操作如下：

> git checkout master
    
> git checkout -b  issues1234
    
> git push origin issues1234
    
> git add ..
    
> git commit -m "***" 
    
> git push origin issues1234 
    

注意：将本地分支branch1推到远端的branch2操作步骤：

> git push origin branch1:branch2 
    

7、删除分支

> ```git git branch -D   issues1234```  //本地强制删除分支issues1234 
    
> git push origin:issues1234  //推到远程 
    

### **二、 解决冲突**

1、发生冲突的文件

> <<<<<<< HEAD 
    
> Creating a new branch is quick & simple. 
    
> ======= 
    
> Creating a new branch is quick AND simple. 
    
> \>>>>>>> feature1 
    

其中，git使用`<<<<<<<`，`=======`，`>>>>>>>`标记文件中自己和别人产生冲突的部分。

在`<<<<<<<`，`=======`之间为自己的代码；

`=======`，`>>>>>>>`之间为别人的代码。

如果保留自己的代码，将别人的代码删掉即可。

2、冲突解决后提交

> git status 
    

> git add *** 
    

> git commit -m "fix conflict" 
    
> git push origin 分支名  
    

### **三、Bug分支**

1、储藏更改:将当前更改的代码储藏起来，等以后恢复使用

> git stash 
    

2、恢复储藏的代码

> git stash pop //恢复的同时把stash内容删掉 
    

或者

> git stash apply//恢复stash，但是stash内容并不删除 
    

> git stash drop //在上面操作的基础上，以此来删除stash 
    

注： git stash list //查看全部的stash列表。

3、将stash空间清空

> git stash clear 
    

4、git stash pop 和 git stash apply 区别

原来git stash pop stash@{id}命令会在执行后将对应的stash id 从stash list里删除，而 git stash apply stash@{id} 命令则会继续保存stash id。

### **四、版本回退**

1、回退至上一个版本

> git reset --hard HEAD
    

2、回退至指定版本

> git reset --hard  版本号 
    

3、查看以往版本号(本地的commit)

> git reflog 
    

4、查看各版本号及信息(所有的commit：本地commit + 其他同事的commit)

> git log 
    

### **五、撤销修改**

1、撤销修改

> git  checkout -- a.html 
    

分两种情况分析：

1.  还没有执行 git add 操作，执行上面的操作后，会恢复到和版本库中一模一样的版本状态。
    
2.  执行了git add ，还没执行 git commit ,再执行上面的操作后，会恢复到git add 结束后的状态
    

注：一旦执行了git commit -m "*"，就不能再使用上面的命令回退。

### **六、对于已经push的版本，进行回退**

1、第一步：

> git reset --hard 版本号  //本地回退到指定的版本 
    

2、第二步：

> git push-f origin dev    //将远程的也回退到指定版本 
    

### **七、本地同步远程删除的分支**

> git fetch origin -p  //用来清除已经没有远程信息的分支，这样git branch -a 就不会拉取远程已经删除的分支了 
    

### **八、删除掉没有与远程分支对应的本地分支**

从gitlab上看不到的分支在本地可以通过git branch -a 查到，删掉没有与远程分支对应的本地分支：

> git fetch -p 
    

**九、查看远程库的一些信息，及与本地分支的信息**  

> git remote show origin
    

### **十、git stash临时保存本地操作**

1、使用`git stash`就可以将你当前未提交到本地（和服务器）的代码推入到Git的栈中，这时候你的工作区间和上一次提交的内容是完全一样的。

2、再切换到别的分支改紧急bug。

3、改完后，切到刚才的分支，使用`git stash apply`将以前一半的工作应用回来。

也许有的人会说，那我可不可以多次将未提交的代码压入到栈中？答案是可以的。当你多次使用`git stash`命令后，你的栈里将充满了未提交的代码，这时候你会对将哪个版本应用回来有些困惑，`git stash list`命令可以将当前的Git栈信息打印出来，你只需要将找到对应的版本号，例如使用`git stash apply stash@{1}`就可以将你指定版本号为stash@{1}的工作取出来，当你将所有的栈都应用回来的时候，可以使用`git stash clear`来将栈清空。

在这里顺便提下`git format-patch-n`, n是具体某个数字， 例如`git format-patch-1`这时便会根据log生成一个对应的补丁，如果`git format-patch-2`那么便会生成2个补丁，当然前提是你的log上有至少有两个记录。

