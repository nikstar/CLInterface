# CLInterface

Swift 5.1 era argument parser

`CLInterface` protocol should be implemented by a class or a struct that will represent command line interface of your program. Apart from required `description` property, it should contain `@Argument` and `@PositionalArguments` properties for any arguments you want. They will be set automatically after you call `parseArguments`.

Use Swift package manager to add to your project: 
```swift
        .package(url: "https://github.com/nikstar/CLInterface.git", .branch("master")),
```

**This is work in progress. PRs and suggestions are welcome!**

Possible improvements:
+ [ ] add default value information to `--help` output
+ [ ] optional and required arguments (required arguments will throw at `parseArguments`)

## Example

```swift
final class Swiftc : CLInterface {
    var description = "Swift compiler"

    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @PositionalArguments(name: "files", usage: "Files that will be compiled")
    var files: [String]
}
```

After calling `parseArguments`, you will be able to use these properties like normal variables.

```swift
let swiftc = Swiftc()
try swiftc.parseArguments(["-o", "hello", "-g", "main.swift", "Greeter.swift"])

swiftc.outputPath // Optional("hello")
swiftc.debugMode! // true
                  // All varibales are optional for now, 
                  // but they can be safely unwrapped when default value is provided
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

See `ExampleSwiftc` for working example.
