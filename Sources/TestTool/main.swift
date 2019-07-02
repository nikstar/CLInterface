
import CLInterface

final class Swiftc : CLInterface {
    var description = "Swift compiler"
    
    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @PositionalArguments(name: "files", usage: "Files that will be compiled")
    var files: [String]
}

let swiftc = Swiftc()
swiftc.parseArguments(["-o", "hello", "-g", "main.swift", "Greeter.swift"])

print(swiftc.outputPath as Any)
print(swiftc.debugMode!)
print(swiftc.files)
