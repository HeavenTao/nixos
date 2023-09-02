#!/usr/bin/env fishshell
echo "===========================set proxy"
set ip "$argv[1]:7890"
echo "the proxy ip is: $ip "
export http_proxy="http://$ip"
echo "http_proxy:" $http_proxy

export https_proxy="http://$ip"
echo "https_proxy:" $https_proxy

export HTTP_PROXY="http://$ip"
echo "HTTP_PROXY:" $HTTP_PROXY

export HTTPS_PROXY="http://$ip"
echo "HTTPS_PROXY" $HTTP_PROXY
echo "done"

echo "=========================set git proxy"
git config --global https.proxy "http://$ip"
git config --global http.proxy "http://$ip"
git config --global user.name "heaven"
git config --global user.email "542248377@qq.com"
git config --global https.proxy 
git config --global http.proxy
echo "done"
