# semver
Read, write and bump version numbers
Please see https://semver.org

## `semver::read`
Print the current version

## `semver::write <version>`
Write the specified version to `VERSION_PATH`

### Example
```sh
bee semver::write 0.1.0
```

## `semver::major`
Bump the major version

## `semver::minor`
Bump the minor version

## `semver::patch`
Bump the path version
