#! /usr/bin/env bash

function F() {
    ferfereh "$@"
}

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        abcli_show_usage "ferfereh cleanup" \
            "cleanup ferfereh."
        ferfereh_publish "$@"
        return
    fi

    local function_name="ferfereh_$task"
    if [[ $(type -t $function_name) == "function" ]]; then
        $function_name "${@:2}"
        return
    fi

    if [ "$task" == "cleanup" ]; then
        python3 -m ferfereh cleanup \
            --path $abcli_path_git/ferfereh/images/tools
        return
    fi

    if [ "$task" == "init" ]; then
        abcli_init ferfereh "${@:2}"
        return
    fi

    if [ "$task" == "version" ]; then
        python3 -m ferfereh version "${@:2}"
        return
    fi

    abcli_log_error "-ferfereh: $task: command not found."
}
