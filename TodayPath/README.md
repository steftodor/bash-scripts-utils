# TodayPath.sh

Sample script to be used to navigate to a folder that may contain todays logs. 
User configures a base folder path. This provides options for changes different userids and a negative date offset. 

By default this script will change the directory to `/path/to/location/{userid}/YYYY/Month/DD`


## Usage 

`source TodaysDatePath.sh -u <Alternative Username> -d <Number of days to offset by>`

This script can be adapted to fit your needs. 

## Note

There is a check to see if this script is running on a Mac since it uses a different offset command. 



`alias todaypath="source /path/to/script/TodayPath.sh"
