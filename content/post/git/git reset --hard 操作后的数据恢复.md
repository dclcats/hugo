---
date: "2018-05-07T17:12:24+02:00"
title: "git reset --hard 操作后的数据恢复"
author: "Chris-dc"
slug: 'git reset'
categories: ["git"]
tags: ["git reset", "数据恢复"]
---

在进行正文之前先简单介绍下`git reset` 命令
### git reset
`git reset` 命令用于改变当前的仓库状态，简单的场景用例：假设一次修改了两个文件，然而需要对这两个文件分别进行两次提交，在进行缓存操作时（`git add`），不小心将两个文件都进行了缓存，此时我们需要对其中一个文件取消缓存，此时就需要`git reset` 操作来实现，如下图
![image](https://user-images.githubusercontent.com/26424129/39693980-53792fbe-5218-11e8-9d88-7aa3a7ee5443.png)
然后，对`b.txt`进行`commit`操作，然后再对`a.txt`进行`add & commit`操作

对于`git reset`命令添加了**--hard** 参数后会怎样呢，在[git官网的reference上](https://git-scm.com/docs/git-reset) 有如下一段话

也就是说，添加`--hard`参数后，会回到上次`commit`的状态，也就是说从上次`commit`之后的的修改都将被重置，换句话说这些数据都丢失了，所以要谨慎操作哦。

![image](https://user-images.githubusercontent.com/26424129/39694690-c4e15864-521a-11e8-8be5-75c2a5f91780.png)

前置知识就到这里了，开始今天的重点。

当我们进行了`git reset --hard`操作进行了版本回退，现在我们又需要之前的修改信息，也就是说我们需要版本回退之前的文件信息，此时我分了三种情况
1. 之前的修改进行了 `commit` 提交，也就是说我们回退前的修改（曾经）存在于版本里;
2. 之前的修改未进行`commit`提交，但是进行了 `git add ` 操作；
3. 之前的修改未进行 `commit` 提交，也未进行`git add`操作。

如果时第一种情况，很简单我们拿到之前修改的`commit`的哈希值（或者说id），然后执行 `git reset --hard [hash]`就可以回退到之前修改的状态。
怎么拿`hash`， 这个好说，可以执行命令`git reflog`命令，它会显示出你之前的所有操作
像这个

![image](https://user-images.githubusercontent.com/26424129/39695387-f6a31e58-521c-11e8-8203-5af2c60b1e66.png)

`62f039e` 就是我的`reflog`提交的哈希值，对其进行`reset`即可

如果是第三种情况，不好意思暂时还没有找回的办法，如果你有欢迎拿出来大家交流

今天的重点就是第二种情况，毕竟曾经我也以为此情况无解，直到后来这边文章诞生前。

今天的主角命令 `git fsck`，这里呢不具体讲解此命令，只是简单描述利用此命令进行文件恢复。

![image](https://user-images.githubusercontent.com/26424129/39695724-2540e294-521e-11e8-9171-c4596fcdef25.png)

![image](https://user-images.githubusercontent.com/26424129/39695739-30cf161c-521e-11e8-9124-521a9815ce06.png)

如图示，我新建了文件`c.txt`并添加了内容 'git fsck'，添加到缓存之后进行了`reset`操作， 此时因为没有进行`git commit`操作所以没有hash值，可供恢复，这个时候需要进行操作 `git fsck --lost-found`操作，返回如下结果：

![image](https://user-images.githubusercontent.com/26424129/39697557-e8e843c2-5223-11e8-88dc-14ae11c22f36.png)


关于此命令，git官网的解释
![image](https://user-images.githubusercontent.com/26424129/39697417-76095378-5223-11e8-8453-654d38de8cd9.png)
根据提示，找到目录'.git/lost-found'，可以看到，

![image](https://user-images.githubusercontent.com/26424129/39697621-191fa13e-5224-11e8-901a-b9a7f881b396.png)

我们在‘commit’和‘other’目录下分别看到命令窗口打印出的文件，在‘other‘目录下找出之前遗失的文件
![image](https://user-images.githubusercontent.com/26424129/39697733-87c3c23c-5224-11e8-8755-443df0853a26.png)
然后新建'c.txt'文件，并将文件内容复制过去，结束。

是不是很麻烦，特别是一次提交的文件多了，一个一个新建（修改）复制过去好烦哦。

是的很烦，所以保持良好的习惯。永远不要让这种操作降临到自己身上才是正道。（这只是为不可控的意外情况准备的）
