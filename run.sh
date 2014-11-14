#!/bin/bash

#Copy PostGreSQL
CONFIG_DIR="/etc/postgresql/"
DATA_DIR="/var/lib/postgresql/"
TMP_CONFIG_DIR="/tmp/etc/postgresql/"
TMP_DATA_DIR="/tmp/var/lib/postgresql/"

# test if CONFIG_DIR has content
if [ ! "$(ls -A $CONFIG_DIR)" ]; then
    # Copy the configuration that we generated within the container to the empty CONFIG_DIR.
    cp -r $TMP_CONFIG_DIR/* $CONFIG_DIR
fi
# Ensure postgres owns the CONFIG_DIR
chown -R postgres $CONFIG_DIR

# test if DATA_DIR has content
if [ ! "$(ls -A $DATA_DIR)" ]; then
    # Copy the data that we generated within the container to the empty DATA_DIR.
    cp -r $TMP_DATA_DIR/* $DATA_DIR 
fi
# Ensure postgres owns the DATA_DIR
chown -R postgres $DATA_DIR
 # Ensure we have the right permissions set on the DATA_DIR
chmod -R 700 $DATA_DIR


# Change the password
service postgresql start >/dev/null 2>&1
if [ ! -f /.postgres_pass_modified ]; then
	/modify_postgres_pass.sh
fi
service postgresql stop >/dev/null 2>&1

# Start PostgreSQL 
#sudo -u postgres /usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf


sudo -u postgres /usr/lib/postgresql/9.3/bin/postgres \
-D /var/lib/postgresql/9.3/main \
-c config_file=/etc/postgresql/9.3/main/postgresql.conf 
