#!/bin/bash

case $1 in
  mysql)
    mysql ${@:2}
    ;;
  *)
    /var/mariadb/scripts/start.sh
    ;;
esac
