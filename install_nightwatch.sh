#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
NW_DIR=$HOME/nightwatch
cd $NW_DIR
nvm install 5.0 \
&& nvm use 5.0 \
&& nvm alias default node \
&& npm install nightwatch \
&& npm install chromedriver \
&& npm install nightwatch-video-recorder
