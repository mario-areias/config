#!/bin/bash

SESSION_LIST=$(zellij list-sessions -s)
TARGET="temp"

ALACRITTY_HOME="/Applications/Alacritty.app/Contents/MacOS/"
CREATE="alacritty -o 'window.position={ x = 1250, y = 0 }' -o 'window.dimensions={ columns=150, lines=10 }' -e zellij -l temp -s $TARGET &"
ATTACH="alacritty -o 'window.position={ x = 1250, y = 0 }' -o 'window.dimensions={ columns=150, lines=10 }' -e zellij attach $TARGET &"

for session in $SESSION_LIST; do
  if [ "$session" == "$TARGET" ]; then
	echo "Attaching to existing session $TARGET"
	ALACRITTY_COMMAND=$ATTACH
	break 
  fi
done

if [ -z "$ALACRITTY_COMMAND" ]; then
	ALACRITTY_COMMAND=$CREATE
fi
  
eval $ALACRITTY_HOME$ALACRITTY_COMMAND
