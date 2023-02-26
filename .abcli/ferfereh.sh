#! /usr/bin/env bash

export FERFEREH_IMAGE_OBJECT=ferfereh-images-v1

function ferfereh() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_show_usage "ferfereh publish 3d-files|coords" \
            "publish ferfereh."
        return
    fi

    if [ "$task" == "publish" ] ; then
        local what=$(abcli_clarify_input $2 3d-files)

        if [ "$what" == "3d-files" ] ; then
            local gens="gen1 gen5 gen6"
            local folders="3d gcode sketchup"

            abcli_log "-ferfereh: publish: $what: $gens X $folders"

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
        elif [ "$what" == "coords" ] ; then
            abcli_select ferfereh-images-v1
            abcli_download

            python3 -m ferfereh \
                publish_coords \
                --output_filename $abcli_path_git/ferfereh/coords.geojson

            abcli_upload
            return
        else
            abcli_log_error "-ferfereh: publish: $what: not found."
            return 1
        fi

        return
    fi

    if [ "$task" == "version" ] ; then
        python3 -m ferfereh version
        return
    fi

    abcli_log_error "-ferfereh: $task: command not found."
}