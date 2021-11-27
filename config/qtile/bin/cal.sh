#!/bin/sh

# Start
DAY=$(date +'%e')
dunstify 'Calendar' "$(cal | sed -e "s/$DAY\b/<u>$DAY<\/u>/g")"

exit 0
