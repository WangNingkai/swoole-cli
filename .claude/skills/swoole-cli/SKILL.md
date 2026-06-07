```markdown
# swoole-cli Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill provides guidance on contributing to the `swoole-cli` TypeScript codebase. It covers the project's coding conventions, file organization, and typical workflows, ensuring consistency and maintainability. While the repository does not use a detected framework, it follows clear patterns for file naming, imports, exports, and testing.

## Coding Conventions

### File Naming
- Use **camelCase** for file names.
  - Example: `myUtilityFile.ts`

### Imports
- Use **relative import paths**.
  - Example:
    ```typescript
    import { myFunction } from './utils';
    ```

### Exports
- Use **named exports**.
  - Example:
    ```typescript
    export function myFunction() { /* ... */ }
    ```

### Commit Messages
- Freeform style, sometimes with prefixes.
- Average length: ~34 characters.
- Example:
  ```
  Fix bug in connection handler
  ```

## Workflows

### Adding a New Feature
**Trigger:** When implementing a new feature or utility.
**Command:** `/add-feature`

1. Create a new TypeScript file using camelCase naming.
2. Implement the feature with named exports.
3. Use relative imports to include dependencies.
4. Write a corresponding test file (`*.test.ts`).
5. Commit changes with a clear, concise message.

### Refactoring Code
**Trigger:** When improving or restructuring existing code.
**Command:** `/refactor`

1. Identify code to refactor.
2. Update logic while maintaining camelCase file names and relative imports.
3. Ensure all exports remain named.
4. Update or add tests as needed.
5. Commit with a descriptive message.

### Writing Tests
**Trigger:** When adding or updating tests.
**Command:** `/write-test`

1. Create or update a test file matching the pattern `*.test.ts`.
2. Write tests for all exported functions.
3. Use the project's preferred (undetected) testing framework.
4. Run tests to verify correctness.
5. Commit with a message indicating test updates.

## Testing Patterns

- Test files follow the `*.test.ts` pattern.
- Each exported function should have corresponding tests.
- The specific testing framework is not detected; follow existing test file patterns.
- Example test file:
  ```typescript
  import { myFunction } from './myUtilityFile';

  describe('myFunction', () => {
    it('should return expected result', () => {
      expect(myFunction()).toBe(/* expected value */);
    });
  });
  ```

## Commands
| Command       | Purpose                              |
|---------------|--------------------------------------|
| /add-feature  | Scaffold and implement a new feature |
| /refactor     | Refactor existing code               |
| /write-test   | Add or update tests                  |
```
