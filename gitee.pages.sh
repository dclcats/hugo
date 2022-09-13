#! /bin/bash

hugo --minify -e gitee

cd .gh-pages

git pull

cd ..

cp -r public/. .gh-pages

cd .gh-pages

if [ -n "$(git status -s)" ];then
  git add $addFile
  git commit -m "deploy"
  cmd="git push gitee"
  echo $cmd
  eval $cmd
fi

exit