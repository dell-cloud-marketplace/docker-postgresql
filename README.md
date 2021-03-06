#docker-postgresql
This is a base Docker image to run a [PostgreSQL](http://www.postgresql.org/) database server. PostgreSQL is a cross platform object-relational database management system (ORDBMS).

## Components
The software stack comprises the following component details:

Name       | Version    | Description
-----------|------------|------------------------------
Ubuntu     | Trusty     | Operating system
PostgreSQL | 9.3        | Database

## Usage

### Start the Container
To start your container with:

* A named container ("postgresql")
* Host port 5432 mapped to container port 5432 (default database port)

Do:

    sudo docker run -d -p 5432:5432 --name postgresql dell/postgresql

A new admin user, with all privileges, will be created in PostgreSQL with a random password. To get the password, check the container logs (```sudo docker logs postgresql```). You will see output like the following:

    ====================================================================
    You can now connect to this PostgreSQL Server using:

      psql -h <host> -p <port> --username=postgres
      and enter the password '5elsT6KtjrqV' when prompted

    Please remember to change the above password as soon as possible!
    =====================================================================

In this case, **5elsT6KtjrqV** is the password allocated to the postgres user.

You can then connect to the admin console...

    psql -h 127.0.0.1 -p 5432 --username=postgres


### Advanced Example 1
To start your image with a specific PostgreSQL postgres password, instead of a randomly generated one, set environment variable `POSTGRES_PASS` when running the container:

    sudo docker run -d -p 5432:5432 -e POSTGRES_PASS="mypass" --name postgresql dell/postgresql

You can now test your new postgres user password when prompted:

    psql -h 127.0.0.1 -p 5432 --username=postgres

### Advanced Example 2

Start your container with:
- Three data volumes (which will survive a restart or recreation of the container). The PostgreSQL data is available in **/var/lib/postgresql** on the host. The configuration files are available in **/etc/postgresql** on the host. The PostgreSQL logs are available in **/var/log/postgresql** on the host.
- A specific PostgreSQL password for user postgres. A preset password can be defined instead of a randomly generated one, this is done by setting the environment variable `POSTGRES_PASS` to your specific password when running the container.

```no-highlight
sudo docker run -d \
    --name="postgresql" \
    -v /etc/postgresql:/etc/postgresql \
    -v /var/log/postgresql:/var/log/postgresql \
    -v /var/lib/postgresql:/var/lib/postgresql \
    -p 5432:5432 \
    -e POSTGRES_PASS="mypass" dell/postgresql
```

You can then connect to the admin console...

    psql -h 127.0.0.1 -p 5432 --username=postgres
    
## Reference

### Environmental Variables

Variable      | Default  | Description
--------------|----------|-------------------------------
POSTGRES_PASS | *random* | Password for user **postgres**

### Image Details

Based on [docker-library/postgres](https://github.com/docker-library/postgres)

Pre-built Image | [https://registry.hub.docker.com/u/dell/postgresql](https://registry.hub.docker.com/u/dell/postgresql) 
