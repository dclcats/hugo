#! /bin/bash

msg=$1
addFile=$2
push=$3

if [[ -z $1 ]] || [[ $1 = "--help" || $1 = "-h" || $1 = "help" ]];then
	echo "参数1： git message"
	echo "参数2： git add 地址"
	echo "参数3： 是否push git到远程仓库：默认push；如果为 -1 不push"
	exit
fi

if [[ $addFile ]]
then
	if [[ -e $addFile ]]
	then
		echo "$addFile: add file 存在"
	else
		addFile=.
	fi
else
	addFile=.
fi

if [ -n "$msg" ]
then
	echo "$msg: message 存在"
else
	msg="update"
fi

if [ -n "$(git status -s)" ];then
    git add $addFile
    git commit -m "$msg"
		if [[ -z $push || $push != "-1" ]];then
			for remote in `git remote`;do
				cmd="git push $remote"
				echo $cmd
				eval $cmd
			done
		fi
fi

exit