import RxSwift
import TestHarness

internal struct TestCase {
  let title: String
  let directive: Directive?
  let source: SourceLocation
  let factory: () -> Observable<TestPoint>

  internal init(
    title: String,
    directive: Directive?,
    source location: SourceLocation,
    factory: @escaping () -> Observable<TestPoint>
  ) {
    self.title = title
    self.directive = directive
    self.source = location
    self.factory = factory
  }
}
