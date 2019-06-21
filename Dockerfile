# this Dockerfile sets up the base bootcamp Docker image
# usage:
# docker build -t "base_bootcamp" .

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl git python build-essential nano man

# create a non-root user and become the learner
RUN useradd -ms /bin/bash learner && \
    chown -R learner:learner /home/learner && \
    cd && cp -R .bashrc .profile /home/learner
USER learner
ENV HOME /home/learner
WORKDIR /home/learner

# needed by nvm install
# change it to your required node version
ENV NODE_VERSION v10.16.0
ENV NVM_DIR /home/learner/.nvm

# install the specified node version and set it as the default one, install the global npm packages
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
RUN . ~/.nvm/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install --global expose-fs

# expose the filesystem - needed for the file browser and editor
# in adventure time
RUN echo "expose-fs >> .fs.out 2>> .fs.err &" >> /home/learner/.bashrc

# more readable terminal prompt
RUN echo "export PS1=\"\[$(tput bold)\]\[\033[38;5;75m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;232m\]@:\[$(tput sgr0)\]\[\033[38;5;9m\]\W\[$(tput sgr0)\]\[\033[38;5;232m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\"" >> /home/learner/.bashrc