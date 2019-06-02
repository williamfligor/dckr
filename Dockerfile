ARG FROM=ubuntu
FROM $FROM

ARG SHELL_REPO=https://github.com/williamfligor/shell.git

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        vim \
        tmux \
        zsh \
        stow \
        git \
        silversearcher-ag \
        curl \
        wget \
        sudo \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o developer && \
    useradd -m -u $UID -g $GID -o -s /bin/zsh developer && \
    adduser developer sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER developer

WORKDIR /home/developer

ARG BUILD_TIME=0
RUN echo $BUILD_TIME > buildtime

RUN git clone $SHELL_REPO && \
    rm .bashrc && \
    cd shell && \
    ./setup.sh && \
    vim +'PlugInstall --sync' +qa && \
    tmux start-server && \
    tmux new-session -d && \
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
    tmux kill-server

ENV TERM=xterm-256color

CMD /bin/zsh
