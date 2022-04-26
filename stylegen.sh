#! /bin/sh

generate() {
  mkdir -p "$1"
  ln -sf '../blog/' "$1"'/blog'
  ln -sf '../about/' "$1"'/about'
  ln -sf '../index.html' "$1"'/index.html'
  ln -sf blog "$1"'/blerg'
  ln -sf '../style_'"$1"'.css' "$1"'/style.css'
}

generate dark
generate light
