#!/bin/bash
set -e

mysql -v -uroot -p"rootsecret" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS idp_db;
    CREATE DATABASE IF NOT EXISTS core_db;
    CREATE DATABASE IF NOT EXISTS business_db;
    GRANT ALL PRIVILEGES ON idp_db.* TO 'laravel'@'%';
    GRANT ALL PRIVILEGES ON core_db.* TO 'laravel'@'%';
    GRANT ALL PRIVILEGES ON business_db.* TO 'laravel'@'%';
    FLUSH PRIVILEGES;
EOSQL