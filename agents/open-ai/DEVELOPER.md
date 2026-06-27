# ~/.codex/DEVELOPMENT.md

## Docs
- All documentation must be well formatted, for example, by following language-specific conventions, and easy for humans to read.
- Always document public functions.
- Always document all public attributes of a data structure, such as a struct or data class.
- Leave comments on code blocks that represent a single logical idea, unless the block is simple setup, boilerplate, or error handling.
- For private functions, always write a one- to three-line summary doc unless the body is very short or the function name already makes the behavior clear. Do not write full documentation as you would for a public function.
- For an attribute or function argument that contains a nested object or JSON, add an inline comment with an example showing the expected structure.

## Code Structure
- Use descriptive function and variable names. Avoid abbreviations or shortened words unless the full name would exceed 20 characters including underscores, or the shortened form is very common, even among non-English speakers.
- If a function contains more than three logical blocks, modularize it by extracting private functions with well-formatted names so the internal flow can be understood without reading the contents of those private functions.
- Do not extract a private function for simple boilerplate or configuration code, such as parsing or data validation, unless more than two logical blocks can be grouped into a single function, a logical block exceeds 10 lines due to if/else statements or exception handling, or the logic is used in more than one place.
- Do not create a private function if doing so would make the code much more complex, for example, by requiring too many variables to be passed or multiple values to be returned.
- Avoid writing code with more than four levels of block depth, where block depth refers to additional indentation introduced by structures such as curly-brace blocks.
- Function order should follow the C style, where a private helper function is placed before the function that calls it. The goal is to narrow the reviewer’s scope when reading code from top to bottom, so they already have the helper function’s context before reading its caller.
- Keep these principles from the Zen of Python in mind
  - Explicit is better than implicit.
  - Simple is better than complex.
  - Readability counts.
  - Errors should never pass silently, unless explicitly silenced.
  - If the implementation is hard to explain, it's a bad idea. If the implementation is easy to explain, it may be a good idea.

## Modifying Existing Code
- Keep the scope of changes as narrow as possible when modifying existing code, unless the prompt explicitly asks you to refactor other parts. Do not make large changes in a single pull request, as this can make the reviewer’s context harder to follow.


## Tests
- Always create unit tests for all public functions.
- Skip unit tests for branches that only handle simple boilerplate, such as null checks.
- When writing tests for an exception-handling branch, do not assert on the exception message. Only check that the correct type of exception is raised.

