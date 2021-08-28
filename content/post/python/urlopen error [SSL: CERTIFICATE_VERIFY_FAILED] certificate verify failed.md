---
title: "Urlopen Error [SSL: CERTIFICATE_VERIFY_FAILED] Certificate Verify Failed"
date: 2021-08-29T00:30:37+08:00
draft: false
slug: "9a01d31d"
author: "Chris-dc"
description: "urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed"
summary: "urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed"
toc: true
comment: false
---


## 错误
python报错：`urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed`

## 原因分析
查找相关资料后确定为，Python 2.7.9 之后版本引入了一个新特性：当你urllib.urlopen一个 https 的时候会验证一次 SSL 证书 ，当目标使用的是自签名的证书时就会爆出该错误消息。

## 解决办法
在全局添加如下代码：

```python
import ssl
ssl._create_default_https_context = ssl._create_unverified_context
```
