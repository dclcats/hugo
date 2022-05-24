---
title: "Reflect"
date: 2022-05-24T21:33:48+08:00
draft: true
slug: "1df76ec1"
author: "Chris-dc"
description: ""
summary: ""
toc: true
comment: false
---


# 描述

Reflect 是一个内置对象，它提供一个**拦截** Javascript 操作的方法。与 proxy handlers 方法相同。Reflect不是一个函数对象，因此它是不可构造的（不能使用 `new` 操作符）。其所有属性和方法都是静态的



## Reflect.apply()


### 语法

```javascript
Reflect.apply(target, thisArgument, argumentsList)
```

#### 参数

target: 目标函数。
thisArgument: target函数调用时绑定的this对象。
argumentsList: target函数调用时传入的实参列表，该参数应该是一个类数组的对象。

#### 返回值
返回值是调用完带着指定参数和 this 值的给定的函数后返回的结果。

#### 异常
如果 target 对象不可调用，抛出 TypeError。




