# Set up extensions that can be downloaded as tarballs

FROM debian:bullseye-slim AS collector

RUN apt update && \
    apt install --reinstall ca-certificates -y && \
    apt install -y curl tar gzip jq

WORKDIR /var/www/html/extensions

ADD download_extension.sh ./
ADD download_extensions.txt ./

RUN cat download_extensions.txt | while read ext; do bash download_extension.sh $ext 1_37 ; done

RUN rm download_extension.sh download_extensions.txt

# Compose extensions

FROM prowiki/mediawiki:37 AS base

COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

COPY --from=collector --chown=nobody:nogroup /var/www/html/extensions /var/www/html/extensions

WORKDIR /var/www/html/

ADD composer.local.json ./
ADD composer_extension.sh ./
ADD composer_extensions.txt ./

RUN composer update
RUN cat composer_extensions.txt | while read composer_line; do bash composer_extension.sh $composer_line; done

RUN rm composer_extension.sh composer_extensions.txt /usr/bin/composer

# Add other requirements

RUN mkdir LocalSettings.php.d

COPY htaccess /var/www/html/.htaccess
COPY LocalSettings.php.template /LocalSettings.php.template

COPY wait-for-it.sh /wait-for-it.sh
COPY entrypoint.sh /entrypoint.sh

COPY htaccess /var/www/html/.htaccess
COPY LocalSettings.php.template /LocalSettings.php.template

RUN ln -s /var/www/html/ /var/www/html/w

RUN chown www-data /var/www/html/ -R

ENV MW_SITE_NAME=wikibase-docker-wbsg\
    MW_SITE_LANG=en\
    MW_WG_JOB_RUN_RATE=2\
    MW_WG_ENABLE_UPLOADS=true\
    MW_WG_UPLOAD_DIRECTORY=/var/www/html/images\
    WIKIBASE_PINGBACK=false

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]