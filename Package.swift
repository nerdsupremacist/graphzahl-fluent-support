// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "graphzahl-fluent-support",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "GraphZahlFluentSupport",
                 targets: ["GraphZahlFluentSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nerdsupremacist/GraphZahl.git", from: "0.1.0-alpha.28"),
        .package(url: "https://github.com/nerdsupremacist/ContextKit.git", from: "0.2.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.2.2"),
        .package(url: "https://github.com/vapor/fluent-kit.git", from: "1.0.0-rc.1.27"),
    ],
    targets: [
        .target(
            name: "GraphZahlFluentSupport",
            dependencies: ["GraphZahl", "Fluent", "ContextKit"]
        ),
    ]
)
