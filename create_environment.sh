#!/bin/bash
#Ask for the name
echo -n "Input your First Name: "
read name

#Making the directory of the user
mkdir -p submission_reminder_$name
the_dir="submission_reminder_$name"

#Make the structure of the directory
mkdir -p "$the_dir/app"
mkdir -p "$the_dir/modules"
mkdir -p "$the_dir/assets"
mkdir -p "$the_dir/config"

#Make the files for the directory
touch "$the_dir/app/reminder.sh"
touch "$the_dir/modules/functions.sh"
touch "$the_dir/assets/submissions.txt"
touch "$the_dir/config/config.env"
touch "$the_dir/startup.sh"

#Adding the contents to a file
cat <<EOF > "$the_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Lorris, Shell Navigation, not submitted
Paradise, Git, submitted
Tedla, Shell Basics, not submitted
Success, Shell Basics, submitted
Eric, Shell Navigation, submitted
Peter, Git, not submitted
EOF

cat <<EOF > "$the_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

cat <<EOF > "$the_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file="\$1"
    echo "Checking submissions in ("\$submissions_file")"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF

cat <<EOF > "$the_dir/app/reminder.sh"
#!/bin/bash

#Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

#Path to the submissions file
submissions_file="../assets/submissions.txt"

#Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOF

chmod +x $the_dir/startup.sh $the_dir/*/*.sh

cat <<EOF > $the_dir/startup.sh
#!/bin/bash
#Message when app is run
echo "Submission Reminder App dey Start"
echo "Loading..."

#Make the script location-independent
base_dir="\$(dirname "\$0")"

# Run the reminder app by executing the reminder.sh file
if [ -d "\$base_dir/app" ]; then
  # Change into the app directory using the determined path
  if cd "\$base_dir/app" ; then
    if [ -f "reminder.sh" ]; then
      bash reminder.sh
      echo "E dey work"
    else
      echo "Problem Dey - reminder.sh no dey!"
      exit 1
    fi
    # Use 'cd -' to return to the original starting directory
    cd - > /dev/null 
  else
    echo "Problem Dey - Could not enter app folder!"
    exit 1
  fi
else
  echo "Problem Dey - app folder no dey!"
fi
EOF
