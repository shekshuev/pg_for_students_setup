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
PGADMIN_DEFAULT_EMAIL=admin@test.ru
DEFAULT_PGADMIN_ADMIN_PASSWORD=test123!
POSTGRES_DB=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```
