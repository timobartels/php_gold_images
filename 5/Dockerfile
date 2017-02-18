FROM debian:jessie

MAINTAINER Timo Bartels <timo@bartels-online.net>

LABEL "language"="php" "type"="photography"

RUN groupadd --gid 1000 docker \
  && useradd --uid 1000 --gid docker --shell /bin/bash --create-home docker
  
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
                                                apache2 \
                                                php5 \
                                                php5-common \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
