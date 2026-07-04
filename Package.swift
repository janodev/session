// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "session",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Session", targets: ["Session"])
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
