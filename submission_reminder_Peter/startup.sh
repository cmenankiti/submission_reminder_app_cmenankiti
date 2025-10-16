#!/bin/bash
#Message when app is run
echo "Submission Reminder App dey Start"
echo "Loading..."

#Make the script location-independent
base_dir="$(dirname "$0")"

# Run the reminder app by executing the reminder.sh file
if [ -d "$base_dir/app" ]; then
  # Change into the app directory using the determined path
  if cd "$base_dir/app" ; then
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
