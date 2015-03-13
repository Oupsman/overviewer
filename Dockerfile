FROM ubuntu:latest

MAINTAINER Benoit SERRA (oupsman@oupsman.fr)

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 1.8.3

RUN apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common
RUN apt-get --yes install curl wget
RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN wget -O - http://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -
RUN apt-get --yes update
RUN apt-get --yes install minecraft-overviewer

VOLUME ['/data']
WORKDIR /data

# Creating the reference

RUN mkdir /server

# Downloading the texture pack

RUN wget https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/${VERSION}.jar -P ~/.minecraft/versions/${VERSION}/

# Accept the licence

ADD ./scripts/update_overviewer.sh /startup.sh

RUN chmod +x /startup.sh

CMD ["/startup.sh"]

