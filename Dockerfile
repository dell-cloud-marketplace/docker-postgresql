FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>


# Set environment variable for package install
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && \
    echo exit 0 > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d && \
    apt-get install -y postgresql-9.3 pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Correct locale settings
RUN export LC_ALL=en_GB.UTF-8
RUN export LANGUAGE=en_GB.UTF-8
RUN export LANG=en_GB.UTF-8
RUN locale-gen en_GB.UTF-8
RUN dpkg-reconfigure locales


# Adjust PostgreSQL configuration,
# so that remote connections to the database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> \
 /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf


# Add VOLUMEs to allow backup of config, logs and databases
VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Run scripts
ADD modify_postgres_pass.sh ./modify_postgres_pass.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Expose postgres port 5432
EXPOSE 5432
CMD ["/run.sh"]
