#!/bin/bash

proxy_user=u100218
proxy_pass=Epopeia0
proxy_host=proxy.corp.valepresente.local
proxy_port=3128

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
    sed -i '/alias wget/c\''alias wget=\"wget --proxy-use='"$proxy_user"' --proxy-passwd='"$proxy_pass"'\"' /etc/environment
else
    echo "alias wget=\"wget --proxy-use=$proxy_user --proxy-passwd=:$proxy_pass\"" >>/etc/environment
fi
