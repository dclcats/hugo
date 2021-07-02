---
title: "安装"
date: 2021-07-02T10:20:28+08:00
draft: true
slug: "451a23b8"
author: "Chris-dc"
description: ""
summary: ""
toc: true
comment: false
---


Visual Studio 2019 生成工具Visual Studio 2019 build tools或者微软Visual Studio。下载build tools之后，在Visual studio installer中只选择“C++生成工具”，然后只选择"MSVC v142 - VS2019 C++  x64/x86 生成工具"。安装上去大约需要1.8G硬盘空间。

Case 1: Using C++ win compiler, to fix it you need to reinstall VS build tool C++ Download the Visual Studio 2019 Build tools from the Microsoft website: https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16

After the download, while installing the Build tools, make sure that you install the required components:

C++ build tools
This will download required files. Once everything is successfully installed, reboot and re-run your rust program and it will compile successfully.

Case2: This error can come from the fact that you use GCC to compile, to fix it (assume that you already have MinGW):

Tape in cmd:


> `rustup uninstall toolchain stable-x86_64-pc-windows-msvc`
> `rustup toolchain install stable-x86_64-pc-windows-gnu (or download rustup-init for the platform of your choice at https://forge.rust-lang.org/infra/other-installation-methods.html)`
> `rustup default stable-x86_64-pc-windows-gnu`

Case 3: You don't want to download Visual studio with build tools, simply install MinGw with g++ gcc development packages, then run CASE 2