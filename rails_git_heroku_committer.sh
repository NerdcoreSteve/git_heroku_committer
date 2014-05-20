#!/bin/bash

selection="none"
message="no commit message"

get_user_selection() {
    echo "$#"
    first_flag_regex="^-(c|h|ch|hc|b|m)$"
    if [[ "$#" -ge 2 && $1 =~ $first_flag_regex ]] ; then
        if [ "$#" -eq 2 ] ; then
            selection=$1
            message=$2
            if [ "$selection" -eq "-hc" ] ; then
                selection="-ch"
            fi
        fi
        #TODO why doesn't this work?
        if [ "$#" -eq 3 ] ; then
            echo "there are three arguments"
        #    selection="-ch"
        #    message=$3
        fi
    fi
}

usage_message() {
    echo "rails_git_heroku_committer usage:"
    echo
    echo "-c for commiting current branch to github."
    echo
    echo "-h for pushing committed changes to heroku."
    echo
    echo "-ch or -hc or -h -c for commiting current branch to github and"
    echo "pushing committed changes to heroku"
    echo
    echo "-b for, while in master branch, creating a new branch and moving to it."
    echo
    echo "-m for, while not in master branch, merging branch to master and moving to master."
}

get_user_selection "$@"

case "$selection" in
-c)  echo "TODO commit branch"
    ;;
-h)  echo "TODO push heroku"
    ;;
-ch) echo "TODO commit branch and push heroku"
    ;;
-b)  echo "TODO create and move to branch"
    ;;
-m)  echo "TODO merge from branch"
    ;;
*) usage_message
    exit 1
   ;;
esac
