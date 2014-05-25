#!/bin/bash

selection="none"
message_or_branch_name="none"

get_command() {
    if [ "$#" -eq 1 ] ; then
        flag_regex="^-(h|m|mc|cm)$"
        if [[ $1 =~ $flag_regex ]] ; then
            selection=$1
            if [ $1 = "-mc" ] ; then
                selection="-cm"
            fi
        fi
    elif [ "$#" -eq 2 ] ; then
        flag_regex="^-(m|c|b|ch|hc)$"
        if [[ $1 =~ $flag_regex ]] ; then
            selection=$1
            if [[ ($1 = "-c" && $2 = "-m") || ($1 = "-m" && $2 = "-c") ]] ; then
                selection="-cm"
            elif [ $1 = "-hc" ] ; then
                selection="-ch"
                message_or_branch_name=$2
            else
                selection=$1
                message_or_branch_name=$2
            fi
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
    #check to see if we're on the master branch
    on_master_regex="\* master"
    if [[ $(git branch) =~ $on_master_regex ]] ; then
        git checkout -b $message_or_branch_name
    else
        echo "This script only branches from master for now"
        exit 1
    fi
}

merge_from_branch_to_master() {
    echo "merge from branch is under construction"
    branch_name=$(git branch | sed -rn 's/\* ([a-z]+)/\1/p')
    if [[ "$branch_name" != "master" ]] ; then
        git checkout master
        git merge $branch_name
    else
        echo "This script is only for merging from a non-master branch"
        exit 1
    fi
}

commit_then_merge_from_branch_to_master() {
    echo "TODO commit_then_merge_from_branch_to_master"
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
-m) merge_from_branch_to_master
    ;;
-cm) commit_then_merge_from_branch_to_master
    ;;
*) usage_message; exit 1
   ;;
esac
