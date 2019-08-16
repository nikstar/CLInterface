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
        .package(url: "https://github.com/nikstar/spm-argument-parser.git", from: "0.5.0"),
    ],
    targets: [
        .target(
            name: "CLInterface",
            dependencies: ["SPMArgumentParser"]),
        .target(name: "ExampleSwiftc", dependencies: ["CLInterface"])
    ]
)
