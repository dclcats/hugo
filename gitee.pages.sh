#! /bin/bash

hugo --minify -e gitee
GIT_TAG=$(git rev-parse --short=8 HEAD)

cd .gh-pages

git pull

cd ..

cp -r public/. .gh-pages

cd .gh-pages

if [ -n "$(git status -s)" ];then
  git add .
  git commit -m "deploy: $GIT_TAG"
  cmd="git push origin"
  echo $cmd
  eval $cmd
fi

exit