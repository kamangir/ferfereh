#! /usr/bin/env bash

function ferfereh_action_git_before_push() {
    ferfereh pypi build
}
