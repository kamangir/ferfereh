#! /usr/bin/env bash

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "ferfereh publish" \
            "terraform ferfereh."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m ferfereh --help
        fi

        return
    fi

    if [ "$task" == "publish" ] ; then
        echo "wip"
        return
    fi

    abcli_log_error "-ferfereh: $task: command not found."
}