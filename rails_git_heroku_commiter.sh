#!/bin/bash

REGEX="^[[:upper:]]{2}[[:lower:]]*$"

# Test 1
STRING=Hello
if [[ $STRING =~ "^[[:upper:]]{2}[[:lower:]]*$" ]]; then
  echo "Match."
else
  echo "No match."
fi
# ==> "No match."

# Test 2
STRING=HEllo
if [[ $STRING =~ ^[[:upper:]]{2}[[:lower:]]*$ ]]; then
  echo "Match."
else
  echo "No match."
fi
# ==> "Match."

#check argument length either 1 or 2 and that the first argument matches one of the flags
if [[ $1 !~ \-c ]]; then
    echo "Flags:"
    echo "-c for commiting current branch to githubi."
    echo "-h for pushing committed changes to heroku."
    echo "-b for, while in master branch, creating a new branch and moving to it."
    echo "-m for, while not in master branch, merging branch to master and moving to master."
    exit 1
fi

case "$1" in

-c)  echo "TODO commit branch"
    ;;
-h)  echo "TODO push heroku"
    ;;
-b)  echo "TODO create and move to branch"
    ;;
-m)  echo "TODO merge from branch"
    ;;
*) echo "Invalid arguments"
   ;;
esac
