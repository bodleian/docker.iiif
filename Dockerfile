# Docker version 1.2.0, build fa7b24f
FROM ubuntu:14.04

# -------------------------------------------------------------------------
# --------------------------- UPDATE SOURCES ------------------------------
# -------------------------------------------------------------------------

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
 
# -------------------------------------------------------------------------
# --------------------------- STIPULATE OS --------------------------------
# -------------------------------------------------------------------------

FROM ubuntu:14.04

# -------------------------------------------------------------------------
# --------------------------- UPDATE OS -----------------------------------
# -------------------------------------------------------------------------

RUN (sudo apt-get update && sudo apt-get upgrade -y -q && sudo apt-get dist-upgrade -y -q && sudo apt-get -y -q autoclean && sudo apt-get -y -q autoremove)

# -------------------------------------------------------------------------
# --------------------------- CREATE USER  --------------------------------
# -------------------------------------------------------------------------

RUN groupadd web
RUN useradd -d /home/bottle -m bottle

# -------------------------------------------------------------------------
# --------------------------- COPY SOURCE INTO CONTAINER ------------------
# -------------------------------------------------------------------------

COPY / /home/bottle/
RUN chown -R bottle:bottle /home/bottle

# -------------------------------------------------------------------------
# --------------------------- INSTALL REQS --------------------------------
# -------------------------------------------------------------------------

RUN apt-get -y install $(cat /home/bottle/ubuntu_requirements14)
RUN mkdir -p /home/bottle/Downloads

# -------------------------------------------------------------------------
# --------------------------- INSTALL PYTHON ------------------------------
# -------------------------------------------------------------------------

#RUN (cd /home/bottle/Downloads && wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz --no-check-certificate && tar zxfv Python-2.7.6.tgz && cd /home/bottle/Downloads/Python-2.7.6)
#RUN /home/bottle/Downloads/Python-2.7.6/configure --prefix=/home/bottle/python/2.7.6 --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath=/home/bottle/python/2.7.6/lib"
#RUN make
#RUN make install

# -------------------------------------------------------------------------
# --------------------------- DEPENDENCIES --------------------------------
# -------------------------------------------------------------------------

RUN apt-get install lynx -y
RUN apt-get install python-lxml -y
RUN apt-get install python-pip -y
RUN (pip install bottle && pip install python-magic && pip install Pillow)

# -------------------------------------------------------------------------
# --------------------------- PORT & ENTRYPOINT ---------------------------
# -------------------------------------------------------------------------

EXPOSE 8080
#ENTRYPOINT ["/home/bottle/html/index.html"]
#ENTRYPOINT ["/home/bottle/"]
USER bottle
