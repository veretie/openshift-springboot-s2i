# openshift-springboot-s2i
OpenShift Docker builder image creation project. This image will allow OpenShift to build Maven SpringBoot application image from GIT source.
Details about OpenShift builds and builder image usage described at https://docs.openshift.com/enterprise/3.0/dev_guide/builds.html

## Build image

### Pre-requisites
 - **Linux OS** needed to trigger the build. For Windows, use provided ```Vagrantfile``` which will create Linux Centos 7 OS host.
 - **Docker** needed to create Docker builder image for OpenShift.

### Create image
 - Execute ```make test``` command to create candidate build and run tests against it [optional]
 - Execute ```make build``` command to create ```openshift-springboot-s2i``` docker image
 
## Test image
OpenShift provides **s2i** tool which can be found in ```test``` directory. 
With the help of **s2i** you can explicitly test builder image using actual SpringBoot source code from GIT.
**s2i** for testing can be used in the following format: ```s2i build <source code> openshift-springboot-s2i:latest <application image>```, i.e. 
command ```./test/s2i build https://github.com/veretie/prime-numbers.git openshift-springboot-s2i:latest prime-numbers-openshift``` 
will create ```prime-numbers-openshift``` image with SpringBoot application started on image run/start.

## Publish image
Builder image can be published to Docker Hub or other Docker repo for OpenShift availability with ```docker push <yourname>/openshift-springboot-s2i```.