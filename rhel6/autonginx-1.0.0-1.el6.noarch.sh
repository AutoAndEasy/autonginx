#!/bin/bash

################ Script Info ################		

## Program: Auto Nginx Install V1.0
## Author:Chier Xuefei
## Date: 2013-03-14
## Update:None


################ Env Define ################

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/sbin
LANG=C
export PATH
export LANG

################ Var Setting ################

InputVar=$*
HomeDir="/tmp/autonginx"
NginxPkg='nginx-1.2.7'
DependPkg=' gcc gcc-c++ make automake autoconf patch libtool fontconfig-devel freetype-devel libjpeg-devel libpng-devel libXpm-devel gettext-devel libmcrypt-devel mhash-devel mysql-devel openssl-devel zlib-devel libxml2-devel pcre-devel perl-ExtUtils-Embed'

if [ ! -z $InputVar ]; then
    Para=${InputVar}
else
    Para=' --prefix=/usr/local/nginx/ --user=nginxur --group=nginxgp --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module --with-http_perl_module --with-http_flv_module --with-http_gzip_static_module --with-md5-asm --with-md5=/usr/include --with-sha1-asm --with-sha1=/usr/include --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module'
fi

################ Func Define ################ 
function _info_msg() {
_header
echo -e " |                                                                |"
echo -e " |                  Thank you for use autonginx!                  |"
echo -e " |                                                                |"
echo -e " |                         Version: 1.0                           |"
echo -e " |                                                                |"
echo -e " |                     http://www.idcsrv.com                      |"
echo -e " |                                                                |"
echo -e " |                   Author:翅儿学飞(chier xuefei)                |"
echo -e " |                      Email:myregs@126.com                      |"
echo -e " |                         QQ:1810836851                          |"
echo -e " |                         QQ群:61749648                          |"
echo -e " |                                                                |"
echo -e " |          Hit [ENTER] to continue or ctrl+c to exit             |"
echo -e " |                                                                |"
printf " o----------------------------------------------------------------o\n"	
 read entcs 
clear
}

function _end_msg() {
echo -e "###################################################################"
echo ""
echo -e "                         Install Finish :)"
echo ""
echo -e "###################################################################"
echo ""
echo ""
_header
echo -e " |                                                                |"
echo -e " |                   Thank you for use autonginx!                 |"
echo -e " |                                                                |"
echo -e " |                The software has been installed!                |"
echo -e " |                                                                |"
echo -e " |                     http://www.idcsrv.com                      |"
echo -e " |                                                                |"
echo -e " |                   Author:翅儿学飞(chier xuefei)                |"
echo -e " |                      Email:myregs@126.com                      |"
echo -e " |                         QQ:1810836851                          |"
echo -e " |                         QQ群:61749648                          |"
echo -e " |                                                                |"
printf " o----------------------------------------------------------------o\n"
}

function _header() {
	printf " o----------------------------------------------------------------o\n"
	printf " | :: Auto Nginx Install                      v1.0.0 (2013/03/14) |\n"
	printf " o----------------------------------------------------------------o\n"	
}

################ Main ################
clear
_info_msg

if [ `id -u` != "0" ]; then
echo -e "You need to be be the root user to run this script.\nWe also suggest you use a direct root login, not su -, sudo etc..."
exit 1
fi

if [ ! -d $HomeDir ]; then
	mkdir -p $HomeDir
fi

cd $HomeDir || exit 1

yum -y install ${DependPkg}
wget http://nginx.org/download/${NginxPkg}.tar.gz
tar xzvf ${NginxPkg}.tar.gz
cd $NginxPkg
groupadd nginxgp
useradd -g nginxgp -s /sbin/nologin -M nginxur
./configure ${Para}
make
make install
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
echo "/usr/local/nginx/sbin/nginx" >> /etc/rc.d/rc.local

_end_msg
############  Clean Cache  ############
rm -rf ${HomeDir}
