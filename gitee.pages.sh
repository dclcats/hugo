#! /bin/bash

echo "######### 打包 #########"
# 打包
hugo --minify -e gitee
# 获取git tag
GIT_TAG=$(git rev-parse --short=8 HEAD)

# 创建 .gh-pages 目录以处理 gh-pages
rm -rf .gh-pages
mkdir .gh-pages

echo "######### 连接远程分支 #########"

# 连接远程分支到本地
cd .gh-pages
git init .
git remote add origin git@gitee.com:dclcats/dclcats.git
git pull -a
git checkout gh-pages
rm -rf *
cd ..

# 将最新代码同步到 gh-pages
cp -r public/. .gh-pages

cd .gh-pages

echo "######### 提交代码 #########"

# 判断更新并提交代码
if [ -n "$(git status -s)" ];then
  git add .
  git commit -m "deploy: $GIT_TAG"
  cmd="git push origin gh-pages"
  echo $cmd
  eval $cmd
fi

echo "######### 清除中间文件 #########"

# 清除中间文件
cd ..
rm -rf .gh-pages
rm -rf public

exit