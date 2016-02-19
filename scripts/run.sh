#!/bin/bash

case $1 in
  mysql)
    mysql "${@:2}"
    ;;
  mysqldump)
    mysqldump "${@:2}"
    ;;
  *)
    /var/mariadb/scripts/start.sh
    ;;
esac
