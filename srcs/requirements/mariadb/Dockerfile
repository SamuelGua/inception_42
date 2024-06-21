FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY conf/init-db.sh /init-db.sh
RUN chmod +x /init-db.sh

# faire attention au & et au &&
CMD ["bash", "-c", "mysqld_safe --datadir=/var/lib/mysql & sleep 5 && /init-db.sh && tail -f /dev/null"]