FROM openshift/base-centos7

MAINTAINER Ed Veretinskas <ed@mits4u.co.uk>

# Inform about software versions being used inside the builder
ENV MAVEN_VERSION=3.3.9
ENV JAVA_VERSION=1.8.0_101

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Platform for serving Spring Boot micro-services" \
      io.k8s.display-name="openshift-springboot-s2i 1.0.0" \
      io.openshift.tags="builder,html,springboot"

# Install JAVA_VERSION
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm"
RUN rpm -ivh jdk-8u111-linux-x64.rpm

# Install Maven
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xvf apache-maven-3.3.9-bin.tar.gz
RUN mkdir -p /usr/local/apache-maven/apache-maven-3.3.9
RUN mv -v -n apache-maven-3.3.9/* /usr/local/apache-maven/apache-maven-3.3.9

# Defines the location of the S2I
# Although this is defined in openshift/base-centos7 image it's repeated here
# to make it clear why the following COPY operation is happening
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
# Copy the S2I scripts from ./.s2i/bin/ to /usr/local/s2i when making the builder image
COPY ./.s2i/bin/ /usr/local/s2i

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# Set the default user for the image, the user itself was created in the base image
USER 1001

# Set the default CMD to print the usage of the image, if somebody does docker run
CMD ["/usr/local/s2i/usage"]
