: "${VERSION_PATH:=version.txt}"

semver::help() {
  echo "# semver - https://github.com/sschmid/bee-semver"
  echo 'VERSION_PATH=version.txt # default'
}

semver::read() {
  if [[ ! -f "${VERSION_PATH}" ]]; then
    bee::log_error "${VERSION_PATH} not found!"
    exit 1
  fi

  cat "${VERSION_PATH}"
}

semver::write() {
  echo "$1" > "${VERSION_PATH}"
  cat "${VERSION_PATH}"
}

semver::major() {
  local version major
  version="$(semver::read)"
  major="${version%%.*}"
  semver::write "$((major + 1)).0.0"
}

semver::minor() {
  local version major no_major minor
  version="$(semver::read)"
  major="${version%%.*}"
  no_major="${version#*.}"
  minor="${no_major%%.*}"
  semver::write "${major}.$((minor + 1)).0"
}

semver::patch() {
  local version major no_major minor patch
  version="$(semver::read)"
  major="${version%%.*}"
  no_major="${version#*.}"
  minor="${no_major%%.*}"
  patch="${no_major#*.}"
  semver::write "${major}.${minor}.$((patch + 1))"
}
