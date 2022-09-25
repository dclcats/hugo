---
title: "git checkout Remote branch Error"
date: 2021-09-14T12:12:14+08:00
draft: false
slug: "d48900ec"
author: "Chris-dc"
description: "error: invalid path 'content/post/python/urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed.md'"
summary: "git checkout :: error: invalid path 'content/post/python/urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed.md'"
toc: true
comment: false
---

## 问题描述

拉取远程分支（`git clone xxxx`），通过`checkout`检出远程分支，报错

```error
error: invalid path 'content/post/python/urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed.md'
```


## 问题分析

NTFS 文件系统的保护机制

如果仓库对应分支中存在系统不能正常识别的文件名称，则会触发。


[官方说明](https://git-scm.com/docs/git-config)

> If set to true, do not allow checkout of paths that would cause problems with the NTFS filesystem, e.g. conflict with 8.3 "short" names. Defaults to true on Windows, and false elsewhere.


![core.protectNTFS](./images/core_protectNTFS.png)



## 解决办法

设置 `core.protectNTFS` 为 `false`

```bash
git config core.protectNTFS false
```


