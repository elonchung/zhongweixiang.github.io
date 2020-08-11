---
title: windows操作集
date: 2019-08-14 16:54:28
categories:
- Windows
tags:
- Windows
toc: true # 是否启用内容索引
keywords: windows
description: windows操作集
---

- ### 关闭hypervisor    docker需要开启auto，虚拟机需要关闭off

bcdedit /set hypervisorlaunchtype off



- ### 修改cmd为管理员  新建reg 复制以下内容后保存双击运行

```cmd
[HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers]

"c:\\windows\\system32\\cmd.exe"="~ RUNASADMIN"
```

- ### you-get 视频下载

```cmd
// 安装及下载命令 需先安装Python
pip3 install you-get
pip3 install --upgrade you-get
you-get --playlist  'https://www.youtube.com/watch?v=jNQXAC9IVRw'
//  --playlist 列表下载
//  -i 查看下载格式
//  --format=flv  清晰度格式下载 最好选默认
//  -o d:/xx  下载路径
```

