#!/usr/bin/env bash
echo "===========================set proxy"
ip="${1}:7890"
echo "the proxy ip is: ${ip} "
export http_proxy="http://${ip}"
echo "http_proxy:" $http_proxy

export https_proxy="http://${ip}"
echo "https_proxy:" $https_proxy

export HTTP_PROXY="http://${ip}"
echo "HTTP_PROXY:" $HTTP_PROXY

export HTTPS_PROXY="http://${ip}"
echo "HTTPS_PROXY" $HTTP_PROXY
echo "done"

echo "=========================set nix-daemon proxy"
sudo mkdir /run/systemd/system/nix-daemon.service.d/
sudo touch /run/systemd/system/nix-daemon.service.d/override.conf
sudo cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf  
[Service]
Environment="http_proxy=http://${ip}"
Environment="https_proxy=http://${ip}"
Environment="all_proxy=http://${ip}"
EOF
echo "reload daemon"
sudo systemctl daemon-reload
echo "restart nix-daemon"
sudo systemctl restart nix-daemon
echo "done"

echo "=========================set git proxy"
git config --global https.proxy "http://${ip}"
git config --global http.proxy "http://${ip}"
git config --global user.name "heaven"
git config --global user.email "542248377@qq.com"
echo "done"
