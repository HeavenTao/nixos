#!/usr/bin/env bash
set -eE

configPath="/home/$USER/.config/nvim"
sharePath="/home/$USER/.local/share/nvim"
statePath="/home/$USER/.local/state/nvim"

function pathExists() {
    if [ -d "$1" ] ; then
        echo $1 exists
        return 0
    else
        echo $1 not exists
        return 1
    fi
}

function removePath() {
    rm -rf $1
}


pathExists $configPath
pathExists $sharePath
pathExists $statePath

removePath $configPath
removePath $sharePath
removePath $statePath
