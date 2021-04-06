---
title: "每天一点React | Render Props"
date: 2021-03-29T15:04:46+08:00
draft: false
slug: "6ce00058"
author: "Chris-dc"
description: "每天一点React | Render Props"
toc: true
show_comments: false
summary: "render prop 是一个用于告知组件需要渲染什么内容的函数 prop"
tags: ["react"]
categories: ["javascript"]
---



### 总结

> 1. `Render Props` 作为参数传入给组件调用执行渲染逻辑
> 2. 应用于某一特定功能的组件封装，可控制渲染出不同view
> 3. 其本质为一个回调函数类型的参数
> 4. 控制组件渲染逻辑的参数（prop），被称为 `Render Props`



**render prop 是一个用于告知组件需要渲染什么内容的函数 prop。**

`Render Props` 是指一种在 React 组件之间使用一个值为函数的 prop 共享代码的简单技术

```jsx
<DataProvider render={data => (
  <h1>Hello {data.target}</h1>
)}/>
```



### 注意

**将 Render Props 与 React.PureComponent 一起使用时要小心**

如果你在 render 方法里创建函数，那么使用 render prop 会抵消使用 [`React.PureComponent`](https://zh-hans.reactjs.org/docs/react-api.html#reactpurecomponent) 带来的优势。因为浅比较 props 的时候总会得到 false，并且在这种情况下每一个 `render` 对于 render prop 将会生成一个新的值。

例如，如果 `Mouse` 继承自 `React.PureComponent`，示例如下：

```jsx
class MouseTracker extends React.Component {
  render() {
    return (
      <div>
        <h1>Move the mouse around!</h1>

        {/*
          这是不好的！
          每个渲染的 `render` prop的值将会是不同的。
        */}
        <Mouse render={mouse => (
          <Cat mouse={mouse} />
        )}/>
      </div>
    );
  }
}
```

在这样例子中，每次 `<MouseTracker>` 渲染，它会生成一个新的函数作为 `<Mouse render>` 的 prop，因而在同时也抵消了继承自 `React.PureComponent` 的 `<Mouse>` 组件的效果！



为了绕过这一问题，有时你可以定义一个 prop 作为实例方法，类似这样：

```jsx
class MouseTracker extends React.Component {
  // 定义为实例方法，`this.renderTheCat`始终
  // 当我们在渲染中使用它时，它指的是相同的函数
  renderTheCat(mouse) {
    return <Cat mouse={mouse} />;
  }

  render() {
    return (
      <div>
        <h1>Move the mouse around!</h1>
        <Mouse render={this.renderTheCat} />
      </div>
    );
  }
}
```

如果你无法静态定义 prop（例如，因为你需要关闭组件的 props 和/或 state），则 `<Mouse>` 应该继承自 `React.Component`。

