# docker.iiif
IIIF validator for internal testing

$ docker run -d -p 8080 iiif/validator
```
This will map port 8080, which the server is listening on, to a dynamically allocated port on the host. You can see which port by running `docker ps`:
```
$ docker ps
CONTAINER ID        IMAGE                                    COMMAND                CREATED             STATUS              PORTS                     NAMES
e9b36d702141        iiif/validator:latest   /usr/bin/python /hom   3 seconds ago       Up 2 seconds        0.0.0.0:49173->8080/tcp   kickass_archimedes
```
This shows that port 8080 on the container is mapped to port 49173 on the host. Thus, assuming `curl` is installed (if not, run `sudo apt-get install curl` first), you can do:
```
$ curl localhost:49173
```

##### Building from source
You can also build from source using:
```
$ docker build -t you/your_tag_name /PATH/TO/THIS/REPOSITORY
$ docker run -d -p 8080 you/your_tag_name
```

##### Linking to another container
If you'd like to link to another container, the image exposes port 8080 as well.
```
$ docker run -name hello -d iiif/validator
$ docker run -i -t -link hello:my_hello ubuntu bash
```

Then, running `env` in the second container will show the information exposed about our linked container
```
root@177dc3b29bf7:/# env
HOSTNAME=177dc3b29bf7
TERM=xterm
MY_HELLO_PORT_8080_TCP_ADDR=172.17.0.81
MY_HELLO_PORT_8080_TCP_PROTO=tcp
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MY_HELLO_PORT_8080_TCP=tcp://172.17.0.81:8080
PWD=/
MY_HELLO_PORT=tcp://172.17.0.81:8080
SHLVL=1
HOME=/
MY_HELLO_NAME=/tender_galileo/my_hello
MY_HELLO_PORT_8080_TCP_PORT=8080
container=lxc
_=/usr/bin/env
```


