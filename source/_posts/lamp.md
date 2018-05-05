---
title: LAMP编译安装及配置篇——就是干
date: 2017-07-20 22:59:34
categories:
- LAMP
tags:
- LAMP
toc: true # 是否启用内容索引
keywords: lamp,LAMP编译安装,编译配置,
description: LAMP编译安装所需要系统库相关库文件安装详细
---


## LAMP：安装所需要系统库相关库文件安装

安装包下载链接：http://download.csdn.net/detail/kc88168/5902111

### 安装gcc
```linux
yum install gcc gcc-c++ gcc-g77
yum install make
文件放到/usr/local/src/下全部解压
for file in *.tar.gz; do tar -zxvf "${file}"; done
```
注：执行上面的语句之后的解压就不用再执行了

### 安装libxml2最新库文件
```linux
tar zxvf libxml2-2.9.0.tar.gz
cd libxml2-2.9.0 
./configure --prefix=/usr/local/libxml2 
```
### 安装zlib最新库文件
```linux
tar zxvf zlib.1.2.7.tar.gz
cd ../zlib.1.2.7
./configure
```
### 安装libpng最新库文件
```linux
tar zxvf libpng-1.5.14.tar.gz
cd ../libpng-1.5.14


在./configure --prefix=/usr/local/libpng这步最后会提示：configure: error: ZLib not installed
解决方法如下：
进入zlib的源文件目录，执行命令 make clean,清除zlib；
重新配置 ./configure,后面不要接--prefix参数；

make && make install；
进入libpng目录，执行命令 ./configure --prefix=/usr/local/libpng;
make && make install；
```

### 安装libmcrypt最新库文件
```linux
//tar zxvf libmcrypt-2.5.8.tar.gz
cd ../libmcrypt-2.5.8
./configure --prefix=/usr/local/libmcrypt
安装完成libmcrypt库以后，不同的linux系统版本有可能还要安装一下libltdl库。
cd /usr/local/src/libmcrypt-2.5.8/libltdl
./configure --enable-ltdl-install
make && make install
```

### 安装jpeg8最新库文件
```linux
cd ../jpeg-8b/
mkdir /usr/local/jpeg8  //建立jpeg8软件安装目录
mkdir /usr/local/jpeg8/bin //建立存放命令的目录
mkdir /usr/local/jpeg8/lib  //创建jpeg8库文件所在目录
mkdir /usr/local/jpeg8/include //建立存放头文件目录
mkdir -p /usr/local/jpeg8/man/man1 //建立存放手册的目录
./configure \
--prefix=/usr/local/jpeg8/ \
--enable-share \
--enable-static
```
> 警告:configure: WARNING: unrecognized options: --enable-share [可忽略] 
在安装GD2库配置时，可以在configure命令的选项中加上“--with-jpeg=/usr/local/jpeg8”选项，指定jpeg8库文件的位置。安装PHP时也要指定该库文件的位置。
> 

### 安装freetype最新库文件
```linux
tar zxvf freetype-2.4.10.tar.gz
cd ../freetype-2.4.10
./configure --prefix=/usr/local/freetype && make && make install
```

### 安装atuoconf最新的库文件
需要先装perl包
```linux
yum install perl
cd ../autoconf-2.69
configure时，不用指定路径。
./configure && make && make install
```
### 安装最新的GD库文件
```linux
cd ../gd-2.0.35
./configure \  //配置命令
--prefix=/usr/local/gd \  //指定安装软件的位置
--with-jpeg=/usr/local/jpeg8/ \  //指定去哪找jpeg库文件
--with-png=/usr/local/libpng/ \  //指定去哪找png库文件
--with-freetype=/usr/local/freetype/   //指定去哪找freetype 2.x字体库的位置
./configure \
--prefix=/usr/local/gd \
--with-jpeg=/usr/local/jpeg8/ \
--with-png=/usr/local/libpng/ \
--with-freetype=/usr/local/freetype/
```

> 
如果安装成功会在/usr/local/gd/目录下存在bin、include和lib这三个目录。在安装PHP5时，通过在configure命令选项中加上“--with-gd=/usr/local/gd”选项，指定GD库文件的位置。
如果报错:
make[2]: *** [gd_png.lo] Error 1
make[2]: Leaving directory `/tmp/gd-2.0.35'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/tmp/gd-2.0.35'
make: *** [all] Error 2
解决方案:
vi gd_png.c
> 找到#include "png.h"改成#include "/usr/local/libpng/include/png.h"

### 安装新版本的apache服务器

1、卸载apr、apr-util
yum remove apr apr-util
下载安装：
http://apr.apache.org/download.cgi
apr-1.4.6.tar.gz
cd ../apr-1.4.6
./configure --prefix=/usr/local/apr-httpd/ && make && make install

下载安装：
http://apr.apache.org/download.cgi
apr-util-1.5.1.tar.gz
cd ../apr-util-1.5.1
./configure --prefix=/usr/local/apr-util-httpd/ --with-apr=/usr/local/apr-httpd/ && make && make install

下载：http://sourceforge.net/projects/pcre

### 安装新版本的pcre
```linux
unzip -o pcre-8.32.zip
cd pcre-8.32
./configure --prefix=/usr/local/pcre && make && make install
```

### 安装apache
```linux
cd ../httpd-2.4.4
./configure \
--prefix=/usr/local/apache2 \
--enable-mods-shared=all \
--enable-deflate \
--enable-speling \
--enable-cache \
--enable-file-cache \
--enable-disk-cache \
--enable-mem-cache \
--enable-so \
--enable-expires=shared \
--enable-rewrite=shared \
--enable-static-support \
--sysconfdir=/etc/httpd \
--with-z=/usr/local/zlib/ \
--with-apr=/usr/local/apr-httpd/ \
--with-apr-util=/usr/local/apr-util-httpd/ \
--with-pcre=/usr/local/pcre/ \
--disable-userdir \
--enable-rewrite \
--enable-cgi \
--enable-ssl 

make && make install
```
修改配置
```linux
vi /etc/httpd/httpd.conf
改
ServerName localhost:80
找
AddType application/x-gzip .gz .tgz
加上下面一行
AddType application/x-httpd-php .php .phtml
改设置默认读取index.后缀
<IfModule dir_module>
    DirectoryIndex index.php index.phtml index.html index.htm
</IfModule>
【下面可以改也可以不改】
<Directory />
    Options FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
</Directory>
```
重启apache

echo "/usr/local/apache2/bin/apachectl start" >> /etc/rc.d/rc.local


### 安装数据库5.5

安装所需要系统库相关库文件 
```linux
yum install ncurses-devel
yum install bison
yum –y install gcc gcc-c++ gcc-g77 autoconf automake zlib* fiex* libxml* \
ncurses-devel libmcrypt* libtool-ltdl-devel*
```
- 创建mysql安装目录
> mkdir -p /usr/local/webserver/mysql/

- 创建数据存放目录
>  mkdir -p /data/mysql/
- 创建用户和用户组与赋予数据存放目录权限
> groupadd mysql
> useradd -g mysql mysql
> chown mysql.mysql -R /data/mysql/
> 
- 安装cmake（mysql5.5以后是通过cmake来编译的）

```linux
wget http://www.cmake.org/files/v2.8/cmake-2.8.4.tar.gz
tar zxvf cmake-2.8.4.tar.gz
cd cmake-2.8.4
./configure
make && make install
```

### 下载安装
http://mirrors.sohu.com/mysql/MySQL-5.5/

```linux
wget http://mirrors.sohu.com/mysql/MySQL-5.5/mysql-5.5.32.tar.gz
tar zxvf mysql-5.5.30.tar.gz
cd mysql-5.5.30

cmake . \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ \
-DMYSQL_DATADIR=/var/lib/mysql \
-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysqld.sock \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3306 \
-DEXTRA_CHARSETS=all \-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DMYSQL_USER=mysql \
-DWITH_DEBUG=0
```
> 
[出现警告：The variable, 'MYSQL USER', specified manually, was not used during the generation. ，可以忽略]
> //需要时也可以把预编译里面的MYSQL_USER去掉，即可预编译成功！

```linux
  make && make install
- 复制配置文件
  # cp support-files/my-medium.cnf /etc/my.cnf
  # cp support-files/mysql.server /etc/init.d/mysqld
  # chmod 755 /etc/init.d/mysqld
- 初始化数据库
  bash scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql/
- 启动mysql服务
 # /etc/init.d/mysqld start  或者service mysqld start
  ps –ef | grep mysql 查看是否启动
  /usr/local/mysql/bin/mysql -u root -p 登录数据库
```

//打开/etc/selinux/config，把SELINUX=enforcing改为SELINUX=disabled后存盘退出重启机器试试3. 

本来初始化配置是这样的：
>scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql
出现了
[root@localhost mysql-5.6.14]# service mysql restart
> ERROR! MySQL server PID file could not be found!
> Starting MySQL. ERROR! The server quit without updating PID file (/var/lib/mysql/localhost.localdomain.pid).

在日志中出现了如下错误：
> Can't open and lock privilege tables: Table 'mysql.user' doesn't exist

后来采用了下面的语句就可以了：
> scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql --ldata=/var/lib/mysql



### 安装php5

先修改后面的错误再./configure
```linux
./configure \
--prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-apxs2=/usr/local/apache2/bin/apxs \
--with-mysql=/usr/local/mysql/ \
--with-libxml-dir=/usr/local/libxml2/ \
--with-png-dir=/usr/local/libpng/ \
--with-jpeg-dir=/usr/local/jpeg8/ \
--with-freetype-dir=/usr/local/freetype/ \
--with-gd=/usr/local/gd/ \
--with-zlib-dir=/usr/local/zlib/ \
--with-mcrypt=/usr/local/libmcrypt/ \
--with-mysqli=/usr/local/mysql/bin/mysql_config \
--enable-soap \
--enable-mbstring=all \
--enable-sockets
```

> 错误 make: *** [ext/gd/gd.lo] error
/usr/local/src/php-5.4.3/ext/gd/gd_ctx.c: In function ‘_php_image_output_ctx’:
/usr/local/src/php-5.4.3/ext/gd/gd_ctx.c:153: error: ‘gdIOCtx’ has no member named ‘data’
make: *** [ext/gd/gd.lo] Error 1
解决
vi <gd_dir>/include/gd_io.h
void (*gd_free) (struct gdIOCtx *);
加void (*data);
}
gdIOCtx;
> 
我的GD安装在/usr/local/gd2目录下，所以是#vi vi /usr/local/gd/include/gd_io.h
libltdl.so.3: cannot open shared object file: No such file or directory
make: *** [ext/phar/phar.php] Error 127
解决方法：
ln -s /usr/local/lib/libltdl.so.3 /usr/lib/libltdl.so.3
cd /usr/local/libpng/lib/
ls
libpng15.a   libpng15.so     libpng15.so.15.10.0  libpng.la  pkgconfig
libpng15.la  libpng15.so.15  libpng.a             libpng.so
可以看到libpng15.so.15
然后修改/etc/ld.so.conf 文件：vi /etc/ld.so.conf
在第一行下面追加/usr/local/libpng/lib这个路径。

> 

然后重新编译安装即可。

```linux
cp php.ini-development /usr/local/php/etc/php.ini

vi /usr/local/php/etc/php.ini
修改 date.timezone ="PRC"

/usr/local/apache2/bin/apachectl stop
/usr/local/apache2/bin/apachectl stop
```

### phpMyAdmin的安装

1、进入软件源码所在的目录/usr/local/src/中，并解压软件包phpMyAdmin-3.5.6-all-languages.tar.gz到当前目录phpMyAdmin-3.5.6-all-languages下。

2、把解压的目录phpMyAdmin-3.5.6-all-languages下的文件，全部复制到Apache的/usr/local/apache243/htdocs下，并新建一个名为phpmyadmin的目录下面，即安装完成。

> cp -a phpMyAdmin-3.5.6-all-languages /usr/local/apache2/htdocs/phpmyadmin

3、在使用phpmyadmin之前，也需要先配置一下。配置的方法是通过对phpmyadmin顶层目录下的config.inc.php文件中 的几个选项做一些设置即可。默认不存在config.inc.php文件，我们需要手工创建一个，也可以复制config.sample.inc.php 模板得到最低限度的配置文件。

```linux
[root@localhost   src]# cd /usr/local/apache2/htdocs/phpmyadmin/
[root@localhost   phpmyadmin]# cp config.sample.inc.php config.inc.php
vi config.inc.php
$cfg['Servers'][$i]['auth_type']='http';//如果想让phpMyAdmin使用HTTP身份验证模式
$cfg['Servers'][$i]['auth_type']='cookie';
//无需输入密码登陆
$cfg['Servers'][$i]['auth_type']='config';
$cfg['Servers'][$i]['user']='root';
$cfg['Servers'][$i]['password']='654321';
```
