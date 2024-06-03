#! /usr/bin/env bash

export FERFEREH_IMAGE_OBJECT=ferfereh-images-v2

function ferfereh_publish() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        abcli_show_usage "ferfereh publish coords$ABCUL[~downloads]" \
            "publish ferfereh coords."
        abcli_show_usage "ferfereh publish 3d-files" \
            "publish ferfereh 3d-files."
        return
    fi

    local what=$(abcli_clarify_input $1 3d-files)

    if [ "$what" == "3d-files" ]; then
        local gens="gen1 gen5 gen6 gen7"
        local folders="3d gcode sketchup"

        abcli_log "-ferfereh: publish: $what: $gens X $folders"

        local folder
        local gen
        for folder in $folders; do
            abcli_log "-ferfereh: publish: $gens -> $folder"

            mkdir -p $abcli_path_git/ferfereh/$folder

            for gen in $gens; do
                cp -v $abcli_path_git/dart/ferfereh/$folder/$gen* $abcli_path_git/ferfereh/$folder
            done
        done

        cd $abcli_path_git/ferfereh
        git status

        return
    fi

    if [ "$what" == "coords" ]; then
        local options=$2
        local ingest_downloads=$(abcli_option "$options" downloads 1)

        abcli_select $FERFEREH_IMAGE_OBJECT
        abcli_download

        if [ "$ingest_downloads" == 1 ]; then
            local download_folder=$HOME/Downloads/ferfereh

            mkdir -p $download_folder

            mv -v $download_folder/* ./
        fi

        python3 -m ferfereh \
            publish_coords \
            --output_filename $abcli_path_git/ferfereh/coords.geojson

        abcli_upload

        abcli_publish - $abcli_object_name

        cd $abcli_path_git/ferfereh/
        git status

        return
    fi

    abcli_log_error "-ferfereh: publish: $what: not found."
    return 1
}
