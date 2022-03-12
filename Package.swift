// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "session",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "SessionStatic", type: .static, targets: ["Session"]),
        .library(name: "SessionDynamic", type: .dynamic, targets: ["Session"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Session",
            dependencies: [],
            path: "sources/main"
        ),
        .testTarget(
            name: "SessionTests",
            dependencies: ["Session"],
            path: "sources/tests"
        )
    ]
)
