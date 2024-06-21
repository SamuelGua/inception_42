FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY conf/init-db.sh .
RUN chmod +x init-db.sh

CMD ["bash", "-c", "service mysql start && bash init-db.sh && tail -f /dev/null"]