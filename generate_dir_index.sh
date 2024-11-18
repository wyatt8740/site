#! /usr/bin/env sh
STARTDIR="$PWD"

htmlHead()
{
cat << EOF
<!DOCTYPE html>
<html>

  <head>
    <title>
EOF
echo '      Index of '"$1"
cat << EOF
    </title>
  </head>
  <body>
EOF
}

htmlFoot()
{
  cat << EOF
  </body>
</html>
EOF
}

# posix-ish null terminated sort, can substitute for 'sort -z' below
sortz()
{
  cat | tr '\0' '\n' | sort | tr '\n' '\0'
}

istracked() {
  # if this is not an empty string, it's probably untracked
  # THIS IS NOT A PERFECT SOLUTION AND HAS MANY POTENTIAL ISSUES WITH EDGE
  # CASES. It will also be weird with empty untracked directories.
  if [ "$(git status --porcelain "$1" | grep -v '^A  ' | grep -v '^ M ' | grep "$1"'$')" ]; then
    return 1 # false
  else
    return 0 # true
  fi
}

buildPage()
{
  htmlHead "$1"
  cd "$1"
  if [ "$1" != '.' ]; then
    echo '[D] <a href="../index.html">../</a><br/>'
  fi
  find . -maxdepth 1 -type d ! -path . -print0 | sort -z | tr '\0' '\n' | while read -r line; do
    procline="$(echo "$line" | sed 's!^\./!!')"
 #   if istracked "$procline"; then
 #     1>&2 echo 'tracked: '"$procline"
      echo '[D] <a href="'"$line"'/index.html">'"$procline"'/</a><br/>'
 #   fi
  done

  # xargs -0 -i sh -c 'echo "[D] <a href="''\"'{}'\"''">"{}"</a><br/>"'
  find . -maxdepth 1 -type f -print0 | sort -z | tr '\0' '\n' | while read -r line; do
    procline="$(echo "$line" | sed 's!^\./!!')"
#    if istracked "$procline"; then
      echo '[F] <a href="'"$line"'">'"$procline"'</a><br/>'
#    fi
  done
  htmlFoot
  cd "$STARTDIR"
}
if [ ! "$CONFIRM" ]; then
  CONFIRM=''
fi
while [ "$#" -gt 0 ]; do
  if [ -d "$1" ]; then
    if [ -f "$1"'/index.html' ]; then
      until (echo "$CONFIRM"|grep -q ^[YyNnAa]$); do
        if [ "$CONFIRM" ]; then
          echo "Invalid option selected, please use one of 'y', 'n', or 'a'."
        fi
        echo "Would you like to replace the existing index.html in directory (Y(es)/N(o)/A(ll)"
        echo "$1" '?:'
        read -r CONFIRM
      done
      case "$CONFIRM" in
        'a'|'A')
          echo 'Removing '"$1"'/index.html as '"'all'"' was selected.'
          rm "$1"'/index.html'
          # do not clear CONFIRM variable if 'all' was chosen.
          ;;
        'y'|'Y')
          echo 'Removing '"$1"'/index.html.'
          rm "$1"'/index.html'
          CONFIRM=''
          ;;
        'n'|'N')
          CONFIRM=''
          ;;
        *)
          1>&2 echo 'this situation should never happen. What did you do!?'
          1>&2 echo 'Exiting.'
          exit 1
          ;;
      esac
      #    1>&2 echo 'E: Please delete the index.html in the directory '"$1"' if you really want to replace it.'
      #    exit 1
    fi
    buildPage "$1" > "$STARTDIR"'/'"$(basename "$1")"'.html'
    mv "$STARTDIR"'/'"$(basename "$1")"'.html' "$1"'/index.html'
  fi
  shift
done
