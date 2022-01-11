---
title: "Expected Workspace Package to Exist"
date: 2022-01-11T15:56:40+08:00
draft: true
slug: "84c59066"
author: "Chris-dc"
description: "expected workspace package to exist"
summary: "expected workspace package to exist"
toc: true
comment: false
---



[解决链接](https://github.com/yarnpkg/yarn/issues/7807)



执行 `yarn install` or 任何通过 `yarn` 安装依赖包过程中



错误信息

```shell
 An unexpected error occurred: "expected workspace package to exist for \"ts-loader\"".
```



已知原因

在 `yarn` 版本 `1.19 - 1.21.1` 之间皆存在



临时解决方案

```shell
yarn policies set-version 1.18.0
```





其他待补充......







