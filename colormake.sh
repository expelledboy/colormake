#!/bin/sh

red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
grey="$(tput setaf 8)"
reset=$(tput sgr0)

error="${red}[ERROR] ${reset}"
info="${green}[INFO] ${reset}"
warn="${yellow}[WARN] ${reset}"

# comments
rules=" /^#/ {
  s/^#/${grey}#/ ;
  s/\$/${reset}/ ;
};"

# delete echo commands
rules+=" /^echo/ d;"

# highlight special echos
rules+=" /^info: / {
  s/^info: /${info}/ ;
};"

rules+=" /^warn: / {
  s/^warn: /${warn}/ ;
};"

rules+=" /^error: / {
  s/^error: /${error}/ ;
};"

# http://www.gnu.org/software/make/manual/html_node/Error-Messages.html
rules+=" /^make\(\[.*\]\)\?: / {
  /Error/ { s/^/${error}/ ; }
  /Error/! { s/^/${info}/ ; }
};"

rules+=" /No rule to make target/ {
  s/^/${error}/ ;
};"

rules+=" /^Makefile:.* Stop\./ {
  s/^/${error}/ ;
};"

rules+=" /warning:/ {
  s/^/${warn}/ ;
};"

# else just print the line
rules+=" p; "

/usr/bin/make "$@" 2>&1 | sed -n "$rules"
exit ${PIPESTATUS[0]}
