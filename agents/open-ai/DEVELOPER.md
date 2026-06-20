# ~/.codex/DEVELOPMENT.md

## Docs
- All documentation must be well formatted, for example, by following language-specific conventions, and easy for humans to read.
- Always document public functions.
- Always document all public attributes of a data structure, such as a struct or data class.
- Leave comments on code blocks that represent a single logical idea, unless the block is simple setup, boilerplate, or error handling.

## Code Structure
- Use descriptive function and variable names. Avoid abbreviations or shortened words unless the full name would exceed 20 characters including underscores, or the shortened form is very common, even among non-English speakers.
- If a function contains more than three logical blocks, modularize it by extracting private functions with well-formatted names so the internal flow can be understood without reading the contents of those private functions.
- Keep function bodies under 50 lines unless the length comes from line breaks in a single statement due to long names. If the line count exceeds the limit because of boilerplate or configuration, move those parts into separate private functions unless doing so would make the code much more complex, for example, by requiring too many variables to be passed or multiple values to be returned.
- Avoid writing code with more than four levels of block depth, where block depth refers to additional indentation introduced by structures such as curly-brace blocks.

## Modifying Existing Code
- Keep the scope of changes as narrow as possible when modifying existing code, unless the prompt explicitly asks you to refactor other parts. Do not make large changes in a single pull request, as this can make the reviewer’s context harder to follow.


## Tests
- Always create unit tests for all public functions.
- Skip unit tests for branches that only handle simple boilerplate, such as null checks.
- When writing tests for an exception-handling branch, do not assert on the exception message. Only check that the correct type of exception is raised.

