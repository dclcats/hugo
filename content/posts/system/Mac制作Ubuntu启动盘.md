+++
title = "Mac制作Ubuntu启动盘"
date = 2021-03-23T14:13:28+08:00
draft = false
slug = "mac-ubuntu"
author = "Chris-dc"
description = ""
summary = ""
+++

## 下载Ubuntu镜像文件
Ubuntu官网下载所需要的的镜像文件（iso）

## 准备一个U盘
准备一个U盘，容量在4G以上（可以作为专门的启动盘），如果U盘曾用过，最好格式化下U盘

### Mac自带磁盘工具
打开磁盘工具，选择U盘，点击抹去（erase），选择对应的信息（exFAT or others），会清除U盘的所有数据，所以记得备份数据

### 命令行
通过命令确定U盘位置信息(通常未 /dev/disk2)
```shell
$ diskutil list
```
卸载U盘
```shell
$ sudo diskutil umountDisk /dev/disk3
```

格式化
```shell
sudo diskutil eraseDisk ExFAT ud /dev/disk3 
```
完成

_以上均为diskutil命令实现，具体命令语法，参数含义，可百度详细了解，小白建议使用Mac自带工具实现_

## 制作启动盘
镜像（iso）文件下载好之后，通过 `hdiutil `命令制作dmg文件，注意镜像文件改为自己的文件（地址）
```shell
$ hdiutil convert -format UDRW ubuntu-20.04-desktop-amd64.iso -o ubuntu-20.04-desktop-amd64
```
此过程很快结束，下一步开始制作启动盘

**在制作启动盘之前记得线卸载U盘，注意是卸载不是推出，上一步命令行中有卸载操作，自带工具中，有对应的卸载图标可以实现**

```shell
$ sudo dd if=ubuntu-20.04-desktop-amd64.img of=/dev/rdisk2 bs=1m
```
**注意`of=`后边的地址是U盘的挂载地址，在`diskutil list`命令中可看到；另外`disk2` -> `rdisk2`，对于两者区别可以百度获取**

**以上命令执行过程中不会有日志，在结束之后会返回一些简单信息，时间会比较久一点，可以做别的事情，在最后会弹窗提示U盘不兼容信息可忽略（如果确定`dd`已执行完成可直接点推出），待`dd`命令执行完成之后，推出U盘即可**

