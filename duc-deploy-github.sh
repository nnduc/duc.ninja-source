#!/bin/bash -ve

rm -frd .deploy_git

git clone git@nnduc_github:nnduc/nnduc.github.io.git --branch publishing .deploy_git --depth 1

rm -frd .deploy_git/*

hexo generator
hexo deploy
