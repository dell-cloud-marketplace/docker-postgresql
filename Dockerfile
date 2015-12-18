FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Set environment variable for package install
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && \
    echo exit 0 > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d && \
    apt-get install -y supervisor postgresql-9.3 pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set locale.
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    export LC_ALL=en_US.UTF-8 && \
    export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8
   
# Adjust PostgreSQL configuration, so that remote connections to the database
# are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> \
    /etc/postgresql/9.3/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Copy PostgreSQL directories in case empty volumes are specified.
RUN mkdir -p /tmp/etc/postgresql/ /tmp/var/lib/postgresql && \
    cp -R /etc/postgresql/9.3 /tmp/etc/postgresql/ && \
    cp -R /var/lib/postgresql/9.3 /tmp/var/lib/postgresql

# We start PostgreSQL using Supervisor. In future we might have additional
# services in the container.
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add scripts
ADD modify_postgres_pass.sh ./modify_postgres_pass.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Environnmental variables.
ENV POSTGRES_PASS ""

# Expose PostgreSQL port 5432
EXPOSE 5432

CMD ["/run.sh"]
