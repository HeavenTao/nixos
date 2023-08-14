cd /home/ht/code/nixos
source set-nix-proxy.sh ${1}
nixos-rebuild switch --flake .
shutdown -r 0
