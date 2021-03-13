# version
Read, write and bump version numbers

## `version::read`
Print the current version

## `version::write <version>`
Write the specified version to `VERSION_PATH`

### Example
```sh
bee version::write 0.1.0
```

## `version::bump_major`
Bump the major version

## `version::bump_minor`
Bump the minor version

## `version::bump_patch`
Bump the path version
