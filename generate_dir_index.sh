#! /usr/bin/env sh
STARTDIR="$PWD"

htmlHead()
{
cat << EOF
<!DOCTYPE html>
<html>

<head>
  <title>Index of 
EOF
echo "$1"
cat << EOF
</title>
</head>
<body>
EOF
}

htmlFoot()
{
  echo '</body>'
}

buildPage()
{
  htmlHead "$1"
  cd "$1"
  find . -maxdepth 1 -type d ! -path . -print0 | xargs -0 -i sh -c 'echo "[D] <a href="''\"'{}'\"''">"{}"</a><br/>"'
  find . -maxdepth 1 -type f -print0 | xargs -0 -i sh -c 'echo "[F] <a href="''\"'{}'\"''">"{}"</a><br/>"'
  htmlFoot
  cd "$STARTDIR"
}

while [ "$#" -gt 0 ]; do
  if [ -d "$1" ]; then
    if [ -f "$1"'/index.html' ]; then
      1>&2 echo 'E: Please delete the index.html in the directory '"$1"' if you really want to replace it.'
      exit 1
    fi
    buildPage "$1" > "$STARTDIR"'/'"$(basename "$1")"'.html'
    mv "$STARTDIR"'/'"$(basename "$1")"'.html' "$1"'/index.html'
  fi
  shift
done
