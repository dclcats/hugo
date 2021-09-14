---
title: "Vue Cli Network Unavailable"
date: 2021-09-14T12:35:00+08:00
draft: false
slug: "848fa889"
author: "Chris-dc"
description: "vue cli 运行项目，network：unavailable"
summary: "vue cli 运行项目，network：unavailable"
toc: true
comment: true
---

## 问题描述

通过 `vue-service` ( `vue-cli` )，运行前端项目时，出现 `network: unavailable`；只能通过 `localhost` 访问。


## 问题分析

网上大部分是因为 windows 有多个网络适配器，`vue-cli` 不能准确解析。

我这里虽然也有多个网络适配器，但是 `vue-service` 能够正常解析，问题的原因出在本地IP上。由于 `vue serve` 是适用于本地开发测试的，不用于生产环境，所以 `vue-service` 对 `network` 的显示针对IP地址做了限制，即只允许私有IP

看源码
```javascript
// Check if the address is a private ip
// https://en.wikipedia.org/wiki/Private_network#Private_IPv4_address_spaces
if (
  /^10[.]|^172[.](1[6-9]|2[0-9]|3[0-1])[.]|^192[.]168[.]/.test(
    lanUrlForConfig
  )
) {
  // Address is private, format it for later use
  lanUrlForTerminal = prettyPrintUrl(lanUrlForConfig)
} else {
  // Address is not private, so we will discard it
  lanUrlForConfig = undefined
}
```

所以如果你的IP地址是非私有IP的，都将出现 `network: unavailable`

## 解决办法

1. 修改源码添加IP白名单，或者直接移除IP检查
2. 通过添加配置 `public` 

解决办法 1 在问题分析中，已能得到答案。

针对解决办法 2，网上有很多了，一句话就是 `public` 的配置会绕过IP检查，直接<span style="color:red">显示</span>出来。

等等，为什么说显示，因为上边说了一大堆，包括 `network: unavailable` 都只是显示的问题，服务本身已经启动了。可以尝试下在 `network: unavailable` 的情况下，浏览器输入 `{IP}:{PORT}`

