# `cat` as a bash script

This repository holds a basic version of the `cat` utility written as a
bash script. This is meant as a teaching aid for bash scripting, so the
incremental steps are given as separate files, which are numbered.

## Supported features

* reading from stdin when no arguments are given
* reading from one or more files
* reading from stdin when `-` is supplied as an argument
* the `-b` flag
* the `-n` flag
* the non-standard `-h` and `--help` flags for usage information

A version with no dependence on external utilities and with support for
the `-s` flag can be found in the `more` branch.

## License

This work is licensed under the MIT. See the [`LICENSE`](LICENSE) file
for details.
