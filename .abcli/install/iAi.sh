#! /usr/bin/env bash

function abcli_install_iAi() {
    local env_name=iAi

    if conda env list | grep -q "$env_name"; then
        conda env remove -y -n "$env_name"
    fi

    conda create -y -n "$env_name"

    conda activate "$env_name"

    conda install -y instapy

    conda deactivate
}

abcli_install_module iAi 102