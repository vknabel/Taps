import PackageDescription

let package = Package(
    name: "Taps",
    targets: [
        Target(name: "Taps", dependencies: ["TestHarness"]),
        Target(name: "TestHarness")
    ],
    dependencies: [
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3)
    ]
)
