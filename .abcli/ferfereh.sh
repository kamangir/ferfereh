#! /usr/bin/env bash

export FERFEREH_IMAGE_OBJECT=ferfereh-images-v1

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        ferfereh_publish "$@"
        return
    fi

    local function_name="ferfereh_$task"
    if [[ $(type -t $function_name) == "function" ]] ; then
        $function_name "${@:2}"
        return
    fi

    if [ "$task" == "version" ] ; then
        python3 -m ferfereh version
        return
    fi

    abcli_log_error "-ferfereh: $task: command not found."
}