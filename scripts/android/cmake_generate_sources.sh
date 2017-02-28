#!/bin/sh
srcs=$(find plugins \( -name '*.h' -or -name '*.c' \) -not -path '*/ios/*' -exec echo $1{} \;)
echo "set(CLUE_SRCS $srcs)"
