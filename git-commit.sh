#! /bin/bash

msg=$1
addFile=$2
push=$3

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