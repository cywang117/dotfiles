#!/usr/bin/env bash

cd
[[ -d ".tmux" ]] && rm -rf .tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
[[ ! -f ~/.tmux.conf.local ]] && cp .tmux/.tmux.conf.local .
cd $CWD
