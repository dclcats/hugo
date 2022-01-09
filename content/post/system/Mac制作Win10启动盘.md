---
title: "Mac制作Win10启动盘"
date: 2022-01-09T21:13:28+08:00
draft: false
slug: "mac-win10"
author: "Chris-dc"
summary: "通过Mac制作Win10启动盘"
description: "通过Mac制作Win10启动盘, 命令行执行"

---



此方法用于手头只有mac，又有制作windows启动盘需求的情况。



### 操作步骤

1. 插入U盘
2. 格式化（FAT32）
3. 挂载下载好的windows iso镜像（在mac下双击即可）
4. 将挂载好的镜像数据，复制到格式化之后的U盘上



### 相关命令

```shell
# 2. 格式化（命名为WINDOWS10便于识别），关于格式化命令可以 "diskutil eraseDisk help" 查看讲解
diskutil eraseDisk FAT32 "WINDOWS10" MBR disk2

# 4. 镜像数据复制到U盘, ISO_NAME为第三步挂载好数据后挂载盘的名称，在finder左侧栏可以看到，或者 "diskutil list" 查看
cp -rp /Volumes/{ISO_NAME}/* /Volumes/WINDOWS10/
```



完成以上四步即可拔出U盘，插入需要安装windows的电脑开始安装系统。





### 可能问题

**不过只做以上四步，可能会有问题，比如：拷贝iso镜像数据失败，处理好的U盘插入windows无法识别等等**

**原因可能是系统数据超过4G，而FAT32格式U盘单文件大小有不能超过4G的限制**





### 解决方法

所以如果你的镜像文件大于4G则需要对文件做一些处理，这里需要用到一个软件 **Boot Camp ISO Converter（这个软件可以解决FAT32格式的u盘单个文件大小不能超过4GB的问题，而不论是1903还是1909的iso镜像文件里，insta.win的大小都超过了4GB，所以这是解决失败问题的关键）**



[关于Boot Camp ISO Converter](https://twocanoes.com/using-larger-windows-10-isos-with-boot-camp-assistant/)

[下载地址](https://twocanoes-software-updates.s3.amazonaws.com/Boot%20Camp%20ISO%20Converter1_6.dmg)



下载 - 安装 - 选择windows镜像文件 - save - 等待 - 转换后的iso镜像 - 按照1/2/3/4执行，挂载阶段请使用转换后的镜像文件

