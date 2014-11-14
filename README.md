#docker-postgresql
This is a base Docker image to run a [PostgreSQL](http://www.postgresql.org/) database server. PostgreSQL is a cross platform object-relational database management system (ORDBMS).

## Components
The software stack comprises of the below component details:

Name       | Version    | Description
-----------|------------|------------------------------
Ubuntu     | Trusty     | Operating system
PostgreSQL | 9.3.5      | Database

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

    sudo docker run -d -p 5432:5432 -e POSTGRES_PASS="mypass" dell/postgresql

You can now test your new postgres user password when prompted:

    psql -h 127.0.0.1 -p 5432 --username=postgres


## Reference

### Image Details

Based on [docker-library/postgres](https://github.com/docker-library/postgres)

Pre-built Image   | [https://registry.hub.docker.com/u/dell/postgresql](https://registry.hub.docker.com/u/dell/postgresql) 
