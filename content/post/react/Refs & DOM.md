---
title: "每天一点React | Refs & DOM"
date: 2021-03-29T13:46:18+08:00
draft: false
slug: "617f0cd9"
author: "Chris-dc"
description: "Refs & DOM"
include_toc: true
show_comments: false
summary: "Refs的使用"
tags: ["react"]
categories: ["javascript"]
---



### 总结

> 1. 通过 `React.createRef()` 方法创建，通过 `React` 元素 或者 `HTML` 元素 的ref属性进行绑定；
> 2. 通过ref的current属性可以访问到 `React` 元素的实例 或者 `HTML` 元素的 `DOM` 元素；
> 3. 可以通过 **`Refs`转发** 将 `DOM` 元素暴露给父组件；
> 4. 可以通过回调的方式设置 `refs` , 会将 `DOM` 元素作为回调函数传入。



### 注意

*React 会在组件挂载时给 `current`属性 or 回调函数参数 传入 DOM 元素，并在组件卸载时传入 `null` 值。`ref` 会在 `componentDidMount` 或 `componentDidUpdate` 生命周期钩子触发前更新。*



### 何时使用 Refs

下面是几个适合使用 refs 的情况：

- 管理焦点，文本选择或媒体播放。
- 触发强制动画。
- 集成第三方 DOM 库。

避免使用 refs 来做任何可以通过声明式实现来完成的事情。



### 创建 Refs

Refs 是使用 `React.createRef()` 创建的，并通过 `ref` 属性附加到 React 元素。在构造组件时，通常将 Refs 分配给实例属性，以便可以在整个组件中引用它们。

```jsx
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();  }
  render() {
    return <div ref={this.myRef} />;  }
}
```

### 访问 Refs

当 ref 被传递给 `render` 中的元素时，对该节点的引用可以在 ref 的 `current` 属性中被访问。

```jsx
const node = this.myRef.current;
```

ref 的值根据节点的类型而有所不同：

- 当 `ref` 属性用于 HTML 元素时，构造函数中使用 `React.createRef()` 创建的 `ref` 接收底层 DOM 元素作为其 `current` 属性。
- 当 `ref` 属性用于自定义 class 组件时，`ref` 对象接收组件的挂载实例作为其 `current` 属性。
- **你不能在函数组件上使用 `ref` 属性**，因为他们没有实例。



### 回调 Refs

React 也支持另一种设置 refs 的方式，称为“回调 refs”。它能助你更精细地控制何时 refs 被设置和解除。

不同于传递 `createRef()` 创建的 `ref` 属性，你会传递一个函数。这个函数中接受 React 组件实例或 HTML DOM 元素作为参数，以使它们能在其他地方被存储和访问。

React 将在组件挂载时，会调用 `ref` 回调函数并传入 DOM 元素，当卸载时调用它并传入 `null`。在 `componentDidMount` 或 `componentDidUpdate` 触发前，React 会保证 refs 一定是最新的。