FROM ubuntu:16.04

RUN apt-get update
# Erlang HiPE build requires M4
RUN apt-get install -y git build-essential libncurses5-dev openssl libssl-dev curl m4

RUN mkdir -p /opt/erlang/ && \
    curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl && chmod a+x kerl && \
    mv kerl /opt/erlang/ && \
    ln -s /opt/erlang/kerl /usr/local/bin/kerl
RUN curl -fsSL https://raw.github.com/synrc/mad/master/mad > mad \
    && chmod +x mad \
    && mv mad /opt/erlang/ && \
    ln -s /opt/erlang/mad /usr/local/bin/mad

RUN apt-get install -y sudo -y inotify-tools -y mc

RUN useradd -m ubuntu && echo "ubuntu:qwerty" | chpasswd && adduser ubuntu sudo

USER ubuntu
RUN kerl update releases && kerl build 20.2 20.2 && kerl install 20.2 ~/.kerl/20.2
RUN . /home/ubuntu/.kerl/20.2/activate