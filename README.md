# CLInterface

> __This project is archived.__ I'm happy with how __CLInterface__ turned out; it's architecture includes extensive use of reflection to achieve exactly the API I wanted. Unfortunatly, soon after it's release, Apple came out with its own first-party [argument parser library](https://github.com/apple/swift-argument-parser) that has a very similar interface.

Swift 5.1 era argument parser

[![Swift 5.1](https://img.shields.io/badge/swift-5.1-important)](#)
[![platforms: macOS, Linux](https://img.shields.io/badge/platforms-macOS%20%7C%20Linux-lightgrey)](#)
[![Swift Package Manager compatible](https://img.shields.io/badge/spm-compatible-brightgreen)](#)
[![releases](https://img.shields.io/github/release/nikstar/CLInterface)](https://github.com/nikstar/CLInterface/releases)
[![MIT license](https://img.shields.io/github/license/nikstar/CLInterface)](LICENSE.md)

`CLInterface` protocol should be implemented by a class or a struct that will represent command line interface of your program. Apart from required `description` property, it should contain `@Argument` and `@PositionalArgument` properties for any arguments you want. They will be set automatically after you call `parseArguments`.

Both optional and required arguments are supported. Use `default:` and optional properies to get the behavior you want. (For example, non-optional property without default value will throw error at `parseArguments` call.)

Use Swift package manager to add to your project: 
```swift
        .package(url: "https://github.com/nikstar/CLInterface.git", from: "1.0.3"),
```

## Example

```swift
final class Swiftc : CLInterface {
    var description = "Swift compiler"

    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @PositionalArgument(name: "files", usage: "Files that will be compiled")
    var files: [String]
}
```

After calling `parseArguments`, you will be able to use these properties like normal variables.

```swift
let swiftc = Swiftc()
try swiftc.parseArguments(["-o", "hello", "-g", "main.swift", "Greeter.swift"])

swiftc.outputPath // Optional("hello")
swiftc.debugMode // true
swiftc.files // ["main.swift", "Greeter.swift"]
```

`swiftc -h` or `swiftc --help` prints usage info:

```
OVERVIEW: Swift compiler

OPTIONS:
--output, -o   Write output to <file>
-g             Emit debug info
--help         Display available options

POSITIONAL ARGUMENTS:
files          Files that will be compiled
```

See [`ExampleSwiftc`](Sources/ExampleSwiftc/main.swift) for working example.

See **Opusab**, my audiobook converter, for another [real-life example](https://github.com/nikstar/opusab/blob/master/Sources/OpusabCore/Opusab.swift).
