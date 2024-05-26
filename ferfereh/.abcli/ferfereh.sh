#! /usr/bin/env bash

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        abcli_show_usage "ferfereh cleanup" \
            "cleanup ferfereh."

        ferfereh_exif "$@"

        ferfereh_publish "$@"
        return
    fi

    if [ "$task" == "cleanup" ]; then
        python3 -m ferfereh cleanup \
            --path $abcli_path_git/ferfereh/images/tools
        return
    fi

    abcli_generic_task \
        plugin=ferfereh,task=$task \
        "${@:2}"
}

abcli_source_path - caller,suffix=/tests
