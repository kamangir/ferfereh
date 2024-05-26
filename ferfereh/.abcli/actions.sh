#! /usr/bin/env bash

function ferfereh_action_git_before_push() {
    [[ "$(abcli_git get_branch)" == "main" ]] &&
        ferfereh pypi build
}
