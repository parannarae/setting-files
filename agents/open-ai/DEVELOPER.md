# ~/.codex/DEVELOPER.md

## Docs
- All documentation must be well formatted, for example, by following language-specific conventions, and easy for humans to read.
- Always document public functions.
- Always document all public attributes of a data structure, such as a struct or data class.
- Leave comments on code blocks that represent a single logical idea, unless the block is simple setup, boilerplate, or error handling.
- For private functions, always write a one- to three-line summary doc unless the body is very short or the function name already makes the behavior clear. Do not write full documentation as you would for a public function.
- For an attribute or function argument that contains a nested object or JSON, add an inline comment with an example showing the expected structure.

## Code Formatting
- Always run the linter, if one is available, after making code changes.
- Remove trailing whitespace and ensure that each file ends with a newline. Apply these formatting changes only to files you have modified, not to the entire project.

## Code Structure
- Use descriptive function and variable names. Avoid abbreviations or shortened words unless the full name would exceed 20 characters including underscores, or the shortened form is very common, even among non-English speakers.
- If a function contains more than three logical blocks, modularize it by extracting private functions with well-formatted names so the internal flow can be understood without reading the contents of those private functions.
- Do not extract a private function for simple boilerplate or configuration code, such as parsing or data validation, unless more than two logical blocks can be grouped into a single function, a logical block exceeds 10 lines due to if/else statements or exception handling, or the logic is used in more than one place.
- Do not create a private function if doing so would make the code much more complex, for example, by requiring too many variables to be passed or multiple values to be returned.
- Avoid writing code with more than four levels of block depth, where block depth refers to additional indentation introduced by structures such as curly-brace blocks.
- Function order should follow the C style, where a private helper function is placed before the function that calls it. The goal is to narrow the reviewer's scope when reading code from top to bottom, so they already have the helper's context before reading its caller.
- Keep these principles from the Zen of Python in mind
  - Explicit is better than implicit.
  - Simple is better than complex.
  - Readability counts.
  - Errors should never pass silently, unless explicitly silenced.
  - If the implementation is hard to explain, it's a bad idea. If the implementation is easy to explain, it may be a good idea.

## Modifying Existing Code
- Keep the scope of changes as narrow as possible when modifying existing code, unless the prompt explicitly asks you to refactor other parts. Do not make large changes in a single pull request, as this can make the reviewer's context harder to follow.

## Tests
- Always create unit tests for all public functions.
- Skip unit tests for branches that only handle simple boilerplate, such as null checks.
- When writing tests for an exception-handling branch, do not assert on the exception message. Only check that the correct type of exception is raised.
- When creating a mock, do not define implicit default return values. Always specify mocked return values explicitly in the test body so that the scenario's assumptions and expectations are clear to reviewers. If the same return value is used across multiple test cases, such as when a mocked intermediate step must return a fixed value to test subsequent logic, define it in a fixture or helper function for reuse.
- When a single test class or file contains tests for multiple functions, use clearly visible ASCII-only comment dividers to group tests by the function under test. For example: `# --- MyClass.functionName ---.`
- Order test scenarios according to the flow of the logic under test so that reviewers can easily identify any missing branches.

## General Programming Quality

Treat these principles as priorities when making trade-offs:

- **Make the code flow readable before making it concise.** A reviewer should be able to understand the main behavior by reading the public entry point from top to bottom. Do not hide the sequence of preparation, dependency invocation, transformation, and response construction behind clever indirection.
- **Choose explicitness over implicit convenience.** Make state transitions, defaults, field mappings, fallback order, and error ownership visible in the code. A few intentional lines are preferable to a compact expression whose meaning depends on unstated assumptions.
- **Use abstractions to clarify responsibilities, not merely to remove duplication.** Extract a helper only when it names a meaningful idea, prevents real behavioral drift, or makes the caller easier to read. Reject an abstraction when its parameters or return values make the overall flow harder to follow.
- **Keep similar behavior structurally similar.** When two operations differ only by data mapping or configuration, share the common flow and isolate the actual differences. Do not force unrelated types through one generic helper merely because their method names look alike.
- **Treat edge cases as part of the design.** Decide how missing, empty, malformed, and valid-but-falsy values behave before implementing the happy path. Encode that decision in a small, obvious branch and test the branch when it carries meaningful behavior.
- **Optimize for the next reviewer.** Prefer names, data structures, comments, tests, and module boundaries that explain why the code works without requiring the reviewer to reconstruct hidden context.

### Contracts And Public Boundaries

- Treat inputs, outputs, errors, and side effects as part of the contract. Decide and document what omitted, null, empty, invalid, and valid-but-falsy values mean when those states differ.
- Validate user input at the boundary closest to the public interface. Invalid requests should fail before business logic or external work begins.
- Document public functions, classes, and data attributes. For structured inputs or nested data, include a concise example where it makes the expected shape easier to understand.

### Code Flow And Abstraction

- Organize public methods so their primary sequence is visible at a glance: validate or prepare input, build the operation, call a dependency, transform the result, and construct the output.
- Extract a helper when it represents a meaningful logical unit, is reused, or makes the caller difficult to read. Do not extract trivial code merely to reduce line count.
- Prefer helper parameters that explicitly describe the required data. Do not pass unrelated object types into one helper just because they happen to share a few attributes.
- Avoid helpers whose argument list or return value is harder to understand than the original code. Use a small named data structure when related values must travel together.
- Keep parsing, validation, transformation, and orchestration responsibilities separate when combining them would make error ownership ambiguous.
- Prefer one shared implementation for one piece of domain behavior. Avoid duplicating parsing or mapping rules in multiple layers and allowing them to drift.

### Values And Error Semantics

- Distinguish a missing value from a value that is present but malformed. Use an exception, result type, or other explicit mechanism when the caller must make different decisions for those cases.
- Preserve valid falsy values such as `0` and `False`. Use explicit missingness checks instead of convenience truthiness checks when falsy values may be meaningful.
- Use specific exception types for expected domain failures. Catch exceptions narrowly at the layer that can make the correct decision.
- Do not catch broad exception types to turn unrelated programming errors or infrastructure failures into apparently successful results.
- Keep client-input failures, domain failures, malformed external data, and dependency failures distinguishable. They often require different status codes, logs, retries, or fallback behavior.
- Comments on defensive branches should state why the branch exists and whether normal validation makes it unreachable. Do not present an unusual bypass or corrupted-data path as ordinary control flow.

### Dependency Boundaries

- Model external request and response shapes deliberately. Verify uncertain behavior with authoritative documentation or an integration environment instead of relying on assumptions from a mock.
- Unit tests should verify what the application sends to and receives from a dependency. They should not claim to verify the dependency's own query semantics unless the dependency is actually exercised.

### Tests That Explain Behavior

- Add tests for every changed public behavior. Test private helpers only when they contain meaningful logic not covered through the public interface.
- Organize tests by the source responsibility they protect. Keep contract or schema validation tests separate from parser/helper tests and service tests when those responsibilities differ.
- Order scenarios along the logic flow: normal behavior, boundaries, validation failures, fallback behavior, malformed data, and empty or short results.
- Use explicit dependency return values in each test or in a clearly named fixture intended for deliberate reuse. Never hide the scenario behind an implicit default return value on a reusable mock.
- Make fixtures and factories construct data; let each test choose the scenario. A test should visibly state whether it represents an empty result, a complete page, a malformed item, a missing field, or a particular cursor.
- Assert request construction when request construction is the behavior under test. Do not assert incidental mock details or reproduce a dependency's internal behavior in a unit test.
- Use short comments to explain why a non-obvious input matters. Comments should describe the scenario or invariant, not restate the test code.
