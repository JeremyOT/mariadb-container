pre_start_action() {
  # test if DATA_DIR has content
  if [[ ! "$(ls -A $DATA_DIR)" ]]; then
      echo "Initializing MariaDB at $DATA_DIR"
      cp -R /var/lib/mysql/* $DATA_DIR
  fi
  chown -R mysql $DATA_DIR
}

post_start_action() {
  touch /var/mariadb/scripts/is_setup
}
