# Changelog

## 0.1.0

### Breaking Changes

- `Test.plan` has accidentially been public. Now it's private. - @vknabel
- Curried versions have now an explicit first label - @vknabel
- `Test.fail(_:)` has been renamed to `Test.fail(with:)` - @vknabel
- `Test.notOk(_:message:)` has been renamed to `Test.notOk(_:_:)` for `Optional<T>` and `Bool`
- `Test.ok(_:message:)` has been renamed to `Test.ok(_:_:)` for `Optional<T>` and `Bool`
- `Test.pass(message:)` has been renamed to `Test.pass(_:)`

### API Additions

- `SourceLocation(file:line:column:function:)` has now an initializer
- Added `Test.doesNotThrow(_:_:test:)` with an Error type
- Added curried `Test.doesNotThrow(of:_:)` with an Error type
- Added `Test.doesThrow(_:_:test:)` with an Error type
- Added curried `Test.doesThrow(of:_:)` with an Error type
- Added curried `Test.notOk(with:matches:)` with custom predicate
- Added curried `Test.notOk(with:)` for `Bool`
- Added curried `Test.notOk(with:)` for `Optional<T>`
- Added curried `Test.ok(with:matches:)` with custom predicate
- Added curried `Test.ok(with:)` for `Bool`
- Added curried `Test.ok(with:)` for `Optional<T>`
- Added curried `Test.pass(with:)`

### Further Changes

- Added documentation - @vknabel
- Fixes bug for `Test.doesThrow` and `Test.doesNotThrow`

## 0.0.1

- Initial Release - @vknabel
