#! /usr/bin/env bash

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "ferfereh publish" \
            "publish ferfereh."
        return
    fi

    if [ "$task" == "publish" ] ; then
        local gens="gen1 gen5 gen6"
        local folders="3d gcode sketchup"

        abcli_log "-ferfereh: publish: $gens X $folders"

        local folder
        local gen
        for folder in $folders ; do
            abcli_log "-ferfereh: publish: $gens -> $folder"

            rm -rfv $abcli_path_git/ferfereh/$folder
            mkdir -p $abcli_path_git/ferfereh/$folder

            for gen in $gens ; do
                cp -v $abcli_path_git/dart/ferfereh/$folder/$gen* $abcli_path_git/ferfereh/$folder
            done
        done

        cd $abcli_path_git/ferfereh
        git status

        return
    fi

    abcli_log_error "-ferfereh: $task: command not found."
}