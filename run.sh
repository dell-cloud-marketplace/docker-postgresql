#!/bin/bash

# Various folders.
CONFIG_DIR="/etc/postgresql/"
DATA_DIR="/var/lib/postgresql/"
TMP_CONFIG_DIR="/tmp/etc/postgresql/"
TMP_DATA_DIR="/tmp/var/lib/postgresql/"

# Test if CONFIG_DIR has content.
if [ ! "$(ls -A $CONFIG_DIR)" ]; then
    # Copy the configuration that we generated within the container to the
    # empty CONFIG_DIR.
    cp -r $TMP_CONFIG_DIR/* $CONFIG_DIR
fi

# Ensure postgres owns the CONFIG_DIR.
chown -R postgres $CONFIG_DIR

# Test if DATA_DIR has content.
if [ ! "$(ls -A $DATA_DIR)" ]; then
    # Copy the data that we generated within the container to the empty
    # DATA_DIR.
    cp -r $TMP_DATA_DIR/* $DATA_DIR 
fi

# Ensure postgres owns the DATA_DIR.
chown -R postgres $DATA_DIR

# Ensure we have the right permissions set on the DATA_DIR.
chmod -R 700 $DATA_DIR

# Change the password
if [ ! -f /.postgres_pass_modified ]; then
    /modify_postgres_pass.sh
    touch /.postgres_pass_modified
fi

# Start PostgreSQL using Supervisor.
exec supervisord -n
