FROM debian:bullseye

#Install default packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install wget -y && \
	apt-get install -y php7.4 php7.4-fpm php7.4-mysql mariadb-client

#Download wordpress and extract it
RUN wget https://fr.wordpress.org/wordpress-6.5.4-fr_FR.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.5.4-fr_FR.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.5.4-fr_FR.tar.gz && \
    chown -R root:root /var/www/wordpress && \ 
    chown -R www-data:www-data /var/www/wordpress

#Copy conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    cp wp-cli.phar /usr/local/bin/wp-cli.phar && \
    cp wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

COPY conf/auto_config.sh /auto_config.sh

RUN chmod +x /auto_config.sh

ENTRYPOINT ["/auto_config.sh" ]