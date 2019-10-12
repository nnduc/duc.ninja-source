#!/bin/bash -v

rm -frd .deploy_git || exit 1

git clone git@nnduc_github:nnduc/nnduc.github.io.git --branch publishing .deploy_git --depth 1  || exit 1

rm -frd .deploy_git/* || exit 1

hexo generator || exit 1
hexo deploy || exit 1
