FROM ubuntu:14.04
MAINTAINER jeremyot@gmail.com

RUN echo mariadb-server-10.0 mysql-server/root_password password admin | debconf-set-selections; echo mariadb-server-10.0 mysql-server/root_password_again password admin | debconf-set-selections; echo mariadb-server-10.0 mysql-server/start_on_boot boolean false | debconf-set-selections
RUN apt-get update && ln -s -f /bin/true /usr/bin/chfn && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server inotify-tools && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i -e 's/^bind-address.*=.*$/bind-address=0.0.0.0/' /etc/mysql/my.cnf
COPY scripts /var/mariadb/scripts
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql", "/etc/mysql"]
ENTRYPOINT ["/var/mariadb/scripts/run.sh"]
