#! /usr/bin/env bash

function iai() {
    iAi $@
}

function iAi() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_show_usage "iAi notebook" \
            "open iAi notebook."

        local options="filename=<filename.png>"
        abcli_show_usage "iAi post <object_name>$ABCUL[$options]" \
            "post <object_name>/<filename.png> on Instagram."

        # iAi_task "$@""

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m iAi --help
        fi
        return
    fi

    local function_name=iAi_$task
    if [[ $(type -t $function_name) == "function" ]] ; then
        $function_name "${@:2}"
        return
    fi

    if [ "$task" == "notebook" ] ; then
        pushd $abcli_path_git/iAi/notebooks > /dev/null
        conda activate iAi
        jupyter notebook
        conda activate abcli
        popd > /dev/null
        return
    fi

    if [ "$task" == "post" ] ; then
        python3 -m iAi \
            $task \
            --what $(abcli_clarify_input $2 all) \
            ${@:3}
        return
    fi

    conda activate iAi
    python3 -m iAi \
        $task \
        ${@:2}
    conda activate abcli
}