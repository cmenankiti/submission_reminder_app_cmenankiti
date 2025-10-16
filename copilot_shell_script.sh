#!/bin/bash

#Add the previously created file as the source file
source create_environment.sh

#Making the directory of the user
mkdir -p submission_reminder_$name
the_dir=submission_reminder_$name

read -p "Enter your Assignment: " meatpie
echo "Updating Assignment..."

cat <<EOF > "$the_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#Source file for the words that should be replaced
source $the_dir/config/config.env

#To replace the word with the user's input use sed
sed -i "s/$ASSIGNMENT/$meatpie/g" $the_dir/config/config.env &&
echo "$ASSIGNMENT has been Updated"

./$the_dir/startup.sh
