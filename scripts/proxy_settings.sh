#!/bin/bash

proxy_user=$1
proxy_pass=$2
proxy_host=$3
proxy_port=$4

## NO PROXY
if [ $# -lt 4 ] || [ -z $proxy_user ] || [ -z $proxy_pass ] || [ -z $proxy_host ] || [ -z $proxy_port ]
then
    echo "Provisionando sem proxy"
    exit 0
else
    echo "Provisionando com proxy"
fi

## HTTP_PROXY
grep -q "http_proxy" /etc/environment
if [ $? -eq 0 ]; then
    sed -i '/http_proxy/c\''export http_proxy=\"http://'"$proxy_user"':'"$proxy_pass"'@'"$proxy_host"':'"$proxy_port"'/\"' /etc/environment
else
    echo "export http_proxy=\"http://$proxy_user:$proxy_pass@$proxy_host:$proxy_port/\"" >>/etc/environment
fi

## HTTPS_PROXY
grep -q "https_proxy" /etc/environment
if [ $? -eq 0 ]; then
    sed -i '/https_proxy/c\''export https_proxy=\"https://'"$proxy_user"':'"$proxy_pass"'@'"$proxy_host"':'"$proxy_port"'/\"' /etc/environment
else
    echo "export https_proxy=\"https://$proxy_user:$proxy_pass@$proxy_host:$proxy_port/\"" >>/etc/environment
fi

## FTP_PROXY
grep -q "ftp_proxy" /etc/environment
if [ $? -eq 0 ]; then
    sed -i '/ftp_proxy/c\''export ftp_proxy=\"ftp://'"$proxy_user"':'"$proxy_pass"'@'"$proxy_host"':'"$proxy_port"'/\"' /etc/environment
else
    echo "export ftp_proxy=\"ftp://$proxy_user:$proxy_pass@$proxy_host:$proxy_port/\"" >>/etc/environment
fi

## WGET
grep -q "alias wget" /etc/environment
if [ $? -eq 0 ]; then
    sed -i '/alias wget/c\''alias wget=\"wget --proxy-user='"$proxy_user"' --proxy-password='"$proxy_pass"'\"' /etc/environment
else
    echo "alias wget=\"wget --proxy-user=$proxy_user --proxy-password=$proxy_pass\"" >>/etc/environment
fi

exit 0
