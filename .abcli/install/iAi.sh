#! /usr/bin/env bash

function abcli_install_iAi() {
    local env_name=iAi

    if conda env list | grep -q "$env_name"; then
        conda env remove -y -n "$env_name"
    fi

    conda create -y -n "$env_name"

    conda activate "$env_name"

    # https://github.com/adw0rd/instagrapi
    echo "installing instagrapi"
    python3 -m pip install instagrapi

    echo "installing jupyter notebook"
    conda install -y -c conda-forge jupyter

    pip3 install pillow
    pip3 install PyMySQL==0.10.1

    pushd $abcli_path_git > /dev/null

    echo "installing awesome-bash-cli"
    cd awesome-bash-cli
    pip3 install -e .
    
    abcli_log "installing iAi"
    cd ../iAi 
    pip3 install -e .

    popd > /dev/null

    conda deactivate
}

abcli_install_module iAi 113