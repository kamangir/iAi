#! /usr/bin/env bash

function abcli_install_iAi() {
    local env_name=iAi

    if conda env list | grep -q "$env_name"; then
        conda env remove -y -n "$env_name"
    fi

    conda create -y -n "$env_name"

    conda activate "$env_name"

    # https://github.com/InstaPy/InstaPy/issues/6692#issuecomment-1474058959
    abcli_log "installing emoji"
    pip3 uninstall emoji --yes
    pip3 install emoji==1.7

    # https://github.com/InstaPy/InstaPy/issues/6697#issuecomment-1474058270
    abcli_log "installing clarifai"
    pip3 uninstall clarifai --yes
    pip3 install clarifai==2.6.2

    abcli_log "installing instapy"
    pip3 install instapy

    abcli_log "installing jupyter notebook"
    conda install -y -c conda-forge jupyter

    pushd $abcli_path_git > /dev/null

    abcli_log "installing awesome-bash-cli"
    cd awesome-bash-cli
    pip3 install -e .
    
    abcli_log "installing iAi"
    cd ../iAi 
    pip3 install -e .

    popd > /dev/null

    conda deactivate
}

abcli_install_module iAi 111