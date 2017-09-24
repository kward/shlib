# shlib

Useful Shell routines.

## functions

Files in the `functions` folder provide specific functionality.

- `shlib_relToAbsPath` -- Converts a relative path into an absolute path from
  the root of the file system.

## standalone

Files in the `standalone` folder are useful as libraries, or as standalone
software if the executable bit is set.

- `versions` -- Provides reusable functions that determine actual names and
  versions of installed shells and the OS.
- `which` -- A version of the `which` command for OSes that don't include one by default.
