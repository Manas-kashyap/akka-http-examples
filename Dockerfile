FROM openjdk:8-jre-alpine
MAINTAINER manaskashyaptech@gmail.com

RUN mkdir -p ~/akka

WORKDIR ~/akka

COPY ./target/scala-2.11/akka-http-helloworld-assembly-1.0.jar ./

ENTRYPOINT ["java","-jar", "akka-http-helloworld-assembly-1.0.jar"]

