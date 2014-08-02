#!/bin/bash
# Starts up MariaDB within the container.

# Stop on error
set -e

DATA_DIR=/var/mariadb/data

pre_start_action() {
  # Cleanup previous sockets
  rm -f /run/mysqld/mysqld.sock
}

post_start_action() {
  : # No-op
}

if [[ ! -e /var/mariadb/scripts/is_setup ]]; then
  source /var/mariadb/scripts/setup.sh
fi

wait_for_mysql_and_run_post_start_action() {
  # Wait for mysql to finish starting up first.
  while [[ ! -e /run/mysqld/mysqld.sock ]] ; do
      inotifywait -q -e create /run/mysqld/ >> /dev/null
  done

  post_start_action
}

pre_start_action

wait_for_mysql_and_run_post_start_action &

# Start MariaDB
echo "Starting MariaDB..."
exec /usr/bin/mysqld_safe
