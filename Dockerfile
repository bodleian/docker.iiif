# Docker version 1.2.0, build fa7b24f
FROM ubuntu:14.04

# create user
RUN groupadd web
RUN useradd -d /home/bottle -m bottle

# make sure sources are up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install lynx -y
RUN apt-get install gcc -y

RUN apt-get install libexpat1-dev -y
RUN apt-get install libssl-dev -y
RUN apt-get install libc6-dev -y

RUN apt-get install python2.7-dev -y
RUN apt-get install python-lxml -y
RUN apt-get install python-dev -y
RUN apt-get install python-setuptools -y
RUN apt-get install build-essential -y

# install pip and hello-world server requirements
RUN apt-get install python-pip -y
ADD / /home/bottle/
RUN (pip install bottle && pip install python-magic && pip install Pillow)

# in case you'd prefer to use links, expose the port
EXPOSE 8080
ENTRYPOINT ["/usr/bin/python2.7", "/home/bottle/validator.py"]
#ENTRYPOINT ["/home/bottle/"]
USER bottle
