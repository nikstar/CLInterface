// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CLInterface",
    products: [
        .library(
            name: "CLInterface",
            targets: ["CLInterface"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", .revision("7c83067f93e414ffa225b033d34640d5bc1bad0e")),
    ],
    targets: [
        .target(
            name: "CLInterface",
            dependencies: ["SPMUtility"]),
        .target(name: "ExampleSwiftc", dependencies: ["CLInterface"])
    ]
)
