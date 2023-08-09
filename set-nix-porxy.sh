#!/usr/bin/env bash
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
