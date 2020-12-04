FROM ubuntu:latest
LABEL maintainer "Herbrand Hofker <herbrand@kafka.academy>"

EXPOSE 2181
EXPOSE 9092
EXPOSE 9093
EXPOSE 9094

ARG kafka_version=2.6.0
ARG scala_version=2.13
ARG kafka_file=kafka_$scala_version-$kafka_version
RUN apt-get update && apt-get install -y wget  &&  apt-get install -y openjdk-11-jre-headless  
RUN wget https://mirror.novg.net/apache/kafka/$kafka_version/$kafka_file.tgz
RUN tar zxvf $kafka_file.tgz && rm $kafka_file.tgz && mv  $kafka_file /opt

WORKDIR /opt/$kafka_file
ADD ./files/config/* ./config
ADD ./files/bin/* ./

ENTRYPOINT ["/bin/bash", "./start.sh" ]
