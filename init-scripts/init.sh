#!/bin/bash

echo "kernel.shmmax=2147483648" >> /etc/sysctl.conf;
echo "max_connections = 300" >> /var/lib/postgresql/data/postgresql.conf;
echo "shared_buffers = 512" >> /var/lib/postgresql/data/postgresql.conf;
echo "statement_timeout = 10000" >> /var/lib/postgresql/data/postgresql.conf;
echo "host all all all scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf;
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf;
echo "host all all ::/0 md5" >> /var/lib/postgresql/data/pg_hba.conf;

psql -U postgres -c "REVOKE ALL ON DATABASE postgres FROM PUBLIC;"

var1=30
while [ $var1 -gt -1 ]
do
psql -U postgres -c "CREATE DATABASE db$var1;"
psql -U postgres -c "REVOKE ALL ON DATABASE db$var1 FROM PUBLIC;"
psql -U postgres -c "REVOKE ALL ON SCHEMA PUBLIC FROM PUBLIC;"
psql -U postgres -c "CREATE USER user$var1 WITH PASSWORD 'password$var1';"
psql -U postgres -c "ALTER DATABASE db$var1 OWNER TO user$var1;"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE db$var1 TO user$var1;"
psql -U postgres -c "GRANT USAGE ON SCHEMA public TO user$var1;"
psql -U postgres -c "GRANT CREATE ON SCHEMA public TO user$var1;"
psql -U postgres -c "GRANT CONNECT ON DATABASE postgres TO user$var1;"
var1=$[ $var1 - 1 ]
done

psql -U postgres -a -f ./demo-big.sql
psql -U postgres -d demo -c "grant usage on schema bookings to public;"
psql -U postgres -d demo -c "grant select on all tables in schema bookings to public;"
