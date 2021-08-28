# 简介
个人博客仓库

## 仓库说明

本项目为 `hugo` 实现的博客项目

## hugo 基础命令

### 新建文章
```shell
hugo new post/first.md
```


### git-commit.sh 文件说明

`git-commit.sh ` 为shell脚本，实现git的提交操作

命令详解

```shell
./git-commit.sh --help  # 获取帮助命令或者 -h
```
输出以下内容

> "参数1： git message"
>
> "参数2： git add 地址"
>
> "参数3： 是否push git到远程仓库：默认push；如果为 -1 不push"

参数1： 通过 `git commit -m` 命令附带的message信息

参数2： 通过 `git add` 命令附带的文件地址，默认为 `.`

参数3:  表示当前提交执行之后是否 `push` 到远程仓库（针对有多个更改，需要提交多个commit的情况）

使用此脚本执行会 推送代码到多个远程仓库，具体为 当前仓库的 `remote` 地址
查看当前仓库的远程仓库信息 `git remote -v` (会显示当前仓库的所有远程仓库及其地址)