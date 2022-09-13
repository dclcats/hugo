---
title: "前端面试题"
date: 2022-05-01T19:35:52+08:00
draft: true
slug: "web-interview"
author: "Chris-dc"
description: "前端面试题汇总"
summary: "前端面试题汇总"
toc: true
comment: true
---

[前端面试经典算法题](https://blog.csdn.net/qq_39207948/article/details/113922691)

[96道前端面试题+前端常用算法](https://zhuanlan.zhihu.com/p/352251817)

[蚂蚁、字节、滴滴面试经历总结](https://blog.csdn.net/LuckyWinty/article/details/106515128)


### 原型链


### 浏览器缓存

浏览器缓存可以从多个维度进行抽象分类。在广义上来讲无论是memory cache、service worker、push cache、http cache都属于浏览器缓存的概念，而大部分时候我们提到浏览器缓存的概念往往是指http cache。其实对于浏览器而言还有一种回退缓存（page cache），

以下我们来关注几种浏览器可能会发生缓存的场景：

资源预加载： 如preloader ,preload、prefetch。preloader与preload不同是资源预加载期，例如在标记化时，可能需要的css资源就已经被预先加载到memory cache中了。而资源预加载技术，通过link实现。可以将项目中可能用到的数据先请求过来以备页面使用。数据存放于内存缓存( memory cache)。参考：https://calendar.perfplanet.com/2013/big-bad-preloader/
服务端推送： 这里是指http2的服务端推送，而非客户端轮询。是一种服务器根据某种规则推送客户端将可能用到的资源来减少请求时间的技术。数据存放于push cache。推送缓存中的数据仅可以使用一次，之后将可能根据协议头存在于http缓存中。参考：https://jakearchibald.com/2017/h2-push-tougher-than-i-thought/
service worker： Service workers 本质上充当 客户端与服务端之间的代理服务器。这个 API 创建了有效的离线体验，它会拦截网络请求并根据网络是否可用采取来适当的动作、更新来自服务器的的资源。它还提供入口以推送通知和访问后台同步 API。server woker的缓存不同于http 缓存，由server worker自身接管，存储在server worker 参考：https://w3c.github.io/ServiceWorker/#cache-objects
重复的网络资源请求： 常见的网络资源请求，可以根据协议头将资源存储在硬存中，以备下一次使用（http cache），相对于内存缓存，可以进行持久化的存储，而不会局限于单次会话。参考：https://www.rfc-editor.org/rfc/inline-errata/rfc7234.html
页面回退：想象有这样一种场景，你点进了一个博客，顺着博客的链接你进了另一篇文章，当你回退的时候是否会觉得上一个页面似乎很快就会退了而非重新进行了一遍加载。这就是浏览器为了浏览器性能实现的页面回退机制（Page Cache）。不过此种机制往往不存在于页面内资源寻找的过程，是一种浏览器自身不受开发者控制的实现机制。
参考:https://calendar.perfplanet.com/2013/big-bad-preloader/
以上缓存的读取顺序为： （Memory Cache/Preload Cache） -> Service Worker -> （Disk Cache/HTTP cache） -> Push Cache

而本文主要以Http Cache的描述为主，关于Service worker以及Server Push如果感兴趣可以通过参考链接进行过了解。


### Session和Cookie的区别？
1、数据存储位置：cookie数据存放在客户的浏览器上，session数据放在服务器上。

2、安全性：cookie不是很安全，别人可以分析存放在本地的cookie并进行cookie欺骗，考虑到安全应当使用session。

3、服务器性能：session会在一定时间内保存在服务器上。当访问增多，会比较占用你服务器的性能，考虑到减轻服务器性能方面，应当使用cookie。

4、数据大小：单个cookie保存的数据不能超过4K，很多浏览器都限制一个站点最多保存20个cookie。

5、信息重要程度：可以考虑将登陆信息等重要信息存放为session，其他信息如果需要保留，可以放在cookie中。


### XSS攻击可以分为三类：反射型，存储型，DOM型

1.反射型XSS攻击

反射型攻击是指用户提交恶意代码给服务器，服务器又将恶意代码反射给浏览器端，例如在url请求中加上script代码，那么浏览器在访问相应url时就会执行恶意代码

2.存储型XSS攻击

如上图所示，攻击者利用站点漏洞将恶意代码提交到网站的数据库中，当用户进行访问时，就会执行相应的恶意代码，脚本代码会将用户信息上传到黑客服务器。

在实际应用中，如果在登录页面，用户名输入框中输入<script>alert('存储型 XSS 攻击')</script>代码，服务端在存储相应信息之后，返回成功的登录名，就会执行这段代码，在页面形成弹窗。

存储型攻击与反射型攻击的区别在于，服务器端是否存储了相应的恶意代码。

3.DOM型XSS攻击

 

 这是发生在前端的攻击，通过恶意脚本修改页面的DOM节点，从js中输出数据到HTML页面中

与普通XSS不同的是，DOM XSS是在浏览器的解析中改变页面DOM树，且恶意代码并不在返回页面源码中回显，这使我们无法通过特征匹配来检测DOM XSS

基于DOM攻击大致需要经历以下几个步骤

攻击者构造出特殊的URL，其中包含恶意代码
用户打开带有恶意代码的URL
用户浏览器接受到响应后执行解析，前端JavaScript取出URL中的恶意代码并执行
恶意代码窃取用户数据并发送到攻击者的网站，冒充用户行为，调用目标网站接口执行攻击者指定的操作

#### 防御办法
1.对输入进行检查和转码

输入检查一般是检查用户输入的数据是都包含一些特殊字符，如 <、>, '及"等。如果发现特殊字符，则将这些字符过滤或编码。这种可以称为 “XSS Filter”。

安全的编码函数

针对HTML代码的编码方式是 HtmlEncode（是一种函数实现，将字符串转成 HTMLEntrities）

```html
& --> &amp;
< --> &lt;
> --> &gt;
" --> &quot;
```
相应的， JavaScript的编码方式可以使用 JavascriptEncode。

假如说用户输入了 `<script>alert("你被攻击了")</script>`，我们要对用户输入的内容进行过滤（如果包含了 `<script>` 等敏感字符，就过滤掉）或者对其编码，如果是恶意的脚本，则会变成下面这样

```html
&lt;script&gt;alert("你被攻击了");&lt;/script&gt;
```

经过转码之后的内容，如 `<script>`标签被转换为 `&lt;script&gt;`，即使这段脚本返回给页面，页面也不会指向这段代码。

2.利用CSP

[Content Security Policy 入门教程 - 阮一峰](http://www.ruanyifeng.com/blog/2016/09/csp.html)

CSP (Content Security Policy) 即内容安全策略，是一种可信白名单机制，可以在服务端配置浏览器哪些外部资源可以加载和执行。可以通过这种方式来尽量减少 XSS 攻击。

通常可以通过两种方式来开启 CSP：

设置 HTTP Header 的 `Content-Security-Policy`

```http
Content-Security-Policy: default-src 'self'; // 只允许加载本站资源
Content-Security-Policy: img-src https://*  // 只允许加载 HTTPS 协议图片
Content-Security-Policy: child-src 'none'    // 允许加载任何来源框架
```

设置 meta 标签的方式

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*; child-src 'none'">
```

### 关于CSRF
跨站请求伪造：攻击者诱导受害者进入第三方网站，在第三方网站中，向被攻击网站发送跨站请求。利用受害者在被攻击网站已经获取的注册凭证，绕过后台的用户验证，达到冒充用户对被攻击的网站执行某项操作的目的。

一个典型的CSRF攻击有着如下的流程：

+ 受害者登录a.com，并保留了登录凭证（Cookie）。
+ 攻击者引诱受害者访问了b.com。
+ b.com 向 a.com 发送了一个请求：a.com/act=xx。
+ a.com接收到请求后，对请求进行验证，并确认是受害者的凭证，误以为是受害者自己发送的请求。
+ a.com以受害者的名义执行了act=xx。
+ 攻击完成，攻击者在受害者不知情的情况下，冒充受害者，让a.com执行了自己定义的操作。

#### 三种常见的攻击方式：
1.GET类型的CSRF

通常请求被放置在img标签的src中，当用户访问了包含这个标签的网页时，浏览器会自动向src中的地址提交一次http请求

2.自动发起POST类型请求

通过构建一个隐藏的表单，表单的内容就是自动发起支付的接口请求。当用户打开该页面时，这个表单会被自动执行提交。当表单被提交之后，服务器就会执行转账操作。因此使用构建自动提交表单这种方式，就可以自动实现跨站点 POST 数据提交。

3.链接类型

通过夸张的广告诱导用户点击链接，跳转到危险的网站，该网站自动自动发送请求，冒充用户执行相应的操作。

因此，CSRF有以下两个特点：一是通常发生在第三方域名，二是攻击者不能访问cookie信息，只是使用。针对这两个方面，对CSRF攻击进行相应的防护。

#### 防护措施：
1.确定来源域名。

由于CSRF攻击大多来自第三方站点，可以在服务器端验证请求来源的站点，禁止第三方站点的请求。 可以通过HTTP请求头中的 Referer和Origin属性确定来源域名。



 

2.设置CSRF Token

在用户首次发出请求时，服务器为该用户生成一个token（一般是随机字符串和时间戳生成的随机数组合），之后所有的请求都携带这个token，在有效期内服务器进行验证。由于攻击者无法获取这个随机的token，可以防护csrf攻击。

3.为Set-Cookie响应头新增Samesite属性


[Cookie 的 SameSite 属性 - 阮一峰](http://www.ruanyifeng.com/blog/2019/09/cookie-samesite.html)

SameSite有3个可选值： Strict, Lax和None

Samesite=Strict，严格模式，浏览器完全禁止第三方cookie，只有本站点访问本站点的资源，才会携带cookie

Samesite=Lax，宽松模式，在跨站点的情况下，从第三方站点链接打开和从第三方站点提交 Get方式的表单这两种方式都会携带Cookie。但如果在第三方站点中使用POST方法或者通过 img、Iframe等标签加载的URL，这些场景都不会携带Cookie。

Samesite=none，任何情况下都可以发送cookie数据



### CSRF和XSS的区别：
1、CSRF需要登陆后操作，XSS不需要

2、CSRF是请求页面api来实现非法操作，XSS是向当前页面植入js脚本来修改页面内容。


### 跨域资源共享 CORS 详解

[跨域资源共享 CORS 详解 - 阮一峰](https://www.ruanyifeng.com/blog/2016/04/cors.html)


### CORS原理及详细使用

https://blog.csdn.net/CWH0908/article/details/89765421




### es module 和 commonjs 的区别

[聊聊什么是CommonJs和Es Module及它们的区别](https://juejin.cn/post/6938581764432461854)

ESM：import, import(), export, export default

CommonJS: require(), module.exports

 

1. CommonJS输出的是值的拷贝，ES Module输出的是值的引用

2. CommonJS是运行时加载（module.exports），ES Module是编译时输出接口

3. CommonJS的require（）是同步加载模块，ESModule的import是异步加载模块，静态编译时加载，有独立的模块依赖解析

4. CommonJS模块的顶层this指向当前模块，ES6模块中，顶层this指向undefined

 

ES Module：静态加载/编译时加载

CommonJS：运行加载

ESM效率要比 CommonJS 模块的加载方式高，动态绑定关系

 

import：静态执行，会提升，不可修改/只读

export default：指定模块的输出，输出一个叫做default的方法/变量，系统允许修改名称

import（）：动态加载模块，当需要按需加载时使用



### react 里如何做动态加载

React.lazy

Suspense

https://www.cnblogs.com/develon/p/13706136.html


### 动态加载的原理是啥

https://segmentfault.com/a/1190000022191241

### 写一个 es6 的继承过程


### hooks 原理


### XML和JSON的区别？

### 位运算

[位运算](https://blog.csdn.net/qq_35014708/article/details/89249373)


### webpack动态加载原理/webpack异步加载原理/webpack动态解析import()原理

https://blog.csdn.net/qq_17175013/article/details/119350311






