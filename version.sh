#!/usr/bin/env bash

version::_new() {
  echo '# version'
  echo 'VERSION_PATH=version.txt'
}

version::read() {
  assert_file VERSION_PATH
  cat "${VERSION_PATH}"
}

version::write() {
  echo "$1" > "${VERSION_PATH}"
  cat "${VERSION_PATH}"
}

version::bump_major() {
  local version major
  version="$(version::read)"
  major="${version%%.*}"
  version::write "$(( major + 1 )).0.0"
}

version::bump_minor() {
  local version major no_major minor
  version="$(version::read)"
  major="${version%%.*}"
  no_major="${version#*.}"
  minor="${no_major%%.*}"
  version::write "${major}.$(( minor + 1 )).0"
}

version::bump_patch() {
  local version major no_major minor patch
  version="$(version::read)"
  major="${version%%.*}"
  no_major="${version#*.}"
  minor="${no_major%%.*}"
  patch="${no_major#*.}"
  version::write "${major}.${minor}.$(( patch + 1 ))"
}
