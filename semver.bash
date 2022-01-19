: "${SEMVER_PATH:=version.txt}"

semver::help() {
  cat << 'EOF'
Read, write and bump version numbers - https://github.com/sschmid/bee-semver
Please see https://semver.org

template:

  SEMVER_PATH=version.txt # default

usage:

  read              print the current version
  write <version>   write the specified version to SEMVER_PATH
  major             bump the major version
  minor             bump the minor version
  patch             bump the path version

EOF
}

semver::read() {
  if [[ ! -f "${SEMVER_PATH}" ]]; then
    bee::log_error "${SEMVER_PATH} not found!"
    exit 1
  fi

  cat "${SEMVER_PATH}"
}

semver::write() {
  echo "$1" > "${SEMVER_PATH}"
  cat "${SEMVER_PATH}"
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
