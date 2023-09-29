infra_setup
=============

Installing, up and running PostgreSQL-15 server. Creating a database and an user for an application.

Requirements
------------

All pre-reqiosites will be installed during the role - Python modules: pip, psycopg2

Role Variables
--------------

* **infra_setup_db_name** - Name of the application database
* **infra_setup_db_user** - User garnted the full access to the applicatin database
* **infra_setup_db_user_passw** - User password
* **infra_setup_pg_hba_path** - Path to the `pg_hba.conf` file needed to determine whether the Postgres server needs to be initialized

Dependencies
------------

User password

Example Playbook
----------------

```yaml
- name: Install and Setup PostgreSQL
  hosts: db_servers
  roles:
    - role: infra_setup
      infra_setup_db_name: "django1"
      infra_setup_db_user: "django1"
      infra_setup_db_user_passw: "Test123"
      infra_setup_pg_hba_path: "/var/lib/pgsql/data/pg_hba.conf"
```

