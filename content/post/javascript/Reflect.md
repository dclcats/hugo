---
title: "Reflect"
date: 2022-05-24T21:33:48+08:00
draft: false
slug: "1df76ec1"
author: "Chris-dc"
description: ""
summary: ""
toc: true
comment: false
---


# 描述

Reflect 是一个内置对象，它提供一个**拦截** Javascript 操作的方法。与 proxy handlers 方法相同。Reflect不是一个函数对象，因此它是不可构造的（不能使用 `new` 操作符）。其所有属性和方法都是静态的

在 `Object` 基础上的功能，使得对于对象属性和方法的处理更加平滑合理


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


## Reflect.construct()

相当于运行 `new` 操作

### 语法

```javascript
Reflect.construct(target, argumentsList[, newTarget])
```

#### 参数

target: 被运行的目标构造函数
argumentsList: 类数组，目标构造函数调用时的参数
newTarget(可选): 作为新创建对象的原型对象的constructor属性， 参考 `new.target` 操作符，默认值为target。相当于将 `new.target` 设置为 `newTarget`; 原型链

#### 返回

以target（如果newTarget存在，则为newTarget）函数为构造函数，argumentList为其初始化参数的对象实例。


#### Reflect.construct() vs Object.create()

`Reflect.construct()` 与 `Object.create()` 操作一致。区别在于 `Reflect.construct()` 相当于 `new` 操作，即其 `new.target` 会指向参数 `target` 或者 `newTarget`，但是 `Object.create()` 的 `new.target` 指向 `undefined`


## Reflect.defineProperty()

与 `Object.defineProperty` 基本相同，区别是该方法返回的是 `Boolean`。设置成功返回 `true`，失败返回 `false`


### 语法

```javascript
Reflect.defineProperty(target, propertyKey, attributes)
```

#### 参数

target: 目标对象。
propertyKey: 要定义或修改的属性的名称。
attributes: 要定义或修改的属性的描述。

#### 返回值

`Boolean` 值指示了属性是否被成功定义。

#### 异常

如果 `target` 不是 `Object`，返回 `TypeError`

### 描述

参考 `Object.defineProperty`


## Reflect.deleteProperty()

删除一个对象的属性。与 `delete operator` 在非严格模式相同

*`delete operator` 在非严格模式下，对于**自身的不可配置**的属性将返回 `false`； 在严格模式下会抛出 `TypeError`*

### 语法

```javascript
Reflect.deleteProperty(target, propertyKey)
```

#### 参数

target：删除属性的目标对象。
propertyKey：需要删除的属性的名称。

#### 返回值

`Boolean` 表示是否删除成功

#### 异常

对于非 `Object` 的 `target` 将抛出 `TypeError`;



