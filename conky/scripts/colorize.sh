#!/bin/bash
# colorize.sh

COOL=40
WARM=50

if [[ $1 < $COOL ]]
   then echo "\${color green}"$1    # COOL
elif [[ $1 > $WARM ]]
   then echo "\${color red}"$1    # HOT
else echo "\${color orange}"$1       # WARM
fi

exit 0
