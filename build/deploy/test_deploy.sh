#!/bin/bash
FLAG=$1
DEPLOY_VERSION=$2
CUR_DIR=$(cd `dirname $0`; pwd)

WEB_IMAGE=ccr.ccs.tencentyun.com/test/test

NGINX_RELOAD='/usr/local/nginx/sbin/nginx -s reload'
NGINX_CONF_PATH=/usr/local/nginx/conf/vhost
PROJECT_NAME=`echo $WEB_IMAGE|awk -F '/' '{print $2"_"$3}'`

echo ${CUR_DIR};
if [ "`ls ${CUR_DIR}/config_*|wc -l`" -eq "0" ];then
	echo "配置文件config.env不存在"
	exit 1
fi
#安装新版本容器
if [ -f ${CUR_DIR}/image_${DEPLOY_VERSION}.tar ]; then
	echo "发现本地镜像文件，正在导入..."
	docker load -i ${CUR_DIR}/image_${DEPLOY_VERSION}.tar
	rm -f ${CUR_DIR}/image_${DEPLOY_VERSION}.tar
fi

for dn in `ls ${CUR_DIR}/config_*`
do
  DBNAME=$(echo ${dn}|awk -F"config_" '{print $2}'|awk -F".env" '{print $1}')

  #自动创建必须目录
  if [ ! -d ${CUR_DIR}/logs_${DBNAME} ]; then
    mkdir ${CUR_DIR}/logs_${DBNAME}
  fi
  if [ ! -d ${CUR_DIR}/upload_${DBNAME} ]; then
    mkdir ${CUR_DIR}/upload_${DBNAME}
  fi

  #数据库更新
  if [ -f ${CUR_DIR}/dbexec/${DEPLOY_VERSION}.sql ]; then
    echo "发现本地数据库更新文件[${CUR_DIR}/dbexec/${DEPLOY_VERSION}.sql]，正在导入..."

    /bin/cp -f ${CUR_DIR}/dbexec/${DEPLOY_VERSION}.sql ${CUR_DIR}/dbexec/update.sql
    echo "-- ${DBNAME}" >> ${CUR_DIR}/dbexec/update.sql

    DBM_CONTAINER_ID=`docker run -d --rm --env-file "${dn}" -v "${CUR_DIR}/dbexec:/work/sql" forgame/dbm:mysql-rsync`
    docker exec ${DBM_CONTAINER_ID} bash /work/sh/mysql-exec.sh update
    docker rm -f ${DBM_CONTAINER_ID}
  fi

  # 固定容器端口号
  PORT=$(echo ${DBNAME}|awk -F"_" '{print $3}')

  #WEB container
  echo "正在启动容器：${DBNAME}，端口：${PORT}"

  WEB_CONTAINER_ID=`docker run -d -p ${PORT}:80 --rm --env-file "${dn}" -v ${CUR_DIR}/logs_${DBNAME}:/var/www/logs  -v ${CUR_DIR}/upload_${DBNAME}:/var/www/html/upload --name="${DBNAME}" ${WEB_IMAGE}:${DEPLOY_VERSION}`
  if [ -z $WEB_CONTAINER_ID ]; then
    echo "WEB容器启动失败[${DBNAME}]，端口：${PORT}"
    break
  fi

  WEB_CONTAINER_PORT=`docker inspect ${WEB_CONTAINER_ID}|grep "Ports" -A 50|grep "80/tcp" -A 3| grep HostPort|cut -d '"' -f4|head -1`
  if [ -z $WEB_CONTAINER_PORT ]; then
    echo "WEB容器启动失败[${DBNAME}]，端口：${WEB_CONTAINER_PORT}"
    break
  fi
  echo "已启动容器：${DBNAME}，端口：${WEB_CONTAINER_PORT}"
done

exit 1
