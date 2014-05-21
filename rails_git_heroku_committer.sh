#!/bin/bash

selection="none"
message_or_branch_name="none"

get_command() {
    if [ "$#" -eq 1 ] ; then
        flag_regex="^-(h|m)$"
        if [[ $1 =~ $flag_regex ]] ; then
            selection=$1
        fi
    elif [ "$#" -eq 2 ] ; then
        flag_regex="^-(c|b|ch|hc)$"
        if [[ $1 =~ $flag_regex ]] ; then
            selection=$1
            if [ $1 = "-hc" ] ; then
                selection="-ch"
            fi
            message_or_branch_name=$2
        fi
    elif [ "$#" -eq 3 ] ; then
        if [[ ($1 = "-c" && $2 = "-h") || ($1 = "-h" && $2 = "-c") ]] ; then
            selection="-ch"
            message_or_branch_name=$3
        fi
    fi
}

usage_message() {
    echo "rails_git_heroku_committer usage:"
    echo
    echo "-c for commiting current branch to github. Requires commit message."
    echo
    echo "-h for pushing committed changes to heroku."
    echo
    echo "-ch or -hc or -h -c for commiting current branch to github and"
    echo "pushing committed changes to heroku. Requires commit message."
    echo
    echo "-b for, while in master branch, creating a new branch and moving to it."
    echo "Requires branch name."
    echo
    echo "-m for, while not in master branch, merging branch to master and moving to master."
}

commit_branch() {
    git add .
    git commit -m "$message_or_branch_name"
    git push
    git status
}

push_to_heroku() {
    echo "TODO push to heroku"
}

create_and_move_to_branch() {
    echo "TODO create and move to branch"
}

merge_from_branch() {
    echo "TODO merge from branch"
}

get_command "$@"

case "$selection" in
-c)  commit_branch
    ;;
-h)  push_to_heroku
    ;;
-ch) commit_branch; push_to_heroku 
    ;;
-b) create_and_move_to_branch
    ;;
-m) merge_from_branch
    ;;
*) usage_message; exit 1
   ;;
esac
