## docker compose файл для развртывания СУБД PostgreSQL для групп студентов

```bash
git clone https://github.com/shekshuev/pg_for_students_setup.git
cd pg_for_students_setup
wget https://edu.postgrespro.ru/demo-big.zip
unzip demo-big.zip
mv demo-big*.sql ./init-scripts/demo-big.sql
docker compose up -d
```

Переменные окружения

```bash
PGADMIN_DEFAULT_EMAIL=admin@example.com
PGADMIN_DEFAULT_PASSWORD=admin
POSTGRES_DB=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

SERVER_ADDRESS=0.0.0.0:3000
ACCESS_TOKEN_EXPIRES=1h
REFRESH_TOKEN_EXPIRES=24h
ACCESS_TOKEN_SECRET=super_secret_access_token_key
REFRESH_TOKEN_SECRET=super_secret_refersh_token_key
POSTGRES_GOPHERTALK_DB=gophertalk
POSTGRES_GOPHERTALK_USER=gophertalk
POSTGRES_GOPHERTALK_PASSWORD=gophertalk
GOLANG_MIGRATE_POSTGRESQL_URL="postgres://gophertalk:gophertalk@postgres_gophertalk:5432/gophertalk?sslmode=disable"
DATABASE_DSN="host=postgres_gophertalk port=5432 user=gophertalk password=gophertalk dbname=gophertalk sslmode=disable"

VITE_APP_API_URL="http://localhost:3000/v1.0"
VITE_APP_DEFAULT_LOCALE=ru


POSTGRES_ECAMPUS_DB=ecampus
POSTGRES_ECAMPUS_USER=ecampus
POSTGRES_ECAMPUS_PASSWORD=ecampus
POSTGRES_ECAMPUS_PORT=5392
POSTGRES_ECAMPUS_HOSTNAME=postgres_ecampus
DATABASE_URL=ecto://ecampus:ecampus@postgres_ecampus:5432/ecampus
SECRET_KEY_BASE=TQX4GN6l/zQlo7s0WgpoBeJBxNDx9uZOu8OSJBz6UWo7BEVQKTEjzkXeJIzOsyG3
PHX_SERVER=true
MIX_ENV=prod
```
