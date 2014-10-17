# Docker version 1.2.0, build fa7b24f
FROM ubuntu:14.04

# create user
RUN groupadd web
RUN useradd -d /home/bottle -m bottle

# make sure sources are up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install gcc -y

# -------------------------------------------------------------------------
# --------------------------- INSTALL PYTHON ------------------------------
# -------------------------------------------------------------------------

RUN (export PATH="/usr/bin:$PATH" && mkdir /home/Downloads/ && cd /home/Downloads && wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz --no-check-certificate && tar zxfv Python-2.7.6.tgz && cd /home/Downloads/Python-2.7.6)
RUN /home/Downloads/Python-2.7.6/configure --prefix=/usr/bin/python/2.7.6 --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath=/root/python/2.7.6/lib"
RUN make
RUN make install

RUN apt-get install lynx -y
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
