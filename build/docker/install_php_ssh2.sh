#!/bin/sh
if [ ! -f /usr/local/src/libssh2-1.8.0.tar.gz ]; then
    wget -O /usr/local/src/libssh2-1.8.0.tar.gz https://libssh2.org/download/libssh2-1.8.0.tar.gz ;
fi
cd /usr/local/src/ && tar xvf libssh2-1.8.0.tar.gz && cd libssh2-1.8.0; ./configure && make && make install;

if [ ! -f /usr/local/src/ssh2-1.1.2.tgz ]; then
    wget -O /usr/local/src/ssh2-1.1.2.tgz https://pecl.php.net/get/ssh2-1.1.2.tgz ;
fi
cd /usr/local/src/ && tar xvf ssh2-1.1.2.tgz && cd ssh2-1.1.2; phpize && ./configure --with-php-config=/usr/local/php/bin/php-config --with-ssh2 && make && make install;
if [ `grep -L 'ssh2.so' '/usr/local/php/etc/php.ini'` ]; then
    echo -e "extension=ssh2.so" > /usr/local/php/etc/conf.d/ssh2.ini;
fi;
rm -rf /usr/local/src/;
