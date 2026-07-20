# ~/.codex/DEVELOPER.md

## Docs

- All documentation must be well formatted, follow applicable language or ecosystem conventions, and be easy for humans to read.
- Document public functions, exported types, and public data attributes.
- For private functions, add a short summary when the name alone does not make the responsibility clear. Do not add ceremonial documentation to obvious one-line helpers or accessors.
- For nested objects or structured data, include a concise shape example when it removes real ambiguity.
- Comment non-obvious decisions, invariants, safety boundaries, and intentional trade-offs. Do not comment syntax that already explains itself.
- A defensive branch comment should explain why it exists and what it protects.
- Write product and frontend documents in terms of observable behavior and API contracts. Do not expose internal class, scheduler, or deployment details unless the document is explicitly an operations or design document.

## Code Formatting

- Always run the available formatter and linter after making code changes.
- Remove trailing whitespace and ensure modified text files end with a newline. Apply formatting changes only to files intentionally modified by the work.
- When the repository has no established package manager, test runner, or linter, choose widely adopted, low-friction tooling for the language and record the choice. Do not introduce unrelated tooling churn.

## Code Structure

- Use descriptive names. Avoid unexplained abbreviations unless they are common to the language, domain, or team.
- Make public entry points readable from top to bottom. The main sequence should show preparation, dependency calls, transformation, and output construction.
- Treat function length, logical-block count, and nesting depth as readability signals. Extract a helper when it names a meaningful operation, is reused, or makes its caller easier to understand.
- Do not extract trivial boilerplate solely to reduce line count. Reject a helper when its parameters, returned values, or control flow are harder to understand than the code it replaces.
- Follow existing repository ordering conventions. When none exists, organize functions so the reader can understand a helper before its caller.
- Keep control flow shallow with guards, explicit failure paths, or meaningful helpers.
- Prefer explicit behavior over implicit convenience. Preserve the distinction between missing, malformed, empty, and valid falsy values.
- Do not silently choose between an injected dependency and a newly constructed dependency. Construction belongs in an explicit factory, bootstrap path, or composition root; injection is explicit when a caller supplies a dependency.
- Do not use convenience fallback expressions when they hide whether a value is absent, invalid, injected, or defaulted. Write the branch or validation that makes the intended choice visible.
- Keep transport adapters focused on request parsing, authentication context, response construction, and transport-level errors.
- Keep application services focused on use-case flow, business decisions, state transitions, and coordination between dependencies.
- Keep repositories focused on persistence primitives and clear query intent. Do not hide service workflow decisions in repository methods when general create, get, list, update, delete, and query criteria express the operation.
- Keep mappers focused on conversion. Do not place dependency calls, use-case-specific defaults, timestamps, or ID policy in a mapper.
- Share an implementation only when several cases have a stable, meaningful common flow and differ at a small explicit hook. Keep that common flow in the shared abstraction and make each variation provide only its actual behavior.
- Do not introduce a base class or generic abstraction for hypothetical reuse.

## Modifying Existing Code

- Keep the scope of changes as narrow as possible unless the request explicitly asks for a broader refactor. Do not make large unrelated changes in a single pull request because they make review context harder to follow.

## Exceptions and Logs

- Define expected application errors under a stable application-level error family when the language and architecture support it. Preserve the causal error where supported.
- Use specific error types for expected validation, domain, and dependency failures. Avoid broad catches that convert programming or infrastructure failures into a misleading success.
- Use `info` sparingly for necessary operational context, `warning` for an unexpected condition from which the operation can recover or skip, and `error` for a failure that requires the operation or process to stop.
- Do not log and rethrow the same failure at every layer. Log at the layer that owns the recovery or reporting decision.
- Errors must not pass silently unless intentionally ignored behavior is safe, explicit, and documented.

## Tests

- Test every changed public behavior. Test private helpers directly only when their meaningful logic is not covered through a public behavior.
- Skip tests only for truly trivial boilerplate branches. Test a small branch when it changes a contract, avoids side effects, protects a state transition, or handles meaningful malformed input.
- Assert error type and structured fields by default. Assert message text only when that wording is an intentional contract.
- Set mock return values and side effects explicitly. Do not rely on implicit mock defaults to make a scenario pass.
- When tests in a file cover multiple methods, use visible ASCII-only dividers: `# --- TypeName.method_name ---`.
- Order tests along the behavior flow: normal case, boundary case, validation failure, fallback or malformed input, and empty result where relevant.
- Name tests after the concrete condition and expected behavior. Prefer `rejects_datetime_without_timezone` to a vague term such as `naive`.
- Keep test files aligned with the responsibility being tested. Business-rule tests belong with the business module; scheduler, lifecycle, mapper, and configuration tests belong with their respective modules.
- Factories and fixtures construct data; each test visibly selects the scenario and dependency result that make the expectation meaningful.
- Use a short comment for a non-obvious test input or call-order side effect. Explain the scenario or invariant, not the syntax of the test.
- Do not add test-only switches, alternate runtime paths, sleeps, or production hooks to make tests easier. Use mocks, patches, fakes, or integration environments instead.

## General Programming Quality

Treat these principles as priorities when making trade-offs:

- **Make the code flow readable before making it concise.** A reviewer should understand the main behavior by reading the public entry point from top to bottom.
- **Choose explicitness over implicit convenience.** Make state transitions, defaults, field mappings, fallback order, and error ownership visible.
- **Use abstractions to clarify responsibilities, not merely to remove duplication.** Reject an abstraction when its parameters or return values make the overall flow harder to follow.
- **Keep similar behavior structurally similar.** Share a meaningful common flow and isolate real variations. Do not force unrelated types through one generic helper merely because their method names look alike.
- **Treat edge cases as part of the design.** Decide how missing, empty, malformed, and valid-but-falsy values behave before implementing the happy path.
- **Optimize for the next reviewer.** Prefer names, module boundaries, data structures, comments, and tests that explain why the code works without hidden context.

### Contracts And Public Boundaries

- Treat inputs, outputs, errors, side effects, and omitted values as contracts.
- A function whose name promises a required result or completed operation must either fulfill that promise or signal failure with a specific error. Do not return an ambiguous boolean or absent value to represent a missing object, a business-rule rejection, or a dependency failure.
- When absence is an expected outcome, make that optionality clear in the function name using the language or repository convention, such as `find`, `lookup_optional`, or `get_or_none`.
- Give one behavior one canonical application-level configuration name. Perform deployment-specific naming transforms at the deployment boundary instead of teaching application code multiple deployment aliases by default.
- Use separate configuration values for different trust boundaries or consumers, such as an internal service endpoint and a public browser endpoint.
- Required production endpoints, credentials, paths, and identifiers should fail fast with an actionable configuration error. Do not silently guess a production-safe value.

### Code Flow And Abstraction

- Keep parsing, validation, transformation, orchestration, and external I/O separate when combining them would hide error ownership or behavior.
- Prefer a small named data type over several loosely related parameters or a positional multi-value return when those values travel together.

### Dependency Boundaries

- Model external request and response shapes deliberately. Verify uncertain dependency behavior through authoritative documentation or an integration environment rather than relying solely on mocks.
- Assert request construction when request construction is the behavior under test. Do not claim that a unit test proves a dependency's own semantics.

### Tests That Explain Behavior

- Integration scripts should create isolated run directories and clean up temporary ports, processes, and test data when practical.

## Deployment And Operational Scripts

- Treat deployment and integration scripts as production-adjacent code. Use strict error handling, command checks, bounded waits, clear target context, and readable evidence of results.
- Guard local-only actions with an exact local context or explicit opt-in. Keep checks that are safe only in local environments separate from remote-safe checks.
- Use the project-managed runtime for scripts when available instead of assuming the host interpreter matches project requirements.
