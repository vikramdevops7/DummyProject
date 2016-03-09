FROM maven:3.3.3-jdk-8 

# Install maven
ENV http_proxy 'http://pitc-zscaler-americas-cincinnati3pr.proxy.corporate.ge.com:80'
ENV https_proxy 'http://pitc-zscaler-americas-cincinnati3pr.proxy.corporate.ge.com:80'
# RUN apt-get update
# RUN apt-get install -y maven

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml
# RUN ["mvn", "dependency:resolve"]
# RUN ["mvn", "verify"]
RUN mvn -B dependency:resolve dependency:resolve-plugins
# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "package"]

EXPOSE 4567
CMD ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-jar", "target/sparkexample-jar-with-dependencies.jar"]
