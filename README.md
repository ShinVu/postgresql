# Project Name

Star schema

## About

A small project for designing and creating star schema in data warehouse

### Prerequisites

- Docker

### Installation

1. Run docker compose

```bash
# Example Bash commands
docker compose up
```

2. Run script inside postgresql container

```bash
# Example Bash commands
export PGPASSWORD='admin'; psql -U admin -d postgres -f /workspace/star_schema_1/create_schema_script.sql;
export PGPASSWORD='admin'; psql -U admin -d postgres -f /workspace/star_schema_2/create_schema_script.sql;
```

3. Check the result in database using pgAdmin

To access pgAdmin:

- The address to connect to pgAdmin is `localhost:8888`.
- Username for pgadmin is `admin@gmail.com`.
- Password for pgadmin is `admin`.