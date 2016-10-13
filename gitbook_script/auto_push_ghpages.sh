#!/bin/bash

# 该脚本为自动提交gh-pages分支

echo "复制静态网页到gh-pages路径下"
cp -rf _book/* gh-pages/
echo "复制成功"
cd gh-pages

git add ./*
git commit -m "提交静态网页"
git push origin gh-pages

echo "推送成功........."
