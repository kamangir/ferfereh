#! /usr/bin/env bash

function ferfereh_exif() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "help" ]; then
        ferfereh_exif get "$@"
        ferfereh_exif install "$@"
        ferfereh_exif put "$@"
        return
    fi

    local options=$2
    local do_dryrun=$(abcli_option_int "$options" dryrun 0)
    local create_backup=$(abcli_option_int "$options" backup $(abcli_not $do_dryrun))
    local do_validate=$(abcli_option_int "$options" validate $(abcli_not $do_dryrun))

    if [ $(abcli_option_int "$options" help 0) == 1 ]; then
        case "$task" in
        "get")
            local options="-"
            abcli_show_usage "ferfereh exif get$ABCUL[$options]$ABCUL<filename.jpg>" \
                "get exif."
            ;;
        "install")
            abcli_show_usage "ferfereh exif install" \
                "install exif."
            ;;
        "put")
            local options="~backup,dryrun,lat=<lat>,lon=<lon>,validate"
            abcli_show_usage "ferfereh exif put$ABCUL[$options]$ABCUL<filename.jpg>" \
                "put exif."
            ;;
        *)
            abcli_log_error "-ferfereh: exif: $task: help: command not found."
            return 1
            ;;
        esac
        return
    fi

    if [ "$task" == "install" ]; then
        if [[ "$abcli_is_mac" == true ]]; then
            # https://exiftool.org/
            brew install exiftool
        fi
        return
    fi

    local filename=$3
    if [[ ! -f "$filename" ]]; then
        abcli_log_error "-ferfereh: exif: $task: $filename: file not found."
        return 1
    fi

    if [ "$task" == "get" ]; then
        exiftool \
            -GPSLatitude -GPSLongitude \
            "$filename"
        return
    fi

    if [ "$task" == "put" ]; then
        [[ "$create_backup" == 1 ]] &&
            cp -v "$filename" "$filename.bkp"

        abcli_eval dryrun=$do_dryrun \
            exiftool \
            -GPSLatitude=$(abcli_option "$options" lat 0) \
            -GPSLatitudeRef=N/S \
            -GPSLongitude=$(abcli_option "$options" lon 0) \
            -GPSLongitudeRef=E/W \
            "$filename"

        if [[ "$do_validate" == 1 ]]; then
            ferfereh_exif get - "$filename"
        fi

        return
    fi

    abcli_log_error "-ferfereh: exif: $task: command not found."
    return 1
}
