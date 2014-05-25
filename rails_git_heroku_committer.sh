#!/bin/bash

command=$1
branch_name_or_commit_message=$2

usage_message() {
    echo "rails_git_heroku_committer usage:"
    echo
    echo "-c for commiting and pushing current branch to github. Requires commit message."
    echo
    echo "-h for pushing committed changes to heroku."
    echo
    echo "-ch for commiting current branch to github and pushing committed changes to heroku. "
    echo "Requires commit message."
    echo
    echo "-b for, while in master branch, creating a new branch and moving to it."
    echo "Requires branch name."
    echo
    echo "-m for, while not in master branch, merging branch to master and moving to master."
    echo
    echo "-cm for commiting current branch to github, merging to master, and pusing to github."
    echo "Requires commit message."
    echo
    echo "-cmh for commiting current branch to github, merging to master, pushing to gitub"
    echo "and then pushing those changes to heroku"
    echo "Requires commit message."
}

commit_branch() {
    git add .
    git commit -m "$branch_name_or_commit_message"
    git push
}

push_to_heroku() {
    git push heroku
    heroku run rake db:migrate
}

create_and_move_to_branch() {
    #check to see if we're on the master branch
    on_master_regex="\* master"
    if [[ $(git branch) =~ $on_master_regex ]] ; then
        git checkout -b $branch_name_or_commit_message
    else
        echo "This script only branches from master for now"
        exit 1
    fi
}

merge_from_branch_to_master() {
    branch_name=$(git branch | sed -rn 's/\* ([a-z]+)/\1/p')
    if [[ "$branch_name" != "master" ]] ; then
        git checkout master
        git merge $branch_name
    else
        echo "This script is only for merging from a non-master branch"
        exit 1
    fi
    git push
}

echo "$command $branch_name_or_commit_message"

case "$command" in
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
-cm) commit_branch; merge_from_branch_to_master
    ;;
-cmh) commit_branch; merge_from_branch_to_master; push_to_heroku
    ;;
*) usage_message; exit 1
   ;;
esac

git status
