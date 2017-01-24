# Changelog

## 0.2.1

## Further Changes

- Fixes an issue, that prevented `OfferingTests.fail` from failing
- Removed some internal, unused code

## 0.2.0

## Breaking Changes

- Removing directive parameters for all Taps

## API Additions

- Added `TestCase` class
- Added `OfferingTaps` and `OfferingRxTaps` where all `TestCase`s are defined on
- Added `OfferingTests` where all `TestPoint`s are defined on
- Added `OfferingTaps.skip(_:)` and `OfferingTaps.skip` to skip tests
- Added `OfferingTaps.todo(_:)` and `OfferingTaps.todo` to mark tests as todo

## 0.1.0

### Breaking Changes

- `Test.plan` has accidentially been public. Now it's private. - @vknabel
- Curried versions have now an explicit first label - @vknabel
- `Test.fail(_:)` has been renamed to `Test.fail(with:)` - @vknabel
- `Test.notOk(_:message:)` has been renamed to `Test.notOk(_:_:)` for `Optional<T>` and `Bool`
- `Test.ok(_:message:)` has been renamed to `Test.ok(_:_:)` for `Optional<T>` and `Bool`
- `Test.pass(message:)` has been renamed to `Test.pass(_:)`
- `RxTaps.test(_directive:source:timeout:scheduler:with:` for `Observable<TestPoint>` has been renamed to `assertionTest`
- All variations of `Test.doesNotThrow` take a real closure instead of an `@autoclosure`
- All variations of `Test.doesThrow` take a real closure instead of an `@autoclosure`
- `Observable.test(onNext:onError:onCompleted:)` now catches and `onError:` is non optional. Introduces non-catching `Observable.test(onNext:onCompleted:)`.
- Combined and renamed variations of `Taps.start` to `Taps.start(with:testing:)`
- Combined and renamed variations of `Taps.run` to `Taps.run(with:testing:)`
- Combined and renamed variations of `Taps.runMain` to `Taps.runMain(with:testing:)`

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
- Added `RxTaps.genericTest(_directive:source:timeout:scheduler:with:)` for `<T> Test -> Observable<T>`
- Added `Observable.test(onNext:onCompleted:)` which won't catch errors.
- Property `Taps.runner` is now public
- Added static `Taps.runner(with:testing:)`
- Added static `Taps.with(_:tests:)`

### Further Changes

- Added documentation - @vknabel
- Fixes bug for `Test.doesThrow` and `Test.doesNotThrow`

## 0.0.1

- Initial Release - @vknabel
