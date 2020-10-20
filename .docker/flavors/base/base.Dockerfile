###############################################################################
# 
# Description: Base Container
# Filename: base.Dockerfile
# 
###############################################################################

FROM debian:buster

# Set Timezone
ENV TZ America/Sao_Paulo

WORKDIR /opt/env

COPY --chown=root:root VERSION .

ENV VERSION 0.0.1

RUN \
    apt-get -yqq update && apt-get install -yqq --no-install-recommends --no-install-suggests \
        tzdata curl jq wget curl unzip ca-certificates sudo git apt-transport-https gnupg-agent \
        software-properties-common gnupg dirmngr xz-utils vim htop ncdu zsh tmux less \
    && apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/*

RUN \
    groupadd -g 1000 developer \
    && useradd -m -u 1000 -g 1000 -s /usr/bin/zsh developer \
    && chsh -s /usr/bin/zsh root \
    && chsh -s /usr/bin/zsh developer

COPY .docker/flavors/base/entrypoint.sh /entrypoint.sh
WORKDIR /home/developer

USER developer

COPY --chown=1000:1000 .docker/flavors/base/dot-files .

RUN \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh \
    && cp allanmacgregor.zsh-theme /home/developer/.oh-my-zsh/themes/ \
    && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

COPY .docker/flavors/base/.zshrc .

CMD [ "/usr/bin/zsh" ]