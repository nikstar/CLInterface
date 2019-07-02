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
        .package(url: "https://github.com/apple/swift-package-manager.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "CLInterface",
            dependencies: ["SPMUtility"]),
        .target(name: "TestTool", dependencies: ["CLInterface"])
    ]
)
