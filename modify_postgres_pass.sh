#!/bin/bash

# We temporarily start PostgreSQL.
service postgresql start >/dev/null 2>&1

# Generate a password
PASS=${POSTGRES_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${POSTGRES_PASS} ] && echo "preset" || echo "random" )

echo "=> Modifying 'postgres' user with a ${_word} password in PostgreSQL"
sudo -u postgres psql -U postgres -d postgres \
    -c "alter user postgres with password '$PASS';"
echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this PostgreSQL Server using:"
echo ""
echo "    psql -h <host> -p <port> --username=postgres"
echo "and enter the password '$PASS' when prompted"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"

# Stop PostgreSQL.
service postgresql stop >/dev/null 2>&1
sleep 5

