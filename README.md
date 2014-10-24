#docker-postgresql
This blueprint installs [PostgreSQL](http://www.postgresql.org/) - a cross platform object-relational database management system (ORDBMS).

* [Components](#components)
* [Usage](#usage)
    * [Basic Example](#basic-example)
    * [Advanced Example 1](#advanced-example-1)
* [Administration](#administration)
    * [Connecting to PostgreSQL](#connecting-to-postgresql)
* [Reference](#reference)
    * [Image Details](#image-details)
    * [Dockerfile Settings](#dockerfile-settings)
    * [Port Details](#port-details)
    * [Volume Details](#volume-details)
    * [Additional Environmental Settings](#additional-environmental-settings)
* [Blueprint Details](#blueprint-details)
* [Building the Image](#building-the-image)
* [Issues](#issues)

<a name="components"></a>
## Components
The software stack comprises of the below component details:

Name       | Version    | Description
-----------|------------|------------------------------
Ubuntu     | Trusty     | Operating system
PostgreSQL | 9.3.5      | Database

**If a component is an up-to-date, compatible version, as determined by the operating system package manager, at installation time, please complete the version information based on the install.**

<a name="usage"></a>
## Usage

<a name="basic-example"></a>
### Basic Example
Start your image with binding host port 5432 to port 5432 (PostgreSQL Server) in your container:

```no-highlight
docker run -d -p 5432:5432 dell/postgresql
```

Test your deployment:

```no-highlight
psql -h <host> -p <port> --username=postgres
```

<a name="advanced-example-1"></a>
### Advanced Example 1
Start your image with:

* A specific PostgreSQL password for user postgres. A preset password can be defined instead of a randomly generated one, this is done by setting the environment variable `POSTGRES_PASS` to your specific password when running the container.

```no-highlight
docker run -d -p 5432:5432 -e POSTGRES_PASS="mypass" dell/postgresql
```

You can now test your new postgres password when prompted:

        psql -h <host> -p <port> --username=postgres

<a name="administration"></a>
## Administration

<a name="connecting-to-postgresql"></a>
### Connecting to PostgreSQL 
The first time that you run your container without presetting the password, a new user admin with all privileges will be created in PostgreSQL with a random password. To get the password, check the logs of the container. You will see an output like the following:

```no-highlight
========================================================================
You can now connect to this PostgreSQL  server using:

    psql -h <host> -p <port> --username=postgres

and enter the password 'HHrUZyI6ubWF' when prompted
Please remember to change the above password as soon as possible!
========================================================================
```

In this case, **HHrUZyI6ubWF ** is the password allocated to the postgres user.

You can then connect to PostgreSQL when prompted:

```no-highlight
psql -h <host> -p <port> --username=postgres
```

Note that the root user does not allow connections from outside the container. Please use this admin user instead.

<a name="reference"></a>
## Reference

<a name="image-details"></a>
### Image Details

Attribute         | Value
------------------|------
Based on          | 
Github Repository | [https://github.com/ghostshark/docker-postgresql](https://github.com/ghostshark/docker-postgresql)
Pre-built Image   | [https://registry.hub.docker.com/u/dell/postgresql](https://registry.hub.docker.com/u/dell/postgresql) 

<a name="dockerfile-settings"></a>
### Dockerfile Settings

Instruction | Value
------------|------
VOLUME      | ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
EXPOSE      | ['5432']
CMD         | ['/run.sh']

<a name="port-details"></a>
### Port Details

Port | Details
-----|--------
5432 | PostgreSQL server

<a name="volume-details"></a>
### Volume Details

Path                | Details
--------------------|--------
/etc/postgresql     | 
/var/log/postgresql |
/var/lib/postgresql |

<a name="additional-environmental-settings"></a>
### Additional Environmental Settings

Variable     | Description
-------------|------------
POSTGRES_PASS | The PostgreSQL admin user password. If not specified, a random value will be generated.

<a name="blueprint-details"></a>
## Blueprint Details
Under construction.

<a name="building-the-image"></a>
## Building the Image
To build the image `docker-postgresql`, clone this repoistory and build the image from the -postgresql folder with the following command:

```no-highlight
git clone https://github.com/ghostshark/docker-postgresql.git
cd docker-postgresql
docker build -t docker-postgresql .
```
<a name="issues"></a>
## Issues
