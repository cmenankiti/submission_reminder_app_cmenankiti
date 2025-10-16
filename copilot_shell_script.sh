#!/bin/bash

#Variable as a shortcut for the file to run smoothly
the_dir="submission_reminder_*/"

read -p "Enter your Assignment: " meatpie
echo "Updating Assignment..."

#Source file for the words that should be replaced
source $the_dir/config/config.env

#To replace the word with the user's input use sed
sed -i "s/$ASSIGNMENT/$meatpie/g" $the_dir/config/config.env &&
echo "$ASSIGNMENT has been Updated"

./$the_dir/startup.sh
