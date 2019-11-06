# Text color codes
YELLOW_TEXT='\e[1;33m'
RED_TEXT='\e[1;31m'
GREEN_TEXT='\e[1;32m'
BLUE_TEXT='\e[1;34m'
ENDCOLOR='\e[0m'

asm8 -E+ -WRN -M prg.asm
if [ $? -ne 0 ] # cd command faults
then
  echo -e "${RED_TEXT}ERROR! Compile failed.${ENDCOLOR}"
  cat prg.err
  exit
fi
~/gzdl.c/gzdl -t -b 57600 -f ~/Dropbox/hc08/gzat/prg.s19 -c -m
