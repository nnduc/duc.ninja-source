#!/bin/bash -ve

rm -frd .deploy_git

git clone git@github.com:nnduc/nnduc.github.io.git --branch publishing .deploy_git --depth 1

rm -frd .deploy_git/*

hexo generate
hexo deploy
