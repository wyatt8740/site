#! /bin/sh
mkdir -p dark
find blog/ about/ ./index.html -type f -iname '*.html' | while read -r line; do
  mkdir -p 'dark/'"$(dirname "$line")"
  sed 's/style\.css/style_dark.css/g' < "$line" > 'dark/'"$line"
done
