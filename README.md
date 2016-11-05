# openshift-springboot-s2i
OpenShift Docker builder image creation project. This image will allow OpenShift to build Maven SpringBoot application image from source.

## Build

### Pre-requisites
 - **Linux OS** To trigger build in Windows, use provided ```Vagrantfile``` which will create Linux Centos 7 OS host.
 - **Docker** Project artifact is Docker builder image.

### Testing your scripts and image
Execute UNIX ```make test``` command 
OpenShift provides s2i tool which can be found in ```test``` directory. More details on s2i tool can be found in   
 - Testing command ```./test/s2i build test/test-app/ openshift-springboot-s2i:latest test-s2i``` 


### Create image
Execute UNIX ```make build``` command which will create ```openshift-springboot-s2i``` docker image

 
## Notes
