#!/bin/sh
#curl -sS "wttr.in/?format=%t"
#curl -sS "wttr.in/38.906551,111.2222683?format="%c+%t+%h""

sleep 10s

curl -sS "wttr.in/beijing?format="%c+%t+%h""
