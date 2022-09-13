---
title: "前端算法题"
date: 2022-05-06T10:54:52+08:00
draft: false
slug: "algorithm"
author: "Chris-dc"
description: "前端算法题汇总"
summary: "前端算法题汇总"
toc: true
comment: true
---


## 排序算法

### 冒泡排序

**两两对比，大的放后边**，最终最大的放在最末尾

```javascript

function buble(arr) {
  if (!arr || arr.length === 0) {
    return arr;
  }
  const len = arr.length;
  for (let i = 0; i < len - 1; i++) {
    for (let j = 0; j < len - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        const k = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = k;
      }
    }
  }
  return arr
}

buble([10,4,2,3,7,5,9,8])

```



### 选择排序

**每轮选出一个最小（大）值**，拿一个值与剩余的其他值做对比


```javascript

function selection(arr) {
  if (!arr || arr.length === 0) {
    return arr;
  }
  const len = arr.length;
  for (let i = 0; i < len - 1; i++) {
    for (let j = i + 1; j < len; j++) {
      if (arr[i] > arr[j]) {
        const k = arr[i];
        arr[i] = arr[j];
        arr[j] = k;
      }
    }
  }
  return arr
}

selection([10,4,2,3,7,5,9,8])

```




### 插入排序

一个值与有序列表对比，冒泡法替换

```javascript

function insertion(arr) {
  if (!arr || arr.length === 0) {
    return arr;
  }
  const len = arr.length;
  for (let i = 1; i < len; i++) {
    for (let j = i; j > 0; j--) {
      if (arr[j] < arr[j - 1]) {
        const k = arr[j - 1];
        arr[j - 1] = arr[j];
        arr[j] = k;
      } else {
        break;
      }
    }
  }
  return arr;
}

insertion([10,4,2,3,7,5,9,8])

```


### 希尔排序

插入排序的升级版， 插入排序与选择排序结合，

```javascript

function shellSort(arr) {
  if (!arr || arr.length === 0) {
    return arr;
  }
  let len = arr.length;
  for (let gap = Math.floor(len / 2); gap > 0; gap = Math.floor(gap / 2)) {
    for (let i = gap; i < len; i++) {
      const tmp = arr[i]
      let j = i;
      while (j >= gap && tmp < arr[j - gap]) {
                arr[j] = arr[j - gap];
                j -= gap;
            }
      arr[j] = tmp;
    }
    console.log(arr);
  }
  return arr;
}

shellSort([10,4,2,3,7,5,9,8])


```



## 其他算法

### 斐波那契

```javascript

function fabonacci(n) {
  if (n <= 1) {
    return n;
  }
  let i = 0;
  let j = 1;
  while (--n) {
    j = i + j;
    i = j - i;
  }
  return j;
}


```


### 青蛙跳台阶

青蛙一次能跳一阶，也可以跳两阶，求对于N阶的台阶，有多少种跳法

对于n阶的台阶，如果青蛙第一次跳一阶，则有 `f(n-1)` 种跳法；如果青蛙第一次跳两阶，则有 `f(n-2)` 种跳法。所以一共有 `f(n-1) + f(n-2)` 种跳法。得出此为一个斐波那契函数

```javascript

function f(n) {
  if (n <= 2) {
    return n;
  }
  let i = 0;
  let j = 1;
  while(n--) {
    j = j + i;
    i = j - i;
  }
  return j;
}

f(100)

```




## js类功能操作

### 防抖

在事件触发后单位时间执行。在单位时间内多次触发，清空定时器，重新计算

*箭头函数没有this，arguments*

```javascript

function debounce(fn, delay = 500) {
  let timer;
  return function () {
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      fn.apply(this, arguments)
      timer = null
    }, delay);
  }
} 

```


### 节流

单位时间内只执行一次

```javascript

function throttle(fn, delay = 500) {
  let timer;
  return function () {
    if (timer) {
      return;
    }
    timer = setTimeout(() => {
      fn.apply(this, arguments);
      timer = null;
    }, delay)
  }
}

```


### 写一个处理加法可能产生精度的函数

比如 0.1 + 0.2 = 0.3

```javascript

function checkPoint(m) {
  const a = m.toString();
  return (a.length - (a.indexOf() + 1));
}

function add(m, n) {
  const mIdx = checkPoint(m);
  const nIdx = checkPoint(n);
  const p = Math.pow(10, Math.max(mIdx, nIdx));
  return (m * p + n * p) / p
}

add(0.1, 0.123)

```


### 大数相加

```javascript

function add(num1, num2) {
  let m = num1.length - 1;
  let n = num2.length - 1;
  const arr = [];
  let add = 0;
  for(; m >= 0 || n >= 0 || add !== 0; m--, n--) {
    const x = m >= 0 ? +num1[m] : 0;
    const y = n >= 0 ? +num2[n] : 0;
    const sum = x + y + add;
    arr.push(sum % 10);
    add = Math.floor(sum / 10);
  }
  return arr.reverse().join('');
}

add('1234567', '87654321174')

```


### 大数相乘

```javascript

function multiply(num1, num2) {
  if (num1 === '0' || num2 === '0') {
    return '0';
  }
  const m = num1.length;
  const n = num2.length;
  const arr = Array(m + n).fill(0);
  for (let i = m - 1; i >= 0; i--) {
    const x = +num1[i];
    for (let j = n - 1; j >= 0; j--) {
      const y = +num2[j];
      const result = x * y + arr[i + j + 1];
      arr[i + j + 1] = result % 10;
      arr[i + j] += Math.floor(result / 10)
    }
  }
  while (arr[0] === 0) {
    arr.shift();
  }
  return arr.join('')
}

multiply('1234567', '87654321174')


```



### 无重复字符的最长子串

```javascript

function lengthOfLongestSubstring(str) {
  const n = str.length;
  const last = {};
  // const last = Array(128).fill(-1);
  let start = 0;
  let len = 0;
  for (let i = 0; i < n; i++) {
    const key = str[i];
    // const key = s.charCodeAt(i);
    start = Math.max(start, (last[key] ?? -1) + 1);
    // start = Math.max(start, last[key] + 1);
    len = Math.max(len, i - start + 1);
    last[key] = i;
  }
  return len;
}

```



### 手写一个Promise all的实现

```javascript

Promise.prototype.all = function (arr) {
  return arr.reduce((result, item) => {
    return item.then(value => {
      return result.then(res => {
        res.push(value)
        return res
      })
    })
  }, Promise.resolve([]))
}

Promise.prototype.all = function (arr) {
  return new Promise((resolve, reject) => {
    if (!arr) {
      reject();
    }
    if (arr.length === 0) {
      resolve([])
    }
    const result = [];
    arr.forEach((item, idx) => {
      item.then((res) => {
        result[idx] = res;
        if (result.length === arr.length) {
          resolve(result);
        }
      }).catch(err => {
        reject(err)
      })
    })
  })
}

```


### 计算数组深度

```javascript

function getDeep(arr) {
  const deeps = [0];
  arr.forEach((item) => {
    if (Array.isArray(item)) {
      deeps.push(getDeep(item))
    }
  })
  return Math.max(...deeps) + 1
}

function getDeep(arr) {
  return arr.reduce((deep, item) => {
    if (Array.isArray(item)) {
      return Math.max(deep, 1 + getDeep(item))
    }
    return deep;
  }, 1);
}

```






