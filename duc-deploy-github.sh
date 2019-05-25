#!/bin/bash -v
rm -frd .deploy_git && git clone git@github.com:nnduc/nnduc.github.io.git --branch master .deploy_git --depth 1
rm -frd .deploy_git/*
hexo generator && hexo deploy