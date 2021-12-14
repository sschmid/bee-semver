setup() {
  load 'test_helper/bats-support/load.bash'
  load 'test_helper/bats-assert/load.bash'
  export BEE_ERR="BEE_ERR"
  semver="${BATS_TEST_DIRNAME}/../semver.bash"
  # shellcheck disable=SC2164
  cd "${BATS_TEST_TMPDIR}"
}

_setup_version() {
  export VERSION_PATH="${BATS_TEST_TMPDIR}/version.txt"
  echo "1.2.3" > "${VERSION_PATH}"
}

_semver() {
  run bee --batch "source ${semver}" "$@"
}

@test "fails when VERSION_PATH does not exist" {
  export VERSION_PATH="${BATS_TEST_TMPDIR}/unknown.md"
  _semver semver::read
  assert_failure
  assert_output "${BEE_ERR} ${VERSION_PATH} not found!"
}

@test "reads version" {
  _setup_version
  _semver semver::read
  assert_success
  assert_output "1.2.3"
}

@test "writes version" {
  _setup_version
  _semver "semver::write 4.5.6"
  assert_success
  _semver semver::read
  assert_output "4.5.6"
}

@test "bumps major" {
  _setup_version
  _semver semver::major
  assert_success
  assert_output "2.0.0"
}

@test "bumps minor" {
  _setup_version
  _semver semver::minor
  assert_success
  assert_output "1.3.0"
}

@test "bumps patch" {
  _setup_version
  _semver semver::patch
  assert_success
  assert_output "1.2.4"
}
