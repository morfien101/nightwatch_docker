#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nohup Xvfb :40 -ac -screen 0 1600x900x24 & > /dev/null
export DISPLAY=:40
NW_DIR=$HOME/nightwatch
cd $NW_DIR
./node_modules/.bin/nightwatch tests $@
