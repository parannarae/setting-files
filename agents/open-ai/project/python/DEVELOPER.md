# ~/DEVELOPER.md

## General
- If the project has no project manager or linter, prefer `uv` and `ruff`, respectively, and add them as dependencies.

## Tests
- Follow a Spring-like test structure: organize test files under tests, mirroring the structure of the source code under `src`. For example, tests for `src/foo/bar.py` should be placed in `tests/foo/test_bar.py`.
- Place general test utilities under `tests/test_utils`, grouping closely related functions into appropriately named files.

