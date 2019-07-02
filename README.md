# CLInterface

Swift 5.1 era argument parser

`CLInterface` protocol should be implemented by a class or a struct that will represent command line interface of your program. Apart from required `description` property, it should contain `@Argument` and `@PositionalArguments` properties for any arguments you want. They will be set automatically after you call `parseArguments`.


## Example

```swift
final class Swiftc : CLInteface {
    var description = "Swift compiler"

    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @PositionArguments(name: "files", usage: "Files that will be compiled")
    var files: [String]
}
```

After calling `parseArguments`, you will be able to use these properties like normal variables.

