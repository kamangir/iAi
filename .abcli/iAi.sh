#! /usr/bin/env bash

function iai() {
    iAi $@
}

function iAi() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        local options="-"
        abcli_show_usage "iAi post <object_name>$ABCUL[$options]" \
            "task things."

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

    if [ "$task" == "task" ] ; then
        python3 -m iAi \
            task \
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