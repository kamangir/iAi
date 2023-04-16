#! /usr/bin/env bash

function abcli_install_iAi() {
    local env_name=iAi

    if conda env list | grep -q "$env_name"; then
        conda env remove -y -n "$env_name"
    fi

    conda create -y -n "$env_name"

    conda activate "$env_name"

    # https://github.com/InstaPy/InstaPy/issues/6692#issuecomment-1474058959
    pip3 uninstall emoji --yes
    pip3 install emoji==1.7

    # https://github.com/InstaPy/InstaPy/issues/6697#issuecomment-1474058270
    pip3 uninstall clarifai --yes
    pip3 install clarifai==2.6.2

    pip3 install instapy

    pushd $abcli_path_git/iAi > /dev/null
    pip3 install -e .
    popd > /dev/null

    conda deactivate
}

abcli_install_module iAi 108