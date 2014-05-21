#!/bin/bash

./rails_git_heroku_committer.sh
echo
echo

./rails_git_heroku_committer.sh -h
echo
./rails_git_heroku_committer.sh -m
echo
./rails_git_heroku_committer.sh -c "commit message"
echo
./rails_git_heroku_committer.sh -b "branch name"
echo
./rails_git_heroku_committer.sh -ch "commit message"
echo
./rails_git_heroku_committer.sh -hc "commit message"
echo
./rails_git_heroku_committer.sh -c -h "commit message"
echo
./rails_git_heroku_committer.sh -h -c "commit message"
