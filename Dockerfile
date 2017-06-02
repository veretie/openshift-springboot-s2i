FROM openshift/base-centos7

MAINTAINER Ed Veretinskas <ed@mits4u.co.uk>

# Inform about software versions being used inside the builder
ENV MAVEN_VERSION="3.3.9" \
    JAVA_VERSION="1.8.0_131" \
    JAVA_HOME="/usr/java/jdk1.8.0_131/jre" \
    M2_HOME="/usr/local/apache-maven/apache-maven-3.3.9" \
    JOLOKIA_VERSION="1.3.5" \
    JOLOKIA_ENABLED="true" \
    JOLOKIA_HOME="/opt/jolokia/" \
    APP_ROOT="/opt/app-root/"

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Buidler image for serving Spring Boot micro-services" \
      io.k8s.display-name="openshift-springboot-s2i 1.0.0" \
      io.openshift.tags="builder,html,springboot"

# Install JAVA_VERSION
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm" \
 && rpm -ivh jdk-8u131-linux-x64.rpm \
 && rm -rf jdk-8u131-linux-x64.rpm

# Jolokia agent
RUN mkdir -p /opt/jolokia/etc \
 && curl http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.5/jolokia-jvm-1.3.5-agent.jar \
         -o /opt/jolokia/jolokia.jar
ADD jolokia /opt/jolokia/
RUN chmod 777 -R /opt/jolokia

# Install Maven
RUN curl -O http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
 && mkdir -p /usr/local/apache-maven && tar zxvf apache-maven-3.3.9-bin.tar.gz -C /usr/local/apache-maven \
 && rm -rf apache-maven-3.3.9-bin.tar.gz \
 && chmod 755 -R /usr/local/apache-maven

# Defines the location of the S2I
# Although this is defined in openshift/base-centos7 image it's repeated here
# to make it clear why the following COPY operation is happening
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i \
		io.s2i.scripts-url=image:///usr/local/s2i \
		vendor=veretie

# Copy the S2I scripts from ./.s2i/bin/ to /usr/local/s2i when making the builder image
COPY ./.s2i/bin/ /usr/local/s2i
RUN chmod -R 755 /usr/local/s2i

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# Set the default user for the image, the user itself was created in the base image
USER 1001

# Specify the ports the final image will expose
EXPOSE 8080

# Set the default CMD to print the usage of the image, if somebody does docker run
CMD ["/usr/local/s2i/usage"]
