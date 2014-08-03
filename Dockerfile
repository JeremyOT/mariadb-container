FROM ubuntu:14.04
MAINTAINER jeremyot@yix.io

RUN echo mariadb-server-10.0 mysql-server/root_password password admin | debconf-set-selections; echo mariadb-server-10.0 mysql-server/root_password_again password admin | debconf-set-selections; echo mariadb-server-10.0 mysql-server/start_on_boot boolean false | debconf-set-selections
RUN apt-get update && alias adduser='useradd' && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server inotify-tools
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i -e's/^datadir\s*=.*/datadir = \/var\/mariadb\/data/' /etc/mysql/my.cnf
RUN sed -i -e 's/^bind-address.*=.*$/bind-address=0.0.0.0/' /etc/mysql/my.cnf
COPY scripts /var/mariadb/scripts
EXPOSE 3306
VOLUME ["/var/mariadb/data", "/var/log/mysql", "/etc/mysql"]
ENTRYPOINT ["/var/mariadb/scripts/run.sh"]
