FROM ubuntu:16.04

RUN apt-get update
# Erlang HiPE build requires M4
RUN apt-get install -y git build-essential libncurses5-dev openssl libssl-dev curl m4

RUN mkdir -p /opt/erlang/ && \
    curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl && chmod a+x kerl && \
    mv kerl /opt/erlang/ && \
    ln -s /opt/erlang/kerl /usr/local/bin/kerl

RUN apt-get install sudo -y inotify-tools


RUN useradd -m -p qwerty ubuntu
RUN ubuntu
RUN whoami
RUN kerl update releases && kerl build 20.2 20.2 && kerl install 20.2 ~/.kerl/20.2
RUN . /home/ubuntu/.kerl/20.2/activate

RUN
