#!/bin/bash

#该脚本用于使用gitbook写笔记时，自动克隆仓库到本地，创建分支gh-pages,初始化gitbook工作空间，maste分支存放gitbook源码，gh-pages分支存放gitbook静态网页
#gh-pages分支存放在gh-pages路径下
#编辑gitbook书籍时：提交master分支的修改后，执行自动提交gh-pages分支脚本

#该脚本使用命令:  gitbook_create.sh gitbook远程仓库ssh地址 仓库名 自动化提交gh-pages分支脚本地址 （gitbook_create.sh arg1 arg2 arg3）

source /home/huoshan/gitRespo/nvm/nvm.sh

echo "开始克隆仓库:"$1

#clone仓库到本地
git clone $1

#复制脚本到该路径下
cp $3 $2
cd $2
#判断是否有readme.md文件
if [ ! -f "README.md" ]
then
echo "没有发现readme文件，开始创建"
	touch README.md
	git add README.md
	git commit -m "add README.md"
	git push
fi
#创建gh-pages分支
git checkout -b gh-pages
#推送分支到github
git push -u origin gh-pages

git checkout master
git clone -b gh-pages $1 gh-pages

if [ ! -f .gitignore ]
then
	touch .gitignore
	#echo "_book" >> .gitignore
	#echo "gh-pages" >> .gitignore
	echo "*~" >> .gitignore
	
	git add .gitignore
	git commit -m "添加.gitignore"
	git push origin master
fi


cd gh-pages
if [ ! -f .gitignore ]
then
	touch .gitignore
	echo "*~" >> .gitignore
	git add .gitignore
	git commit -m "添加.gitignore"
	git push origin gh-pages
fi


cd ..

nvm use v4.1.2
gitbook init
gitbook build
gitbook serve 

echo "success"
